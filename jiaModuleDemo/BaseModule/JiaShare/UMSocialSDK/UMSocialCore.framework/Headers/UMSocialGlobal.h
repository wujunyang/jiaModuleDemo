//
//  UMSocialGlobal.h
//  UMSocialSDK
//
//  Created by 张军华 on 16/8/16.
//  Copyright © 2016年 dongjianxiong. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 *  UMSocial的全局配置文件
 */



/**
 *  用来设置UMSocial的全局设置变量
 */
@interface  UMSocialGlobal: NSObject

+ (UMSocialGlobal *)shareInstance;

/**
 *  是否用cocos2dx,0-没有使用 1-使用cocos2dx 默认为0
 */
@property(atomic,readwrite, assign)NSInteger use_coco2dx;

/**
 *  统计的主题，默认为：UMSocialDefault
 */
@property(atomic,readwrite,copy)NSString* dc;

/**
 *  是否请求的回流统计请求，默认为不请求
 */
@property(atomic,readwrite,assign)BOOL isUrlRequest;


/**
 *  UMSocial的版本号
 *
 *  @return 返回当前的版本号
 */
+(NSString*)umSocialSDKVersion;

@end

