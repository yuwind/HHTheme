//
//  NSObject+HHTheme.m
//  HHThemeDemo
//
//  Created by huxuewei on 2022/7/14.
//

#import "NSObject+HHTheme.h"
#import "HHThemeManager.h"
#import "HHThemeModel.h"
#import "HHThemeDeallocObject.h"
#import <objc/runtime.h>

@implementation NSObject (HHTheme)

- (void)theme_changedBlock:(nullable HHThemeModeBlock)changeBlock {
    if (@available(iOS 13.0, *)) {
        HHThemeModel *model = [HHThemeModel modelWithThemeObject:self lightMode:changeBlock darkMode:changeBlock];
        [HHThemeManager storeThemeModel:model];
    }
}

- (void)theme_lightMode:(HHThemeModeBlock)lightMode darkMode:(HHThemeModeBlock)darkMode {
    if (@available(iOS 13.0, *)) {
        HHThemeModel *model = [HHThemeModel modelWithThemeObject:self lightMode:lightMode darkMode:darkMode];
        [HHThemeManager storeThemeModel:model];
    }
}

- (void)theme_afterDeallocCallBack:(void(^ _Nullable)(void))callBack {
    if (callBack == nil) {
        return;
    }
    HHThemeDeallocObject *previousObject = objc_getAssociatedObject(self, @selector(theme_afterDeallocCallBack:));
    if (previousObject != nil) {
        return;
    }
    HHThemeDeallocObject *object = [HHThemeDeallocObject deallocObjectWithCallBack:callBack];
    objc_setAssociatedObject(self, @selector(theme_afterDeallocCallBack:), object, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
