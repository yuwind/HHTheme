//
//  CAShapeLayer+HHTheme.m
//  HHThemeDemo
//
//  Created by huxuewei on 2024/11/20.
//

#import "CAShapeLayer+HHTheme.h"
#import "NSObject+HHTheme.h"
#import "HHThemePrivate.h"

@implementation CAShapeLayer (HHTheme)

@dynamic theme_strokeColors;
@dynamic theme_fillColors;

- (void)setTheme_fillColors:(NSArray<UIColor *> *)theme_fillColors {
    if (theme_fillColors.count != 2) {
        return;
    }
    @themeWeak(self);
    [self theme_lightMode:^{
        @themeStrong(self);
        self.fillColor = theme_fillColors.firstObject.CGColor;
    } darkMode:^{
        @themeStrong(self);
        self.fillColor = theme_fillColors.lastObject.CGColor;
    }];
}

- (void)setTheme_strokeColors:(NSArray<UIColor *> *)theme_strokeColors {
    if (theme_strokeColors.count != 2) {
        return;
    }
    @themeWeak(self);
    [self theme_lightMode:^{
        @themeStrong(self);
        self.strokeColor = theme_strokeColors.firstObject.CGColor;
    } darkMode:^{
        @themeStrong(self);
        self.strokeColor = theme_strokeColors.lastObject.CGColor;
    }];
}

@end
