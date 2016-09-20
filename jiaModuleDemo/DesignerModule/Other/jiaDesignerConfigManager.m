//
//  jiaConfigManager.m
//  jiaModuleDemo
//
//  Created by wujunyang on 16/9/20.
//  Copyright © 2016年 wujunyang. All rights reserved.
//

#import "jiaDesignerConfigManager.h"

@implementation jiaDesignerConfigManager

+ (jiaDesignerConfigManager *)sharedInstance
{
    static jiaDesignerConfigManager* instance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [jiaDesignerConfigManager new];
    });
    
    return instance;
}

@end
