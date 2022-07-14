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

- (void)setTheme_backgroundColors:(NSArray<UIColor *> *)theme_backgroundColors {
    if (theme_backgroundColors.count != 2) {
        self.backgroundColor = theme_backgroundColors.firstObject.CGColor;
        return;
    }
    @weakify(self);
    [self theme_lightMode:^{
        @strongify(self);
        self.backgroundColor = theme_backgroundColors.firstObject.CGColor;
    } darkMode:^{
        @strongify(self);
        self.backgroundColor = theme_backgroundColors.lastObject.CGColor;
    }];
}

@end
