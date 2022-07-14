//
//  UIImageView+HHTheme.h
//  HHThemeDemo
//
//  Created by huxuewei on 2022/7/14.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (HHTheme)

//write only
@property (nonatomic, copy) NSArray<UIImage *> *theme_images;
@property (nonatomic, copy) NSArray<NSString *> *theme_imageNames;

@end

NS_ASSUME_NONNULL_END
