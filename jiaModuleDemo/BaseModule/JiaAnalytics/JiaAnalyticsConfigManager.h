//
//  JiaAnalyticsConfigManager.h
//  jiaModuleDemo
//
//  Created by wujunyang on 16/9/22.
//  Copyright © 2016年 wujunyang. All rights reserved.
//

#import <Foundation/Foundation.h>

#define JiaAnalyticsConfigManagerInstance [JiaAnalyticsConfigManager sharedInstance]

@interface JiaAnalyticsConfigManager : NSObject

+ (JiaAnalyticsConfigManager *)sharedInstance;

//友盟统计配置 友盟key,chanel,是否开启SDK调试,是否开启闪退记录
@property (strong, nonatomic) NSString *analyticsAppKey;
@property (strong, nonatomic) NSString *analyticsChannelID;
@property (nonatomic,getter=isLogEnabled) BOOL analyticsLogEnabled;
@property(nonatomic) BOOL  bCrashReportEnabled;

//要统计的开头页面的前缀字符串数组 比如"CF"
@property(strong,nonatomic)NSArray *prefixFilterArray;
//要统计的页面名称字符串数组 比如"detailViewController"
@property(strong,nonatomic)NSArray *fileterNameArray;
//不统计的页面名称字符串数组 
@property(strong,nonatomic)NSArray *noFileterNameArray;

@end
