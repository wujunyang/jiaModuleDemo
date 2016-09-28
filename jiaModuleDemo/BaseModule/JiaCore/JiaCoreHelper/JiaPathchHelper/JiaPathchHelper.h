//
//  JiaPathchHelper.h
//  jiaModuleDemo
//
//  Created by wujunyang on 16/9/26.
//  Copyright © 2016年 wujunyang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JiaPathchHelper : NSObject

//是关于JiaPathchModel的数组
- (instancetype)initWithPatchArray:(NSMutableArray *)array;

//加载热更新文件
-(void)loadPathchFile;

@end
