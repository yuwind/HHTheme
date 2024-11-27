//
//  HHThemeObserverView.m
//  HHThemeDemo
//
//  Created by huxuewei on 2022/7/14.
//

#import "HHThemeObserverView.h"
#import "HHThemeManager.h"

@implementation HHThemeObserverView

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    [super traitCollectionDidChange:previousTraitCollection];
    if (@available(iOS 13.0, *)) {
        if ([HHThemeManager themeStyle] != HHThemeStyleSystem) {
            return;
        }
        if ([self.traitCollection hasDifferentColorAppearanceComparedToTraitCollection:previousTraitCollection]) {
            if (self.traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
                [HHThemeManager updateInternalThemeStyle:HHThemeStyleDark];
            } else {
                [HHThemeManager updateInternalThemeStyle:HHThemeStyleLight];
            }
        }
    }
}

@end
