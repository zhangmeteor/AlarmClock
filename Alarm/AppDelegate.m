//
//  AppDelegate.m
//  Alarm
//
//  Created by zhanghao on 13-11-19.
//  Copyright (c) 2013年 zhanghao. All rights reserved.
//

#import "AppDelegate.h"

#import "LeftSliderViewController.h"

#import <PKRevealController/PKRevealController.h>

#import "GlobalFunction.h"

@interface AppDelegate () <PKRevealing>

@property (strong,nonatomic) PKRevealController* pKRevealController;

@end

@implementation AppDelegate
@synthesize viewController;
@synthesize pKRevealController = _pKRevealController;
@synthesize leftSliderViewController = _leftSliderViewController;
@synthesize alarmSetViewController = _alarmSetViewController;
@synthesize NavBar = _NavBar;

//侧边栏宽度
static const double s_LeftSliderWidth = 170;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
   
    //Set LeftSliderBar title
     NSArray* const CurrentViewModelTitle = @[@"Alarm",@"Music",@"Background Color",@"Weather",@"Death Time",@"WakeUp Trend"];
    [GlobalFunction SetGlobalViewTitle:CurrentViewModelTitle];
    
    //添加侧边栏
    self.leftSliderViewController = [[LeftSliderViewController alloc]initWithNibName:@"LeftSliderViewController" bundle:nil];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
   
    //Set PKRevealController
    self.pKRevealController = [PKRevealController revealControllerWithFrontViewController:[storyboard instantiateInitialViewController] leftViewController:self.leftSliderViewController];
    
    //Configure
    [self.pKRevealController setMinimumWidth:s_LeftSliderWidth maximumWidth:s_LeftSliderWidth forViewController:self.leftSliderViewController];
    self.pKRevealController.delegate = self;
    self.pKRevealController.animationDuration = 0.25;
    
    self.window.rootViewController = self.pKRevealController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - PKRevealing
- (void)revealController:(PKRevealController *)revealController didChangeToState:(PKRevealControllerState)state
{
//    NSLog(@"%@ (%d)", NSStringFromSelector(_cmd), (int)state);
}

- (void)revealController:(PKRevealController *)revealController willChangeToState:(PKRevealControllerState)next
{
//    PKRevealControllerState current = revealController.state;
//    NSLog(@"%@ (%d -> %d)", NSStringFromSelector(_cmd), (int)current, (int)next);
}

@end
