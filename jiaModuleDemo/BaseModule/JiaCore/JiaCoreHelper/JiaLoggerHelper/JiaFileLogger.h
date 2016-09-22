//
//  JiaFileLogger.h
//  jiaModuleDemo
//
//  Created by wujunyang on 16/9/22.
//  Copyright © 2016年 wujunyang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JiaCocoaLumberjack.h"
#import "JiaLoggerFormatter.h"

@interface JiaFileLogger : NSObject

@property (nonatomic, strong, readwrite) DDFileLogger *fileLogger;

+(JiaFileLogger *)sharedManager;

@end
