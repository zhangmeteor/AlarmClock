//
//  CustomPresentModal.m
//  Alarm
//
//  Created by zhanghao on 13-11-25.
//  Copyright (c) 2013年 zhanghao. All rights reserved.
//

#import "CustomPresentModal.h"
#import "GlobalFunction.h"

@implementation CustomPresentModal
- (void)perform
{
    UIViewController* current = self.sourceViewController;
    UIViewController* destination = self.destinationViewController;
    [current presentViewController:destination animated:YES completion:nil];
}
@end
