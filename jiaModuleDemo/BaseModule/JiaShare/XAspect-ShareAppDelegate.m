//
//  XAspect-LogAppDelegate.m
//  MobileProject 抽离原本应在AppDelegate友盟统计内容
//
//  Created by wujunyang on 16/6/22.
//  Copyright © 2016年 wujunyang. All rights reserved.
//

#import "JiaAppDelegate.h"
#import "XAspect.h"
#import <UMengSocialCOM/UMSocial.h>
#import "JiaShareConfigManager.h"

#define AtAspect ShareAppDelegate

#define AtAspectOfClass JiaAppDelegate
@classPatchField(JiaAppDelegate)

AspectPatch(-, BOOL, application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions)
{
    NSLog(@"成功加载友盟分享");
    
    
    return XAMessageForward(application:application didFinishLaunchingWithOptions:launchOptions);
}

@end
#undef AtAspectOfClass
#undef AtAspect
