//
//  UIButton+HHTheme.h
//  HHThemeDemo
//
//  Created by huxuewei on 2022/7/14.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (HHTheme)

- (void)theme_setTitleColors:(NSArray<UIColor *> *)colors forState:(UIControlState)state;
- (void)theme_setImageNames:(NSArray<NSString *> *)imageNames forState:(UIControlState)state;
- (void)theme_setImages:(NSArray<UIImage *> *)images forState:(UIControlState)state;
- (void)theme_setBackgroundImageNames:(NSArray<NSString *> *)imageNames forState:(UIControlState)state;
- (void)theme_setBackgroundImages:(NSArray<UIImage *> *)images forState:(UIControlState)state;

@end

NS_ASSUME_NONNULL_END
