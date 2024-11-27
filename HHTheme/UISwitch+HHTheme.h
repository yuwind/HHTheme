//
//  UISwitch+HHTheme.h
//  HHThemeDemo
//
//  Created by huxuewei on 2024/11/27.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UISwitch (HHTheme)

@property (nonatomic, copy) NSArray<UIColor *> * theme_onTintColors;
@property (nonatomic, copy) NSArray<UIColor *> * theme_thumbTintColors;

@end

NS_ASSUME_NONNULL_END
