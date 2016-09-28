//
//  JiaAnalyticsConfigManager.m
//  jiaModuleDemo
//
//  Created by wujunyang on 16/9/22.
//  Copyright © 2016年 wujunyang. All rights reserved.
//

#import "JiaAnalyticsConfigManager.h"

@implementation JiaAnalyticsConfigManager

+ (JiaAnalyticsConfigManager *)sharedInstance
{
    static JiaAnalyticsConfigManager* instance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [JiaAnalyticsConfigManager new];
    });
    return instance;
}

@end
