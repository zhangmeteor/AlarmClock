//
//  AlarmNavigationController.m
//  Alarm
//
//  Created by zhanghao on 13-11-20.
//  Copyright (c) 2013年 zhanghao. All rights reserved.
//

#import "AlarmNavigationController.h"

#import "AlarmNavigationDelegate.h"

#import "NavigationBarView.h"

@interface AlarmNavigationController ()<NavigationBarDelegate>
{
    NavigationBarView* m_NavBar;
    
    NavigationBaseViewController* m_RootController;
    
    NavigationBaseViewController* m_CurrentController;
    
    NSMutableArray* controller;
}

@property (nonatomic,assign)id <AlarmNavigationDelegate> delegate;

@end

@implementation AlarmNavigationController

@synthesize delegate = _delegate;

@synthesize m_NavBar = _m_NavBar;

@synthesize controller = _controller;

@synthesize m_RootController = _m_RootController;

@synthesize m_CurrentController = _m_CurrentController;

static const int ANIMATION_DURATION = 0.5;

static NSString* PUSH_ANIMATION = @"Push_Animation";

static NSString* POP_ANIMATION = @"Pop_Animation";

-(id)initWithRootController:(NavigationBaseViewController*)RootController WithNavigationBar:(NavigationBarView*)navBar
{
    if (self = [super initWithNibName:@"AlarmNavigationController" bundle:nil]) {
        self.controller = [[NSMutableArray alloc]init];
        self.m_RootController = RootController;
        self.m_NavBar = navBar;
        self.m_NavBar.delegate = self;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addSubview:self.m_NavBar];
    [self pushViewController:self.m_RootController withAnimation:NO];
	// Do any additional setup after loading the view, typically from a nib.
}

-(void)pushViewController:(NavigationBaseViewController*)viewController withAnimation:(BOOL)animated
{
    if ([self.controller count] == 0) {
        self.m_RootController = viewController;
    }
    
    //Add viewController to Stack,Set CurretController.
    [self.controller addObject:viewController];
    viewController.nav = self;
    self.m_CurrentController = viewController;
    
    //Set Animation
    if (animated) {
        [self AddAnimate:PUSH_ANIMATION];
    }
    
    //Update NavigationBarInfo Before Push
    [self.m_NavBar UpdateNavigationBarWithType:UPDATE_NAVIGATIONBAR_TYPE_PUSH];
    
    //Set RootViewController View
    if (self.m_CurrentController == self.m_RootController) {
        [self.m_NavBar SetLeftButtonHidden:YES];
    }
    
    //Show View of CurrentViewController
    [self.view addSubview:viewController.view];
    [self ShowCurrentView];
    
    //transmit Selector
    if ([self.delegate respondsToSelector:@selector(AlarmNavigationController:didShowViewController:)]) {
        [self.delegate AlarmNavigationController:self didShowViewController:self.m_CurrentController];
    }
}

-(void)popViewControllerWithAnimated:(BOOL)animated
{
    //Delete CurrentViewController
    [self.m_CurrentController.view removeFromSuperview];
    [self.controller removeObject:self.m_CurrentController];
    self.m_CurrentController = nil;
    
    //Set CurrentViewController
    if ([self.controller count]) {
        self.m_CurrentController = [self.controller lastObject];
    }
    
    //Set Animation
    if (animated) {
        [self AddAnimate:POP_ANIMATION];
    }
    
    //Update NavigationBarInfo Before Pop
    [self.m_NavBar UpdateNavigationBarWithType:UPDATE_NAVIGATIONBAR_TYPE_POP];
    
    [self ShowCurrentView];
}

-(void)popToRootController:(BOOL)animated
{
    if ([self.controller count] < 1) {
        return;
    }
    
    //Clear All ViewController except RootViewController
    [self.controller enumerateObjectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(1, self.controller.count-1)] options:NSEnumerationReverse usingBlock:^(NavigationBaseViewController* viewController, NSUInteger idx,BOOL* stop){
        [viewController.view removeFromSuperview];
        [self.controller removeObject:viewController];
        viewController = nil;
    }];
    
    if ([self.controller lastObject] != self.m_RootController) {
        NavigationBaseViewController* navigationBaseViewController = [self.controller lastObject];
        [navigationBaseViewController.view removeFromSuperview];
        [self.controller removeAllObjects];
        controller = nil;
    }
    
    //Set Animation
    if (animated) {
        [self AddAnimate:POP_ANIMATION];
    }
    self.m_CurrentController = self.m_RootController;
    //Update NavigationBarInfo Before Pop
    [self.m_NavBar UpdateNavigationBarWithType:UPDATE_NAVIGATIONBAR_TYPE_CLEAR];
    
    [self ShowCurrentView];
}

/**
	Hidden NavigationBar Or Not
 */
-(void)setHidden:(BOOL)hidden withAnimated:(BOOL)animated
{
    if (animated) {
    }
    switch (hidden) {
        case YES:
            [self.m_NavBar removeFromSuperview];
            break;
        case NO:
            [self.view addSubview:self.m_NavBar];
            break;
    }
}

/**
	设置RootViewController
 */
-(void)SetRootViewController:(NavigationBaseViewController*)rootController
{
    self.m_RootController = rootController;
}

#pragma Common Method

/**
	Add Animtate To CurrentView
 */
-(void)AddAnimate:(NSString*)type
{
    if (![self.view.layer animationForKey:type]) {
        //remove all animations before Add New Animation
        [self.view.layer removeAllAnimations];
        CATransition* animation = [CATransition animation];
        animation.duration = ANIMATION_DURATION;
        animation.timingFunction = UIViewAnimationCurveEaseInOut;
        animation.fillMode = kCAFillModeBackwards;
        animation.type = kCATransitionPush;
        animation.delegate = self;
        
        if ([type isEqualToString:PUSH_ANIMATION]) {
            animation.subtype = kCATransitionFromRight;
        }
        else if ([type isEqualToString:POP_ANIMATION])
        {
            animation.subtype = kCATransitionFromLeft;
        }
        else
        {
            return;
        }
        [self.view.layer addAnimation:animation forKey:type];
    }
}


#pragma NavigationBarDelegate

-(void)LeftNavigationButtonClicked
{
    [self popViewControllerWithAnimated:YES];
}

-(void)RightNavigationButtonClicked
{
    NSLog(@"Right Clicked");
}

/**
	Show CurrentView
 */
-(void)ShowCurrentView
{
    [self.view bringSubviewToFront:self.m_NavBar];
    [self.m_CurrentController viewWillAppear:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

@end
