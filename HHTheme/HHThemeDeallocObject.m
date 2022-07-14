//
//  HHThemeDeallocObject.m
//  HHThemeDemo
//
//  Created by huxuewei on 2022/7/14.
//

#import "HHThemeDeallocObject.h"

@interface HHThemeDeallocObject ()

@property (nonatomic, copy) void(^callBack)(void);

@end

@implementation HHThemeDeallocObject

+ (instancetype)deallocObjectWithCallBack:(void (^)(void))callBack {
    HHThemeDeallocObject *object = [HHThemeDeallocObject new];
    object.callBack = callBack;
    return object;
}

- (void)dealloc {
    if (self.callBack) {
        self.callBack();
    }
}

@end
