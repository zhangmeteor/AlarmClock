//
//  AlarmSoundViewController.h
//  Alarm
//
//  Created by zhanghao on 13-12-11.
//  Copyright (c) 2013年 zhanghao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AlarmSoundDelegate.h"
@interface AlarmSoundViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property(assign, nonatomic)id currentSound;
@property(assign, nonatomic)id<AlarmSoundDelegate> delegate;
@end
