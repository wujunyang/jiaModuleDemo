//
//  jiaConfigManager.h
//  jiaModuleDemo 关于模块中一些配置文件
//
//  Created by wujunyang on 16/9/20.
//  Copyright © 2016年 wujunyang. All rights reserved.
//

#import <Foundation/Foundation.h>

#define JiaDesignerConfigManagerInstance [jiaDesignerConfigManager sharedInstance]

@interface jiaDesignerConfigManager : NSObject

+ (jiaDesignerConfigManager *)sharedInstance;

//网络请求前缀
@property (strong, nonatomic) NSString *prefixNetWorkUrl;

@end
