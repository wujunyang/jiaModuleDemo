//
//  JiaCoreConfigManager.h
//  jiaModuleDemo
//
//  Created by wujunyang on 16/9/22.
//  Copyright © 2016年 wujunyang. All rights reserved.
//

#import <Foundation/Foundation.h>

//日志记录等级
typedef NS_ENUM(NSInteger, JiaCoreLoggerLevel) {
    JiaCoreLoggerLevelOff,
    JiaCoreLoggerLevelErro,
    JiaCoreLoggerLevelWarning,
    JiaCoreLoggerLevelInfo,
    JiaCoreLoggerLevelDebug,
    JiaCoreLoggerLevelVerbose,
    JiaCoreLoggerLevelAll
};


@interface JiaCoreConfigManager : NSObject

+ (JiaCoreConfigManager *)sharedInstance;

//是否开启日志记录
@property(nonatomic, assign, getter = isRecordlogger) BOOL recordlogger;

@end
