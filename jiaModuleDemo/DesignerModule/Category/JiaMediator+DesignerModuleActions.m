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
NSString * const kJiaMediatorActionNativePresentImage = @"nativePresentImage";
NSString * const kJiaMediatorActionNativeNoImage = @"nativeNoImage";


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

- (void)JiaMediator_Designer_presentImage:(UIImage *)image
{
    if (image) {
        [self performTarget:kJiaMediatorTargetA
                     action:kJiaMediatorActionNativePresentImage
                     params:@{kDesignerModuleActionsDictionaryKeyImage:image}];
    } else {
        // 这里处理image为nil的场景
        [self performTarget:kJiaMediatorTargetA
                     action:kJiaMediatorActionNativeNoImage
                     params:@{kDesignerModuleActionsDictionaryKeyImage:[UIImage imageNamed:@"noImage"]}];
    }
}

@end
