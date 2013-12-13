//
//  AlarmSoundDelegate.h
//  Alarm
//
//  Created by zhanghao on 13-12-13.
//  Copyright (c) 2013年 zhanghao. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol AlarmSoundDelegate <NSObject>
-(void)AlarmSoundTest:(NSString*)type Key:(NSString*)key;
@end
