//
//  UILabel+HHTheme.h
//  HHThemeDemo
//
//  Created by huxuewei on 2022/7/14.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (HHTheme)

//write only
@property (nonatomic, copy) NSArray<UIColor *> * theme_textColors;

@end

NS_ASSUME_NONNULL_END
