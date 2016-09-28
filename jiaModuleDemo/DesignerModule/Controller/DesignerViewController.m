//
//  DesignerViewController.m
//  jiaModuleDemo
//
//  Created by wujunyang on 16/9/13.
//  Copyright © 2016年 wujunyang. All rights reserved.
//

#import "DesignerViewController.h"

#import "DesignerServiceApi.h"

@interface DesignerViewController()

@property (nonatomic, strong) UIButton *returnButton;
@property(nonatomic,strong)UILabel *myDesignerLabel;
@property(nonatomic,strong)UILabel *myDesignIDLabel;
@property(nonatomic,strong)UIImageView *myDesignImageView;
@end


@implementation DesignerViewController

#pragma mark – Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor blueColor];
    [self layoutPageSubviews];
    self.navigationItem.title=@"设计师模块";
    NSLog(@"当前参数：%@",self.parameterDictionary);
    
    NSLog(@"%@",[self getMessage]);
    NSLog(@"%@",[self getOtherMessage]);
    
    //测试网络请求
    DesignerServiceApi *serverApi=[[DesignerServiceApi alloc]init];
    [serverApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSLog(@"成功");
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSLog(@"失败");
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:[self getMessage] delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
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


#pragma mark - Events

- (void)didTappedReturnButton:(UIButton *)button
{
    if (self.navigationController == nil) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}


#pragma mark – Private Methods

- (void)layoutPageSubviews
{
    [self.view addSubview:self.myDesignerLabel];
    [self.view addSubview:self.myDesignIDLabel];
    [self.view addSubview:self.myDesignImageView];
    [self.view addSubview:self.returnButton];
    self.myDesignIDLabel.frame=CGRectMake(10, 140, 200, 50);
    self.myDesignerLabel.frame=CGRectMake(10, 200, 200, 50);
    self.myDesignImageView.frame=CGRectMake(150, 70, 50, 50);
    self.returnButton.frame=CGRectMake(10, 250, 50, 50);
}

#pragma mark - UITextFieldDelegate

#pragma mark - UITableViewDataSource

#pragma mark - UITableViewDelegate

#pragma mark - Custom Delegates

#pragma mark – Getters and Setters

-(UILabel *)myDesignerLabel
{
    if (_myDesignerLabel==nil) {
        _myDesignerLabel=[[UILabel alloc]init];
        _myDesignerLabel.font=[UIFont systemFontOfSize:13];
        _myDesignerLabel.textColor=[UIColor redColor];
        _myDesignerLabel.text=self.parameterDictionary[kDesignerModuleActionsDictionaryKeyName];
    }
    return _myDesignerLabel;
}

-(UILabel *)myDesignIDLabel
{
    if (_myDesignIDLabel==nil) {
        _myDesignIDLabel=[[UILabel alloc]init];
        _myDesignIDLabel.font=[UIFont systemFontOfSize:14];
        _myDesignIDLabel.textColor=[UIColor whiteColor];
        _myDesignIDLabel.text=self.parameterDictionary[kDesignerModuleActionsDictionaryKeyID];
    }
    
    return _myDesignIDLabel;
}

-(UIImageView *)myDesignImageView
{
    if (_myDesignImageView==nil) {
        _myDesignImageView=[[UIImageView alloc]init];
        _myDesignImageView.image=[UIImage imageNamed:self.parameterDictionary[kDesignerModuleActionsDictionaryKeyImage]];
    }
    
    return _myDesignImageView;
}

- (UIButton *)returnButton
{
    if (_returnButton == nil) {
        _returnButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_returnButton addTarget:self action:@selector(didTappedReturnButton:) forControlEvents:UIControlEventTouchUpInside];
        [_returnButton setTitle:@"返回" forState:UIControlStateNormal];
        [_returnButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return _returnButton;
}


-(NSString *)getMessage
{
    return @"我是原来的内容";
}

-(NSString *)getOtherMessage
{
    return @"我是getOtherMessage的内容";
}

@end
