//
//  NavigationBarView.h
//  Alarm
//
//  Created by zhanghao on 13-11-19.
//  Copyright (c) 2013年 zhanghao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NavigationBarView : UIView
/**
 initialization Method
 */
- (id)initNavigationBarWithLeftButton:(CGRect)LeftButtonframe;

- (id)initNavigationBarWithRightButton:(CGRect)RightButtonframe;

- (id)initNavigationBarWithLeftButton:(CGRect)LeftButtonframe RightButton:(CGRect)RightButtonframe;

@end
