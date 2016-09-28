//
//  JiaCoreConfigManager.h
//  jiaModuleDemo
//
//  Created by wujunyang on 16/9/22.
//  Copyright © 2016年 wujunyang. All rights reserved.
//

#import <Foundation/Foundation.h>

#define JiaCoreConfigManagerInstance [JiaCoreConfigManager sharedInstance]

@interface JiaCoreConfigManager : NSObject

+ (JiaCoreConfigManager *)sharedInstance;

//是否开启日志记录
@property(nonatomic, assign, getter = isRecordlogger) BOOL recordlogger;
//是否开启调试插件
@property(nonatomic, assign, getter = isOpenDebug) BOOL openDebug;
//设置Patcth 传入JiaPathchModel类型的数组 有值则会启动JSPatch热更新功能
@property(nonatomic,strong) NSMutableArray *jSPatchMutableArray;

@end
