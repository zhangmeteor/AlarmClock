//
//  NavigationBarView.m
//  Alarm
//
//  Created by zhanghao on 13-11-19.
//  Copyright (c) 2013年 zhanghao. All rights reserved.
//

#import "NavigationBarView.h"

@interface NavigationBarView ()

@property (nonatomic,retain) UIButton* LeftButton;

@property (nonatomic,retain) UIButton* RightButton;

@end

@implementation NavigationBarView

@synthesize LeftButton = _LeftButton;

@synthesize RightButton = _RightButton;

/**
	initialization Method
 */
- (id)initNavigationBarWithLeftButton:(CGRect)LeftButtonframe
{
    self = [super init];
    if (self) {
        [self InitLeftButtonWithFrame:LeftButtonframe];
        // Initialization code
    }
    return self;
}

- (id)initNavigationBarWithRightButton:(CGRect)RightButtonframe
{
    self = [super init];
    if (self) {
        [self InitRightButtonWithFrame:RightButtonframe];
        // Initialization code
    }
    return self;
}

- (id)initNavigationBarWithLeftButton:(CGRect)LeftButtonframe RightButton:(CGRect)RightButtonframe
{
    self = [super init];
    if (self) {
        [self InitLeftButtonWithFrame:LeftButtonframe];
        [self InitRightButtonWithFrame:RightButtonframe];
        // Initialization code
    }
    return self;
}

/**
    Intialization NavigationBar button
 */
-(void)InitLeftButtonWithFrame:(CGRect)frame
{
    
}

-(void)InitRightButtonWithFrame:(CGRect)frame
{
    
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
