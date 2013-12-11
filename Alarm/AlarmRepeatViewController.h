//
//  AlarmRepeatViewController.h
//  Alarm
//
//  Created by zhanghao on 13-12-11.
//  Copyright (c) 2013年 zhanghao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlarmRepeatViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *AlarmRepeatTableView;

@end
