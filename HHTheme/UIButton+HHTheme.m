//
//  UIButton+HHTheme.m
//  HHThemeDemo
//
//  Created by huxuewei on 2022/7/14.
//

#import "UIButton+HHTheme.h"
#import "NSObject+HHTheme.h"
#import "HHThemePrivate.h"

@implementation UIButton (HHTheme)

- (void)theme_setTitleColors:(NSArray<UIColor *> *)colors forState:(UIControlState)state {
    if (colors.count != 2) {
        [self setTitleColor:colors.firstObject forState:state];
        return;
    }
    @weakify(self);
    [self theme_lightMode:^{
        @strongify(self);
        [self setTitleColor:colors.firstObject forState:state];
    } darkMode:^{
        @strongify(self);
        [self setTitleColor:colors.lastObject forState:state];
    }];
}

- (void)theme_setImageNames:(NSArray<NSString *> *)imageNames forState:(UIControlState)state {
    NSMutableArray *arrayM = @[].mutableCopy;
    for (NSString *imageName in imageNames) {
        UIImage *image = [UIImage imageNamed:imageName];
        if (image != nil) {
            [arrayM addObject:image];
        }
    }
    [self theme_setImages:arrayM.copy forState:state];
}

- (void)theme_setImages:(NSArray<UIImage *> *)images forState:(UIControlState)state {
    if (images.count != 2) {
        [self setImage:images.firstObject forState:state];
        return;
    }
    @weakify(self);
    [self theme_lightMode:^{
        @strongify(self);
        [self setImage:images.firstObject forState:state];
    } darkMode:^{
        @strongify(self);
        [self setImage:images.lastObject forState:state];
    }];
}

- (void)theme_setBackgroundImageNames:(NSArray<NSString *> *)imageNames forState:(UIControlState)state {
    NSMutableArray *arrayM = @[].mutableCopy;
    for (NSString *imageName in imageNames) {
        UIImage *image = [UIImage imageNamed:imageName];
        if (image != nil) {
            [arrayM addObject:image];
        }
    }
    [self theme_setBackgroundImages:arrayM.copy forState:state];
}

- (void)theme_setBackgroundImages:(NSArray<UIImage *> *)images forState:(UIControlState)state {
    if (images.count != 2) {
        [self setBackgroundImage:images.firstObject forState:state];
        return;
    }
    @weakify(self);
    [self theme_lightMode:^{
        @strongify(self);
        [self setBackgroundImage:images.firstObject forState:state];
    } darkMode:^{
        @strongify(self);
        [self setBackgroundImage:images.lastObject forState:state];
    }];
}

@end
