//
//  JiaShareTool.h
//  jiaModuleDemo
//
//  Created by wujunyang on 16/10/10.
//  Copyright © 2016年 wujunyang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UMSocialCore/UMSocialCore.h>
#import "JiaShareConfigManager.h"

@interface JiaShareTool : NSObject

/**
 把Jia分享类型映射到友盟的类型
 
 @param jiaPlatformType <#jiaPlatformType description#>
 
 @return <#return value description#>
 */
+(UMSocialPlatformType)getUMSocialPlatformJiaPlatformType:(JiaSocialPlatformType)jiaPlatformType;

@end
