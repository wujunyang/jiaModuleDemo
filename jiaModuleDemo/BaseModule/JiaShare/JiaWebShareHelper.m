//
//  JiaWebShareHelper.m
//  jiaModuleDemo
//
//  Created by wujunyang on 16/10/9.
//  Copyright © 2016年 wujunyang. All rights reserved.
//

#import "JiaWebShareHelper.h"
#import "JiaShareHelper.h"
#import "JiaShareConfigManager.h"

@implementation JiaWebShareHelper

-(void)shareText:(NSString *)platformType withText:(NSString *)text
{
    //要在主线程进行
    dispatch_async(dispatch_get_main_queue(), ^{
        [JiaShareHelper shareTextDataWithPlatform:[self getPlatformType:platformType] withTextData:text withCompletion:^(id result, NSError *error) {
            [self shareResultShow:error];
        }];
    });
}

-(void)shareUrl:(NSString *)platformType withShareUrl:(NSString *)shareUrl withTitle:(NSString *)title withDescr:(NSString *)descr withThumImageUrl:(NSString *)thumImageUrl
{
    //要在主线程进行
    dispatch_async(dispatch_get_main_queue(), ^{
        [JiaShareHelper shareUrlDataWithPlatform:[self getPlatformType:platformType] withShareUrl:shareUrl withTitle:title withDescr:descr withThumImage:thumImageUrl withCompletion:^(id result, NSError *error) {
            [self shareResultShow:error];
        }];
    });
}

- (void)shareImageText:(NSString *)platformType withShareImageUrl:(NSString *)shareImageUrl withTitle:(NSString *)title withDescr:(NSString *)descr withThumImageUrl:(NSString *)thumImageUrl
{
    //要在主线程进行
    dispatch_async(dispatch_get_main_queue(), ^{
        [JiaShareHelper shareImageTextDataWithPlatform:[self getPlatformType:platformType] withShareImage:shareImageUrl withTitle:title withDescr:descr withThumImage:thumImageUrl withCompletion:^(id result, NSError *error) {
            [self shareResultShow:error];
        }];
    });
}

/**
 转换类型

 @param platformType 平台字符串sina（新浪微博）wechatsession（微信好友）wechattimeline（微信朋友圈）tencentwb（腾讯微博）qzone(QQ空间) qq（QQ）

 @return JIA平台类型 
 */
-(JiaSocialPlatformType)getPlatformType:(NSString *)platformType
{
    JiaSocialPlatformType jiaPlatformType=JiaSocialPlatformType__UnKnown;
    if ([platformType isEqualToString:@"sina"]) {
        jiaPlatformType=JiaSocialPlatformType_Sina;
    }
    else if ([platformType isEqualToString:@"wechatsession"])
    {
        jiaPlatformType=JiaSocialPlatformType_WechatSession;
    }
    else if ([platformType isEqualToString:@"tencentwb"])
    {
        jiaPlatformType=JiaSocialPlatformType_TencentWb;
    }
    else if ([platformType isEqualToString:@"wechattimeline"])
    {
        jiaPlatformType=JiaSocialPlatformType_WechatTimeLine;
    }
    else if ([platformType isEqualToString:@"qzone"])
    {
        jiaPlatformType=JiaSocialPlatformType_Qzone;
    }
    else if ([platformType isEqualToString:@"qq"])
    {
        jiaPlatformType=JiaSocialPlatformType_QQ;
    }
    else
    {
        NSLog(@"分享指定的类型不存在，请检查平台类型字符串是否正确");
    }
    return jiaPlatformType;
}

-(void)shareResultShow:(NSError *)error
{
    if(error)
    {
        NSLog(@"分享失败了");
        return;
    }
    NSString *alertMessage=JiaShareConfigManagerInstance.shareSuccessMessage?:@"分享成功";
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:alertMessage delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
    [alert show];
}
@end
