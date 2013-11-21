/**
	NavigationBarView.m
	  Alarm
	
	  Created by zhanghao on 13-11-19.
	  Copyright (c) 2013年 zhanghao. All rights reserved.
 */

#import "NavigationBarView.h"

#import "UIPositionDefine.h"

#import "GlobalFunction.h"

@interface NavigationBarView ()
{
    NSMutableArray* LeftButtonItem;
    
    UIButton*  m_CurrentLeftButton;
    
    UIButton* m_NextLeftButton;
    
    NSMutableArray* RightButtonItem;
    
    UIButton* m_CurrentRightButton;
    
    UIButton* m_NextRightbutton;
    
    NSMutableArray* TitleLabelItem;
    
    UILabel* m_CurrentLabel;
//    
//    UILabel* m_NextLabel;
    
    struct DefaultFrame defaultFrame;
    
    BOOL LeftButtonModified;
    
    BOOL RightButtonModified;
}

@end

@implementation NavigationBarView

@synthesize LeftButtonItem = _LeftButtonItem;

@synthesize RightButtonItem = _RightButtonItem;

@synthesize delegate = _delegate;

@synthesize TitleLabelItem = _TitleLabelItem;

/**
	initialization Method
 */
-(id)initWithType:(int)type LeftFrame:(CGRect)LeftButtonframe RIghtFrame:(CGRect)RightButtonframe UsingFrameType:(NAVIGATION_BUTTON_FRAME)frameType
{
    if (self = [super init]) {
        self.frame = NAVIGATION_UI_FRAME;
        //Defalut Frame Setting
        if (frameType == NAVIGATION_BUTTON_FRAME_DEAFULT) {
            LeftButtonframe = NAVIGATION_UI_LEFT_BUTTON_DEAFULT_FRAME;
            RightButtonframe = NAVIGATION_UI_RIGHT_BUTTON_DEAFULT_FRAME;
        }
        
        //Save Default Frame by Setting
        defaultFrame.LeftButtonFrame = LeftButtonframe;
        defaultFrame.RightButtonFrame = RightButtonframe;
        defaultFrame .LabelFrame = NAVIGATION_UI_TITLE_FRAME;
        defaultFrame.type = type;
        
        //initialization Button Array
        LeftButtonItem = [[NSMutableArray alloc]init];
        RightButtonItem = [[NSMutableArray alloc]init];
        TitleLabelItem = [[NSMutableArray alloc]init];
        
        //intialization Label
        m_CurrentLabel = [self InitLabelWithFrame:defaultFrame.LabelFrame];
        
        [self ResetNextButtonInfo];
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
    Intialization NavigationBar button and label
 */
-(UIButton*)InitLeftButtonWithFrame:(CGRect)frame
{
    UIButton* LeftButton;
    if (IS_IOS_7) {
        LeftButton = [UIButton buttonWithType:UIButtonTypeSystem];
    }
    else
    {
        LeftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    LeftButton.tag = DEFAULT_LEFT_BUTTON_TAG;
    [LeftButton setFrame:frame];
    [LeftButton addTarget:self action:@selector(LeftButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    
    return LeftButton;
}

-(UIButton*)InitRightButtonWithFrame:(CGRect)frame
{
   UIButton* RightButton;
    if (IS_IOS_7) {
        RightButton = [UIButton buttonWithType:UIButtonTypeSystem];
    }
    else
    {
        RightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    RightButton.tag = DEFAULT_RIGHT_BUTTON_TAG;
    [RightButton setFrame:frame];
    [RightButton addTarget:self action:@selector(RightButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    
    return RightButton;
}

-(UILabel*)InitLabelWithFrame:(CGRect)frame
{
    UILabel* label = [[UILabel alloc]initWithFrame:frame];
    [label setTextAlignment:NSTextAlignmentCenter];
    return label;
}

/**
 Default NavigationBar style
 */
-(void)SetNavigationBarAsDefault
{
    NSString* FillString = @"No View";
    switch (defaultFrame.type) {
        case NAVIGATION_TYPE_LEFT_BUTTON:
            m_NextLeftButton = [self InitLeftButtonWithFrame:defaultFrame.LeftButtonFrame];
            [LeftButtonItem addObject:m_NextLeftButton];
            [RightButtonItem addObject:FillString];
            break;
        case NAVIGATION_TYPE_RIGHT_BUTTON:
            m_NextRightbutton = [self InitRightButtonWithFrame:defaultFrame.RightButtonFrame];
            [RightButtonItem addObject:m_NextRightbutton];
            [LeftButtonItem addObject:FillString];
            break;
        case NAVIGATION_TYPE_LEFT_RIGHT_BUTTON:
            m_NextLeftButton = [self InitLeftButtonWithFrame:defaultFrame.LeftButtonFrame];
            m_NextRightbutton = [self InitRightButtonWithFrame:defaultFrame.RightButtonFrame];
            [LeftButtonItem addObject:m_NextLeftButton];
            [RightButtonItem addObject:m_NextRightbutton];
            break;
    }
    [TitleLabelItem addObject:@""];
}

/**
    Add All View To NavigaitonBar
 */
-(void)AddAllCurrentStyleView
{
    switch (defaultFrame.type) {
        case NAVIGATION_TYPE_LEFT_BUTTON:
            [self addSubview:m_CurrentLeftButton];
            if (m_CurrentRightButton) {
                [self addSubview:m_CurrentRightButton];
            }
            break;
        case NAVIGATION_TYPE_RIGHT_BUTTON:
            [self addSubview:m_CurrentRightButton];
            if (m_CurrentLeftButton) {
                [self addSubview:m_CurrentLeftButton];
            }
            break;
        case NAVIGATION_TYPE_LEFT_RIGHT_BUTTON:
            [self addSubview:m_CurrentLeftButton];
            [self addSubview:m_CurrentRightButton];
            break;
    }
    [self addSubview:m_CurrentLabel];
}

/**
    Set Button Hidden
 */

-(void)SetLeftButtonHidden:(BOOL)hidden
{
    [m_CurrentLeftButton setHidden:hidden];
}

-(void)SetRightButtonHidden:(BOOL)hidden
{
    [m_CurrentRightButton setHidden:hidden];
}

/**
 Set Button To NavigationBar
 */
-(void)SetLeftButtonItem:(UIButton*)btn
{
    if (m_CurrentLeftButton) {
        [m_CurrentLeftButton removeFromSuperview];
    }
    m_CurrentLeftButton = btn;
    [self addSubview:m_CurrentLeftButton];
    [LeftButtonItem replaceObjectAtIndex:[LeftButtonItem count]-1 withObject:m_CurrentLeftButton];
}

-(void)SetRightButtonItem:(UIButton*)btn
{
    if (m_CurrentRightButton) {
        [m_CurrentRightButton removeFromSuperview];
    }
    m_CurrentRightButton = btn;
    [self addSubview:m_CurrentRightButton];
    [RightButtonItem replaceObjectAtIndex:[RightButtonItem count]-1 withObject:m_CurrentRightButton];
}

#pragma Configure

/**
 Update NavigationBar in different viewController
 */
-(void)UpdateNavigationBarWithType:(int)type
{
    switch (type) {
    //Push Method
        case UPDATE_NAVIGATIONBAR_TYPE_PUSH:
            [self SetNavigationBarAsDefault];
            if ([LeftButtonItem count] != 0)
            {
                [m_CurrentLeftButton removeFromSuperview];
                [m_CurrentRightButton removeFromSuperview];
                [m_CurrentLabel removeFromSuperview];
            }
            m_CurrentLeftButton = m_NextLeftButton;
            m_CurrentRightButton = m_NextRightbutton;
            m_CurrentLabel.text = @"";
            [self AddAllCurrentStyleView];
            break;
    //Pop Method
        case UPDATE_NAVIGATIONBAR_TYPE_POP:
            [m_CurrentLeftButton removeFromSuperview];
            [m_CurrentRightButton removeFromSuperview];
            
            [LeftButtonItem removeLastObject];
            [RightButtonItem removeLastObject];
            [TitleLabelItem removeLastObject];
            
            m_CurrentLeftButton = [LeftButtonItem lastObject];
            m_CurrentRightButton = [RightButtonItem lastObject];
            if ([[LeftButtonItem lastObject] isKindOfClass:[NSString class]]) {
                m_CurrentLeftButton = nil;
            }
            if ([[LeftButtonItem lastObject] isKindOfClass:[NSString class]]){
                m_CurrentRightButton = nil;
            }
            m_CurrentLabel.text = [TitleLabelItem lastObject];
            [self AddAllCurrentStyleView];
            break;
    //Clear All ViewController except rootViewController
        case UPDATE_NAVIGATIONBAR_TYPE_CLEAR:
            [LeftButtonItem removeObjectsInRange:NSMakeRange(1, [LeftButtonItem count]-1)];
            [RightButtonItem removeObjectsInRange:NSMakeRange(1, [RightButtonItem count]-1)];
            [TitleLabelItem removeObjectsInRange:NSMakeRange(1, [TitleLabelItem count]-1)];
            
            m_CurrentLeftButton = [LeftButtonItem objectAtIndex:0];
            m_CurrentRightButton = [RightButtonItem objectAtIndex:0];
            m_CurrentLabel = [TitleLabelItem objectAtIndex:0];
            [self AddAllCurrentStyleView];
            break;
    }
    [self ResetNextButtonInfo];
}

/**
	Reset Modified State
 */
-(void)ResetNextButtonInfo
{
    m_NextLeftButton = nil;
    m_NextRightbutton = nil;
}

///**
// Reset NavigationBar To Default
// */
//-(void)ResetNavigationBar
//{
//    self.LeftButton.hidden = NO;
//    self.RightButton.hidden = NO;
//    
//    //Clear Button without Default Button
//    [self.subviews enumerateObjectsUsingBlock:^(UIButton* btn, NSUInteger idx, BOOL* stop)
//     {
//         if (btn.tag == DEFAULT_LEFT_BUTTON_TAG || btn.tag == DEFAULT_RIGHT_BUTTON_TAG) {
//         }
//         else
//         {
//             if ([btn isKindOfClass:[UIButton class]]) {
//                 [btn removeFromSuperview];
//             }
//         }
//     }];
//}

/**
 Set NavigationBar Title
 */
-(void)SetTitle:(NSString*)title
{
    [m_CurrentLabel setText:title];
    [TitleLabelItem replaceObjectAtIndex:[TitleLabelItem count]-1 withObject:title];
}

-(void)SetTitleColor:(UIColor*)color
{
    [m_CurrentLabel setTextColor:color];
}

-(void)SetTitleFont:(UIFont*)font
{
    [m_CurrentLabel setFont:font];
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
    [[LeftButtonItem lastObject] setTitle:title forState:state];
}

-(void)SetRightButtonTitle:(NSString*)title State:(UIControlState)state
{
    [[RightButtonItem lastObject] setTitle:title forState:state];
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
