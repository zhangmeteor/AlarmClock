//
//  AddAlarmViewController.h
//  Alarm
//
//  Created by zhanghao on 13-11-21.
//  Copyright (c) 2013年 zhanghao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddAlarmViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *SetAlarmTableView;
@property(assign,nonatomic)int clockID;
@end
