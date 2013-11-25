//
//  ViewController.m
//  Alarm
//
//  Created by zhanghao on 13-11-19.
//  Copyright (c) 2013年 zhanghao. All rights reserved.
//

#import "AlarmSetViewController.h"

#import "GlobalFunction.h"

#import "NavigationBarDelegate.h"

#import "UIPositionDefine.h"

#import "AddAlarmViewController.h"

@interface AlarmSetViewController ()

@property (nonatomic, assign) int m_alarmNumber;

@end

@implementation AlarmSetViewController

@synthesize m_alarmNumber = _m_alarmNumber;

- (void)viewDidLoad
{
    [super viewDidLoad];
    //Set NavigaitonBar
    [self.nav.m_NavBar SetTitle:@"Alarm Clock"];
    [self.nav.m_NavBar SetTitleColor:[UIColor blueColor]];
//    [self.nav.m_NavBar SetLeftButtonTitle:@"Back" State:UIControlStateNormal];
    
    //Add Right NavigationBar ButtonItem
    UIButton* navRightBtnItem = [UIButton buttonWithType:UIButtonTypeContactAdd];
    navRightBtnItem.frame = NAVIGATION_UI_RIGHT_BUTTON_DEAFULT_FRAME;
    [navRightBtnItem addTarget:self action:@selector(navBtnItemClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.nav.m_NavBar SetRightButtonItem:navRightBtnItem];
   
	// Do any additional setup after loading the view, typically from a nib.
}

/**
    Add New Alarm
 */
-(void)navBtnItemClicked
{
    AddAlarmViewController* addAlarmViewController = [[AddAlarmViewController alloc]initWithNibName:@"AddAlarmViewController" bundle:nil];
    [self.nav pushViewController:addAlarmViewController withAnimation:YES];
}

#pragma TableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.m_alarmNumber;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section   // custom view for header. will be adjusted to default or specified header height
{
    UILabel* headerLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 320, tableView.rowHeight)];
    headerLabel.text = @"test";
    headerLabel.textAlignment = NSTextAlignmentCenter;
    return headerLabel;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* CellIdentifier = @"cell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    [cell setBackgroundColor:[UIColor clearColor]];
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setAlarmSetTableView:nil];
    [super viewDidUnload];
}
@end
