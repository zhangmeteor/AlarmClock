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
    UPDATE_NAVIGATIONBAR_TYPE_TO_ROOTVIEW,
}UPDATE_NAVIGATIONBAR_TYPE;


typedef enum _navigation_type
{
	NAVIGATION_TYPE_LEFT_BUTTON,	/** 左侧有按钮 */
	NAVIGATION_TYPE_RIGHT_BUTTON,	/** 右侧有按钮 */
	NAVIGATION_TYPE_LEFT_RIGHT_BUTTON,	/** 两边都有按钮 */
    /** NavigationBar Type */
}NAVIGATION_TYPE;

typedef enum _default_button_tag
{
	DEFAULT_LEFT_BUTTON_TAG = 1001,	/** 默认左侧按钮tag */
	DEFAULT_RIGHT_BUTTON_TAG,	/** 默认右侧按钮tag */
    /** NavigationBar 默认按钮Tag */
}DEFAULT_BUTTON_TAG;

/**
 Save Default Frame Size defined by Initilization
 */
struct DefaultFrame
{
	CGRect LeftButtonFrame;	/** Default Left Button Frame*/
	CGRect RightButtonFrame;	/** Default Right Button Frame */
    CGRect LabelFrame;        /** Default Label Frame */
    NAVIGATION_TYPE type; /** Default NavigationBar Type */
};

@class NavigationBaseViewController;

@interface NavigationBarView : UIView

@property (nonatomic,weak) id<NavigationBarDelegate> delegate;

@property (nonatomic,strong,readonly) NSMutableDictionary* LeftButtonItem;

@property (nonatomic,strong,readonly) NSMutableDictionary* RightButtonItem;

@property (nonatomic,strong,readonly) NSMutableDictionary* TitleLabelItem;

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
-(void)UpdateNavigationBarWithType:(int)type ViewController:(NavigationBaseViewController*)viewController;
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
