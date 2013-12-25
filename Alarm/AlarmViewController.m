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

/**
	Set Clock Alert
 */
- (void)SetClockAlertWith:(int)index Remember_p:(NSString **)Remember_p timeDate_p:(NSDate **)timeDate_p RepeatInterval_p:(NSString **)RepeatInterval_p
{
    NSDictionary* clockDictionary = [userDefault objectForKey:[NSString stringWithFormat:@"%d",index]];
    //设置提示内容和重复日期
    *Remember_p = [clockDictionary objectForKey:@"ClockRemember"];
    *RepeatInterval_p = [clockDictionary objectForKey:@"ClockRepeatInterval"];
    NSString* RepeatIntervalString = [clockDictionary objectForKey:@"ClockRepeatIntervalChar"];
    int RepeatIntervalInt = [RepeatIntervalString intValue];
    char RepeatIntervalChar  = RepeatIntervalInt & 0xfff;
    //设置时间
    *timeDate_p = [clockDictionary objectForKey:@"ClockTime"];
    //设置铃声
    NSString* Sound =  [clockDictionary objectForKey:@"ClockMusic"];
    //设置本地推送
    [self SetClockAlert:*timeDate_p Text:*Remember_p Sound:Sound RepeatInterval:RepeatIntervalChar UserID:index];
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
    
    NSString *Remember;
    NSString *RepeatInterval;
    NSDate *timeDate;
    [self SetClockAlertWith:indexPath.row Remember_p:&Remember timeDate_p:&timeDate RepeatInterval_p:&RepeatInterval];
    
    //设置cell显示内容
    ((AlarmCell*)cell).AlarmRememberAndRepeatInterval.text = [NSString stringWithFormat:@"%@,  %@",Remember,RepeatInterval];
    NSArray* timeArray =  [GlobalFunction ChangeDataTimeToString:timeDate];
    ((AlarmCell*)cell).AlarmAmOrPm.text = [timeArray objectAtIndex:1];
    ((AlarmCell*)cell).AlarmTime.text = [timeArray objectAtIndex:0];
    [((AlarmCell*)cell).AlarmSwitch addTarget:self action:@selector(SwitchAlarm:) forControlEvents:UIControlEventValueChanged];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (tableView.editing == YES) {
       //Get Infomation of Selected Alarm
        NSDictionary* clockDictionary = [userDefault    objectForKey:[NSString stringWithFormat:@"%d",indexPath.row]];
        
       //Jump to EditView of Selected Alarm
        UINavigationController* EditViewNavigation = [self.storyboard instantiateViewControllerWithIdentifier:@"AddAlarmViewControllerNavigation"];
        [self presentViewController:EditViewNavigation animated:YES completion:nil];
       
        AddAlarmViewController* EditView = [EditViewNavigation.viewControllers objectAtIndex:0];
        [EditView setClockID:indexPath.row + 1];
        [EditView setAlarmDefaultState:[@[[clockDictionary objectForKey:@"ClockRemember"],[clockDictionary objectForKey:@"ClockMusic"],[clockDictionary objectForKey:@"ClockRepeatInterval"],[clockDictionary objectForKey:@"ClockShuffle"],[clockDictionary objectForKey:@"ClockReminderLater"]]mutableCopy]];
        
        //回到完成状态
        [_AlarmTableView setEditing:NO animated:NO];
        self.navigationItem.leftBarButtonItem.title = @"编辑";
    }
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
        AlarmCell* cell = (AlarmCell*)[tableView cellForRowAtIndexPath:indexPath];
        int index = indexPath.row;
        
        [userDefault removeObjectForKey:[NSString stringWithFormat:@"%d",index]];
        for (int i = index + 1; i <= [GlobalFunction GetClockNumber]; i++) {
            NSString* preClockID = [NSString stringWithFormat:@"%d",i-1];
            NSString* clockID = [NSString stringWithFormat:@"%d",i];
            NSMutableDictionary* clockDic = [[userDefault objectForKey:clockID]copy];
            //        通过获取的索引值删除数组中的值
            [userDefault removeObjectForKey:clockID];
            [userDefault setObject:clockDic forKey:preClockID];
        }
        [GlobalFunction DeleteClockNumber];
        
        //开启时，先取消通知
        if (cell.AlarmSwitch.isOn) {
            [self CancleClockAlert:index];
        }
        [userDefault synchronize];
        
        //    删除单元格的某一行时，在用动画效果实现删除过程
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
        
        //回到完成状态
        [_AlarmTableView setEditing:NO animated:NO];
        self.navigationItem.leftBarButtonItem.title = @"编辑";
//        [_AlarmTableView reloadData];
    }
}

/**
	设置本地推送
 */
-(void)SetClockAlert:(NSDate*)date Text:(NSString*)text Sound:(NSString*)sound RepeatInterval:(char)interval UserID:(int)id
{
    for (int i = SUNDAY ; i < WEEKDAY_COUNT; i++) {
        if ((interval>>i)&0x001) {
            NSDate* AlertDate= [date dateByAddingTimeInterval:3600*24*i];
            //先关闭可能存在的本地通知
            [self CancleClockAlert:id];
            //添加本地通知
            [self AddLocalNotificationWithDate:AlertDate Text:text Sound:sound UserID:id];
        }
    }
    //大周设置
    if ((interval>>BIG_WEEKDAY)&0x001) {
       
    }
    //小周设置
    if ((interval>>SMALL_WEEKDAY)&0x001) {
        
    }
}

-(void)AddLocalNotificationWithDate:(NSDate*)date Text:(NSString*)text Sound:(NSString*)sound UserID:(int)id
{
    @autoreleasepool {
        UILocalNotification* noti = [[UILocalNotification alloc]init];
        if (noti) {
            //设置推送时间
            noti.fireDate = date;
            //设置时区
            noti.timeZone = [NSTimeZone defaultTimeZone];
            //设置重复间隔
            noti.repeatInterval = NSWeekCalendarUnit;
            //推送声音
            noti.soundName = [NSString stringWithFormat:@"%@.m4a",sound];
            //内容
            noti.alertBody = text;
            //显示在icon上的红色圈中的数子
            noti.applicationIconBadgeNumber = 1;
            //设置userinfo 方便在之后需要撤销的时候使用
            NSDictionary *infoDic = [NSDictionary dictionaryWithObject:[NSString stringWithFormat:@"%d",id] forKey:@"ActivityClock"];
            noti.userInfo = infoDic;
            //添加推送到uiapplication
            UIApplication* app = [UIApplication sharedApplication];
            [app scheduleLocalNotification:noti];
        }
    }
}


-(void)CancleClockAlert:(int)clockID
{
    UIApplication *app = [UIApplication sharedApplication];
    //获取本地推送数组
    NSArray *localArr = [app scheduledLocalNotifications];
    //声明本地通知对象
    
    if (localArr) {
       [localArr enumerateObjectsUsingBlock:^(UILocalNotification* noti, NSUInteger idx, BOOL* stop)
        {
            if ([[[noti userInfo]objectForKey:@"ActiveAlarm"]intValue] == clockID) {
                [app cancelLocalNotification:noti];
            }
        }];
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

-(void)SwitchAlarm:(id)sender
{
    //Swith State
    UISwitch* Switch                                       = (UISwitch*)sender;
    BOOL  isButtonOn                                       = [Switch isOn];
   
    UISwitch *switchView = (UISwitch *)sender;
    UITableViewCell *cell = (UITableViewCell *)switchView.superview.superview.superview;
    
    NSIndexPath *SwitchIndexPath = [_AlarmTableView indexPathForCell:cell];
    
    NSString *Remember;
    NSString *RepeatInterval;
    NSDate *timeDate;
    
    switch (isButtonOn) {
        case TRUE:
            [self SetClockAlertWith:SwitchIndexPath.row Remember_p:&Remember timeDate_p:&timeDate RepeatInterval_p:&RepeatInterval];
            break;
        case FALSE:
            [self CancleClockAlert:SwitchIndexPath.row];
            break;
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
