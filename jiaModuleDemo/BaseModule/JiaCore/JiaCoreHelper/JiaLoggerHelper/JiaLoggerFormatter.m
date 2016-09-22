//
//  JiaLoggerFormatter.m
//  jiaModuleDemo
//
//  Created by wujunyang on 16/9/22.
//  Copyright © 2016年 wujunyang. All rights reserved.
//

#import "JiaLoggerFormatter.h"

@implementation JiaLoggerFormatter

- (NSString *)formatLogMessage:(DDLogMessage *)logMessage {
    
    NSString *logLevel = nil;
    switch (logMessage.flag) {
        case DDLogFlagError:
            logLevel = @"[ERROR]";
            break;
        case DDLogFlagWarning:
            logLevel = @"[WARN]";
            break;
        case DDLogFlagInfo:
            logLevel = @"[INFO]";
            break;
        case DDLogFlagDebug:
            logLevel = @"[DEBUG]";
            break;
        default:
            logLevel = @"[VBOSE]";
            break;
    }
    
    NSString *formatStr
    = [NSString stringWithFormat:@"%@ %@ [%@][line %ld] %@ %@", logLevel,[self stringWithFormat:@"yyyy-MM-dd HH:mm:ss.S" dateTime:logMessage.timestamp], logMessage.fileName, logMessage.line, logMessage.function, logMessage.message];
    return formatStr;
}

- (NSString *)stringWithFormat:(NSString *)format dateTime:(NSDate *)dateTime {
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:format];
    NSString *retStr = [outputFormatter stringFromDate:dateTime];
    return retStr;
}

@end
