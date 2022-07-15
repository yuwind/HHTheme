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
    
    UIButton *systemButton = [self createButtonWithTitle:@"system" tag:0 offset:-60];
    [self.view addSubview:systemButton];
    systemButton.theme_backgroundColors = @[UIColor.blackColor, UIColor.redColor];
    [systemButton theme_setTitleColors:@[UIColor.whiteColor, UIColor.blackColor] forState:UIControlStateNormal];
    
    UIButton *lightButton = [self createButtonWithTitle:@"light" tag:1 offset:0];
    [self.view addSubview:lightButton];
    lightButton.theme_backgroundColors = @[UIColor.blackColor, UIColor.redColor];
    [lightButton theme_setTitleColors:@[UIColor.whiteColor, UIColor.blackColor] forState:UIControlStateNormal];
    
    UIButton *darkButton = [self createButtonWithTitle:@"dark" tag:2 offset:60];
    [self.view addSubview:darkButton];
    darkButton.theme_backgroundColors = @[UIColor.blackColor, UIColor.redColor];
    [darkButton theme_setTitleColors:@[UIColor.whiteColor, UIColor.blackColor] forState:UIControlStateNormal];
    
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

- (UIButton *)createButtonWithTitle:(NSString *)title tag:(NSInteger)tag offset:(CGFloat)offset{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.tag = tag;
    [button setTitle:title forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, 100, 44);
    button.center = CGPointMake(UIScreen.mainScreen.bounds.size.width / 2, UIScreen.mainScreen.bounds.size.height / 2 + offset);
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    return button;
}

- (void)buttonAction:(UIButton *)sender {
    HHThemeManager.themeStyle = sender.tag;
}

@end
