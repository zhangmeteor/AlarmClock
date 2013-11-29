//
//  AddAlarmViewController.m
//  Alarm
//
//  Created by zhanghao on 13-11-21.
//  Copyright (c) 2013年 zhanghao. All rights reserved.
//

#import "AddAlarmViewController.h"

#import "UIPositionDefine.h"

@interface AddAlarmViewController ()
{
    NSArray* AlarmSetItem;
}

@end

@implementation AddAlarmViewController
//
//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        // Custom initialization
//    }
//    return self;
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
    AlarmSetItem = @[@"Clock Remember",@"Clock Music",@"Music Shuffle",@"Clock Mode",@"Clock Repeat"];
    // Do any additional setup after loading the view from its nib.
}

/**
    Add Alarm
 */
- (IBAction)SaveAlarm:(id)sender {
  //Alarm数据序列化
    NSMutableDictionary* clockDictionary = [NSMutableDictionary dictionaryWithCapacity:6];
    
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [AlarmSetItem count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* CellIdentifier = @"cell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = AlarmSetItem[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    [cell setBackgroundColor:[UIColor clearColor]];
    return cell;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
