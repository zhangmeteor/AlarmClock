//
//  GlobelFunction.h
//  Alarm
//
//  Created by zhanghao on 13-11-19.
//  Copyright (c) 2013年 zhanghao. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface GlobalFunction : NSObject

+(double)GetGlobalViewState;

+(void)SetGlobalViewState:(double)state;

+(double)GetFunctionCount;
@end
