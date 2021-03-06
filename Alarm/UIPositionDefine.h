//
//  UIPositionDefine.h
//  Alarm
//
//  Created by zhanghao on 13-11-20.
//  Copyright (c) 2013年 zhanghao. All rights reserved.
//

#ifndef Alarm_UIPositionDefine_h
#define Alarm_UIPositionDefine_h
/********************************************************
 定义系统信息
 ********************************************************/
#define IS_IOS_7 ([GlobalFunction GetCurrentVersion] >= 7)

/********************************************************
 定义所有页面的尺寸,尽量将所有的参数定义为偶数
 ********************************************************/
#define SCREEN_HEIGHT [[UIScreen mainScreen]bounds].size.height
#define SCREEN_WIDTH [[UIScreen mainScreen]bounds].size.width
#define SCREEN_STATE_BAR 20

/********************************************************
 定义NavitaionBar页面尺寸
 ********************************************************/
#define NAVIGATION_UI_HEIGHT 30
#define NAVIGATION_UI_FRAME CGRectMake(0, SCREEN_STATE_BAR, SCREEN_WIDTH, NAVIGATION_UI_HEIGHT)
#define NAVIGATION_UI_HORIZONTAL_MARIN_BOUNDS 20
#define NAVIGATION_UI_VERTICAL_MARGIN_BOUNDS 5
#define NAVIGATION_UI_BUTTON_DEFAULT_WIDTH 60
#define NAVIGATION_UI_BUTTON_DEFAULT_HEIGHT 20

#define NAVIGATION_UI_TITLE_FRAME CGRectMake( NAVIGATION_UI_HORIZONTAL_MARIN_BOUNDS+NAVIGATION_UI_BUTTON_DEFAULT_WIDTH+ NAVIGATION_UI_HORIZONTAL_MARIN_BOUNDS, NAVIGATION_UI_VERTICAL_MARGIN_BOUNDS, SCREEN_WIDTH-2*NAVIGATION_UI_HORIZONTAL_MARIN_BOUNDS-NAVIGATION_UI_BUTTON_DEFAULT_WIDTH-(NAVIGATION_UI_HORIZONTAL_MARIN_BOUNDS+NAVIGATION_UI_BUTTON_DEFAULT_WIDTH+ NAVIGATION_UI_HORIZONTAL_MARIN_BOUNDS), NAVIGATION_UI_BUTTON_DEFAULT_HEIGHT)
#define NAVIGATION_UI_LEFT_BUTTON_DEAFULT_FRAME CGRectMake( NAVIGATION_UI_HORIZONTAL_MARIN_BOUNDS, NAVIGATION_UI_VERTICAL_MARGIN_BOUNDS, NAVIGATION_UI_BUTTON_DEFAULT_WIDTH, NAVIGATION_UI_BUTTON_DEFAULT_HEIGHT);
#define NAVIGATION_UI_RIGHT_BUTTON_DEAFULT_FRAME CGRectMake( SCREEN_WIDTH-NAVIGATION_UI_BUTTON_DEFAULT_WIDTH-NAVIGATION_UI_HORIZONTAL_MARIN_BOUNDS, NAVIGATION_UI_VERTICAL_MARGIN_BOUNDS, NAVIGATION_UI_BUTTON_DEFAULT_WIDTH, NAVIGATION_UI_BUTTON_DEFAULT_HEIGHT);

#endif
