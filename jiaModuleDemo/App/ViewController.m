//
//  ViewController.m
//  jiaModuleDemo
//
//  Created by wujunyang on 16/9/13.
//  Copyright © 2016年 wujunyang. All rights reserved.
//

#import "ViewController.h"
#import "JiaTestListViewController.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic,strong)UITableView *myTableView;
@property(nonatomic,strong)NSArray *myDataList;
@end

@implementation ViewController

#pragma mark – Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor whiteColor];
    DDLogDebug(@"我是测试DDLOGDEBUG");
    [self layoutPageSubviews];
    
    //监听返回值通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userVCNotification:) name:kUserViewControllerNotificationWithName object:nil];
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

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Events

- (void)userVCNotification:(NSNotification *)dic{
    NSDictionary *infoDic=(NSDictionary *)dic.userInfo;
    NSLog(@"－－－－－接收到通知返回------");
    
    NSLog(@"内容为：%@",infoDic);
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"回调回来的参数" message:[NSString stringWithFormat:@"内容为：%@",infoDic] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
}


#pragma mark – Private Methods

- (void)layoutPageSubviews
{
    [self.view addSubview:self.myTableView];
}


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return self.myDataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class]) forIndexPath:indexPath];
    [self configureCell:cell forRowAtIndexPath:indexPath];
    return cell;
}

- (void)configureCell:(UITableViewCell *)cell
    forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.textLabel.text=self.myDataList[indexPath.row];
}

#pragma mark - UITableViewDelegate

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary *curParams=@{kDesignerModuleActionsDictionaryKeyName:@"wujunyang",kDesignerModuleActionsDictionaryKeyID:@"1001",kDesignerModuleActionsDictionaryKeyImage:@"designerImage"};
    switch (indexPath.row) {
        case 0:
        {
            UIViewController *viewController=[[JiaMediator sharedInstance]JiaMediator_Designer_viewControllerForDetail:curParams];
            [self presentViewController:viewController animated:YES completion:nil];
            break;
        }
        case 1:
        {
            UIViewController *viewController=[[JiaMediator sharedInstance]JiaMediator_Designer_viewControllerForDetail:curParams];
            [self.navigationController pushViewController:viewController animated:YES];
            break;
        }
        case 2:
        {
            NSString *curRoue=@"jiaScheme://Designer/nativeFetchDetailViewController?name=wujunyang&ID=1001&image=designerImage";
            UIViewController *viewController=[[JiaMediator sharedInstance]performActionWithUrl:[NSURL URLWithString:curRoue] completion:^(NSDictionary *info) {
                
            }];
            [self.navigationController pushViewController:viewController animated:YES];
            break;
        }
        case 3:
        {
            NSDictionary *userParaDictionary=@{kUserModuleActionsDictionaryKeyID:@"1"};
            UIViewController *viewController=[[JiaMediator sharedInstance] JiaMediator_User_viewControllerForDetail:userParaDictionary];
            [self.navigationController pushViewController:viewController animated:YES];
            break;
        }
            case 5:
        {
            JiaTestListViewController *vc=[[JiaTestListViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        default:
            break;
    }
}

#pragma mark - Custom Delegates

#pragma mark – Getters and Setters

-(UITableView *)myTableView
{
    if (_myTableView==nil) {
        _myTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _myTableView.backgroundColor = [UIColor clearColor];
        _myTableView.showsVerticalScrollIndicator = NO;
        _myTableView.showsHorizontalScrollIndicator=NO;
        _myTableView.dataSource = self;
        _myTableView.delegate = self;
        [_myTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
    }
    
    return _myTableView;
}


-(NSArray *)myDataList
{
    if (_myDataList==nil) {
        _myDataList=@[@"模态方式弹出设计模块",@"导栏方式跳转设计模块",@"路由方式跳转设计模块",@"跳转到用户模块并通知还回值",@"",@"功能模块的测试"];
    }
    return _myDataList;
}
@end
