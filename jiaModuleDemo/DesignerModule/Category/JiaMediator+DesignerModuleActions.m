//
//  JiaMediator+DesignerModuleActions.m
//  jiaModuleDemo
//
//  Created by wujunyang on 16/9/13.
//  Copyright © 2016年 wujunyang. All rights reserved.
//

#import "JiaMediator+DesignerModuleActions.h"

//模块的常量
NSString * const kJiaMediatorTargetA = @"Designer";
NSString * const kJiaMediatorActionNativFetchDetailViewController = @"nativeFetchDetailViewController";


@implementation JiaMediator (DesignerModuleActions)

- (UIViewController *)JiaMediator_Designer_viewControllerForDetail
{
    return [self JiaMediator_Designer_viewControllerForDetail:nil];
}

- (UIViewController *)JiaMediator_Designer_viewControllerForDetail:(NSDictionary *)params
{
    UIViewController *viewController = [self performTarget:kJiaMediatorTargetA
                                                    action:kJiaMediatorActionNativFetchDetailViewController
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
