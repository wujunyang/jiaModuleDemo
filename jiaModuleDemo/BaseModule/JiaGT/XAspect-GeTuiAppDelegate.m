//
//  XAspect-LogAppDelegate.m
//  MobileProject 抽离原本应在AppDelegate的内容（个推）
//
//  Created by wujunyang on 16/6/22.
//  Copyright © 2016年 wujunyang. All rights reserved.
//

#import "JiaAppDelegate.h"
#import "GeTuiSdk.h"
#import "XAspect.h"
#import "JiaGTConfigManager.h"
#import "JiaAppDelegate+myGt.h"


#define AtAspect GeTuiAppDelegate

#define AtAspectOfClass JiaAppDelegate
@classPatchField(JiaAppDelegate)

@synthesizeNucleusPatch(Default, -, BOOL, application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions);
@synthesizeNucleusPatch(Default, -, void, application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken);
@synthesizeNucleusPatch(Default, -, void, application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error);
@synthesizeNucleusPatch(Default, -, void, application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings);
@synthesizeNucleusPatch(Default, -, void, application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler);
@synthesizeNucleusPatch(Default,-,void, dealloc);


AspectPatch(-, BOOL, application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions)
{
    NSLog(@"成功加载个推模块");
    
    //个推初始化
    [self initLoadGeTui:launchOptions];
    
    //注册个推通知事件
    return XAMessageForward(application:application didFinishLaunchingWithOptions:launchOptions);
}

/** 远程通知注册成功委托 */
AspectPatch(-, void, application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken)
{
    NSString *myToken = [[deviceToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    myToken = [myToken stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    [GeTuiSdk registerDeviceToken:myToken];
    
    NSLog(@"\n>>>[DeviceToken值]:%@\n\n", myToken);
    
    return XAMessageForward(application:application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken);
}

/** 远程通知注册失败委托 */
AspectPatch(-, void, application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error){
    
    [GeTuiSdk registerDeviceToken:@""];
    
    NSLog(@"\n>>>[DeviceToken失败]:%@\n\n", error.description);
    
    return XAMessageForward(application:application didFailToRegisterForRemoteNotificationsWithError:error);
}


#pragma mark - 用户通知(推送)回调 _IOS 8.0以上使用

/** 已登记用户通知 */
AspectPatch(-, void, application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings)
{
    // 注册远程通知（推送）
    [application registerForRemoteNotifications];
    
    return XAMessageForward(application:application didRegisterUserNotificationSettings:notificationSettings);
}


AspectPatch(-, void,application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler)
{
    //处理applicationIconBadgeNumber-1
    [self handlePushMessage:userInfo notification:nil];
    
    //除了个推还要处理走苹果的信息放在body里面
    if (userInfo) {
        NSString *payloadMsg = [userInfo objectForKey:@"payload"];
        NSString *message=[[[userInfo objectForKey:@"aps"]objectForKey:@"alert"]objectForKey:@"body"];
        
        NSDictionary *dict =[[NSDictionary alloc] initWithObjectsAndKeys:payloadMsg,@"payload",message,@"message",nil];
        
        [self receiveRemoteMessageHandleing:dict];
    }
    // 处理APN
    //NSLog(@"\n>>>[Receive RemoteNotification - Background Fetch]:%@\n\n", userInfo);
    completionHandler(UIBackgroundFetchResultNewData);
    return XAMessageForward(application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler);
}

AspectPatch(-, void, dealloc)
{
    XAMessageForwardDirectly(dealloc);
}


#pragma mark - GeTuiSdkDelegate

/** SDK启动成功返回cid */
- (void)GeTuiSdkDidRegisterClient:(NSString *)clientId {
    // [4-EXT-1]: 个推SDK已注册，返回clientId
    NSLog(@"\n>>>[个推Cid]:%@\n\n", clientId);
}

/** SDK遇到错误回调 */
- (void)GeTuiSdkDidOccurError:(NSError *)error {
    // [EXT]:个推错误报告，集成步骤发生的任何错误都在这里通知，如果集成后，无法正常收到消息，查看这里的通知。
    NSLog(@"\n>>>[GexinSdk error]:%@\n\n", [error localizedDescription]);
}



/** SDK收到sendMessage消息回调 */
- (void)GeTuiSdkDidSendMessage:(NSString *)messageId result:(int)result {
    // [4-EXT]:发送上行消息结果反馈
    NSString *msg = [NSString stringWithFormat:@"sendmessage=%@,result=%d", messageId, result];
    NSLog(@"\n>>>[GexinSdk DidSendMessage]:%@\n\n", msg);
}

/** SDK运行状态通知 */
- (void)GeTuiSDkDidNotifySdkState:(SdkStatus)aStatus {
    // [EXT]:通知SDK运行状态
    NSLog(@"\n>>>[GexinSdk SdkState]:%u\n\n", aStatus);
}

/** SDK设置推送模式回调 */
- (void)GeTuiSdkDidSetPushMode:(BOOL)isModeOff error:(NSError *)error {
    if (error) {
        NSLog(@"\n>>>[GexinSdk SetModeOff Error]:%@\n\n", [error localizedDescription]);
        return;
    }
    
    NSLog(@"\n>>>[GexinSdk SetModeOff]:%@\n\n", isModeOff ? @"开启" : @"关闭");
}

// 处理推送消息
- (void)handlePushMessage:(NSDictionary *)dict notification:(UILocalNotification *)localNotification {
    if ([UIApplication sharedApplication].applicationIconBadgeNumber != 0) {
        if (localNotification) {
            [[UIApplication sharedApplication] cancelLocalNotification:localNotification];
        }
        [UIApplication sharedApplication].applicationIconBadgeNumber -= 1;
    }
    else {
        [[UIApplication sharedApplication] cancelAllLocalNotifications];
        [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    }
}



/** SDK收到透传消息回调 */
- (void)GeTuiSdkDidReceivePayloadData:(NSData *)payloadData andTaskId:(NSString *)taskId andMsgId:(NSString *)msgId andOffLine:(BOOL)offLine fromGtAppId:(NSString *)appId {
    
    [self handlePushMessage:nil notification:nil];
    
    // 数据转换
    NSString *payloadMsg = nil;
    if (payloadData) {
        payloadMsg = [[NSString alloc] initWithBytes:payloadData.bytes length:payloadData.length encoding:NSUTF8StringEncoding];
    }
    
    NSDictionary *dict =[[NSDictionary alloc] initWithObjectsAndKeys:msgId,@"aMsgId", [NSNumber numberWithBool:offLine],@"offLine",appId,@"appId",payloadMsg,@"payload",nil];
    
    [self geTuiMessageHandleing:dict];
}


#pragma mark 自定义关于个推的内容

-(void)initLoadGeTui:(NSDictionary *)launchOptions
{
    // 通过 appId、 appKey 、appSecret 启动SDK，注：该方法需要在主线程中调用
    [GeTuiSdk startSdkWithAppId:[JiaGTConfigManager sharedInstance].jiaGTAppId appKey:[JiaGTConfigManager sharedInstance].jiaGTAppKey appSecret:[JiaGTConfigManager sharedInstance].jiaGTAppSecret delegate:self];
    
    // 注册APNS
    [self registerUserNotification];
    
    // 处理远程通知启动APP
    [self receiveNotificationByLaunchingOptions:launchOptions];
    
    //个推SDK支持当APP进入后台后，个推是否运行。NO是不允许(为了让个APP进入后端时就直接走苹果推送)
    [GeTuiSdk runBackgroundEnable:NO];
}



#pragma mark - 用户通知(推送) _自定义方法

/** 注册用户通知 */
- (void)registerUserNotification {
    
    /*
     注册通知(推送)
     申请App需要接受来自服务商提供推送消息
     */
    
    // 判读系统版本是否是“iOS 8.0”以上
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0 ||
        [UIApplication instancesRespondToSelector:@selector(registerUserNotificationSettings:)]) {
        
        // 定义用户通知类型(Remote.远程 - Badge.标记 Alert.提示 Sound.声音)
        UIUserNotificationType types = UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound;
        
        // 定义用户通知设置
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
        
        // 注册用户通知 - 根据用户通知设置
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    } else { // iOS8.0 以前远程推送设置方式
        // 定义远程通知类型(Remote.远程 - Badge.标记 Alert.提示 Sound.声音)
        UIRemoteNotificationType myTypes = UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound;
        
        // 注册远程通知 -根据远程通知类型
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:myTypes];
    }
}

/** 自定义：APP被“推送”启动时处理推送消息处理（APP 未启动--》启动）*/
- (void)receiveNotificationByLaunchingOptions:(NSDictionary *)launchOptions {
    if (!launchOptions)
        return;
    
    /*
     通过“远程推送”启动APP
     UIApplicationLaunchOptionsRemoteNotificationKey 远程推送Key
     */
    NSDictionary *userInfo = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    if (userInfo) {
        NSLog(@"\n>>>[Launching RemoteNotification]:%@", userInfo);
    }
}


#pragma mark 自定义代码

//处理个推本地通知，判断是否存在gtNotification方法
- (void)geTuiMessageHandleing:(NSDictionary *)dic{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    SEL gtNotificationSelector=@selector(gtNotification:);
    if([self respondsToSelector:gtNotificationSelector])
    {
        [self performSelector:gtNotificationSelector withObject:dic];
    }
#pragma clang diagnostic pop
}


//处理苹果远程通知，判断是否存在receiveRemoteNotification方法
- (void)receiveRemoteMessageHandleing:(NSDictionary *)dic{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    SEL receiveRemoteNotificationSelector=@selector(receiveRemoteNotification:);
    if([self respondsToSelector:receiveRemoteNotificationSelector])
    {
        [self performSelector:receiveRemoteNotificationSelector withObject:dic];
    }
#pragma clang diagnostic pop
}

//获得deviceToken
-(void)receiveDeviceTokenHandleing:(NSString *)deviceToken
{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    SEL receiveDeviceTokenSelector=@selector(receiveDeviceToken:);
    if([self respondsToSelector:receiveDeviceTokenSelector])
    {
        [self performSelector:receiveDeviceTokenSelector withObject:deviceToken];
    }
#pragma clang diagnostic pop
}

@end
#undef AtAspectOfClass
#undef AtAspect
