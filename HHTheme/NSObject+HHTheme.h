//
//  NSObject+HHTheme.h
//  HHThemeDemo
//
//  Created by huxuewei on 2022/7/14.
//

#import <Foundation/Foundation.h>
#import "HHThemeConstant.h"

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (HHTheme)

//watch out for circular references
- (void)theme_lightMode:(nullable HHThemeModeBlock)lightMode darkMode:(nullable HHThemeModeBlock)darkMode;

//called when the object is destroyed
- (void)theme_afterDeallocCallBack:(void(^ _Nullable)(void))callBack;

@end

NS_ASSUME_NONNULL_END
