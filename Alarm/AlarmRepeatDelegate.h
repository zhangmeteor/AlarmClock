//
//  AlarmRepeatDelegate.h
//  Alarm
//
//  Created by zhanghao on 13-12-12.
//  Copyright (c) 2013年 zhanghao. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol AlarmRepeatDelegate <NSObject>
-(void)AlarmRepeatType:(char)type Text:(NSString*)text;
@end
