//
//  XAspect-LogAppDelegate.m
//  MobileProject 抽离原本应在AppDelegate友盟分享内容
//
//  Created by wujunyang on 16/6/22.
//  Copyright © 2016年 wujunyang. All rights reserved.
//

#import "JiaAppDelegate.h"
#import "XAspect.h"
#import <UMSocialCore/UMSocialCore.h>
#import "JiaShareConfigManager.h"

#define AtAspect ShareAppDelegate

#define AtAspectOfClass JiaAppDelegate
@classPatchField(JiaAppDelegate)

AspectPatch(-, BOOL, application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions)
{
    NSLog(@"成功加载友盟分享");
    //打开日志
    if(JiaShareConfigManagerInstance.isLogEnabled)
    {
        [[UMSocialManager defaultManager] openLog:YES];
    }
    
    if(JiaShareConfigManagerInstance.shareAppKey)
    {
        //设置友盟appkey
        [[UMSocialManager defaultManager] setUmSocialAppkey:JiaShareConfigManagerInstance.shareAppKey];
    }
    
    //各平台的详细配置
    if(JiaShareConfigManagerInstance.jiaSocialPlatConfigType_Wechat_AppKey&&JiaShareConfigManagerInstance.jiaSocialPlatConfigType_Wechat_AppSecret)
    {
        NSLog(@"分享-微信平台已经配置");
        //设置微信的appId和appKey
        [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:JiaShareConfigManagerInstance.jiaSocialPlatConfigType_Wechat_AppKey appSecret:JiaShareConfigManagerInstance.jiaSocialPlatConfigType_Wechat_AppSecret redirectURL:JiaShareConfigManagerInstance.jiaSocialPlatConfigType_Wechat_RedirectURL];
    }
    
    if(JiaShareConfigManagerInstance.jiaSocialPlatConfigType_Tencent_AppKey&&JiaShareConfigManagerInstance.jiaSocialPlatConfigType_Tencent_AppSecret)
    {
        NSLog(@"分享-腾讯平台已经配置");
        //设置分享到QQ互联的appId和appKey
        [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:JiaShareConfigManagerInstance.jiaSocialPlatConfigType_Tencent_AppKey  appSecret:JiaShareConfigManagerInstance.jiaSocialPlatConfigType_Tencent_AppSecret redirectURL:JiaShareConfigManagerInstance.jiaSocialPlatConfigType_Tencent_RedirectURL];
    }
    
    if(JiaShareConfigManagerInstance.jiaSocialPlatConfigType_Sina_AppKey&&JiaShareConfigManagerInstance.jiaSocialPlatConfigType_Sina_AppSecret)
    {
        NSLog(@"分享-新浪平台已经配置");
        //设置新浪的appId和appKey
        [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:JiaShareConfigManagerInstance.jiaSocialPlatConfigType_Sina_AppKey  appSecret:JiaShareConfigManagerInstance.jiaSocialPlatConfigType_Sina_AppSecret redirectURL:JiaShareConfigManagerInstance.jiaSocialPlatConfigType_Sina_RedirectURL];
    }
    
    return XAMessageForward(application:application didFinishLaunchingWithOptions:launchOptions);
}

AspectPatch(-, BOOL,application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation)
{
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result) {
        
    }
    return result;
}

AspectPatch(-, BOOL,application:(UIApplication *)application handleOpenURL:(NSURL *)url)
{
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result) {
        
    }
    return result;
}

@end
#undef AtAspectOfClass
#undef AtAspect
