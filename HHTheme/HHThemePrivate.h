//
//  HHThemeConstant.h
//  HHThemeDemo
//
//  Created by huxuewei on 2022/7/14.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^ThemeActionBlock)(void);

static inline void theme_performActionOnMainThread(ThemeActionBlock actionBlock) {
    if (NSThread.isMainThread) {
        if (actionBlock) {
            actionBlock();
        }
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (actionBlock) {
                actionBlock();
            }
        });
    }
}

static inline void theme_performActionOnBackgroundThread(ThemeActionBlock actionBlock) {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        if (actionBlock) {
            actionBlock();
        }
    });
}

#define mThemeObjectAddress(object) [NSString stringWithFormat:@"theme_%p",object]

#define mThemeAvailableWindow ({UIWindow *window = nil;\
if ([UIApplication.sharedApplication.delegate respondsToSelector:@selector(window)]) {\
    window = UIApplication.sharedApplication.delegate.window;\
}\
if (window == nil) {\
    window = UIApplication.sharedApplication.keyWindow;\
}\
window;})

#if DEBUG
#define theme_keywordify autoreleasepool {}
#else
#define theme_keywordify try {} @catch (...) {}
#endif

#define themeWeak(var) theme_keywordify __weak __typeof(var) __weak__##var = var;
#define themeStrong(var) theme_keywordify __strong typeof(var) var = __weak__##var;

NS_ASSUME_NONNULL_END
