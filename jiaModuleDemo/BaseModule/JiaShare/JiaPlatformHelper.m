//
//  JiaPlatformHelper.m
//  jiaModuleDemo
//
//  Created by wujunyang on 16/10/10.
//  Copyright © 2016年 wujunyang. All rights reserved.
//

#import "JiaPlatformHelper.h"
#import "JiaShareTool.h"
#import <UMSocialCore/UMSocialCore.h>

@implementation JiaPlatformHelper

+(BOOL)installPlatAppWithType:(JiaSocialPlatformType)platformType
{
    BOOL result=NO;
    
    result=[[UMSocialManager defaultManager] isInstall:[JiaShareTool getUMSocialPlatformJiaPlatformType:platformType]];
    
    return result;
}


/**
 授权
 
 @param platformType 平台类型
 */
+(void)authWithPlatform:(JiaSocialPlatformType)platformType withCompletion:(JiaSocialAuthCompletionHandler)completionHandler
{
    [[UMSocialManager defaultManager] authWithPlatform:[JiaShareTool getUMSocialPlatformJiaPlatformType:platformType] currentViewController:nil completion:^(id result, NSError *error) {
        UMSocialAuthResponse *authresponse=result;
        completionHandler(authresponse.uid,authresponse.openid,authresponse.accessToken,error);
    }];
}


/**
 取消授权
 
 @param platformType 平台类型
 */
+(void)cancelAuthWithPlatform:(JiaSocialPlatformType)platformType withCompletion:(JiaCancelSocialAuthCompletionHandler)completionHandler
{
    [[UMSocialManager defaultManager] cancelAuthWithPlatform:[JiaShareTool getUMSocialPlatformJiaPlatformType:platformType] completion:^(id result, NSError *error) {
        completionHandler(result,error);
    }];
}


/**
 获得用户信息
 
 @param platformType 平台类型
 */
+(void)getUserInfoWithPlatform:(JiaSocialPlatformType)platformType withCompletion:(JiaSocialGetUserInfoCompletionHandler)completionHandler
{
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:[JiaShareTool getUMSocialPlatformJiaPlatformType:platformType] currentViewController:nil completion:^(id result, NSError *error) {
        UMSocialUserInfoResponse *userinfo =result;
        completionHandler(userinfo.name,userinfo.iconurl,userinfo.gender,error);
    }];
}

@end
