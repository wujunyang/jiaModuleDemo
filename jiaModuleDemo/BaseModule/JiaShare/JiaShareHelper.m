//
//  JiaShareHelper.m
//  jiaModuleDemo
//
//  Created by wujunyang on 16/10/9.
//  Copyright © 2016年 wujunyang. All rights reserved.
//

#import "JiaShareHelper.h"
#import <UMSocialCore/UMSocialCore.h>

@interface JiaShareHelper()

@end

@implementation JiaShareHelper

+ (void)shareTextDataWithPlatform:(JiaSocialPlatformType)platformType withTextData:(NSString *)textData withCompletion:(JiaSocialShareCompletionHandler)completionHandler
{
    UMSocialPlatformType umPlatFormType=[self getUMSocialPlatformJiaPlatformType:platformType];
    
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    messageObject.text=textData;
    
    //友盟分享
    [[UMSocialManager defaultManager] shareToPlatform:umPlatFormType messageObject:messageObject currentViewController:nil completion:^(id result, NSError *error) {
        completionHandler(result,error);
    }];
}

+ (void)shareUrlDataWithPlatform:(JiaSocialPlatformType)platformType withShareUrl:(NSString *)shareUrl withTitle:(NSString *)title withDescr:(NSString *)descr withThumImage:(id)thumImage withCompletion:(JiaSocialShareCompletionHandler)completionHandler
{
    UMSocialPlatformType umPlatFormType=[self getUMSocialPlatformJiaPlatformType:platformType];
    
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:title descr:descr thumImage:thumImage];
    [shareObject setWebpageUrl:shareUrl];
    messageObject.shareObject = shareObject;
    
    //友盟分享
    [[UMSocialManager defaultManager] shareToPlatform:umPlatFormType messageObject:messageObject currentViewController:nil completion:^(id result, NSError *error) {
        completionHandler(result,error);
    }];
}

+ (void)shareImageTextDataWithPlatform:(JiaSocialPlatformType)platformType withShareImage:(id)shareImage withTitle:(NSString *)title withDescr:(NSString *)descr withThumImage:(id)thumImage withCompletion:(JiaSocialShareCompletionHandler)completionHandler
{
    UMSocialPlatformType umPlatFormType=[self getUMSocialPlatformJiaPlatformType:platformType];
    
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    UMShareImageObject *shareObject = [UMShareImageObject shareObjectWithTitle:title descr:descr thumImage:thumImage];
    [shareObject setShareImage:shareImage];
    messageObject.shareObject = shareObject;
    
    //友盟分享
    [[UMSocialManager defaultManager] shareToPlatform:umPlatFormType messageObject:messageObject currentViewController:nil completion:^(id result, NSError *error) {
        completionHandler(result,error);
    }];
}

+ (void)shareVideoDataWithPlatform:(JiaSocialPlatformType)platformType withShareVideoUrl:(NSString *)shareVideoUrl withTitle:(NSString *)title withDescr:(NSString *)descr withThumImage:(id)thumImage withCompletion:(JiaSocialShareCompletionHandler)completionHandler
{
    UMSocialPlatformType umPlatFormType=[self getUMSocialPlatformJiaPlatformType:platformType];
    
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    UMShareVideoObject *shareObject = [UMShareVideoObject shareObjectWithTitle:title descr:descr thumImage:thumImage];
    [shareObject setVideoUrl:shareVideoUrl];
    messageObject.shareObject = shareObject;
    
    //友盟分享
    [[UMSocialManager defaultManager] shareToPlatform:umPlatFormType messageObject:messageObject currentViewController:nil completion:^(id result, NSError *error) {
        completionHandler(result,error);
    }];
}

+ (void)shareMusicDataWithPlatform:(JiaSocialPlatformType)platformType withShareMusicUrl:(NSString *)shareMusicUrl withTitle:(NSString *)title withDescr:(NSString *)descr withThumImage:(id)thumImage withCompletion:(JiaSocialShareCompletionHandler)completionHandler
{
    UMSocialPlatformType umPlatFormType=[self getUMSocialPlatformJiaPlatformType:platformType];
    
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    UMShareMusicObject *shareObject = [UMShareMusicObject shareObjectWithTitle:title descr:descr thumImage:thumImage];
    [shareObject setMusicUrl:shareMusicUrl];
    messageObject.shareObject = shareObject;
    
    //友盟分享
    [[UMSocialManager defaultManager] shareToPlatform:umPlatFormType messageObject:messageObject currentViewController:nil completion:^(id result, NSError *error) {
        completionHandler(result,error);
    }];
}

/**
 把Jia分享类型映射到友盟的类型

 @param jiaPlatformType <#jiaPlatformType description#>

 @return <#return value description#>
 */
+(UMSocialPlatformType)getUMSocialPlatformJiaPlatformType:(JiaSocialPlatformType)jiaPlatformType
{
    UMSocialPlatformType platFormType=UMSocialPlatformType_UnKnown;
    switch (jiaPlatformType) {
        case JiaSocialPlatformType_QQ:
            platFormType=UMSocialPlatformType_QQ;
            break;
        case JiaSocialPlatformType_Sina:
            platFormType=UMSocialPlatformType_Sina;
            break;
        case JiaSocialPlatformType_Qzone:
            platFormType=UMSocialPlatformType_Qzone;
            break;
        case JiaSocialPlatformType_TencentWb:
            platFormType=UMSocialPlatformType_TencentWb;
            break;
        case JiaSocialPlatformType_WechatSession:
            platFormType=UMSocialPlatformType_WechatSession;
            break;
        case JiaSocialPlatformType_WechatTimeLine:
            platFormType=UMSocialPlatformType_WechatTimeLine;
            break;
        default:
            platFormType=UMSocialPlatformType_UnKnown;
            break;
    }
    
    return platFormType;
}

@end
