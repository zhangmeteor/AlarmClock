//
//  GlobelFunction.m
//  Alarm
//
//  Created by zhanghao on 13-11-19.
//  Copyright (c) 2013年 zhanghao. All rights reserved.
//

#import "GlobalFunction.h"
typedef enum _view_mode
{
    VIEW_MODE_ALARM,
    VIEW_MODE_MUSIC,
    VIEW_MODE_BACKGROUND,
    VIEW_MODE_WEATHER,
    VIEW_MODE_DEATH_TIME,
    VIEW_MODE_WAKEUP_TREND,
}VIEW_MODE;

@implementation GlobalFunction
static double m_CurrentViewModel = 0;

static double m_FunctionCount = 6;

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
@end
