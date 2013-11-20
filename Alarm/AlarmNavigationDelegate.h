//
//  AlarmNavigationDelegate.h
//  Alarm
//
//  Created by zhanghao on 13-11-20.
//  Copyright (c) 2013年 zhanghao. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol AlarmNavigationDelegate <NSObject>
/**
	跳转指定viewController
 */
-(void)AlarmNavigationController:(AlarmNavigationController*)navigationController didShowViewController:(NavigationBaseViewController*)viewController;

@end
