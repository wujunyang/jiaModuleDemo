//
//  JiaMediator+DesignerModuleActions.h
//  jiaModuleDemo
//
//  Created by wujunyang on 16/9/13.
//  Copyright © 2016年 wujunyang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JiaMediator.h"
#import "headerDesignerConfig.h"


@interface JiaMediator (DesignerModuleActions)

- (UIViewController *)JiaMediator_Designer_viewControllerForDetail;

- (UIViewController *)JiaMediator_Designer_viewControllerForDetail:(NSDictionary *)params;

@end
