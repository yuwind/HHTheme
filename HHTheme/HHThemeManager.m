//
//  HHThemeManager.m
//  HHThemeDemo
//
//  Created by huxuewei on 2022/7/13.
//

#import "HHThemeManager.h"
#import "HHThemeModel.h"
#import "HHThemeObserverView.h"
#import "NSObject+HHTheme.h"
#import "HHThemePrivate.h"

@interface HHThemeManager ()

@property (nonatomic, assign) BOOL isLessThaniOS13;
@property (nonatomic, assign) HHThemeStyle themeStyle;
@property (nonatomic, assign) HHThemeStyle internalThemeStyle;
@property (nonatomic, strong) NSMutableDictionary<NSString *, NSMutableArray<HHThemeModel *> *> *themeDictionaryM;
@property (nonatomic, strong) HHThemeObserverView *observerView;
@property (nonatomic, assign) NSInteger lightStartSeconds;//default 6 AM, deviation 5 minutes
@property (nonatomic, assign) NSInteger darkStartSeconds;//default 7 PM, deviation 5 minutes
@property (nonatomic, assign) NSInteger deviationSeconds;//default 5 minutes
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation HHThemeManager

+ (instancetype)manager {
    static HHThemeManager *manager_ = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager_ = [HHThemeManager new];
    });
    return manager_;
}

+ (HHThemeStyle)themeStyle {
    return [HHThemeManager manager].themeStyle;
}

+ (void)setThemeStyle:(HHThemeStyle)themeStyle {
    [HHThemeManager manager].themeStyle = themeStyle;
}

+ (void)updateInternalThemeStyle:(HHThemeStyle)themeStyle {
    [HHThemeManager manager].internalThemeStyle = themeStyle;
}

+ (void)storeThemeModel:(HHThemeModel *)themeModel {
    [[HHThemeManager manager] storeThemeModel:themeModel];
}

+ (void)clearThemeStoreInfo {
    [[HHThemeManager manager] clearThemeStoreInfo];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _lightStartSeconds = 6*60*60;
        _darkStartSeconds = 19*60*60;
        _deviationSeconds = 5*60;
        _isLessThaniOS13 = NO;
        if (@available(iOS 13.0, *)) {
            _isLessThaniOS13 = NO;
        } else {
            _isLessThaniOS13 = YES;
        }
        [self setupInitialInfo];
    }
    return self;
}

- (void)setupInitialInfo {
    self.themeStyle = HHThemeStyleSystem;
    if (self.isLessThaniOS13) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillEnterForeground:) name:UIApplicationWillEnterForegroundNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidEnterBackground:) name:UIApplicationDidEnterBackgroundNotification object:nil];
        theme_performActionOnBackgroundThread(^{
            @weakify(self);
            self.timer = [NSTimer scheduledTimerWithTimeInterval:self.deviationSeconds repeats:YES block:^(NSTimer * _Nonnull timer) {
                @strongify(self);
                if (self.themeStyle == HHThemeStyleSystem) {
                    HHThemeStyle themeStyle = [self nowDisplayThemeStyle];
                    theme_performActionOnMainThread(^{
                        self.internalThemeStyle = themeStyle;
                    });
                }
            }];
            [self.timer fire];
            [[NSRunLoop currentRunLoop] run];
        });
    } else {
        _observerView = [[HHThemeObserverView alloc] initWithFrame:CGRectMake(0, 0, 0.02, 0.02)];
        __block UIWindow *window = nil;
        window = mThemeAvailableWindow;
        if (window != nil) {
            [window addSubview:_observerView];
        } else {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                window = UIApplication.sharedApplication.keyWindow;
                [window addSubview:self.observerView];
            });
        }
    }
}

- (void)applicationWillEnterForeground:(NSNotification *)notification {
    if (self.themeStyle != HHThemeStyleSystem) {
        return;
    }
    HHThemeStyle style = [self nowDisplayThemeStyle];
    self.internalThemeStyle = style;
    if (self.timer != nil) {
        [self.timer setFireDate:[NSDate date]];
    }
}

- (void)applicationDidEnterBackground:(NSNotification *)notification {
    if (self.themeStyle != HHThemeStyleSystem) {
        return;
    }
    if (self.timer != nil) {
        [self.timer setFireDate:[NSDate distantFuture]];
    }
}

- (void)storeThemeModel:(HHThemeModel *)themeModel {
    [self invokeThemeModel:themeModel];
    [self addThemeModelIfNeeded:themeModel];
    [self clearThemeModelIfNeeded:themeModel];
}

- (void)addThemeModelIfNeeded:(HHThemeModel *)themeModel {
    id themeObject = themeModel.themeObject;
    if (themeObject == nil) {
        return;
    }
    NSString *objectKey = mThemeObjectAddress(themeObject);
    NSMutableArray *arrayM = [self.themeDictionaryM objectForKey:objectKey];
    if (arrayM == nil) {
        arrayM = @[].mutableCopy;
    }
    [arrayM addObject:themeModel];
    [self.themeDictionaryM setObject:arrayM forKey:objectKey];
}

- (void)clearThemeModelIfNeeded:(HHThemeModel *)themeModel {
    id themeObject = themeModel.themeObject;
    if (themeObject == nil) {
        return;
    }
    NSString *objectKey = mThemeObjectAddress(themeObject);
    [themeObject theme_afterDeallocCallBack:^{
        [self removeThemeModelsWithObjectKey:objectKey];
    }];
}

- (void)removeThemeModelsWithObjectKey:(NSString *)objectKey {
    if (objectKey.length == 0) {
        return;
    }
    [self.themeDictionaryM removeObjectForKey:objectKey];
}

- (void)setThemeStyle:(HHThemeStyle)themeStyle {
    _themeStyle = themeStyle;
    if (_themeStyle == HHThemeStyleSystem) {
        if (@available(iOS 13.0, *)) {
            if ([UITraitCollection currentTraitCollection].userInterfaceStyle == UIUserInterfaceStyleDark) {
                self.internalThemeStyle = HHThemeStyleDark;
            } else {
                self.internalThemeStyle = HHThemeStyleLight;
            }
        } else {
            HHThemeStyle currentStyle = [self nowDisplayThemeStyle];
            self.internalThemeStyle = currentStyle;
            if (self.timer != nil) {
                [self.timer setFireDate:[NSDate date]];
            }
        }
    } else {
        self.internalThemeStyle = themeStyle;
        if (self.timer != nil) {
            [self.timer setFireDate:[NSDate distantFuture]];
        }
    }
}

- (void)setInternalThemeStyle:(HHThemeStyle)internalThemeStyle {
    if (_internalThemeStyle == internalThemeStyle) {
        return;
    }
    _internalThemeStyle = internalThemeStyle;
    NSMutableArray *expiredArray = @[].mutableCopy;
    for (NSString *objectKey in self.themeDictionaryM.allKeys) {
        NSMutableArray<HHThemeModel *> *modelArrayM = [self.themeDictionaryM objectForKey:objectKey];
        [modelArrayM enumerateObjectsUsingBlock:^(HHThemeModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (obj.themeObject != nil) {
                [self invokeThemeModel:obj];
            } else {
                [expiredArray addObject:objectKey];
            }
        }];
    }
    //clear invalid objects
    for (NSString *objectKey in expiredArray) {
        [self removeThemeModelsWithObjectKey:objectKey];
    }
}

- (void)invokeThemeModel:(HHThemeModel *)themeModel {
    if (self.internalThemeStyle == HHThemeStyleLight) {
        if (themeModel.lightMode) {
            themeModel.lightMode();
        }
    } else {
        if (themeModel.darkMode) {
            themeModel.darkMode();
        }
    }
}

- (HHThemeStyle)nowDisplayThemeStyle {
    NSInteger todaySeconds = [self todaySecondsSinceZero];
    if (todaySeconds < self.lightStartSeconds) {
        return HHThemeStyleDark;
    } else if (todaySeconds < self.darkStartSeconds) {
        return HHThemeStyleLight;
    }
    return HHThemeStyleDark;
}

- (NSInteger)todaySecondsSinceZero {
    static NSCalendar *calendar = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    });
    NSDate *today = [NSDate date];
    NSDateComponents *components = [calendar components:NSCalendarUnitEra|NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:today];
    NSDate *startDate = [calendar dateFromComponents:components];
    NSTimeInterval timeInterval = [today timeIntervalSinceDate:startDate];
    return floor(timeInterval);
}

- (NSMutableDictionary *)themeDictionaryM {
    if (_themeDictionaryM == nil) {
        _themeDictionaryM = @{}.mutableCopy;
    }
    return _themeDictionaryM;
}

- (void)clearThemeStoreInfo {
    _themeDictionaryM = @{}.mutableCopy;
}

@end
