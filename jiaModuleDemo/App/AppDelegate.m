//
//  AppDelegate.m
//  jiaModuleDemo
//
//  Created by wujunyang on 16/9/13.
//  Copyright © 2016年 wujunyang. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

#import "jiaGTConfigManager.h"
#import "jiaDesignerConfigManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //设置模块jiaDesigner相关配置
    jiaDesignerConfigManager *jiaDesignerConfig=[jiaDesignerConfigManager sharedInstance];
    jiaDesignerConfig.prefixNetWorkUrl=@"http://private.com/";
    
    
    //设置个推模块的配置
    JiaGTConfigManager *gtConfig=[JiaGTConfigManager sharedInstance];
    gtConfig.jiaGTAppId=@"0uuwznWonIANoK07JeRWgAs";
    gtConfig.jiaGTAppKey=@"26LeO4stbrA7TeyMUJdXlx3";
    gtConfig.jiaGTAppSecret=@"2282vl0IwZd9KL3ZpDyoUL7";
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    ViewController *vc = [[ViewController alloc]init];
    UINavigationController *navc = [[UINavigationController alloc]initWithRootViewController:vc];
    self.window.rootViewController = navc;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    [super applicationWillResignActive:application];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    [super applicationDidEnterBackground:application];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    [super applicationWillEnterForeground:application];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [super applicationDidBecomeActive:application];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    [super applicationWillTerminate:application];
}


#pragma mark 消息推送相关处理

/**
 *  @author wujunyang, 16-07-07 16:07:25
 *
 *  @brief  处理个推消息
 *
 *  @param NotificationMessage
 */
-(void)gtNotification:(NSDictionary *)NotificationMessage
{
    NSLog(@"%@",NotificationMessage[@"payload"]);
    NSLog(@"－－－－－接收到个推通知------");
}


/**
 *  @author wujunyang, 16-07-07 16:07:40
 *
 *  @brief  处理远程苹果通知
 *
 *  @param RemoteNotificationMessage
 */
-(void)receiveRemoteNotification:(NSDictionary *)RemoteNotificationMessage
{
    NSLog(@"%@",RemoteNotificationMessage[@"message"]);
    NSLog(@"－－－－－接收到苹果通知------");
}

/**
 *  @author wujunyang, 16-09-21 14:09:33
 *
 *  @brief 获得注册成功时的deviceToken 可以在里面做一些绑定操作
 *
 *  @param deviceToken <#deviceToken description#>
 */
-(void)receiveDeviceToken:(NSString *)deviceToken
{
    NSLog(@"－－－－－当前deviceToken：%@------",deviceToken);
}

@end
