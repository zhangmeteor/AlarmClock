/**
	NavigationBarView.m
	  Alarm
	
	  Created by zhanghao on 13-11-19.
	  Copyright (c) 2013年 zhanghao. All rights reserved.
 */

#import "NavigationBarView.h"

#import "UIPositionDefine.h"

#import "GlobalFunction.h"

typedef enum _navigation_type
{
	NAVIGATION_TYPE_LEFT_BUTTON,	/** 左侧有按钮 */
	NAVIGATION_TYPE_RIGHT_BUTTON,	/** 右侧有按钮 */
	NAVIGATION_TYPE_LEFT_RIGHT_BUTTON,	/** 两边都有按钮 */
		/** NavigationBar Type */
}NAVIGATION_TYPE;

@interface NavigationBarView ()

@property (nonatomic,retain) UIButton* LeftButton;

@property (nonatomic,retain) UIButton* RightButton;

@property (nonatomic,retain) UILabel* TitleLabel;

@end

@implementation NavigationBarView

@synthesize LeftButton = _LeftButton;

@synthesize RightButton = _RightButton;

@synthesize delegate = _delegate;

@synthesize TitleLabel = _TitleLabel;

/**
	initialization Method
 */
-(id)initWithType:(int)type LeftFrame:(CGRect)LeftButtonframe RIghtFrame:(CGRect)RightButtonframe UsingFrameType:(NAVIGATION_BUTTON_FRAME)frameType
{
    if (self = [super init]) {
        self.frame = NAVIGATION_UI_FRAME;
        //Add TitleLabel To View
        self.TitleLabel = [[UILabel alloc]initWithFrame:NAVIGATION_UI_TITLE_FRAME];
        [self.TitleLabel setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:self.TitleLabel];
        
        //Defalut Frame Setting
        if (frameType == NAVIGATION_BUTTON_FRAME_DEAFULT) {
            LeftButtonframe = NAVIGATION_UI_LEFT_BUTTON_DEAFULT_FRAME;
            RightButtonframe = NAVIGATION_UI_RIGHT_BUTTON_DEAFULT_FRAME;
        }
        
        switch (type) {
            case NAVIGATION_TYPE_LEFT_BUTTON:
                [self InitLeftButtonWithFrame:LeftButtonframe];
                break;
            case NAVIGATION_TYPE_RIGHT_BUTTON:
                [self InitRightButtonWithFrame:RightButtonframe];
                break;
            case NAVIGATION_TYPE_LEFT_RIGHT_BUTTON:
                [self InitLeftButtonWithFrame:LeftButtonframe];
                [self InitRightButtonWithFrame:RightButtonframe];
                break;
        }
    }
    return self;
}

- (id)initNavigationBarWithLeftButton:(CGRect)LeftButtonframe UsingFrameType:(NAVIGATION_BUTTON_FRAME)type
{
    return [self initWithType:NAVIGATION_TYPE_LEFT_BUTTON LeftFrame:LeftButtonframe RIghtFrame:CGRectZero UsingFrameType:type];
}

- (id)initNavigationBarWithRightButton:(CGRect)RightButtonframe UsingFrameType:(NAVIGATION_BUTTON_FRAME)type
{
    return [self initWithType:NAVIGATION_TYPE_LEFT_BUTTON LeftFrame:CGRectZero RIghtFrame:RightButtonframe UsingFrameType:type];
}

- (id)initNavigationBarWithLeftButton:(CGRect)LeftButtonframe RightButton:(CGRect)RightButtonframe UsingFrameType:(NAVIGATION_BUTTON_FRAME)type
{
    return [self initWithType:NAVIGATION_TYPE_LEFT_RIGHT_BUTTON LeftFrame:LeftButtonframe RIghtFrame:RightButtonframe UsingFrameType:type];
}

/**
    Intialization NavigationBar button
 */
-(void)InitLeftButtonWithFrame:(CGRect)frame
{
    if (IS_IOS_7) {
       self.LeftButton = [UIButton buttonWithType:UIButtonTypeSystem];
    }
    else
    {
        self.LeftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    [self.LeftButton setFrame:frame];
    [self.LeftButton addTarget:self action:@selector(LeftButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.LeftButton];
}

-(void)InitRightButtonWithFrame:(CGRect)frame
{
    if (IS_IOS_7) {
        self.RightButton = [UIButton buttonWithType:UIButtonTypeSystem];
    }
    else
    {
        self.RightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    [self.RightButton setFrame:frame];
    [self.RightButton addTarget:self action:@selector(RightButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.RightButton];
}

/**
 Set Button Hidden
 */

-(void)SetLeftButtonHidden:(BOOL)hidden
{
    self.LeftButton.hidden = hidden;
}

-(void)SetRightButtonHidden:(BOOL)hidden
{
    self.RightButton.hidden = hidden;
}

#pragma Configure

/**
    Set NavigationBar Title
 */
-(void)SetTitle:(NSString*)title
{
    [self.TitleLabel setText:title];
}

-(void)SetTitleColor:(UIColor*)color
{
    [self.TitleLabel setTextColor:color];
}

-(void)SetTitleFont:(UIFont*)font
{
    [self.TitleLabel setFont:font];
}

/**
	Set Background Color
 */
-(void)SetBackgroundColor:(UIColor*)color
{
    [self SetBackgroundColor:color];
}

/**
	Set Backgound Image
 */
-(void)SetBackgroundImage:(UIImage*)image
{
    [self SetBackgroundImage:image];
}

/**
	Set Button Title
 */
-(void)SetLeftButtonTitle:(NSString*)title State:(UIControlState)state
{
    [self.LeftButton setTitle:title forState:state];
}

-(void)SetRightButtonTitle:(NSString*)title State:(UIControlState)state
{
    [self.RightButton setTitle:title forState:state];
}

#pragma DelegateMethod
/**
	Navigation Button Click Method
 */
-(void)LeftButtonClicked
{
    [self.delegate LeftNavigationButtonClicked];
}

-(void)RightButtonClicked
{
    [self.delegate RightNavigationButtonClicked];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
