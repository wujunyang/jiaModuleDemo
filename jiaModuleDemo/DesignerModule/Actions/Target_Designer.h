//
//  Target_Designer.h
//  jiaModuleDemo
//
//  Created by wujunyang on 16/9/13.
//  Copyright © 2016年 wujunyang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface Target_Designer : NSObject

- (UIViewController *)Action_nativeFetchDetailViewController:(NSDictionary *)params;

- (id)Action_nativePresentImage:(NSDictionary *)params;

- (id)Action_nativeNoImage:(NSDictionary *)params;

@end
