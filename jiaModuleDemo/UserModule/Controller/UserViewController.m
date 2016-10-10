//
//  UserViewController.m
//  jiaModuleDemo
//
//  Created by wujunyang on 16/9/13.
//  Copyright © 2016年 wujunyang. All rights reserved.
//

#import "UserViewController.h"

#import "JiaShareHelper.h"

@interface UserViewController()

@property (nonatomic, strong) UIButton *returnButton,*shareButton;

@end

@implementation UserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor blueColor];
    self.navigationItem.title=@"用户模块";
    NSLog(@"当前用户模块获得参数：%@",self.parameterDictionary);
    
    [self.view addSubview:self.returnButton];
    self.returnButton.frame=CGRectMake(10, 250, 250, 100);
    
    [self.view addSubview:self.shareButton];
    self.shareButton.frame=CGRectMake(10, 70, 200, 40);
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark 自定义代码

- (UIButton *)returnButton
{
    if (_returnButton == nil) {
        _returnButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_returnButton addTarget:self action:@selector(didTappedReturnButton:) forControlEvents:UIControlEventTouchUpInside];
        [_returnButton setTitle:@"返回并回调参数给上一个页面" forState:UIControlStateNormal];
        [_returnButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return _returnButton;
}

- (UIButton *)shareButton
{
    if (_shareButton == nil) {
        _shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_shareButton addTarget:self action:@selector(shareAction:) forControlEvents:UIControlEventTouchUpInside];
        [_shareButton setTitle:@"分享功能测试" forState:UIControlStateNormal];
        [_shareButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return _shareButton;
}

- (void)didTappedReturnButton:(UIButton *)button
{
    NSDictionary *dict =@{@"backName":@"jiaModuleUser"};
    //创建通知
    NSNotification *notification =[NSNotification notificationWithName:kUserViewControllerNotificationWithName object:nil userInfo:dict];
    //通过通知中心发送通知
    [[NSNotificationCenter defaultCenter] postNotification:notification];
    
    
    if (self.navigationController == nil) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)shareAction:(UIButton *)button
{
//    [JiaShareHelper shareTextDataWithPlatform:JiaSocialPlatformType_Sina withTextData:@"我是测试的内容" withCompletion:^(id result, NSError *error) {
//       if(error)
//       {
//           NSLog(@"分享出错了");
//       }
//    }];
    
    [JiaShareHelper shareUrlDataWithPlatform:JiaSocialPlatformType_WechatSession withShareUrl:@"http://www.sina.com.cn" withTitle:@"新浪" withDescr:@"新浪网页" withThumImage:@"http://dev.umeng.com/images/tab2_1.png" withCompletion:^(id result, NSError *error) {
        if(error)
        {
            NSLog(@"分享出错了");
        }
    }];
}
@end
