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
    userDefault                            = [NSUserDefaults standardUserDefaults];
    _AlarmTableView.allowsSelection = NO;
    _AlarmTableView.allowsSelectionDuringEditing = YES;
    [super viewDidLoad];
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
    ((AlarmCell*)cell).editingAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    NSDictionary* clockDictionary = [userDefault objectForKey:[NSString stringWithFormat:@"%d",indexPath.row]];
    //设置提示内容和重复日期
    NSString* Remember = [clockDictionary objectForKey:@"ClockRemember"];
    NSString* Repeat = [clockDictionary objectForKey:@"ClockRepeat"];
    ((AlarmCell*)cell).AlarmRememberAndRepeat.text = [NSString stringWithFormat:@"%@,  %@",Remember,Repeat];
    //设置时间
    NSArray* time = [clockDictionary objectForKey:@"ClockTime"];
    ((AlarmCell*)cell).AlarmAmOrPm.text = [time objectAtIndex:1];
    ((AlarmCell*)cell).AlarmTime.text = [time objectAtIndex:0];
    //设置本地推送
    [self SetClockAlert:clockDictionary];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


/**
	点击编辑委托函数
 */
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (tableView.editing == YES) {
        ((AlarmCell*)cell).AlarmSwitch.hidden = YES;
    }
    else
    {
        ((AlarmCell*)cell).AlarmSwitch.hidden = NO;
    }
    return YES;
}

/**
 删除tableView方法
 */
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle==UITableViewCellEditingStyleDelete) {
        //        获取选中删除行索引值
        NSInteger row = [indexPath row];
        //        通过获取的索引值删除数组中的值
        [userDefault removeObjectForKey:[NSString stringWithFormat:@"%d",row]];
        [GlobalFunction DeleteClockNumber];
//        //        删除单元格的某一行时，在用动画效果实现删除过程
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        
        //回到完成状态
        [_AlarmTableView setEditing:NO animated:YES];
        self.navigationItem.leftBarButtonItem.title = @"编辑";
    }
}

/**
	设置本地推送
 */
-(void)SetClockAlert:(NSDictionary*)clockDictionary
{
    UILocalNotification* noti = [[UILocalNotification alloc]init];
    if (noti) {
        //设置推送时间
        noti.fireDate =
        //设置时区
        noti.timeZone = [NSTimeZone defaultTimeZone];
        //设置重复间隔
        noti.repeatInterval = NSWeekCalendarUnit;
        //推送声音
        noti.soundName = UILocalNotificationDefaultSoundName;
        //内容
        noti.alertBody = @"推送内容";
        //显示在icon上的红色圈中的数子
        noti.applicationIconBadgeNumber = 1;
        //设置userinfo 方便在之后需要撤销的时候使用
        NSDictionary *infoDic = [NSDictionary dictionaryWithObject:@"name" forKey:@"key"];
        noti.userInfo = infoDic;
        //添加推送到uiapplication
        UIApplication* app = [UIApplication sharedApplication];
        [app scheduleLocalNotification:noti];
    }
    
}

-(void)CancleClockAlert:(NSDictionary*)clockDictionary
{
    UIApplication *app = [UIApplication sharedApplication];
    //获取本地推送数组
    NSArray *localArr = [app scheduledLocalNotifications];
    
    //声明本地通知对象
    UILocalNotification *localNoti;
    
    if (localArr) {
        for (UILocalNotification *noti in localArr) {
            NSDictionary *dict = noti.userInfo;
            if (dict) {
                NSString *inKey = [dict objectForKey:@"key"];
                if ([inKey isEqualToString:key]) {
                    if (localNoti){
                        [localNoti release];
                        localNoti = nil;
                    }
                    localNoti = [noti retain];
                    break;
                }
            }
        }
        
        //判断是否找到已经存在的相同key的推送
        if (!localNoti) {
            //不存在 初始化
            localNoti = [[UILocalNotification alloc] init];
        }
        
        if (localNoti && !state) {
            //不推送 取消推送
            [app cancelLocalNotification:localNoti];
            return;
        }
    }
}

/**
 Edit Alarm
 */
- (IBAction)EditAlarm:(id)sender
{
    //没数据时不响应
    if (![GlobalFunction GetClockNumber]) {
        return;
    }
    
    if (_AlarmTableView.editing == NO) {
        [_AlarmTableView setEditing:YES animated:YES];
        self.navigationItem.leftBarButtonItem.title = @"完成";
    }
    else
    {
        [_AlarmTableView setEditing:NO animated:YES];
        self.navigationItem.leftBarButtonItem.title = @"编辑";
    }
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
