//
//  JiaSearchBarViewController.m
//  jiaModuleDemo
//
//  Created by wujunyang on 16/10/11.
//  Copyright © 2016年 wujunyang. All rights reserved.
//

#import "JiaSearchBarViewController.h"

@interface JiaSearchBarViewController ()<JiaSearchBarDelegate>
@property(strong,nonatomic)JiaSearchBar *myJiaSearchBar;
@end

@implementation JiaSearchBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (!_myJiaSearchBar) {
        self.myJiaSearchBar = [[JiaSearchBar alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 44)];
        self.myJiaSearchBar.delegate=self;
        self.myJiaSearchBar.placeholder = @"请输入当前城市";
        self.myJiaSearchBar.placeholderColor = [UIColor purpleColor];
        
        self.myJiaSearchBar.backgroundColor = [UIColor yellowColor];
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 30)];
        view.backgroundColor = [UIColor redColor];
        self.myJiaSearchBar.keyboardType=UIKeyboardTypeDefault;
        //self.myJiaSearchBar.inputAccessoryView =view;
        [self.myJiaSearchBar.cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [self.view addSubview:self.myJiaSearchBar];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark JiaSearchBarDelegate

-(BOOL)searchBarShouldBeginEditing:(JiaSearchBar *)searchBar{
    NSLog(@"%s: Line-%d", __func__, __LINE__);
    return YES;
    
}
- (void)searchBarTextDidBeginEditing:(JiaSearchBar *)searchBar{
    NSLog(@"%s: Line-%d", __func__, __LINE__);
    
}
- (BOOL)searchBarShouldEndEditing:(JiaSearchBar *)searchBar{
    NSLog(@"%s: Line-%d", __func__, __LINE__);
    return YES;
}
- (void)searchBarTextDidEndEditing:(JiaSearchBar *)searchBar{
    NSLog(@"%s: Line-%d", __func__, __LINE__);
    
}
- (void)searchBar:(JiaSearchBar *)searchBar textDidChange:(NSString *)searchText{
    NSLog(@"%s: Line-%d", __func__, __LINE__);
    
}
- (BOOL)searchBar:(JiaSearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    NSLog(@"%s: Line-%d", __func__, __LINE__);
    return YES;
    
}
- (void)searchBarSearchButtonClicked:(JiaSearchBar *)searchBar{
    NSLog(@"输出的内容：%@",searchBar.text);
    NSLog(@"%s: Line-%d", __func__, __LINE__);
    
}
- (void)searchBarCancelButtonClicked:(JiaSearchBar *)searchBar{
    NSLog(@"%s: Line-%d", __func__, __LINE__);
    
}

@end
