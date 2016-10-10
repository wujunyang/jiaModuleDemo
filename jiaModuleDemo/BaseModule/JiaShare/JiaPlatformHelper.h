//
//  JiaPlatformHelper.h
//  jiaModuleDemo 第三方登录 跟 登录后用户信息的获取
//
//  Created by wujunyang on 16/10/10.
//  Copyright © 2016年 wujunyang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JiaShareConfigManager.h"


/**
 授权

 @param uid         授权成功获得uid
 @param uid         授权成功获得openid QQ，微信用户openid，其他平台没有
 @param accessToken 授权成功获得accessToken
 @param error       error
 */
typedef void (^JiaSocialAuthCompletionHandler)(NSString *uid,NSString *openid,NSString *accessToken,NSError *error);


/**
 取消授权

 @param result 结果
 @param error  error
 */
typedef void (^JiaCancelSocialAuthCompletionHandler)(id result,NSError *error);


/**
 获得用户

 @param name    用户名称
 @param iconUrl 头像URL
 @param gender  性别 （m表示男，w表示女）
 @param error   error
 */
typedef void (^JiaSocialGetUserInfoCompletionHandler)(NSString *name,NSString *iconUrl,NSString *gender,NSError *error);



@interface JiaPlatformHelper : NSObject


@property (nonatomic, copy) JiaSocialAuthCompletionHandler socialAuthCompletionBlock;
@property (nonatomic, copy) JiaCancelSocialAuthCompletionHandler cancelSocialAuthCompletionBlock;
@property (nonatomic, copy) JiaSocialGetUserInfoCompletionHandler socialGetUserInfoCompletionBlock;

/**
 判断当前手机是否有安装相应的APP
 
 @param platformType 平台类型
 
 @return YES 有安装 NO 未安装
 */
+(BOOL)installPlatAppWithType:(JiaSocialPlatformType)platformType;


/**
 授权

 @param platformType 平台类型
 */
+(void)authWithPlatform:(JiaSocialPlatformType)platformType withCompletion:(JiaSocialAuthCompletionHandler)completionHandler;


/**
 取消授权

 @param platformType 平台类型
 */
+(void)cancelAuthWithPlatform:(JiaSocialPlatformType)platformType withCompletion:(JiaCancelSocialAuthCompletionHandler)completionHandler;


/**
 获得用户信息

 @param platformType 平台类型
 */
+(void)getUserInfoWithPlatform:(JiaSocialPlatformType)platformType withCompletion:(JiaSocialGetUserInfoCompletionHandler)completionHandler;

@end
