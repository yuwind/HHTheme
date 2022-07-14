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

#define mThemeObjectAddress(object) [NSString stringWithFormat:@"%p",object]

@interface HHThemeManager ()

@property (nonatomic, assign) HHThemeStyle themeStyle;
@property (nonatomic, assign) BOOL shouldFollowSystem;
@property (nonatomic, strong) NSMutableDictionary<NSString *, NSMutableArray<HHThemeModel *> *> *themeDictionaryM;
@property (nonatomic, strong) HHThemeObserverView *observerView;

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

+ (BOOL)shouldFollowSystem {
    return [HHThemeManager manager].shouldFollowSystem;
}

+ (void)setShouldFollowSystem:(BOOL)shouldFollowSystem {
    [HHThemeManager manager].shouldFollowSystem = shouldFollowSystem;
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
        _shouldFollowSystem = YES;
        _themeStyle = HHThemeStyleLight;
        if (@available(iOS 13.0, *)) {
            if ([UITraitCollection currentTraitCollection].userInterfaceStyle == UIUserInterfaceStyleDark) {
                _themeStyle = HHThemeStyleDark;
            } else {
                _themeStyle = HHThemeStyleLight;
            }
        }
        _observerView = [[HHThemeObserverView alloc] initWithFrame:CGRectMake(0, 0, 0.02, 0.02)];
        __block UIWindow *window = nil;
        if ([UIApplication.sharedApplication.delegate respondsToSelector:@selector(window)]) {
            window = UIApplication.sharedApplication.delegate.window;
        }
        if (window == nil) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                window = UIApplication.sharedApplication.keyWindow;
                [window addSubview:self.observerView];
            });
        } else {
            [window addSubview:_observerView];
        }
    }
    return self;
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
    if (_themeStyle == themeStyle) {
        return;
    }
    _themeStyle = themeStyle;
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
    for (NSString *objectKey in expiredArray) {
        [self removeThemeModelsWithObjectKey:objectKey];
    }
}

- (void)invokeThemeModel:(HHThemeModel *)themeModel {
    if (self.themeStyle == HHThemeStyleLight) {
        if (themeModel.lightMode) {
            themeModel.lightMode();
        }
    } else {
        if (themeModel.darkMode) {
            themeModel.darkMode();
        }
    }
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
