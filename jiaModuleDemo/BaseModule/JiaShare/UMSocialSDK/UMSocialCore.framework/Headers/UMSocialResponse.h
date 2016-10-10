//
//  UMSocialResponse.h
//  UMSocialSDK
//
//  Created by wangfei on 16/8/12.
//  Copyright © 2016年 dongjianxiong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UMSocialPlatformConfig.h"

@interface UMSocialResponse : NSObject
@property (nonatomic, copy) NSString  *uid;
@property (nonatomic, copy) NSString  *openid;
@property (nonatomic, assign) UMSocialPlatformType  platformType;
/**
 * 第三方原始数据
 */
@property (nonatomic, strong) id  originalResponse;
@property (nonatomic, strong) id  originalUserProfile;

@end

@interface UMSocialShareResponse : UMSocialResponse

@property (nonatomic, copy) NSString  *message;

+ (UMSocialShareResponse *)shareResponseWithMessage:(NSString *)message;

@end

@interface UMSocialAuthResponse : UMSocialResponse

@property (nonatomic, copy) NSString  *refreshToken;
@property (nonatomic, copy) id  expiration;
@property (nonatomic, copy) NSString  *accessToken;

@end

@interface UMSocialUserInfoResponse : UMSocialResponse
@property (nonatomic, copy) NSString  *name;
@property (nonatomic, copy) NSString  *iconurl;
@property (nonatomic, copy) NSString  *gender;

@end
