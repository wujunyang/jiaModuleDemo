//
//  JiaShareHelper.m
//  jiaModuleDemo
//
//  Created by wujunyang on 16/10/9.
//  Copyright © 2016年 wujunyang. All rights reserved.
//

#import "JiaShareHelper.h"
#import <UMSocialCore/UMSocialCore.h>
#import "JiaShareTool.h"


@interface JiaShareHelper()

@end

@implementation JiaShareHelper

+ (void)shareTextDataWithPlatform:(JiaSocialPlatformType)platformType withTextData:(NSString *)textData withCompletion:(JiaSocialShareCompletionHandler)completionHandler
{
    UMSocialPlatformType umPlatFormType=[JiaShareTool getUMSocialPlatformJiaPlatformType:platformType];
    
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
    UMSocialPlatformType umPlatFormType=[JiaShareTool getUMSocialPlatformJiaPlatformType:platformType];
    
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
    UMSocialPlatformType umPlatFormType=[JiaShareTool getUMSocialPlatformJiaPlatformType:platformType];
    
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
    UMSocialPlatformType umPlatFormType=[JiaShareTool getUMSocialPlatformJiaPlatformType:platformType];
    
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
    UMSocialPlatformType umPlatFormType=[JiaShareTool getUMSocialPlatformJiaPlatformType:platformType];
    
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

@end
