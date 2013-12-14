//
//  AlarmRepeatDelegate.h
//  Alarm
//
//  Created by zhanghao on 13-12-12.
//  Copyright (c) 2013年 zhanghao. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol AlarmRepeatIntervalDelegate <NSObject>
-(void)AlarmRepeatIntervalType:(char)type Text:(NSString*)text;
@end
