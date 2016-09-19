//
//  Target_Designer.m
//  jiaModuleDemo
//
//  Created by wujunyang on 16/9/13.
//  Copyright © 2016年 wujunyang. All rights reserved.
//

#import "Target_Designer.h"
#import "DesignerViewController.h"

typedef void (^JiaUrlRouterCallbackBlock)(NSDictionary *info);

@implementation Target_Designer

- (UIViewController *)Action_nativeFetchDetailViewController:(NSDictionary *)params
{
    DesignerViewController *viewController=[[DesignerViewController alloc]initWithRouterParams:params];
    return viewController;
}

@end
