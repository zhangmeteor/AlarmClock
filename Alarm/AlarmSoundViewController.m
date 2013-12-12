//
//  AlarmSoundViewController.m
//  Alarm
//
//  Created by zhanghao on 13-12-11.
//  Copyright (c) 2013年 zhanghao. All rights reserved.
//

#import "AlarmSoundViewController.h"

@interface AlarmSoundViewController ()
@property(strong, nonatomic)NSDictionary* MusicName;
@property(strong, nonatomic)NSArray* MusicKey;
@end

@implementation AlarmSoundViewController

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
    //获取铃声列表
    NSString* path = [[NSBundle mainBundle]pathForResource:@"sound" ofType:@"plist"];
    NSDictionary* MusicDic = [[NSDictionary alloc]initWithContentsOfFile:path];
    _MusicName = MusicDic;
    NSArray* MusicArray = [[MusicDic allKeys]sortedArrayUsingSelector:@selector(compare:)];
    _MusicKey = MusicArray;
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

#pragma UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_MusicName count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* CellIdentifier = @"cell";
    UITableViewCell* cell           = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell                            = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = [_MusicName objectForKey:[_MusicKey objectAtIndex:indexPath.row]];
    return  cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
