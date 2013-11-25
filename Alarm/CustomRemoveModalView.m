//
//  CustomRemoveModalView.m
//  Alarm
//
//  Created by zhanghao on 13-11-25.
//  Copyright (c) 2013年 zhanghao. All rights reserved.
//

#import "CustomRemoveModalView.h"

@implementation CustomRemoveModalView
- (void)perform
{
    UIViewController * current = self.sourceViewController;
    [current dismissViewControllerAnimated:YES completion:nil];
}

@end
