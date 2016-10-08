//
//  JiaShareConfigManager.h
//  jiaModuleDemo
//
//  Created by wujunyang on 16/10/8.
//  Copyright © 2016年 wujunyang. All rights reserved.
//

#import <Foundation/Foundation.h>

#define JiaShareConfigManagerInstance [JiaShareConfigManager sharedInstance]

@interface JiaShareConfigManager : NSObject

+ (JiaShareConfigManager *)sharedInstance;

@end
