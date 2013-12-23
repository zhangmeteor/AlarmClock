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

/**
 * 实现NSUncaughtExceptionHandler方法
 */
void uncaughtExceptionHandler(NSException *exception)
{
    // 调用堆栈
    NSArray *arr = [exception callStackSymbols];
    // 错误reason
    NSString *reason = [exception reason];
    // exception name
    NSString *name = [exception name];
    
    // 根据自己的需求将crash信息记录下来，下次启动的时候传给服务器。
    // 尽量不要在此处将crash信息上传，因为App将要退出，不保证能够将信息上传至服务器
}

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
    
    //Add Notification
    [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector(HideLeftSlider) name:ChangeCurrentViewNotification object:nil];
    
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

-(void)HideLeftSlider
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    [self.pKRevealController showViewController:[storyboard instantiateInitialViewController]];
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"接收到本地提醒 in app"
                                                    message:notification.alertBody
                                                   delegate:nil
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles:nil];
    [alert show];
    //这里，你就可以通过notification的useinfo，干一些你想做的事情了
    application.applicationIconBadgeNumber -= 1;
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
