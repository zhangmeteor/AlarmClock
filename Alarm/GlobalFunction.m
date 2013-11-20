//
//  GlobelFunction.m
//  Alarm
//
//  Created by zhanghao on 13-11-19.
//  Copyright (c) 2013年 zhanghao. All rights reserved.
//

#import "GlobalFunction.h"

/**
	type define
 */
typedef enum _view_mode
{
	VIEW_MODE_ALARM,	/** 闹钟设置页面 */
	VIEW_MODE_MUSIC,	/** 音乐设置页面 */
	VIEW_MODE_BACKGROUND,	/** 设置背景图片页面 */
	VIEW_MODE_WEATHER,	/** 天气设置页面 */
	VIEW_MODE_DEATH_TIME,	/** 死亡事件设置页面 */
	VIEW_MODE_WAKEUP_TREND,	/** 醒来趋势图表页面 */
		/** 不同页面不同状态 */
}VIEW_MODE;

@implementation GlobalFunction
static double m_CurrentViewModel = 0;

static double m_FunctionCount = 6;

static NSUInteger _deviceSystemMajorVersion = -1;

/**
	设置View的状态
 */
+(void)SetGlobalViewState:(double)state
{
    m_CurrentViewModel = state;
}
+(double)GetGlobalViewState
{
    return m_CurrentViewModel;
}

/**
    获取支持功能数目
 */
+(double)GetFunctionCount
{
    return m_FunctionCount;
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
@end
