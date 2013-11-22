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
    NSMutableDictionary* LeftButtonItem;
    
    UIButton*  m_CurrentLeftButton;
    
    UIButton* m_NextLeftButton;
    
    NSMutableDictionary* RightButtonItem;
    
    UIButton* m_CurrentRightButton;
    
    UIButton* m_NextRightbutton;
    
    NSMutableDictionary* TitleLabelItem;
    
    UILabel* m_CurrentLabel;
//    
//    UILabel* m_NextLabel;
    
    struct DefaultFrame defaultFrame;
    
    BOOL LeftButtonModified;
    
    BOOL RightButtonModified;
    
    NSString* m_CurrentIdentifyID;
}

@property (nonatomic,strong,readwrite) NSMutableDictionary* LeftButtonItem;

@property (nonatomic,strong,readwrite) NSMutableDictionary* RightButtonItem;

@property (nonatomic,strong,readwrite) NSMutableDictionary* TitleLabelItem;

@end

@implementation NavigationBarView

@synthesize LeftButtonItem = _LeftButtonItem;

@synthesize RightButtonItem = _RightButtonItem;

@synthesize delegate = _delegate;

@synthesize TitleLabelItem = _TitleLabelItem;

static NSString* const DefaultTitle = @"";

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
        LeftButtonItem = [@{}mutableCopy];
        _RightButtonItem = [@{}mutableCopy];
        TitleLabelItem = [@{}mutableCopy];
        
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
//
///**
// Default NavigationBar style
// */
//-(void)SetNavigationBarAsDefault
//{
//    switch (defaultFrame.type) {
//        case NAVIGATION_TYPE_LEFT_BUTTON:
//            m_NextLeftButton = [self InitLeftButtonWithFrame:defaultFrame.LeftButtonFrame];
//            [LeftButtonItem addObject:m_NextLeftButton];
//            [RightButtonItem addObject:FillString];
//            break;
//        case NAVIGATION_TYPE_RIGHT_BUTTON:
//            m_NextRightbutton = [self InitRightButtonWithFrame:defaultFrame.RightButtonFrame];
//            [RightButtonItem addObject:m_NextRightbutton];
//            [LeftButtonItem addObject:FillString];
//            break;
//        case NAVIGATION_TYPE_LEFT_RIGHT_BUTTON:
//            m_NextLeftButton = [self InitLeftButtonWithFrame:defaultFrame.LeftButtonFrame];
//            m_NextRightbutton = [self InitRightButtonWithFrame:defaultFrame.RightButtonFrame];
//            [LeftButtonItem addObject:m_NextLeftButton];
//            [RightButtonItem addObject:m_NextRightbutton];
//            break;
//    }
//    [TitleLabelItem addObject:@""];
//}

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
//    if ([[LeftButtonItem allKeysForObject:m_CurrentLeftButton]count]) {
//        NSString* key = [[LeftButtonItem allKeysForObject:m_CurrentLeftButton]objectAtIndex:0];
//        LeftButtonItem[key] = btn;
//        m_CurrentLeftButton = btn;
    LeftButtonItem[m_CurrentIdentifyID] = m_CurrentLeftButton;
    [self addSubview:m_CurrentLeftButton];
//    }
}

-(void)SetRightButtonItem:(UIButton*)btn
{
    if (m_CurrentRightButton) {
        [m_CurrentRightButton removeFromSuperview];
    }
    m_CurrentRightButton = btn;
    //    if ([[RightButtonItem allKeysForObject:m_CurrentRightButton]count]) {
    //        NSString* key = [[RightButtonItem allKeysForObject:m_CurrentRightButton]objectAtIndex:0];
    //        RightButtonItem[key] = btn;
    //        m_CurrentRightButton = btn;
    RightButtonItem[m_CurrentIdentifyID] = m_CurrentRightButton;
    [self addSubview:m_CurrentRightButton];
    //    }
}

#pragma Configure

/**
 Update NavigationBar in different viewController
 */
-(void)UpdateNavigationBarWithType:(int)type ViewController:(NavigationBaseViewController*)viewController
{
    //Obtain NextViewID and set current view IdentifyID equal to NextViewID
    m_CurrentIdentifyID = viewController.IdentifyID;
    
    switch (defaultFrame.type) {
        case NAVIGATION_TYPE_LEFT_BUTTON:
            [self UpdateLeftButtonWithType:type ViewController:viewController];
            break;
        case NAVIGATION_TYPE_RIGHT_BUTTON:
            [self UpdateRightButtonWithType:type ViewController:viewController];
            break;
        case NAVIGATION_TYPE_LEFT_RIGHT_BUTTON:
            [self UpdateLeftButtonAndRightButtonWithType:type ViewController:viewController];
            break;
    }
    [self UpdateTitleLabelWithType:type ViewController:viewController];
    
//    switch (type) {
//    //Push Method
//        case UPDATE_NAVIGATIONBAR_TYPE_PUSH:
////            [self SetNavigationBarAsDefault];
//            if ([LeftButtonItem count] != 0)
//            {
//                [m_CurrentLeftButton removeFromSuperview];
//                [m_CurrentRightButton removeFromSuperview];
//                [m_CurrentLabel removeFromSuperview];
//            }
//            m_CurrentLeftButton = m_NextLeftButton;
//            m_CurrentRightButton = m_NextRightbutton;
//            m_CurrentLabel.text = @"";
//            [self AddAllCurrentStyleView];
//            break;
//    //Pop Method
//        case UPDATE_NAVIGATIONBAR_TYPE_POP:
//            [m_CurrentLeftButton removeFromSuperview];
//            [m_CurrentRightButton removeFromSuperview];
//            
//            [LeftButtonItem removeLastObject];
//            [RightButtonItem removeLastObject];
//            [TitleLabelItem removeLastObject];
//            
//            m_CurrentLeftButton = [LeftButtonItem lastObject];
//            m_CurrentRightButton = [RightButtonItem lastObject];
//            if ([[LeftButtonItem lastObject] isKindOfClass:[NSString class]]) {
//                m_CurrentLeftButton = nil;
//            }
//            if ([[LeftButtonItem lastObject] isKindOfClass:[NSString class]]){
//                m_CurrentRightButton = nil;
//            }
//            m_CurrentLabel.text = [TitleLabelItem lastObject];
//            [self AddAllCurrentStyleView];
//            break;
//    //Clear All ViewController except rootViewController
//        case UPDATE_NAVIGATIONBAR_TYPE_CLEAR:
//            [LeftButtonItem removeObjectsInRange:NSMakeRange(1, [LeftButtonItem count]-1)];
//            [RightButtonItem removeObjectsInRange:NSMakeRange(1, [RightButtonItem count]-1)];
//            [TitleLabelItem removeObjectsInRange:NSMakeRange(1, [TitleLabelItem count]-1)];
//            
//            m_CurrentLeftButton = [LeftButtonItem objectAtIndex:0];
//            m_CurrentRightButton = [RightButtonItem objectAtIndex:0];
//            m_CurrentLabel = [TitleLabelItem objectAtIndex:0];
//            [self AddAllCurrentStyleView];
//            break;
//    }
    [self ResetNextButtonInfo];
}

/**
	Remove Button View And Set Title Default
 */
-(void)RemoveCurrentView
{
    if ([LeftButtonItem count] != 0)
    {
        [m_CurrentLeftButton removeFromSuperview];
        [m_CurrentRightButton removeFromSuperview];
    }
}

/**
	Delete CurrentButton Information from ButtonDictionary
 */
-(void)DeleteButtonWithIdentify:(NSString*)Identify
{
    if (LeftButtonItem[Identify]) {
        [LeftButtonItem removeObjectForKey:Identify];
    }
    if (RightButtonItem[Identify]) {
        [RightButtonItem removeObjectForKey:Identify];
    }
}

/**
    Instead NavigationBar Button from current button With Next button
 */
-(void)ChangeCurrentButtonWithNextCurrentButton
{
    m_CurrentLeftButton = m_NextLeftButton;
    m_CurrentRightButton = m_NextRightbutton;
}

/**
	Share Code With UpdateNavigationbar
 */
-(void)CommonPushView:(NSString*)Identify
{
    //Remove Current View
    [self RemoveCurrentView];
    
    //Set NavigationBar Views of Next ViewController
    if (LeftButtonItem[Identify]) {
        [self addSubview:m_NextLeftButton];
    }
    if (RightButtonItem[Identify]) {
        [self addSubview:m_NextRightbutton];
    }
    [self ChangeCurrentButtonWithNextCurrentButton];
}

-(void)CommonPopView:(NSString*)Identify
{
    //Remove Current View
    [self RemoveCurrentView];
    
    //Delete ViewController
    [self DeleteButtonWithIdentify:Identify];
    
    //Add View to Navigationbar
    if ((m_CurrentLeftButton = LeftButtonItem[Identify])) {
        [self addSubview:m_CurrentRightButton];
    }
    if ((m_CurrentRightButton = RightButtonItem[Identify])) {
        [self addSubview:m_CurrentRightButton];
    }
}

-(void)CommonToRootView:(NSString*)Identify
{
    [self RemoveCurrentView];
}

/**
	All Kind of type Update Method
 */
-(void)UpdateLeftButtonWithType:(UPDATE_NAVIGATIONBAR_TYPE)type ViewController:(NavigationBaseViewController*)viewController
{
    NSString* Identify = viewController.IdentifyID;
    switch (type) {
            //Push Method
        case UPDATE_NAVIGATIONBAR_TYPE_PUSH:
            //Initilization Default View
            if (!(m_NextLeftButton = LeftButtonItem[Identify])) {
                m_NextLeftButton = [self InitLeftButtonWithFrame:defaultFrame.LeftButtonFrame];
                LeftButtonItem[Identify] = m_NextLeftButton;
            }
            m_NextRightbutton = RightButtonItem[Identify];
            //Using Common Code
            [self CommonPushView:Identify];
            break;
            //Pop Method
        case UPDATE_NAVIGATIONBAR_TYPE_POP:
            [self CommonPopView:Identify];
            break;
            //Clear All ViewController except rootViewController
        case UPDATE_NAVIGATIONBAR_TYPE_TO_ROOTVIEW:
            [self CommonToRootView:Identify];
            break;
    }
}

-(void)UpdateRightButtonWithType:(UPDATE_NAVIGATIONBAR_TYPE)type ViewController:(NavigationBaseViewController*)viewController
{
    NSString* Identify = viewController.IdentifyID;
    switch (type) {
            //Push Method
        case UPDATE_NAVIGATIONBAR_TYPE_PUSH:
            //Initilization Default View
            if (!(m_NextRightbutton = RightButtonItem[Identify])) {
                m_NextRightbutton = [self InitLeftButtonWithFrame:defaultFrame.RightButtonFrame];
                RightButtonItem[Identify] = m_NextRightbutton;
            }
            m_NextLeftButton = LeftButtonItem[Identify];
            //Using Common Code
            [self CommonPushView:Identify];
            break;
            //Pop Method
        case UPDATE_NAVIGATIONBAR_TYPE_POP:
            [self CommonPopView:Identify];
            break;
            //Clear All ViewController except rootViewController
        case UPDATE_NAVIGATIONBAR_TYPE_TO_ROOTVIEW:
            [self CommonToRootView:Identify];
            break;
    }
}

-(void)UpdateLeftButtonAndRightButtonWithType:(UPDATE_NAVIGATIONBAR_TYPE)type ViewController:(NavigationBaseViewController*)viewController
{
    NSString* Identify = viewController.IdentifyID;
    switch (type) {
            //Push Method
        case UPDATE_NAVIGATIONBAR_TYPE_PUSH:
            //Initilization Default View
            if (!(m_NextLeftButton = LeftButtonItem[Identify])) {
                m_NextLeftButton = [self InitLeftButtonWithFrame:defaultFrame.LeftButtonFrame];
                LeftButtonItem[Identify] = m_NextLeftButton;
            }
            if (!(m_NextRightbutton = RightButtonItem[Identify])) {
                m_NextRightbutton = [self InitLeftButtonWithFrame:defaultFrame.RightButtonFrame];
                RightButtonItem[Identify] = m_NextRightbutton;
            }
            //Using Common Code
            [self CommonPushView:Identify];
            break;
            //Pop Method
        case UPDATE_NAVIGATIONBAR_TYPE_POP:
            [self CommonPopView:Identify];
            break;
            //Clear All ViewController except rootViewController
        case UPDATE_NAVIGATIONBAR_TYPE_TO_ROOTVIEW:
            [self CommonToRootView:Identify];
            break;
    }
}

-(void)UpdateTitleLabelWithType:(UPDATE_NAVIGATIONBAR_TYPE)type ViewController:(NavigationBaseViewController*)viewController
{
    switch (type) {
        case UPDATE_NAVIGATIONBAR_TYPE_PUSH:
            break;
        case UPDATE_NAVIGATIONBAR_TYPE_POP:
            //Delete Current ViewController Title
            if (TitleLabelItem[viewController.IdentifyID]) {
                [TitleLabelItem removeObjectForKey:viewController.IdentifyID];
            }
            break;
            //Clear All ViewController except rootViewController
        case UPDATE_NAVIGATIONBAR_TYPE_TO_ROOTVIEW:
            break;
    }
    if (TitleLabelItem[viewController.IdentifyID]) {
        m_CurrentLabel.text = TitleLabelItem[viewController.IdentifyID];
    }
    else
    {
        m_CurrentLabel.text = DefaultTitle;
    }
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
        TitleLabelItem[m_CurrentIdentifyID] = title;
        [m_CurrentLabel setText:title];
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
    if ([[LeftButtonItem allKeysForObject:m_CurrentLeftButton]count]) {
        NSString* key = [[LeftButtonItem allKeysForObject:m_CurrentLeftButton]objectAtIndex:0];
        [LeftButtonItem[key] setTitle:title forState:state];
    }
}

-(void)SetRightButtonTitle:(NSString*)title State:(UIControlState)state
{
    if ([[RightButtonItem allKeysForObject:m_CurrentRightButton]count]) {
        NSString* key = [[RightButtonItem allKeysForObject:m_CurrentRightButton]objectAtIndex:0];
        [RightButtonItem[key] setTitle:title forState:state];
    }
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
