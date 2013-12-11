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
@property (assign, nonatomic)char   SelectedDays;

@end

@implementation AlarmRepeatViewController

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
    _SelectedDays = 0x000;
   RepeatTime                      = @[@"每周日",@"每周一",@"每周二",@"每周三",@"每周四",@"每周五",@"每周六",@"大周",@"小周"];
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
    [_AlarmRepeatTableView.subviews enumerateObjectsUsingBlock:^(NSIndexPath* indexPath, NSUInteger idx, BOOL* stop)
    {
        if ([_AlarmRepeatTableView cellForRowAtIndexPath:indexPath].accessoryType == UITableViewCellAccessoryCheckmark) {
//            switch (indexPath.row) {
//                case BIG_WEEKDAY:
//                    [self SetUpSelectDaysWithIndex:indexPath.row];
//                    break;
//                case SMALL_WEEKDAY:
//                    [self SetUpSelectDaysWithIndex:indexPath.row];
//                    break;
//                case MONDAY:
//                    _SelectedDays  = ((_SelectedDays>>5) | 0x01)<<5;
//                    break;
//                case TUESDAY:
//                    _SelectedDays  = ((_SelectedDays>>4) | 0x01)<<4;
//                    break;
//                case WEDNESDAY:
//                    _SelectedDays  = ((_SelectedDays>>3) | 0x01)<<3;
//                    break;
//                case THURSDAY:
//                    _SelectedDays  = ((_SelectedDays>>2) | 0x01)<<2;
//                    break;
//                case FRIDAY:
//                    _SelectedDays  = ((_SelectedDays>>1) | 0x01)<<1;
//                    break;
//                case SATURDAY:
//                    _SelectedDays  = ((_SelectedDays>>1) | 0x01)<<0;
//                    break;
//                case SUNDAY:
//                    _SelectedDays  = ((_SelectedDays>>0) | 0x01)<<0;
//                    break;
//            }
            _SelectedDays  = ((_SelectedDays>>indexPath.row) | 0x01)<<indexPath.row;
        }
    }];
    
    if (_IsWeekdayChoose) {
        if (_SelectedDays >> BIG_WEEKDAY) {
            
        }
        else if (_SelectedDays >> SMALL_WEEKDAY)
        {
            
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
