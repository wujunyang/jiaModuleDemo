//
//  jiaGTConfigManager.m
//  Pods
//
//  Created by wujunyang on 16/7/7.
//
//

#import "jiaGTConfigManager.h"

@implementation jiaGTConfigManager

+ (jiaGTConfigManager *)sharedInstance
{
    static jiaGTConfigManager* instance = nil;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [jiaGTConfigManager new];
    });

    return instance;
}

@end
