//
//  ViewController.m
//  Alarm
//
//  Created by zhanghao on 13-11-19.
//  Copyright (c) 2013年 zhanghao. All rights reserved.
//

#import "AlarmViewController.h"

#import "GlobalFunction.h"

#import "NavigationBarDelegate.h"

#import "UIPositionDefine.h"

#import "AddAlarmViewController.h"

#import "AlarmCell.h"

@interface AlarmViewController ()
{
    NSUserDefaults* userDefault;
}

@property (nonatomic, assign) int m_alarmNumber;
@property (strong, nonatomic) IBOutlet UITableView *AlarmTableView;
@end

@implementation AlarmViewController
@synthesize m_alarmNumber       = _m_alarmNumber;

- (id)initWithStyle:(UITableViewStyle)style
{
    self                            = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    userDefault                            = [NSUserDefaults standardUserDefaults];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

/**
	刷新页面
 */
-(void)viewWillAppear:(BOOL)animated
{
    [_AlarmTableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section   // custom view for header. will be adjusted to default or specified header height
//{
//    UILabel* headerLabel            = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 320, tableView.rowHeight)];
//    headerLabel.text                = @"test";
//    headerLabel.textAlignment       = NSTextAlignmentCenter;
//    return headerLabel;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [GlobalFunction GetClockNumber];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* CellIdentifier = @"cell";
    UITableViewCell* cell           = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell                            = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell = [[[NSBundle mainBundle]loadNibNamed:@"AlarmCell" owner:self options:nil]objectAtIndex:0];
    NSDictionary* clockDictionary = [userDefault objectForKey:[NSString stringWithFormat:@"%d",indexPath.row]];
    //设置提示内容和重复日期
    NSString* Remember = [clockDictionary objectForKey:@"ClockRemember"];
    NSString* Repeat = [clockDictionary objectForKey:@"ClockRepeat"];
    ((AlarmCell*)cell).AlarmRememberAndRepeat.text = [NSString stringWithFormat:@"%@,  %@",Remember,Repeat];
    //设置时间
    NSArray* time = [clockDictionary objectForKey:@"ClockTime"];
    ((AlarmCell*)cell).AlarmAmOrPm.text = [time objectAtIndex:1];
    ((AlarmCell*)cell).AlarmTime.text = [time objectAtIndex:0];
    return cell;
}

/**
 Edit Alarm
 */
- (IBAction)EditAlarm:(id)sender
{
    
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation

 // In a story board-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }

 */
@end
