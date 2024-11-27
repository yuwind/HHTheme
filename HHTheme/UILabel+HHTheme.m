//
//  UILabel+HHTheme.m
//  HHThemeDemo
//
//  Created by huxuewei on 2022/7/14.
//

#import "UILabel+HHTheme.h"
#import "NSObject+HHTheme.h"
#import "HHThemePrivate.h"

@implementation UILabel (HHTheme)

@dynamic theme_textColors;

- (void)setTheme_textColors:(NSArray<UIColor *> *)theme_textColors {
    if (theme_textColors.count != 2) {
        self.textColor = theme_textColors.firstObject;
        return;
    }
    @themeWeak(self);
    [self theme_lightMode:^{
        @themeStrong(self);
        self.textColor = theme_textColors.firstObject;
    } darkMode:^{
        @themeStrong(self);
        self.textColor = theme_textColors.lastObject;
    }];
}

@end
