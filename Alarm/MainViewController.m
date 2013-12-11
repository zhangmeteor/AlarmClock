//
//  MainViewController.m
//  Alarm
//
//  Created by zhanghao on 13-11-25.
//  Copyright (c) 2013年 zhanghao. All rights reserved.
//

#import "MainViewController.h"

#import "GlobalFunction.h"

#import "LeftSliderViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Recevie notificaiton from SliderBar
    [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector(ShowCurrentView:) name:ChangeCurrentViewNotification object:nil];
    
    //Set default View Alarm View
    [self performSegueWithIdentifier:@"AlarmView" sender:nil];
    
	// Do any additional setup after loading the view.
}

/**
	Show the CurrentView Which was Clicked By SliderBar
 */
-(void)ShowCurrentView:(NSNotification*)indexPath
{
    int CurrentViewID = [[indexPath object]row];
    
    [self.navigationController popToRootViewControllerAnimated:NO];
    
    switch (CurrentViewID) {
        case VIEW_MODE_ALARM:
            [self performSegueWithIdentifier:@"AlarmView" sender:self];
            break;
        case VIEW_MODE_WAKEUP_TREND:
            [self performSegueWithIdentifier:@"WakeUpTrendView" sender:self];
            break;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
