//
//  JiaShareConfigManager.m
//  jiaModuleDemo
//
//  Created by wujunyang on 16/10/8.
//  Copyright © 2016年 wujunyang. All rights reserved.
//

#import "JiaShareConfigManager.h"

@implementation JiaShareConfigManager

+ (JiaShareConfigManager *)sharedInstance
{
    static JiaShareConfigManager* instance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [JiaShareConfigManager new];
    });
    return instance;
}

@end
