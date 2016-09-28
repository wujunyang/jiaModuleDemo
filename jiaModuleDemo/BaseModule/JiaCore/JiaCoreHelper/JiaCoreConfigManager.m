//
//  JiaCoreConfigManager.m
//  jiaModuleDemo
//
//  Created by wujunyang on 16/9/22.
//  Copyright © 2016年 wujunyang. All rights reserved.
//

#import "JiaCoreConfigManager.h"
#import "JiaPathchHelper.h"

@implementation JiaCoreConfigManager

+ (JiaCoreConfigManager *)sharedInstance
{
    static JiaCoreConfigManager* instance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [JiaCoreConfigManager new];
    });
    
    return instance;
}

-(void)setJSPatchMutableArray:(NSMutableArray *)jSPatchMutableArray
{
    if (jSPatchMutableArray.count>0) {
        NSLog(@"开启热更新功能");
        
        JiaPathchHelper *helper=[[JiaPathchHelper alloc]initWithPatchArray:jSPatchMutableArray];
        [helper loadPathchFile];
    }
}

@end
