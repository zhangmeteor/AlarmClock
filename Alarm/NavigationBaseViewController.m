//
//  NavigationBaseViewViewController.m
//  Alarm
//
//  Created by zhanghao on 13-11-20.
//  Copyright (c) 2013年 zhanghao. All rights reserved.
//

#import "NavigationBaseViewController.h"

#import "AlarmNavigationController.h"

@interface NavigationBaseViewController ()

@property(nonatomic,strong,readwrite)NSString* IdentifyID;

@end

@implementation NavigationBaseViewController
@synthesize nav = _nav;
@synthesize IdentifyID = _IdentifyID;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.IdentifyID =[NSString stringWithFormat:@"%d", [self GetViewControllerUUID]];
        // Custom initialization
    }
    return self;
}

/**
 Get UUID for everyViewController
 */
-(__uint32_t)GetViewControllerUUID
{
    return geteuid();
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
