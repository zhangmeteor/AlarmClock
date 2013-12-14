//
//  AlarmCell.h
//  Alarm
//
//  Created by zhanghao on 13-12-13.
//  Copyright (c) 2013年 zhanghao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlarmCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *AlarmTime;
@property (weak, nonatomic) IBOutlet UILabel *AlarmAmOrPm;
@property (weak, nonatomic) IBOutlet UILabel *AlarmRememberAndRepeatInterval;
@property (weak, nonatomic) IBOutlet UISwitch *AlarmSwitch;
@end
