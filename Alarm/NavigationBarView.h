//
//  NavigationBarView.h
//  Alarm
//
//  Created by zhanghao on 13-11-19.
//  Copyright (c) 2013年 zhanghao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum _navigation_button_frame
{
	NAVIGATION_BUTTON_FRAME_DEAFULT,	/** Using Deafult Button Frame */
    NAVIGATION_BUTTON_FRAME_CUSTOMIZE, /** Using Customize Button Frame */
    /** Navigation Button Frame type */
}NAVIGATION_BUTTON_FRAME;

@interface NavigationBarView : UIView

/**
    initialization Method
 */
- (id)initNavigationBarWithLeftButton:(CGRect)LeftButtonframe UsingFrameType:(NAVIGATION_BUTTON_FRAME)type;

- (id)initNavigationBarWithRightButton:(CGRect)RightButtonframe UsingFrameType:(NAVIGATION_BUTTON_FRAME)type;

- (id)initNavigationBarWithLeftButton:(CGRect)LeftButtonframe RightButton:(CGRect)RightButtonframe UsingFrameType:(NAVIGATION_BUTTON_FRAME)type;

/**
    Navigation Button Click Method
 */
-(void)LeftButtonClicked;

-(void)RightButtonClicked;

/**
	Navigation Configure
 */
-(void)SetTitle:(NSString*)title;

-(void)SetTitleFont:(UIFont*)font;

-(void)SetTitleColor:(UIColor*)color;

-(void)SetBackgroundColor:(UIColor*)color;

-(void)SetBackgroundImage:(UIImage*)image;

-(void)SetLeftButtonTitle:(NSString*)title State:(UIControlState)state;

-(void)SetRightButtonTitle:(NSString*)title State:(UIControlState)state;

@end
