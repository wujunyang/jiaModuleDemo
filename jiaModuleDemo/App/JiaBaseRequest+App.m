//
//  JiaBaseRequest+App.m
//  jiaModuleDemo
//
//  Created by wujunyang on 16/9/21.
//  Copyright © 2016年 wujunyang. All rights reserved.
//

#import "JiaBaseRequest+App.h"

@implementation JiaBaseRequest (App)

- (NSTimeInterval)requestTimeoutInterval {
    return 15;
}

//公共头部设置
- (NSDictionary *)requestHeaderFieldValueDictionary
{
    NSDictionary *headerDictionary=@{@"platform":@"ios"};
    return headerDictionary;
}

@end
