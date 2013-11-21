//
//  AlarmNavigationController.h
//  Alarm
//
//  Created by zhanghao on 13-11-20.
//  Copyright (c) 2013年 zhanghao. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "NavigationBarView.h"

@class NavigationBaseViewController;

@interface AlarmNavigationController : UIViewController

@property(nonatomic,strong,readonly)NavigationBarView* m_NavBar;

@property(nonatomic,strong,readonly)NavigationBaseViewController* m_RootController;

@property(nonatomic,strong,readonly)NavigationBaseViewController* m_CurrentController;

@property(nonatomic,strong,readonly)NSMutableArray* controller;

-(id)initWithRootController:(NavigationBaseViewController*)RootController WithNavigationBar:(NavigationBarView*)navBar;

-(void)pushViewController:(NavigationBaseViewController*)viewController withAnimation:(BOOL)animated;

-(void)popViewControllerWithAnimated:(BOOL)animated;

-(void)popToRootController:(BOOL)animated;

-(void)setHidden:(BOOL)hidden withAnimated:(BOOL)animated;

-(void)SetRootViewController:(NavigationBaseViewController*)rootController;

@end
