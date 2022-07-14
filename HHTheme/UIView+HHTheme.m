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

- (void)setTheme_backgroundColors:(NSArray<UIColor *> *)theme_backgroundColors {
    if (theme_backgroundColors.count != 2) {
        self.backgroundColor = theme_backgroundColors.firstObject;
        return;
    }
    @weakify(self);
    [self theme_lightMode:^{
        @strongify(self);
        self.backgroundColor = theme_backgroundColors.firstObject;
    } darkMode:^{
        @strongify(self);
        self.backgroundColor = theme_backgroundColors.lastObject;
    }];
}

- (void)theme_tintColors:(NSArray<UIColor *> *)themeColors {
    if (themeColors.count != 2) {
        self.tintColor = themeColors.firstObject;
        return;
    }
    @weakify(self);
    [self theme_lightMode:^{
        @strongify(self);
        self.tintColor = themeColors.firstObject;
    } darkMode:^{
        @strongify(self);
        self.tintColor = themeColors.lastObject;
    }];
}

@end
