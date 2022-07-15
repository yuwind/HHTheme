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

//theme style, above iOS 13 is HHThemeStyleSystem, below iOS 13 is HHThemeStyleLight
@property (nonatomic, assign, class) HHThemeStyle themeStyle;

//update internal style when system mode changed, not need to call
+ (void)updateInternalThemeStyle:(HHThemeStyle)themeStyle;

//store theme model
+ (void)storeThemeModel:(HHThemeModel *)themeModel;

//clear objects stored by the theme manager
+ (void)clearThemeStoreInfo;

@end

NS_ASSUME_NONNULL_END
