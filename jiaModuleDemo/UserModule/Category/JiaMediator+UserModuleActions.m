//
//  JiaMediator+UserModuleActions.m
//  jiaModuleDemo
//
//  Created by wujunyang on 16/9/13.
//  Copyright © 2016年 wujunyang. All rights reserved.
//

#import "JiaMediator+UserModuleActions.h"

//模块的常量
NSString * const kJiaMediatorTargetUser = @"User";
NSString * const kJiaMediatorActionNativUserDetailViewController = @"nativeUserDetailViewController";

@implementation JiaMediator (UserModuleActions)

- (UIViewController *)JiaMediator_User_viewControllerForDetail
{
    return [self JiaMediator_User_viewControllerForDetail:nil];
}

- (UIViewController *)JiaMediator_User_viewControllerForDetail:(NSDictionary *)params
{
    UIViewController *viewController = [self performTarget:kJiaMediatorTargetUser
                                                    action:kJiaMediatorActionNativUserDetailViewController
                                                    params:params];
    if ([viewController isKindOfClass:[UIViewController class]]) {
        // view controller 交付出去之后，可以由外界选择是push还是present
        return viewController;
    } else {
        // 这里处理异常场景，具体如何处理取决于产品
        return [[UIViewController alloc] init];
    }
}

@end
