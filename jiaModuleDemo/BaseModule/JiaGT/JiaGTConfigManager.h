//
//  jiaGTConfigManager.h
//  Pods
//
//  Created by wujunyang on 16/7/7.
//
//

#import <Foundation/Foundation.h>

@interface JiaGTConfigManager : NSObject

+ (JiaGTConfigManager *)sharedInstance;

//个推配置
@property (strong, nonatomic) NSString *jiaGTAppId;
@property (strong, nonatomic) NSString *jiaGTAppKey;
@property (strong, nonatomic) NSString *jiaGTAppSecret;

@end
