//
//  HHThemeModel.h
//  HHThemeDemo
//
//  Created by huxuewei on 2022/7/14.
//

#import <UIKit/UIKit.h>
#import "HHThemeConstant.h"

NS_ASSUME_NONNULL_BEGIN

@interface HHThemeModel : NSObject

@property (nonatomic, weak, readonly) id themeObject;
@property (nonatomic, copy, readonly) HHThemeModeBlock lightMode;
@property (nonatomic, copy, readonly) HHThemeModeBlock darkMode;

+ (instancetype)modelWithThemeObject:(id)themeObject lightMode:(HHThemeModeBlock)lightMode darkMode:(HHThemeModeBlock)darkModel;

@end

NS_ASSUME_NONNULL_END
