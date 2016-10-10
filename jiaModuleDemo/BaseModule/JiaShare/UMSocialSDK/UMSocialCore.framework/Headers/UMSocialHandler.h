//
//  UMSShareDataTypeTableViewController.h
//  SocialSDK
//
//  Created by umeng on 16/4/14.
//  Copyright © 2016年 dongjianxiong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UMSocialPlatformConfig.h"
#import "UMSocialPlatformProvider.h"


extern NSString *const  UMSocialErrorDomain;
extern NSString *const  UMSocialShareDataTypeIllegalMessage;

/**
 *  实现所有平台的基类
 *  @discuss 
 *  前提条件:需要在主工程配置 other link flag -ObjC
 *  所有实现UMSocialHandler对应平台类型子类，需要重写如下方法：
 *  1.+(NSArray*) socialPlatformTypes; 返回对应平台的类型的数组，此处用数组是为了在微信和qq的平台是可以有不同的平台类型（微信，朋友圈等）与统一handler公用
 *  2.重写load函数：
 *  @encode:
 *   +(void)load
 *   {
 *       [super load];//必须调用
 *   }
 *  @encode
 *  重载后保证调用基类的[UMSocialHandler load]
 *  3.重写defaultManager单例类方法，保证运行时能找到defaultManager来获得当前的单例方法,保证其唯一性。
 */
@interface UMSocialHandler : NSObject<UMSocialPlatformProvider>

#pragma mark - 子类需要重载的类
+(void)load;
+(NSArray*) socialPlatformTypes;
+ (UMSocialHandler *)defaultManager;

#pragma mark -

@property (nonatomic, copy) NSString *appID;

@property (nonatomic, copy) NSString *appSecret;

@property (nonatomic, copy) NSString *redirectURL;

/**
 * 当前ViewController（用于一些特定平台弹出相应的页面，默认使用当前ViewController）
 */
@property (nonatomic, strong) UIViewController *currentViewController;

@property (nonatomic, copy) UMSocialRequestCompletionHandler shareCompletionBlock;

@property (nonatomic, copy) UMSocialRequestCompletionHandler authCompletionBlock;

@property (nonatomic, copy) UMSocialRequestCompletionHandler userinfoCompletionBlock;


-(BOOL)searchForURLSchemeWithPrefix:(NSString *)prefix;
-(void)setAppId:(NSString *)appID appSecret:(NSString *)secret url:(NSString *)url;
-(void)saveuid:(NSString *)uid openid:(NSString *)openid accesstoken:(NSString *)token refreshtoken:(NSString *)retoken expiration:(id )expiration;

@end
