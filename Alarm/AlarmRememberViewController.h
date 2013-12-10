//
//  AlarmRemeberViewController.h
//  Alarm
//
//  Created by 张 龙 on 13-12-9.
//  Copyright (c) 2013年 zhanghao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AlarmRememberDelegate.h"

@interface AlarmRememberViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *AlarmRememberText;
@property (assign, nonatomic)id<AlarmRememberDelegate> delegate;
@end
