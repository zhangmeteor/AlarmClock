//
//  NavigationBarDelegate.h
//  Alarm
//
//  Created by zhanghao on 13-11-19.
//  Copyright (c) 2013年 zhanghao. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol NavigationBarDelegate <NSObject>

/**
    Navigation Button Click Method
 */
-(void)LeftNavigationButtonClicked;

-(void)RightNavigationButtonClicked;

@end
