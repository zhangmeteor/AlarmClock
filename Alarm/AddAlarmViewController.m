//
//  AddAlarmViewController.m
//  Alarm
//
//  Created by zhanghao on 13-11-21.
//  Copyright (c) 2013年 zhanghao. All rights reserved.
//

#import "AddAlarmViewController.h"

#import "UIPositionDefine.h"

#import "GlobalFunction.h"

#import "SwitchCell.h"

#import "SetAlarmCell.h"

#import "AlarmRememberViewController.h"

#import "AlarmRememberDelegate.h"

/**
	设置每行label名称
 */
typedef enum _alarm_set_item
{
    ALARM__REMEMBER                             = 0, /** 提醒内容 */
	ALARM_SOUND,	/** 铃声 */
	ALARM_REPEAT,	/** 重复 */
    ALARM_SHUFFLE,	/** 随机铃声 */
	ALARM_REMINDER_LATER,	/** 稍后提醒 */
}ALARM_SET_ITEM;

@interface AddAlarmViewController ()<AlarmRememberDelegate>
{
    NSArray* AlarmSetItem;
    NSMutableArray* AlarmDefaultState;
    BOOL     IsReminderLater;
    BOOL     IsShuffle;
}
@end

@implementation AddAlarmViewController
@synthesize clockID;
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.clockID                                = [GlobalFunction GetClockNumber] + 1;
    AlarmSetItem                                = @[@"提醒内容",@"铃声",@"重复",@"随机铃声",@"稍后提醒"];
    AlarmDefaultState                           = [@[@"闹钟",@"雷达",@"永不",@"",@""]mutableCopy];
    
    // Do any additional setup after loading the view from its nib.
}

/**
    Add Alarm
 */
- (IBAction)SaveAlarm:(id)sender {
  //Alarm数据序列化
    NSMutableDictionary* clockDictionary        = [NSMutableDictionary dictionaryWithCapacity:5];
    [self.view.subviews enumerateObjectsUsingBlock:^(UILabel* label , NSUInteger idx , BOOL* stop)
    {
        if ([label isKindOfClass:[UILabel class]]) {
            switch (label.tag) {
                case ALARM__REMEMBER:
                    [clockDictionary setObject:label.text forKey:@"ClockRemember"];
                    break;
                case ALARM_SOUND:
                    [clockDictionary setObject:label.text forKey:@"ClockMusic"];
                    break;
                case ALARM_REPEAT:
                    [clockDictionary setObject:label.text forKey:@"ClockRepeat"];
                    break;
            }
        }
    }];
    [clockDictionary setObject:[NSNumber numberWithBool:IsShuffle] forKey:@"ClockShuffle"];
    [clockDictionary setObject:[NSNumber numberWithBool:IsReminderLater] forKey:@"ClockReminderLater"];

    NSUserDefaults* userDefault                 = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:clockDictionary forKey:[NSString stringWithFormat:@"%d",clockID]];

    //增加Clock数目
    [GlobalFunction AddClockNumber];

    //关闭当前页面
    [self dismissViewControllerAnimated:YES completion:nil];
//    clockDictionary setObject:<#(id)#> forKey:<#(id<NSCopying>)#>
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [AlarmSetItem count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* CellIdentifier             = @"cell";
    UITableViewCell* cell                       = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
    cell                                        = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }

    if (indexPath.row == ALARM_REMINDER_LATER || indexPath.row == ALARM_SHUFFLE) {
    cell                                        = [[[NSBundle mainBundle] loadNibNamed:@"SwitchCell" owner:self options:nil]objectAtIndex:0];
    ((SwitchCell*)cell).CellLabel.text          = AlarmSetItem[indexPath.row];
        [((SwitchCell*)cell).CellSwitch addTarget:self action:@selector(RemindLater:) forControlEvents:UIControlEventValueChanged];
    ((SwitchCell*)cell).CellSwitch.tag          = indexPath.row;
        return cell;
    }
    else
    {
    cell                                        = [[[NSBundle mainBundle] loadNibNamed:@"SetAlarmCell" owner:self options:nil]objectAtIndex:0];
    ((SetAlarmCell*)cell).CellLabel.text        = AlarmSetItem[indexPath.row];
    ((SetAlarmCell*)cell).CellCurrentState.text = AlarmDefaultState[indexPath.row];
    cell.tag                                    = indexPath.row;
          }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    id   destination;
    if (indexPath.row == ALARM__REMEMBER) {
        //初始化
        destination = [[[NSBundle mainBundle] loadNibNamed:@"AlarmRememberViewController" owner:self options:nil]objectAtIndex:0];
        //设置代理
        ((AlarmRememberViewController*)destination).delegate = self;
        //设置textfield文字
        [((AlarmRememberViewController*)destination).AlarmRememberText setText:AlarmDefaultState[indexPath.row]];
    }
    if (indexPath.row == ALARM_SOUND) {
        //初始化
        destination = [[[NSBundle mainBundle] loadNibNamed:@"AlarmSoundViewController" owner:self options:nil]objectAtIndex:0];
    }
    if (indexPath.row == ALARM_REPEAT) {
        //初始化
        destination = [[[NSBundle mainBundle] loadNibNamed:@"AlarmRepeatViewController" owner:self options:nil]objectAtIndex:0];
    }
    //push
    [self.navigationController pushViewController:(UIViewController*)destination animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

/**
	稍后提醒/随机铃声 开启关闭
 */
-(void)RemindLater:(id)sender
{
    UISwitch* Switch                            = (UISwitch*)sender;
    BOOL  isButtonOn                            = [Switch isOn];

    switch (Switch.tag) {
        case ALARM_SHUFFLE:
    IsShuffle                                   = isButtonOn;
            break;
        case ALARM_REMINDER_LATER:
    IsReminderLater                             = isButtonOn;
            break;
    }
}

#pragma AlarmRememberDelegate
-(void)SetAlarmRemeberText:(NSString*)text
{
    //修改闹钟提醒内容
    [AlarmDefaultState setObject:text atIndexedSubscript:0];
    [_SetAlarmTableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
