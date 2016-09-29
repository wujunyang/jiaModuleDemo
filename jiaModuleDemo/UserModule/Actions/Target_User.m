//
//  Target_User.m
//  jiaModuleDemo
//
//  Created by wujunyang on 16/9/13.
//  Copyright © 2016年 wujunyang. All rights reserved.
//

#import "Target_User.h"
#import "UserViewController.h"

@implementation Target_User

- (UIViewController *)Action_nativeUserDetailViewController:(NSDictionary *)params
{
    UserViewController *viewController=[[UserViewController alloc]initWithRouterParams:params];
    return viewController;
}

@end
