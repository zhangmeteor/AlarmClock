//
//  AlarmRememberDelegate.h
//  Alarm
//
//  Created by 张 龙 on 13-12-11.
//  Copyright (c) 2013年 zhanghao. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol AlarmRememberDelegate <NSObject>
//设置提醒文字
-(void)SetAlarmRemeberText:(NSString*)text;
@end
