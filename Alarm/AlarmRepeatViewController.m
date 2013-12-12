//
//  AlarmRepeatViewController.m
//  Alarm
//
//  Created by zhanghao on 13-12-11.
//  Copyright (c) 2013年 zhanghao. All rights reserved.
//

#import "AlarmRepeatViewController.h"
typedef enum _weekday
{
    SUNDAY = 0,
    MONDAY,
    TUESDAY,
    WEDNESDAY,
    THURSDAY,
    FRIDAY,
    SATURDAY,
    SMALL_WEEKDAY,
    BIG_WEEKDAY,
}WEEKDAY;

@interface AlarmRepeatViewController ()
{
    NSArray* RepeatTime;
}
@property (assign, nonatomic)BOOL IsWeekdayChoose;
@property (retain, nonatomic)NSIndexPath* Saturday;
@property (retain, nonatomic)NSIndexPath* Sunday;
@property (retain, nonatomic)NSString* RepeatType;

@end

@implementation AlarmRepeatViewController
@synthesize SelectedDays;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
   self                            = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    SelectedDays = 0x000;
    RepeatTime                      = @[@"每周日",@"每周一",@"每周二",@"每周三",@"每周四",@"每周五",@"每周六",@"大周",@"小周"];
    _RepeatType = @"每周";
    // Do any additional setup after loading the view from its nib.
}

#pragma UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [RepeatTime count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   static NSString* CellIdentifier = @"cell";
   UITableViewCell* cell           = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
   cell                            = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }   cell.textLabel.text             = RepeatTime[indexPath.row];
     if ((SelectedDays >> indexPath.row) & 0x001)
     {
         cell.accessoryType              = UITableViewCellAccessoryCheckmark;
     }
    return  cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //存储周六周日状态
    if (indexPath.row == SATURDAY) {
        _Saturday = indexPath;
    }
    if (indexPath.row == SUNDAY) {
        _Sunday = indexPath;
    }

    //选中框
    UITableViewCell* cell           = [tableView cellForRowAtIndexPath:indexPath];
    //大周小周不能同时选中
    if (cell.accessoryType == UITableViewCellAccessoryCheckmark) {
        if (indexPath.row == BIG_WEEKDAY || indexPath.row == SMALL_WEEKDAY)
        {
            _IsWeekdayChoose = FALSE;
        }
        cell.accessoryType              = UITableViewCellAccessoryNone;
    }
    else if (!_IsWeekdayChoose)
    {
        if (indexPath.row == BIG_WEEKDAY || indexPath.row == SMALL_WEEKDAY) {
            //清除周六周日选中状态
            [tableView cellForRowAtIndexPath: _Saturday].accessoryType = UITableViewCellAccessoryNone;
            [tableView cellForRowAtIndexPath: _Sunday].accessoryType = UITableViewCellAccessoryNone;
            _IsWeekdayChoose = YES;
        }
        cell.accessoryType              = UITableViewCellAccessoryCheckmark;
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
    

//返回事件
-(void)viewWillDisappear:(BOOL)animated
{
    //获取所有选择框的状态
    for (NSInteger row = 0; row < [RepeatTime count]; row++) {
        NSIndexPath* indexpath = [NSIndexPath indexPathForRow:row inSection:0];
        UITableViewCell* cell = [_AlarmRepeatTableView cellForRowAtIndexPath:indexpath];
        
        if (cell.accessoryType == UITableViewCellAccessoryCheckmark) {
            switch (row) {
                case MONDAY:
                    _RepeatType = [_RepeatType stringByAppendingString:[self CutString:RepeatTime[MONDAY]]];
                    break;
                case TUESDAY:
                    _RepeatType = [_RepeatType stringByAppendingString:[self CutString:RepeatTime[TUESDAY]]];
                    break;
                case WEDNESDAY:
                    _RepeatType = [_RepeatType stringByAppendingString:[self CutString:RepeatTime[WEDNESDAY]]];
                    break;
                case THURSDAY:
                    _RepeatType = [_RepeatType stringByAppendingString:[self CutString:RepeatTime[THURSDAY]]];
                    break;
                case FRIDAY:
                    _RepeatType = [_RepeatType stringByAppendingString:[self CutString:RepeatTime[FRIDAY]]];
                    break;
            }
            SelectedDays  = (((SelectedDays>>row) | 0x001)<<row) | SelectedDays;
        }
    }
    
    //全部选中的情况
    if (SelectedDays  == 0x07f) {
       _RepeatType = @"每天";
        //回调函数，返回当前重复的类型
        [_delegate AlarmRepeatType:SelectedDays Text:_RepeatType];
        return;
    }
    //全部不选中的情况
    if (SelectedDays  == 0x000) {
        _RepeatType = @"永不";
        //回调函数，返回当前重复的类型
        [_delegate AlarmRepeatType:SelectedDays Text:_RepeatType];
        return;
    }
   //选中大小周和没选中大小周的处理
    if (_IsWeekdayChoose) {
        if (SelectedDays >> BIG_WEEKDAY & 0x001) {
            _RepeatType = [_RepeatType stringByAppendingString:RepeatTime[BIG_WEEKDAY]];
        }
        else if (SelectedDays >> SMALL_WEEKDAY & 0x001)
        {
           _RepeatType= [_RepeatType stringByAppendingString:RepeatTime[SMALL_WEEKDAY]];
        }
    }
    else
    {
        if (SelectedDays>>SATURDAY & 0x001) {
           _RepeatType = [_RepeatType stringByAppendingString:[self CutString:RepeatTime[SATURDAY]]];
        }
        if (SelectedDays>>SUNDAY & 0x001) {
            _RepeatType = [_RepeatType stringByAppendingString:[self CutString:RepeatTime[SUNDAY]]];
        }
    }
    //回调函数，返回当前重复的类型
    [_delegate AlarmRepeatType:SelectedDays Text:_RepeatType];
}

-(NSString*)CutString:(NSString*)str
{
    NSArray* array = [str componentsSeparatedByString:@"每周"];
    return [NSString stringWithFormat:@"%@ ",[array objectAtIndex:1]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
