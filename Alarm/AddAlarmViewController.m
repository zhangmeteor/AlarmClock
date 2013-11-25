//
//  AddAlarmViewController.m
//  Alarm
//
//  Created by zhanghao on 13-11-21.
//  Copyright (c) 2013年 zhanghao. All rights reserved.
//

#import "AddAlarmViewController.h"

#import "UIPositionDefine.h"

@interface AddAlarmViewController ()

@end

@implementation AddAlarmViewController

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
    
//    //Add Right NavigationBar ButtonItem
//    UIButton* navRightBtnItem = [UIButton buttonWithType:UIButtonTypeSystem];
//    [navRightBtnItem setTitle:@"Submit" forState:UIControlStateNormal];
//    navRightBtnItem.frame = NAVIGATION_UI_RIGHT_BUTTON_DEAFULT_FRAME;
//    [navRightBtnItem addTarget:self action:@selector(navBtnItemClicked) forControlEvents:UIControlEventTouchUpInside];
//    [self.nav.m_NavBar SetRightButtonItem:navRightBtnItem];
    
    // Do any additional setup after loading the view from its nib.
}

/**
    Submit Alarm Setting
 */
-(void)navBtnItemClicked
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
