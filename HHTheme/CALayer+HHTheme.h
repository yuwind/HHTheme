//
//  CALayer+HHTheme.h
//  HHThemeDemo
//
//  Created by huxuewei on 2022/7/14.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CALayer (HHTheme)

//write only
@property (nonatomic, copy) NSArray<UIColor *> *theme_backgroundColors;
@property (nonatomic, copy) NSArray<UIColor *> *theme_borderColors;
@property (nonatomic, copy) NSArray<UIColor *> *theme_shadowColors;

@end

NS_ASSUME_NONNULL_END
