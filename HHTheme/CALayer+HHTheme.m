//
//  CALayer+HHTheme.m
//  HHThemeDemo
//
//  Created by huxuewei on 2022/7/14.
//

#import "CALayer+HHTheme.h"
#import "NSObject+HHTheme.h"
#import "HHThemePrivate.h"

@implementation CALayer (HHTheme)

@dynamic theme_backgroundColors;
@dynamic theme_borderColors;
@dynamic theme_shadowColors;

- (void)setTheme_backgroundColors:(NSArray<UIColor *> *)theme_backgroundColors {
    if (theme_backgroundColors.count != 2) {
        self.backgroundColor = theme_backgroundColors.firstObject.CGColor;
        return;
    }
    @themeWeak(self);
    [self theme_lightMode:^{
        @themeStrong(self);
        self.backgroundColor = theme_backgroundColors.firstObject.CGColor;
    } darkMode:^{
        @themeStrong(self);
        self.backgroundColor = theme_backgroundColors.lastObject.CGColor;
    }];
}

- (void)setTheme_borderColors:(NSArray<UIColor *> *)theme_borderColors {
    if (theme_borderColors.count != 2) {
        self.borderColor = theme_borderColors.firstObject.CGColor;
        return;
    }
    @themeWeak(self);
    [self theme_lightMode:^{
        @themeStrong(self);
        self.borderColor = theme_borderColors.firstObject.CGColor;
    } darkMode:^{
        @themeStrong(self);
        self.borderColor = theme_borderColors.lastObject.CGColor;
    }];
}

- (void)setTheme_shadowColors:(NSArray<UIColor *> *)theme_shadowColors {
    if (theme_shadowColors.count != 2) {
        self.shadowColor = theme_shadowColors.firstObject.CGColor;
        return;
    }
    @themeWeak(self);
    [self theme_lightMode:^{
        @themeStrong(self);
        self.shadowColor = theme_shadowColors.firstObject.CGColor;
    } darkMode:^{
        @themeStrong(self);
        self.shadowColor = theme_shadowColors.lastObject.CGColor;
    }];
}

@end
