//
//  AppDelegate.h
//  Alarm
//
//  Created by zhanghao on 13-11-19.
//  Copyright (c) 2013年 zhanghao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AlarmNavigationController;

@class AlarmSetViewController;

@class LeftSliderViewController;

@class NavigationBarView;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) AlarmNavigationController *viewController;

@property (strong,nonatomic) LeftSliderViewController* leftSliderViewController;

@property(strong,nonatomic) AlarmSetViewController* alarmSetViewController;

@property(strong,nonatomic)NavigationBarView* NavBar;

@end
