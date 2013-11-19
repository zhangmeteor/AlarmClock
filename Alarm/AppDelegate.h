//
//  AppDelegate.h
//  Alarm
//
//  Created by zhanghao on 13-11-19.
//  Copyright (c) 2013年 zhanghao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AlarmSetViewController;

@class LeftSliderViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) AlarmSetViewController *viewController;

@property (strong,nonatomic) LeftSliderViewController* leftSliderViewController;

@end
