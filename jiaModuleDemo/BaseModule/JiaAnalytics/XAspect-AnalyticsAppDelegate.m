//
//  XAspect-LogAppDelegate.m
//  MobileProject 抽离原本应在AppDelegate友盟统计内容
//
//  Created by wujunyang on 16/6/22.
//  Copyright © 2016年 wujunyang. All rights reserved.
//

#import "JiaAppDelegate.h"
#import "XAspect.h"
#import "UMMobClick/MobClick.h"
#import "JiaAnalyticsConfigManager.h"

#define AtAspect AnalyticsAppDelegate

#define AtAspectOfClass JiaAppDelegate
@classPatchField(JiaAppDelegate)

AspectPatch(-, BOOL, application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions)
{
    NSLog(@"成功加载友盟统计");

    UMConfigInstance.appKey=JiaAnalyticsConfigManagerInstance.analyticsAppKey;
    UMConfigInstance.channelId=JiaAnalyticsConfigManagerInstance.analyticsChannelID;
    UMConfigInstance.bCrashReportEnabled=!JiaAnalyticsConfigManagerInstance.bCrashReportEnabled?NO:YES;
    [MobClick startWithConfigure:UMConfigInstance];
    // version标识
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    [MobClick setAppVersion:version];
    
    if(JiaAnalyticsConfigManagerInstance.isLogEnabled)
    {
        [MobClick setLogEnabled:YES];
    }
    
    
    return XAMessageForward(application:application didFinishLaunchingWithOptions:launchOptions);
}

@end
#undef AtAspectOfClass
#undef AtAspect
