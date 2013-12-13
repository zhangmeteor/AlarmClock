//
//  AlarmSoundViewController.m
//  Alarm
//
//  Created by zhanghao on 13-12-11.
//  Copyright (c) 2013年 zhanghao. All rights reserved.
//

#import "AlarmSoundViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface AlarmSoundViewController ()<AVAudioPlayerDelegate>
{
    AVAudioPlayer* player;
}
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
    
    //默认选中铃声
    _currentSound = [_MusicKey objectAtIndex:0];
    
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
    cell.accessoryType = UITableViewCellAccessoryNone;
    if (indexPath.row == [_MusicKey indexOfObject:_currentSound]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    cell.textLabel.text = [_MusicName objectForKey:[_MusicKey objectAtIndex:indexPath.row]];
    return  cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //取消cell选中状态
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
     NSInteger catIndex = [_MusicKey indexOfObject:_currentSound];
    if (indexPath.row == catIndex) {
        return;
    }
    NSIndexPath* oldIndexPath = [NSIndexPath indexPathForRow:catIndex inSection:0];
    UITableViewCell* oldCell = [tableView cellForRowAtIndexPath:oldIndexPath];
    
    //设置cell选中标识符
    if (oldCell.accessoryType == UITableViewCellAccessoryCheckmark) {
        oldCell.accessoryType = UITableViewCellAccessoryNone;
    }
    UITableViewCell* newCell = [tableView cellForRowAtIndexPath:indexPath];
    if (newCell.accessoryType == UITableViewCellAccessoryNone) {
        newCell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    
    _currentSound = [_MusicKey objectAtIndex:indexPath.row];
    //播放当前选中铃声
    [self initAudioPlayerWithFileName:[_MusicName objectForKey:[_MusicKey objectAtIndex:indexPath.row]]];
    [self PlaySound];
}

/**
	初始化播放器
 */
-(void)initAudioPlayerWithFileName:(NSString*)name
{
    if (player) {
        [player stop];
        player = nil;
    }
    NSURL* url = [NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:name ofType:@"m4a"]];
    player = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:nil];
    player.delegate = self;
    
    //参数设置
    player.volume = 0.8;
    player.numberOfLoops = 1;
    player.currentTime = 0.0;
    
    [player prepareToPlay];
}

/**
	播放当前选中的铃声
 */
-(void)PlaySound
{
    [player play];
}

-(void)viewWillDisappear:(BOOL)animated
{
   //返回选中铃声信息
    [_delegate AlarmSoundTest:[_MusicName objectForKey:_currentSound] Key:_currentSound];
    
    //关闭铃声
    if (player) {
        [player stop];
        player = nil;
    }
}

#pragma AVAudioPlayerDelegate
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer*)player successfully:(BOOL)flag{
    //播放结束时执行的动作
}
- (void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer*)player error:(NSError *)error{
    //解码错误执行的动作
}
- (void)audioPlayerBeginInteruption:(AVAudioPlayer*)player{
    //处理中断的代码
}
- (void)audioPlayerEndInteruption:(AVAudioPlayer*)player{
    //处理中断结束的代码
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
