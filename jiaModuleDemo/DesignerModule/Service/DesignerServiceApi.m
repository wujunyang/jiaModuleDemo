//
//  DesignerServiceApi.m
//  jiaModuleDemo
//
//  Created by wujunyang on 16/9/21.
//  Copyright © 2016年 wujunyang. All rights reserved.
//

#import "DesignerServiceApi.h"

@implementation DesignerServiceApi

- (NSString *)requestUrl {
    return [NSString stringWithFormat:@"%@%@",JiaDesignerConfigManagerInstance.prefixNetWorkUrl,@"message/notice/list/task_type"];
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGET;
}

@end
