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
    DesignerViewController *viewController=[[DesignerViewController alloc]init];
    viewController.myDesignerLabel.text=params[@"name"];
    viewController.myDesignIDLabel.text=params[@"ID"];
    viewController.myDesignImageView.image=params[@"image"];
    return viewController;
}

- (id)Action_nativePresentImage:(NSDictionary *)params
{
    DesignerViewController *viewController=[[DesignerViewController alloc]init];
    viewController.myDesignerLabel.text=params[@"name"];
    viewController.myDesignIDLabel.text=params[@"ID"];
    viewController.myDesignImageView.image=params[@"image"];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:viewController animated:YES completion:nil];
    return nil;
}


- (id)Action_nativeNoImage:(NSDictionary *)params
{
    DesignerViewController *viewController=[[DesignerViewController alloc]init];
    viewController.myDesignerLabel.text=@"当前没有图标";
    viewController.myDesignIDLabel.text=params[@"ID"];
    viewController.myDesignImageView.image=params[@"image"];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:viewController animated:YES completion:nil];
    return nil;
}

@end
