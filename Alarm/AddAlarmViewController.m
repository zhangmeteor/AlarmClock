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

#import "AlarmRepeatDelegate.h"

#import "AlarmRepeatViewController.h"

#import "AlarmSoundDelegate.h"

#import "AlarmSoundViewController.h"

/**
 设置每行label名称
 */
typedef enum _alarm_set_item
{
    ALARM__REMEMBER                                        = 0, /** 提醒内容 */
	ALARM_SOUND,	/** 铃声 */
	ALARM_REPEAT,	/** 重复 */
    ALARM_SHUFFLE,	/** 随机铃声 */
	ALARM_REMINDER_LATER,	/** 稍后提醒 */
}ALARM_SET_ITEM;

@interface AddAlarmViewController ()<AlarmRememberDelegate,AlarmRepeatDelegate,AlarmSoundDelegate>
{
    NSArray* AlarmSetItem;
    NSMutableArray* AlarmDefaultState;
    
    char        AlarmRepeatType;
    NSString* AlarmSoundKey;
    NSArray* AlarmTime;
    
    BOOL     IsReminderLater;
    BOOL     IsShuffle;
    BOOL     IsProhibitionChangeSound;
}
@end

@implementation AddAlarmViewController
@synthesize clockID;
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.clockID                                           = [GlobalFunction GetClockNumber];
    AlarmSetItem                                           = @[@"提醒内容",@"铃声",@"重复",@"随机铃声",@"稍后提醒"];
    AlarmDefaultState                                      = [@[@"闹钟",@"Opening (Default)",@"永不",@"",@""]mutableCopy];
    //默认为不重复
    AlarmRepeatType                                        = 0x000;
    
    // Do any additional setup after loading the view from its nib.
}

/**
 Add Alarm
 */
- (IBAction)SaveAlarm:(id)sender {
    //获取Data时间
    AlarmTime =  [GlobalFunction ChangeDataTimeToString:_AlarmTimePicker.date];
    //Alarm数据序列化
    NSMutableDictionary* clockDictionary                   = [NSMutableDictionary dictionaryWithCapacity:5];
    [_SetAlarmTableView.visibleCells enumerateObjectsUsingBlock:^(UITableViewCell* cell , NSUInteger idx , BOOL* stop)
     {
         if ([cell isKindOfClass:[SetAlarmCell class]]) {
             switch (((SetAlarmCell*)cell).tag) {
                 case ALARM__REMEMBER:
                     [clockDictionary setObject:((SetAlarmCell*)cell).CellCurrentState.text forKey:@"ClockRemember"];
                     break;
                 case ALARM_SOUND:
                     [clockDictionary setObject:((SetAlarmCell*)cell).CellCurrentState.text forKey:@"ClockMusic"];
                     break;
                 case ALARM_REPEAT:
                     [clockDictionary setObject:((SetAlarmCell*)cell).CellCurrentState.text forKey:@"ClockRepeat"];
                     break;
             }
         }
     }];
    [clockDictionary setObject:[NSNumber numberWithBool:IsShuffle] forKey:@"ClockShuffle"];
    [clockDictionary setObject:[NSNumber numberWithBool:IsReminderLater] forKey:@"ClockReminderLater"];
    [clockDictionary setObject:AlarmTime forKey:@"ClockTime"];
    
    NSUserDefaults* userDefault                            = [NSUserDefaults standardUserDefaults];
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
    static NSString* CellIdentifier                        = @"cell";
    UITableViewCell* cell                                  = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell                                                   = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    if (indexPath.row == ALARM_REMINDER_LATER || indexPath.row == ALARM_SHUFFLE) {
        cell                                                   = [[[NSBundle mainBundle] loadNibNamed:@"SwitchCell" owner:self options:nil]objectAtIndex:0];
        ((SwitchCell*)cell).CellLabel.text                     = AlarmSetItem[indexPath.row];
        [((SwitchCell*)cell).CellSwitch addTarget:self action:@selector(RemindLater:) forControlEvents:UIControlEventValueChanged];
        ((SwitchCell*)cell).CellSwitch.tag                     = indexPath.row;
        if (indexPath.row == ALARM_REMINDER_LATER) {
            ((SwitchCell*)cell).CellSwitch.on                      = IsReminderLater;
        }
        else
        {
            ((SwitchCell*)cell).CellSwitch.on                      = IsShuffle;
        }
        return cell;
    }
    else
    {
        cell                                                   = [[[NSBundle mainBundle] loadNibNamed:@"SetAlarmCell" owner:self options:nil]objectAtIndex:0];
        ((SetAlarmCell*)cell).CellLabel.text                   = AlarmSetItem[indexPath.row];
        ((SetAlarmCell*)cell).CellCurrentState.text            = AlarmDefaultState[indexPath.row];
        cell.tag                                               = indexPath.row;
    }
    //不允许修改铃声时
    if (IsProhibitionChangeSound) {
        if (indexPath.row == ALARM_SOUND) {
            cell.userInteractionEnabled                            = NO;
            return cell;
        }
    }
    cell.userInteractionEnabled                            = YES;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    id   destination;
    if (indexPath.row == ALARM__REMEMBER) {
        //初始化
        destination                                            = [[[NSBundle mainBundle] loadNibNamed:@"AlarmRememberViewController" owner:self options:nil]objectAtIndex:0];
        //设置代理
        ((AlarmRememberViewController*)destination).delegate   = self;
        //设置textfield文字
        [((AlarmRememberViewController*)destination).AlarmRememberText setText:AlarmDefaultState[indexPath.row]];
    }
    if (indexPath.row == ALARM_SOUND) {
        //初始化
        destination                                            = [[[NSBundle mainBundle] loadNibNamed:@"AlarmSoundViewController" owner:self options:nil]objectAtIndex:0];
        //设置代理
        ((AlarmSoundViewController*)destination).delegate      = self;
        //设置textfield文字
        if (AlarmSoundKey) {
            ((AlarmSoundViewController*)destination).currentSound  = AlarmSoundKey;
        }
    }
    if (indexPath.row == ALARM_REPEAT) {
        //初始化
        destination                                            = [[[NSBundle mainBundle] loadNibNamed:@"AlarmRepeatViewController" owner:self options:nil]objectAtIndex:0];
        //设置代理
        ((AlarmRepeatViewController*)destination).delegate     = self;
        //设置重复状态
        ((AlarmRepeatViewController*)destination).SelectedDays = AlarmRepeatType;
    }
    //push
    [self.navigationController pushViewController:(UIViewController*)destination animated:YES];
}

/**
 稍后提醒/随机铃声 开启关闭
 */
-(void)RemindLater:(id)sender
{
    UISwitch* Switch                                       = (UISwitch*)sender;
    BOOL  isButtonOn                                       = [Switch isOn];
    
    switch (Switch.tag) {
        case ALARM_SHUFFLE:
            IsShuffle                                              = isButtonOn;
            //开启随机铃声时
            if (IsShuffle) {
                [self ProhibitionChangeSound];
            }
            else
            {
                [self AllowChangeSound];
            }
            break;
        case ALARM_REMINDER_LATER:
            IsReminderLater                                        = isButtonOn;
            break;
    }
}

/**
 铃声随机时，禁止更改铃声选项
 */
-(void)ProhibitionChangeSound
{
    IsProhibitionChangeSound                               = YES;
    [_SetAlarmTableView reloadData];
}

/**
 取消铃声随机，允许更改铃声
 */
-(void)AllowChangeSound
{
    IsProhibitionChangeSound                               = NO;
    [_SetAlarmTableView reloadData];
}

#pragma AlarmRememberDelegate
-(void)SetAlarmRemeberText:(NSString*)text
{
    //修改闹钟提醒内容
    [AlarmDefaultState setObject:text atIndexedSubscript:ALARM__REMEMBER];
    [_SetAlarmTableView reloadData];
}

#pragma AlarmRepeatDelegate
-(void)AlarmRepeatType:(char)type Text:(NSString*)text
{
    //修改重复内容
    [AlarmDefaultState setObject:text atIndexedSubscript:ALARM_REPEAT];
    AlarmRepeatType                                        = type;
    [_SetAlarmTableView reloadData];
}

-(void)AlarmSoundTest:(NSString*)type Key:(NSString*)key
{
    //修改铃声
    [AlarmDefaultState setObject:type atIndexedSubscript:ALARM_SOUND];
    AlarmSoundKey                                          = [key copy];
    [_SetAlarmTableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
