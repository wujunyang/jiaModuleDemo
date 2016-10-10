//
//  JiaShareConfigManager.h
//  jiaModuleDemo
//
//  Created by wujunyang on 16/10/8.
//  Copyright © 2016年 wujunyang. All rights reserved.
//

#import <Foundation/Foundation.h>

#define JiaShareConfigManagerInstance [JiaShareConfigManager sharedInstance]

//配置类型 目前只支持新浪、微信、腾讯
typedef NS_ENUM(NSInteger,JiaSocialPlatConfigType)
{
    JiaSocialPlatConfigType_Sina,        //新浪
    JiaSocialPlatConfigType_Wechat,      //微信
    JiaSocialPlatConfigType_Tencent,     //腾讯
};


//平台类型 目前只支持新浪、微信聊天、微信朋友圈、QQ聊天页面、qq空间、腾讯微博
typedef NS_ENUM(NSInteger,JiaSocialPlatformType)
{
    JiaSocialPlatformType__UnKnown,      //未指定
    JiaSocialPlatformType_Sina,          //新浪
    JiaSocialPlatformType_WechatSession, //微信聊天
    JiaSocialPlatformType_WechatTimeLine,//微信朋友圈
    JiaSocialPlatformType_QQ,            //QQ聊天页面
    JiaSocialPlatformType_Qzone,         //qq空间
    JiaSocialPlatformType_TencentWb,     //腾讯微博
};

@interface JiaShareConfigManager : NSObject

//友盟分享配置 友盟key,是否开启SDK调试
@property (strong, nonatomic) NSString *shareAppKey;
@property (nonatomic,getter=isLogEnabled) BOOL shareLogEnabled;

//其它配置 分享成功跟失败的提示语
@property (strong, nonatomic) NSString *shareSuccessMessage;
@property (strong, nonatomic) NSString *shareFailMessage;

//设置新浪
@property (strong, nonatomic) NSString *jiaSocialPlatConfigType_Sina_AppKey;
@property (strong, nonatomic) NSString *jiaSocialPlatConfigType_Sina_AppSecret;
@property (strong, nonatomic) NSString *jiaSocialPlatConfigType_Sina_RedirectURL;

//设置微信
@property (strong, nonatomic) NSString *jiaSocialPlatConfigType_Wechat_AppKey;
@property (strong, nonatomic) NSString *jiaSocialPlatConfigType_Wechat_AppSecret;
@property (strong, nonatomic) NSString *jiaSocialPlatConfigType_Wechat_RedirectURL;

//设置腾讯
@property (strong, nonatomic) NSString *jiaSocialPlatConfigType_Tencent_AppKey;
@property (strong, nonatomic) NSString *jiaSocialPlatConfigType_Tencent_AppSecret;
@property (strong, nonatomic) NSString *jiaSocialPlatConfigType_Tencent_RedirectURL;

+ (JiaShareConfigManager *)sharedInstance;


/**
 设置平台配置内容

 @param platformType 平台类型
 @param appKey       appKey
 @param appSecret    appSecret
 @param redirectURL  redirectURL
 */
- (void)setPlaform:(JiaSocialPlatConfigType)platformType
            appKey:(NSString *)appKey
         appSecret:(NSString *)appSecret
       redirectURL:(NSString *)redirectURL;

@end
