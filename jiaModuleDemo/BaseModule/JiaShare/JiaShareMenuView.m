//
//  JiaShareMenuView.m
//  jiaModuleDemo
//
//  Created by wujunyang on 16/10/11.
//  Copyright © 2016年 wujunyang. All rights reserved.
//

#import "JiaShareMenuView.h"

#define kScreenWidth          [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight         [[UIScreen mainScreen] bounds].size.height

#define kBtnW 60
#define kBtnH 60
#define kMarginX 15
#define kMarginY 15
#define kFirst 10
#define kTitlePrecent 0.4
#define kImageViewWH 40
#define RGB(r, g, b)   [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]


@interface JiaShareItemButton()
@end
@implementation JiaShareItemButton
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:10];
        [self setTitleColor:RGB(40, 40, 40) forState:UIControlStateNormal];
        self.imageView.layer.cornerRadius = kImageViewWH * 0.5;
    }
    return self;
}
#pragma mark 调整文字的位置和尺寸
- (CGRect)titleRectForContentRect:(CGRect)contentRect{
    CGFloat titleW = self.frame.size.width;
    CGFloat titleH = self.frame.size.height * kTitlePrecent;
    CGFloat titleX = 2;
    CGFloat titleY = self.frame.size.height * (1 - kTitlePrecent) + 7;
    return CGRectMake(titleX, titleY, titleW, titleH);
}
#pragma mark 调整图片的位置和尺寸
- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    CGFloat imageW = kImageViewWH;
    CGFloat imageH = kImageViewWH;
    CGFloat imageX = (self.frame.size.width - kImageViewWH) * 0.5;
    CGFloat imageY = 2;
    return CGRectMake(imageX, imageY, imageW, imageH);
}
@end


@interface JiaShareMenuView()
@property (nonatomic, strong) NSArray *sharItems;
@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) UIButton *canleBtn;
@property (nonatomic, copy) void(^btnBlock)(NSInteger tag, NSString *title);
@end

@implementation JiaShareMenuView

- (void)addShareItems:(UIView *)superView  shareItems:(NSArray *)shareItems selectShareItem:(selectItemBlock)selectShareItem{
    if (shareItems == nil || shareItems.count < 1) return;
    self.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self addBackgroundView:superView];
    
    //相关属性值
    NSInteger curRowNumberItem=self.rowNumberItem?:4;
    NSString *cannelText=self.cancelButtonText?:@"取消";
    
    [shareItems enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *name = obj[@"name"];
        NSString *icon = obj[@"icon"];
        JiaShareItemButton *btn = [JiaShareItemButton buttonWithType:UIButtonTypeCustom];
        btn.titleLabel.font =self.shareItemButtonFont?:[UIFont systemFontOfSize:10];
        [btn setTitleColor:self.shareItemButtonColor?:RGB(40, 40, 40) forState:UIControlStateNormal];
        btn.tag = idx;
        [btn setTitle:name forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        CGFloat marginX = (self.frame.size.width - curRowNumberItem * kBtnW) / (curRowNumberItem + 1);
        NSInteger col = idx % curRowNumberItem;
        NSInteger row = idx / curRowNumberItem;
        CGFloat btnX = marginX + (marginX + kBtnW) * col;
        CGFloat btnY = kFirst + (kMarginY + kBtnH) * row;
        btn.frame = CGRectMake(btnX, btnY, kBtnW, kBtnH);
        [self addSubview:btn];
    }];
    
    //计算面板大小
    NSUInteger row = (shareItems.count - 1) / curRowNumberItem;
    CGFloat height = kFirst + 100 + (row +1) * (kBtnH + kMarginY);
    
    //分割线
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, (row +1)* (kBtnH + kMarginY)+5, kScreenWidth, 0.5)];
    line.backgroundColor = RGB(180, 180, 180);
    [self addSubview:line];
    
    //取消
    self.canleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.canleBtn.frame = CGRectMake(0, CGRectGetMaxY(line.frame), self.frame.size.width, 44);
    [self.canleBtn setTitle:cannelText forState:UIControlStateNormal];
    self.canleBtn.titleLabel.font =self.cancelButtonFont?:[UIFont systemFontOfSize:16];
    [self.canleBtn setBackgroundColor:self.cancelBackgroundColor?:[UIColor whiteColor]];
    [self.canleBtn setTitleColor:self.cancelButtonColor?:[UIColor grayColor] forState:UIControlStateNormal];
    [self.canleBtn addTarget:self action:@selector(cancleButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.canleBtn];
    
    self.btnBlock = ^(NSInteger tag, NSString *title){
        if(selectShareItem) selectShareItem(tag, title);
    };

    //增加
    [superView addSubview:self];

    CGFloat originY = [UIScreen mainScreen].bounds.size.height;
    self.frame = CGRectMake(0, originY, 0, height);
    [UIView animateWithDuration:0.25 animations:^{
        CGRect sF = self.frame;
        sF.origin.y = kScreenHeight - sF.size.height;
        self.frame = sF;
    }];
}
- (void)setFrame:(CGRect)frame{
    frame.size.width = kScreenWidth;
    if (frame.size.height <= 0) {
        frame.size.height = 0;
    }
    frame.origin.x = 0;
    [super setFrame:frame];
}
- (void)addBackgroundView:(UIView *)superView{
    _backgroundView = [[UIView alloc] initWithFrame:superView.bounds];
    _backgroundView.backgroundColor = [UIColor blackColor];
    _backgroundView.alpha = 0.4;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancleButtonAction)];
    [_backgroundView addGestureRecognizer:tap];
    [superView addSubview:_backgroundView];
}
- (void)cancleButtonAction{
    [_backgroundView removeFromSuperview];
    _backgroundView = nil;
    [UIView animateWithDuration:0.25 animations:^{
        CGRect sf = self.frame;
        sf.origin.y = kScreenHeight;
        self.frame = sf;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
- (void)btnClick:(UIButton *)sender{
    if(_btnBlock) _btnBlock(sender.tag, sender.titleLabel.text);
}
@end
