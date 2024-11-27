//
//  UISwitch+HHTheme.m
//  HHThemeDemo
//
//  Created by huxuewei on 2024/11/27.
//

#import "UISwitch+HHTheme.h"
#import "NSObject+HHTheme.h"
#import "HHThemePrivate.h"

@implementation UISwitch (HHTheme)

@dynamic theme_onTintColors;
@dynamic theme_thumbTintColors;

- (void)setTheme_onTintColors:(NSArray<UIColor *> *)theme_onTintColors {
    if (theme_onTintColors.count != 2) {
        self.onTintColor = theme_onTintColors.firstObject;
        return;
    }
    @themeWeak(self);
    [self theme_lightMode:^{
        @themeStrong(self);
        self.onTintColor = theme_onTintColors.firstObject;
    } darkMode:^{
        @themeStrong(self);
        self.onTintColor = theme_onTintColors.lastObject;
    }];
}

- (void)setTheme_thumbTintColors:(NSArray<UIColor *> *)theme_thumbTintColors {
    if (theme_thumbTintColors.count != 2) {
        self.thumbTintColor = theme_thumbTintColors.firstObject;
        return;
    }
    @themeWeak(self);
    [self theme_lightMode:^{
        @themeStrong(self);
        self.thumbTintColor = theme_thumbTintColors.firstObject;
    } darkMode:^{
        @themeStrong(self);
        self.thumbTintColor = theme_thumbTintColors.lastObject;
    }];
}

@end
