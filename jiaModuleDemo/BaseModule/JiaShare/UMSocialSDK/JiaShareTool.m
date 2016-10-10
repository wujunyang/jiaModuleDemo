//
//  JiaShareTool.m
//  jiaModuleDemo
//
//  Created by wujunyang on 16/10/10.
//  Copyright © 2016年 wujunyang. All rights reserved.
//

#import "JiaShareTool.h"

@implementation JiaShareTool

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
