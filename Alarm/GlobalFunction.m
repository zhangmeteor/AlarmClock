//
//  GlobelFunction.m
//  Alarm
//
//  Created by zhanghao on 13-11-19.
//  Copyright (c) 2013年 zhanghao. All rights reserved.
//

#import "GlobalFunction.h"

@implementation GlobalFunction
static double s_CurrentViewModel = 0;

static NSArray*  s_CurrentViewModelTitle;

static double s_FunctionCount = 6;

static NSUInteger _deviceSystemMajorVersion = -1;

static NSUInteger s_ClockNumber = 0;

/**
	设置View的状态
 */
+(void)SetGlobalViewState:(double)state
{
    s_CurrentViewModel = state;
}
+(double)GetGlobalViewState
{
    return s_CurrentViewModel;
}
+(void)SetGlobalViewTitle:(NSArray*)title
{
    s_CurrentViewModelTitle = title;
}
+(NSArray*)GetGlobalViewTitle
{
    return s_CurrentViewModelTitle;
}

/**
    获取支持功能数目
 */
+(double)GetFunctionCount
{
    return s_FunctionCount;
}

/**
	获取当前系统版本号
 */
+(float)GetCurrentVersion
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _deviceSystemMajorVersion = [[[[[UIDevice currentDevice] systemVersion] componentsSeparatedByString:@"."] objectAtIndex:0] intValue];
	});
	return _deviceSystemMajorVersion;
}

/**
	设置当前闹钟总数目
 */
+(void)SetClockNumber
{
    NSUserDefaults* userDefault                            = [NSUserDefaults standardUserDefaults];
    s_ClockNumber =  [[userDefault objectForKey:@"ClockNumber"]intValue];
}

+(int)GetClockNumber
{
    return s_ClockNumber;
}

+(void)AddClockNumber
{
    s_ClockNumber++;
    NSUserDefaults* userDefault                            = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:[NSNumber numberWithInt:s_ClockNumber] forKey:@"ClockNumber"];
    [userDefault synchronize];
    
}

+(void)DeleteClockNumber
{
    if (s_ClockNumber) {
        s_ClockNumber--;
    }
    NSUserDefaults* userDefault                            = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:[NSNumber numberWithInt:s_ClockNumber] forKey:@"ClockNumber"];
    [userDefault synchronize];
}

/**
 改变时间为显示需要的格式
 */
+(NSArray*)ChangeDataTimeToString:(NSDate*)date
{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"hh:mm"];
    NSString* time = [dateFormatter stringFromDate:date];
    
    [dateFormatter setDateFormat: @"a"];
    NSString* AmOrPm = [dateFormatter stringFromDate:date];
    
    return [NSArray arrayWithObjects:time,AmOrPm,nil];
}
@end
