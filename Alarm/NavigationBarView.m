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
        // Initialization code
        self.frame = CGRectMake(0, 0, 320, 30);
        [self InitLeftButtonWithFrame:LeftButtonframe];
    }
    return self;
}

- (id)initNavigationBarWithRightButton:(CGRect)RightButtonframe
{
    self = [super init];
    if (self) {
        // Initialization code
        self.frame = CGRectMake(0, 0, 320, 30);
        [self InitRightButtonWithFrame:RightButtonframe];
    }
    return self;
}

- (id)initNavigationBarWithLeftButton:(CGRect)LeftButtonframe RightButton:(CGRect)RightButtonframe
{
    self = [super init];
    if (self) {
        // Initialization code
        self.frame = CGRectMake(0, 0, 320, 30);
        [self InitLeftButtonWithFrame:LeftButtonframe];
        [self InitRightButtonWithFrame:RightButtonframe];
    }
    return self;
}

/**
    Intialization NavigationBar button
 */
-(void)InitLeftButtonWithFrame:(CGRect)frame
{
    self.LeftButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.LeftButton setFrame:frame];
    [self addSubview:self.LeftButton];
}

-(void)InitRightButtonWithFrame:(CGRect)frame
{
    self.RightButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.RightButton setFrame:frame];
    [self addSubview:self.RightButton];
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
