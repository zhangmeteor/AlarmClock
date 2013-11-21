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

@interface AlarmSetViewController ()

@end

@implementation AlarmSetViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.nav.m_NavBar SetTitle:@"test"];
    [self.nav.m_NavBar SetLeftButtonTitle:@"Back" State:UIControlStateNormal];
   
	// Do any additional setup after loading the view, typically from a nib.
}

#pragma TableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section    // fixed font style. use custom view (UILabel) if you want something different
//{
//    
//    return @"test";
//}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* CellIdentifier = @"cell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
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
