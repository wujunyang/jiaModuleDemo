//
//  UserViewController.m
//  jiaModuleDemo
//
//  Created by wujunyang on 16/9/13.
//  Copyright © 2016年 wujunyang. All rights reserved.
//

#import "UserViewController.h"

@interface UserViewController()

@property (nonatomic, strong) UIButton *returnButton;
@end

@implementation UserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor blueColor];
    self.navigationItem.title=@"用户模块";
    NSLog(@"当前用户模块获得参数：%@",self.parameterDictionary);
    
    [self.view addSubview:self.returnButton];
    self.returnButton.frame=CGRectMake(10, 250, 250, 100);
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
@end
