//
//  HHThemeConstant.h
//  HHThemeDemo
//
//  Created by huxuewei on 2022/7/14.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#if DEBUG
#define hh_keywordify autoreleasepool {}
#else
#define hh_keywordify try {} @catch (...) {}
#endif

#define weakify(var) hh_keywordify __weak __typeof(var) __weak__##var = var;
#define strongify(var) hh_keywordify __strong typeof(var) var = __weak__##var;

NS_ASSUME_NONNULL_END
