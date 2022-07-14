//
//  HHThemeModel.m
//  HHThemeDemo
//
//  Created by huxuewei on 2022/7/14.
//

#import "HHThemeModel.h"

@interface HHThemeModel ()

@property (nonatomic, weak) id themeObject;
@property (nonatomic, copy) HHThemeModeBlock lightMode;
@property (nonatomic, copy) HHThemeModeBlock darkMode;

@end

@implementation HHThemeModel

+ (instancetype)modelWithThemeObject:(UIView *)themeObject lightMode:(HHThemeModeBlock)lightMode darkMode:(HHThemeModeBlock)darkModel {
    HHThemeModel *model = [HHThemeModel new];
    model.themeObject = themeObject;
    model.lightMode = lightMode;
    model.darkMode = darkModel;
    return model;
}

@end
