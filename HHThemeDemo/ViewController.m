//
//  ViewController.m
//  HHThemeDemo
//
//  Created by huxuewei on 2022/7/14.
//

#import "ViewController.h"
#import "HHTheme.h"

@interface ViewController ()

@property (nonatomic, assign) UIStatusBarStyle statusBarStyle;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.theme_backgroundColors = @[UIColor.whiteColor, UIColor.darkTextColor];
    
    UIButton *button = [self createButton];
    [self.view addSubview:button];
    button.theme_backgroundColors = @[UIColor.blackColor, UIColor.redColor];
    [button theme_setTitleColors:@[UIColor.whiteColor, UIColor.blackColor] forState:UIControlStateNormal];
    
    if (HHThemeManager.themeStyle == HHThemeStyleDark) {
        _statusBarStyle = UIStatusBarStyleLightContent;
    } else {
        _statusBarStyle = UIStatusBarStyleDarkContent;
    }
    __weak __typeof(self) weakSelf = self;
    [self theme_lightMode:^{
        __strong __typeof(weakSelf) self = weakSelf;
        self.statusBarStyle = UIStatusBarStyleDarkContent;
        [self setNeedsStatusBarAppearanceUpdate];
    } darkMode:^{
        __strong __typeof(weakSelf) self = weakSelf;
        self.statusBarStyle = UIStatusBarStyleLightContent;
        [self setNeedsStatusBarAppearanceUpdate];
    }];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return _statusBarStyle;
}

- (UIButton *)createButton {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"Test Button" forState:UIControlStateNormal];
    [button sizeToFit];
    button.center = CGPointMake(UIScreen.mainScreen.bounds.size.width / 2, UIScreen.mainScreen.bounds.size.height / 2);
    [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    return button;
}

- (void)buttonAction {
    HHThemeManager.themeStyle = !HHThemeManager.themeStyle;
}

@end
