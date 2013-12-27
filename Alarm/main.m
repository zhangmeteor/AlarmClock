//
//  main.m
//  Alarm
//
//  Created by zhanghao on 13-11-19.
//  Copyright (c) 2013年 zhanghao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoggerClient.h"

#import "AppDelegate.h"

int main(int argc, char *argv[])
{
    LoggerSetViewerHost(NULL, (CFStringRef)@"127.0.0.1", (UInt32)50000);
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
