//
//  HHThemeDeallocObject.h
//  HHThemeDemo
//
//  Created by huxuewei on 2022/7/14.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HHThemeDeallocObject : NSObject

+ (instancetype)deallocObjectWithCallBack:(void(^)(void))callBack;

@end

NS_ASSUME_NONNULL_END
