//
//  GlobelFunction.h
//  Alarm
//
//  Created by zhanghao on 13-11-19.
//  Copyright (c) 2013年 zhanghao. All rights reserved.
//

#import <Foundation/Foundation.h>

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

@interface GlobalFunction : NSObject

+(double)GetGlobalViewState;

+(void)SetGlobalViewState:(double)state;

+(double)GetFunctionCount;

+(float)GetCurrentVersion;

+(void)SetGlobalViewTitle:(NSArray*)title;

+(NSArray*)GetGlobalViewTitle;

+(int)GetClockNumber;

+(void)AddClockNumber;

+(void)DeleteClockNumber;

+(NSArray*)ChangeDataTimeToString:(NSDate*)date;

@end
