//
//  NavigationBarView.h
//  Alarm
//
//  Created by zhanghao on 13-11-19.
//  Copyright (c) 2013年 zhanghao. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "NavigationBarDelegate.h"

typedef enum _navigation_button_frame
{
	NAVIGATION_BUTTON_FRAME_DEAFULT,	/** Using Deafult Button Frame */
    NAVIGATION_BUTTON_FRAME_CUSTOMIZE, /** Using Customize Button Frame */
    /** Navigation Button Frame type */
}NAVIGATION_BUTTON_FRAME;

typedef enum _update_navigationbar_type
{
    UPDATE_NAVIGATIONBAR_TYPE_PUSH,
    UPDATE_NAVIGATIONBAR_TYPE_POP,
    UPDATE_NAVIGATIONBAR_TYPE_CLEAR,
}UPDATE_NAVIGATIONBAR_TYPE;

@interface NavigationBarView : UIView

@property (nonatomic,assign) id<NavigationBarDelegate> delegate;

@property (nonatomic,retain) NSMutableArray* LeftButtonItem;

@property (nonatomic,retain) NSMutableArray* RightButtonItem;

@property (nonatomic,retain) NSMutableArray* TitleLabelItem;

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
	Set Button Hidden
 */
-(void)SetLeftButtonHidden:(BOOL)hidden;

-(void)SetRightButtonHidden:(BOOL)hidden;

/**
	Update NavigationBar in different viewController
 */
-(void)UpdateNavigationBarWithType:(int)type;

/**
	Set Button To NavigationBar
 */
-(void)SetLeftButtonItem:(UIButton*)btn;

-(void)SetRightButtonItem:(UIButton*)btn;

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
