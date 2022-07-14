//
//  HHThemeManager.h
//  HHThemeDemo
//
//  Created by huxuewei on 2022/7/13.
//

#import <Foundation/Foundation.h>
#import "HHThemeConstant.h"

NS_ASSUME_NONNULL_BEGIN

@class HHThemeModel;
@interface HHThemeManager : NSObject

//theme style, default HHThemeStyleLight
@property (nonatomic, assign, class) HHThemeStyle themeStyle;

//below iOS 13 are invalid, default true
@property (nonatomic, assign, class) BOOL shouldFollowSystem;

//store theme model
+ (void)storeThemeModel:(HHThemeModel *)themeModel;

//clear objects stored by the theme manager
+ (void)clearThemeStoreInfo;

@end

NS_ASSUME_NONNULL_END
