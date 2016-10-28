//
//  jiaBaseViewController.m
//  jiaModuleDemo
//
//  Created by wujunyang on 16/9/14.
//  Copyright © 2016年 wujunyang. All rights reserved.
//

#import "JiaBaseViewController.h"

@interface JiaBaseViewController()
{
    CGFloat navigationY;
    CGFloat navBarY;
    CGFloat verticalY;
    BOOL _isShowMenu;
}
@property CGFloat original_height;
@end

@implementation JiaBaseViewController

- (id)initWithRouterParams:(NSDictionary *)params {
    self = [super init];
    if (self) {
        _parameterDictionary=params;
        NSLog(@"当前参数：%@",params);
    }
    return self;
}


-(id)init
{
    if (self == [super init]) {
        [self.navigationController.navigationBar setTranslucent:NO];
        [self.navigationController setNavigationBarHidden:YES];
        navBarY = 0;
        navigationY = 0;
    }
    return self;
}


-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.extendedLayoutIncludesOpaqueBars=YES;
    [self.navigationController.navigationBar setTranslucent:NO];
    [self.navigationController setNavigationBarHidden:NO];
    
    if ([self respondsToSelector:@selector(backgroundImage)]) {
        UIImage *bgimage = [self navBackgroundImage];
        [self setNavigationBack:bgimage];
    }
    if ([self respondsToSelector:@selector(setTitle)]) {
        NSMutableAttributedString *titleAttri = [self setTitle];
        [self set_Title:titleAttri];
    }
    if (![self leftButton]) {
        [self configLeftBaritemWithImage];
    }
    
    if (![self rightButton]) {
        [self configRightBaritemWithImage];
    }
    
    //添加一个通知监听网络状态切换
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(networkChanged:)
                                                 name:kRealReachabilityChangedNotification
                                               object:nil];
    [GLobalRealReachability startNotifier];
    
    ReachabilityStatus status = [GLobalRealReachability currentReachabilityStatus];
    //当无网络时 每进一个页面都进行提示
    if (status == RealStatusNotReachable)
    {
        [MBProgressHUD showInfo:@"当前网络连接失败，请查看设置" ToView:self.view];
    }
}




-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if ([self respondsToSelector:@selector(set_colorBackground)]) {
        UIColor *backgroundColor =  [self set_colorBackground];
        UIImage *bgimage = [self imageWithColor:backgroundColor];
        
        [self.navigationController.navigationBar setBackgroundImage:bgimage forBarMetrics:UIBarMetricsDefault];
    }
    
    UIImageView* blackLineImageView = [self findHairlineImageViewUnder:self.navigationController.navigationBar];
    //默认显示黑线
    blackLineImageView.hidden = NO;
    if ([self respondsToSelector:@selector(hideNavigationBottomLine)]) {
        if ([self hideNavigationBottomLine]) {
            //隐藏黑线
            blackLineImageView.hidden = YES;
        }
    }
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

-(void)dealloc
{
    [GLobalRealReachability stopNotifier];
    //移除通知
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}


-(void)setNavigationBack:(UIImage*)image
{
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
    [self.navigationController.navigationBar setBackIndicatorTransitionMaskImage:image ];
    [self.navigationController.navigationBar setShadowImage:image];
}

#pragma mark --- NORMAl

-(void)set_Title:(NSMutableAttributedString *)title
{
    UILabel *navTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 120, 44)];
    navTitleLabel.numberOfLines=0;//可能出现多行的标题
    [navTitleLabel setAttributedText:title];
    navTitleLabel.textAlignment = NSTextAlignmentCenter;
    navTitleLabel.backgroundColor = [UIColor clearColor];
    navTitleLabel.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(titleClick:)];
    [navTitleLabel addGestureRecognizer:tap];
    self.navigationItem.titleView = navTitleLabel;
}


-(void)titleClick:(UIGestureRecognizer*)Tap
{
    UIView *view = Tap.view;
    if ([self respondsToSelector:@selector(title_click_event:)]) {
        [self title_click_event:view];
    }
}

#pragma mark -- left_item
-(void)configLeftBaritemWithImage
{
    if ([self respondsToSelector:@selector(set_leftBarButtonItemWithImage)]) {
        UIImage *image = [self set_leftBarButtonItemWithImage];
        UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithImage:image style:UIBarButtonItemStyleBordered target:self  action:@selector(left_click:)];
        self.navigationItem.backBarButtonItem = item;
    }
}

-(void)configRightBaritemWithImage
{
    if ([self respondsToSelector:@selector(set_rightBarButtonItemWithImage)]) {
        UIImage *image = [self set_rightBarButtonItemWithImage];
        UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithImage:image style:UIBarButtonItemStyleBordered target:self  action:@selector(right_click:)];
        self.navigationItem.rightBarButtonItem = item;
    }
}


#pragma mark -- left_button
-(BOOL)leftButton
{
    BOOL isleft =  [self respondsToSelector:@selector(set_leftButton)];
    if (isleft) {
        UIButton *leftbutton = [self set_leftButton];
        [leftbutton addTarget:self action:@selector(left_click:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:leftbutton];
        self.navigationItem.leftBarButtonItem = item;
    }
    return isleft;
}

#pragma mark -- right_button
-(BOOL)rightButton
{
    BOOL isright = [self respondsToSelector:@selector(set_rightButton)];
    if (isright) {
        UIButton *right_button = [self set_rightButton];
        [right_button addTarget:self action:@selector(right_click:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:right_button];
        self.navigationItem.rightBarButtonItem = item;
    }
    return isright;
}

#pragma mark 事件代码

-(void)left_click:(id)sender
{
    if ([self respondsToSelector:@selector(left_button_event:)]) {
        [self left_button_event:sender];
    }
}

-(void)right_click:(id)sender
{
    if ([self respondsToSelector:@selector(right_button_event:)]) {
        [self right_button_event:sender];
    }
}

-(void)changeNavigationBarHeight:(CGFloat)offset
{
    [UIView animateWithDuration:0.3f animations:^{
        self.navigationController.navigationBar.frame  = CGRectMake(
                                                                    self.navigationController.navigationBar.frame.origin.x,
                                                                    navigationY,
                                                                    self.navigationController.navigationBar.frame.size.width,
                                                                    offset
                                                                    );
    }];
    
}

-(void)changeNavigationBarTranslationY:(CGFloat)translationY
{
    self.navigationController.navigationBar.transform = CGAffineTransformMakeTranslation(0, translationY);
}

#pragma mark 自定义代码
//找查到Nav底部的黑线
- (UIImageView *)findHairlineImageViewUnder:(UIView *)view
{
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0)
    {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self findHairlineImageViewUnder:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}

-(UIImage *)imageWithColor : (UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

/**
 *  @author wujunyang, 16-09-19 16:09:24
 *
 *  @brief 监听网络变化
 *
 *  @param notification <#notification description#>
 */
- (void)networkChanged:(NSNotification *)notification
{
    RealReachability *reachability = (RealReachability *)notification.object;
    ReachabilityStatus status = [reachability currentReachabilityStatus];

    
    if (status == RealStatusNotReachable)
    {
        [MBProgressHUD showInfo:@"当前网络连接失败，请查看设置" ToView:self.view];
    }
    
    if (status == RealStatusViaWiFi)
    {
        [MBProgressHUD showInfo:@"当前网络为WIFI" ToView:self.view];
    }
    
    if (status == RealStatusViaWWAN)
    {
        
    }
    
    WWANAccessType accessType = [GLobalRealReachability currentWWANtype];
    
    if (status == RealStatusViaWWAN)
    {
        if (accessType == WWANType2G)
        {
            [MBProgressHUD showInfo:@"当前为2G网络" ToView:self.view];
        }
        else if (accessType == WWANType3G)
        {
            [MBProgressHUD showInfo:@"当前为3G网络" ToView:self.view];
        }
        else if (accessType == WWANType4G)
        {
            [MBProgressHUD showInfo:@"当前为4G网络" ToView:self.view];
        }
        else
        {
            
        }
    }
}

@end
