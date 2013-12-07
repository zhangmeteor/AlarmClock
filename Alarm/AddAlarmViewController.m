//
//  AddAlarmViewController.m
//  Alarm
//
//  Created by zhanghao on 13-11-21.
//  Copyright (c) 2013年 zhanghao. All rights reserved.
//

#import "AddAlarmViewController.h"

#import "UIPositionDefine.h"
/**
	设置每行label名称
 */
typedef enum _alarm_set_item
{
	ALARM__REMEMBER = 0,	/** 提醒内容 */
	ALARM_SOUND,	/** 铃声 */
	ALARM_SHUFFLE,	/** 随机铃声 */
	ALARM_REPEAT,	/** 重复 */
	ALARM_REMINDER_LATER,	/** 稍后提醒 */
}ALARM_SET_ITEM;

@interface AddAlarmViewController ()
{
    NSArray* AlarmSetItem;
}
@end

@implementation AddAlarmViewController
@synthesize clockID;
- (void)viewDidLoad
{
    [super viewDidLoad];
    AlarmSetItem                         = @[@"提醒内容",@"铃声",@"随机铃声",@"重复",@"稍后提醒"];
    // Do any additional setup after loading the view from its nib.
}

/**
    Add Alarm
 */
- (IBAction)SaveAlarm:(id)sender {
  //Alarm数据序列化
    NSMutableDictionary* clockDictionary = [NSMutableDictionary dictionaryWithCapacity:5];
    [self.view.subviews enumerateObjectsUsingBlock:^(UILabel* label , NSUInteger idx , BOOL* stop)
    {
        switch (label.tag) {
            case ALARM__REMEMBER:
                [clockDictionary setObject:label.text forKey:@"ClockRemember"];
                break;
            case ALARM_SOUND:
                 [clockDictionary setObject:label.text forKey:@"ClockMusic"];
                break;
            case ALARM_SHUFFLE:
                 [clockDictionary setObject:label.text forKey:@"ClockShuffle"];
                break;
            case ALARM_REPEAT:
                 [clockDictionary setObject:label.text forKey:@"ClockRepeat"];
                break;
            case ALARM_REMINDER_LATER:
                 [clockDictionary setObject:label.text forKey:@"ClockReminderLater"];
                break;
            default:
                break;
        }
    }];
    
    NSUserDefaults* userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:clockDictionary forKey:[NSString stringWithFormat:@"%d",clockID]];
    
    
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
    static NSString* CellIdentifier      = @"cell";
    UITableViewCell* cell                = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
    cell                                 = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text                  = AlarmSetItem[indexPath.row];
    cell.textLabel.font                  = [UIFont systemFontOfSize:15];
    [cell setBackgroundColor:[UIColor clearColor]];
    
    if (indexPath.row != 4) {
        UILabel* showSettingText = [[UILabel alloc]initWithFrame:CGRectMake(200, 8, 90, 22)];
        [cell addSubview:showSettingText];
        cell.tag = indexPath.row;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    else
    {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UISwitch *switchButton = [[UISwitch alloc] initWithFrame:CGRectMake(260, 3, 10, 5)];
        [switchButton setOn:NO];
        [switchButton addTarget:self action:@selector(RemindLater:) forControlEvents:UIControlEventValueChanged];
        [cell addSubview:switchButton];
    }
    return cell;
}

/**
	稍后提醒开启关闭
 */
-(void)RemindLater:(id)sender
{
    UISwitch* Remindswitch = (UISwitch*)sender;
    BOOL  isButtonOn = [Remindswitch isOn];
    if (isButtonOn) {
        
    }
    else
    {
        
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
