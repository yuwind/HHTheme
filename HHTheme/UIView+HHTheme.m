//
//  UIView+HHTheme.m
//  HHThemeDemo
//
//  Created by huxuewei on 2022/7/13.
//

#import "UIView+HHTheme.h"
#import "NSObject+HHTheme.h"
#import "HHThemePrivate.h"

@implementation UIView (HHTheme)

@dynamic theme_backgroundColors;
@dynamic theme_tintColors;
@dynamic theme_alphas;

- (void)setTheme_backgroundColors:(NSArray<UIColor *> *)theme_backgroundColors {
    if (theme_backgroundColors.count != 2) {
        self.backgroundColor = theme_backgroundColors.firstObject;
        return;
    }
    @themeWeak(self);
    [self theme_lightMode:^{
        @themeStrong(self);
        self.backgroundColor = theme_backgroundColors.firstObject;
    } darkMode:^{
        @themeStrong(self);
        self.backgroundColor = theme_backgroundColors.lastObject;
    }];
}

- (void)theme_tintColors:(NSArray<UIColor *> *)themeColors {
    if (themeColors.count != 2) {
        self.tintColor = themeColors.firstObject;
        return;
    }
    @themeWeak(self);
    [self theme_lightMode:^{
        @themeStrong(self);
        self.tintColor = themeColors.firstObject;
    } darkMode:^{
        @themeStrong(self);
        self.tintColor = themeColors.lastObject;
    }];
}

- (void)setTheme_alphas:(NSArray<NSNumber *> *)theme_alphas {
    if (theme_alphas.count != 2) {
        self.alpha = theme_alphas.firstObject.floatValue;
        return;
    }
    @themeWeak(self);
    [self theme_lightMode:^{
        @themeStrong(self);
        self.alpha = theme_alphas.firstObject.floatValue;
    } darkMode:^{
        @themeStrong(self);
        self.alpha = theme_alphas.lastObject.floatValue;
    }];
}

@end
