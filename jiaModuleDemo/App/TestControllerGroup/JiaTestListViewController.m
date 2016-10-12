//
//  JiaTestListViewController.m
//  jiaModuleDemo
//
//  Created by wujunyang on 16/10/10.
//  Copyright © 2016年 wujunyang. All rights reserved.
//

#import "JiaTestListViewController.h"

#import "JiaWebShareViewController.h"
#import "JiaLoginViewController.h"
#import "JiaSearchBarViewController.h"

#import "JiaShareMenuView.h"

@interface JiaTestListViewController()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic,strong) NSArray             *dataArray;
@property (nonatomic,strong) UITableView         *myTableView;
@end

@implementation JiaTestListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationItem.title=@"模块功能导航";
    
    if (!self.dataArray) {
        self.dataArray=@[@"WEB分享实例",@"第三方登录",@"弹出分享菜单",@"自定义SearchBar"];
    }
    
    //初始化表格
    if (!_myTableView) {
        _myTableView                                = [[UITableView alloc] initWithFrame:CGRectMake(0,0.5, Main_Screen_Width, Main_Screen_Height) style:UITableViewStylePlain];
        _myTableView.showsVerticalScrollIndicator   = NO;
        _myTableView.showsHorizontalScrollIndicator = NO;
        _myTableView.dataSource                     = self;
        _myTableView.delegate                       = self;
        [_myTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
        [self.view addSubview:_myTableView];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark UITableViewDataSource, UITableViewDelegate相关内容

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class]) forIndexPath:indexPath];
    cell.accessoryType    = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text   = self.dataArray[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.row) {
        case 0:
        {
            JiaWebShareViewController *vc=[[JiaWebShareViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
            case 1:
        {
            JiaLoginViewController *vc=[[JiaLoginViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 2:
        {
            NSArray *contentArray = @[@{@"name":@"新浪微博",@"icon":@"sns_icon_3"},
                                      @{@"name":@"QQ空间 ",@"icon":@"sns_icon_5"},
                                      @{@"name":@"QQ",@"icon":@"sns_icon_4"},
                                      @{@"name":@"微信",@"icon":@"sns_icon_7"},
                                      @{@"name":@"朋友圈",@"icon":@"sns_icon_8"},
                                      @{@"name":@"微信收藏",@"icon":@"sns_icon_9"}];
            JiaShareMenuView *shareView = [[JiaShareMenuView alloc] init];
            shareView.rowNumberItem=3;
            shareView.cancelButtonText=@"取消分享";
            [shareView addShareItems:self.view shareItems:contentArray selectShareItem:^(NSInteger tag, NSString *title) {
                NSLog(@"%ld --- %@", tag, title);
            }];
            break;
        }
        case 3:
        {
            JiaSearchBarViewController *vc=[[JiaSearchBarViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        default:
            break;
    }
}



@end
