//
//  UIView+HHTheme.h
//  HHThemeDemo
//
//  Created by huxuewei on 2022/7/13.
//

#import <UIKit/UIKit.h>
#import "HHThemeConstant.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIView (HHTheme)

//write only
@property (nonatomic, copy) NSArray<UIColor *> *theme_backgroundColors;

//write only
@property (nonatomic, copy) NSArray<UIColor *> *theme_tintColors;

//write only
@property (nonatomic, copy) NSArray<NSNumber *> *theme_alphas;

@end

NS_ASSUME_NONNULL_END
