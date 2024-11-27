//
//  CAShapeLayer+HHTheme.h
//  HHThemeDemo
//
//  Created by huxuewei on 2024/11/20.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CAShapeLayer (HHTheme)

//write only
@property (nonatomic, copy) NSArray<UIColor *> *theme_fillColors;
@property (nonatomic, copy) NSArray<UIColor *> *theme_strokeColors;

@end

NS_ASSUME_NONNULL_END
