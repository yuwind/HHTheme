//
//  HHThemeConstant.h
//  HHThemeDemo
//
//  Created by huxuewei on 2022/7/14.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^HHThemeModeBlock)(void);

typedef NS_ENUM(NSUInteger, HHThemeStyle) {
    HHThemeStyleSystem,
    HHThemeStyleLight,
    HHThemeStyleDark,
};

NS_ASSUME_NONNULL_END
