//
//  ViewController.h
//  Alarm
//
//  Created by zhanghao on 13-11-19.
//  Copyright (c) 2013年 zhanghao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlarmSetViewController : NavigationBaseViewController<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *AlarmSetTableView;

@end
