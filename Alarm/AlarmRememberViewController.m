//
//  AlarmRemeberViewController.m
//  Alarm
//
//  Created by 张 龙 on 13-12-9.
//  Copyright (c) 2013年 zhanghao. All rights reserved.
//

#import "AlarmRememberViewController.h"

@interface AlarmRememberViewController ()

@end

@implementation AlarmRememberViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //设置navigationBar Title
    [self.navigationItem setTitle:@"提醒内容"];
    //自动进入编辑状态
    [_AlarmRememberText becomeFirstResponder];
    [_AlarmRememberText addTarget:self action:@selector(ReturnKeyPressd:) forControlEvents:UIControlEventEditingDidEndOnExit];
	// Do any additional setup after loading the view.
}

/**
	return键盘按钮事件
 */
-(void)ReturnKeyPressd:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewWillDisappear:(BOOL)animated
{
    //保存当前更改
    [_delegate SetAlarmRemeberText:_AlarmRememberText.text];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
