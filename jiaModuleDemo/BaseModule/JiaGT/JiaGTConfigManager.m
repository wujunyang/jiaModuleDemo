//
//  jiaGTConfigManager.m
//  Pods
//
//  Created by wujunyang on 16/7/7.
//
//

#import "jiaGTConfigManager.h"

@implementation JiaGTConfigManager

+ (JiaGTConfigManager *)sharedInstance
{
    static JiaGTConfigManager* instance = nil;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [JiaGTConfigManager new];
    });

    return instance;
}

@end
