//
//  UIImageView+HHTheme.m
//  HHThemeDemo
//
//  Created by huxuewei on 2022/7/14.
//

#import "UIImageView+HHTheme.h"
#import "NSObject+HHTheme.h"
#import "HHThemePrivate.h"

@implementation UIImageView (HHTheme)

@dynamic theme_images;
@dynamic theme_imageNames;

- (void)setTheme_images:(NSArray<UIImage *> *)theme_images {
    if (theme_images.count != 2) {
        self.image = theme_images.firstObject;
        return;
    }
    @weakify(self);
    [self theme_lightMode:^{
        @strongify(self);
        self.image = theme_images.firstObject;
    } darkMode:^{
        @strongify(self);
        self.image = theme_images.lastObject;
    }];
}

- (void)setTheme_imageNames:(NSArray<NSString *> *)theme_imageNames {
    NSMutableArray *arrayM = @[].mutableCopy;
    for (NSString *imageName in theme_imageNames) {
        UIImage *image = [UIImage imageNamed:imageName];
        if (image != nil) {
            [arrayM addObject:image];
        }
    }
    [self setTheme_images:arrayM.copy];
}

@end
