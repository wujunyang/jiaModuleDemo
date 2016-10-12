//
//  JiaShareMenuView.h
//  jiaModuleDemo 从底部弹出菜单视图
//
//  Created by wujunyang on 16/10/11.
//  Copyright © 2016年 wujunyang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^selectItemBlock)(NSInteger tag, NSString *title);

@interface JiaShareItemButton : UIButton

@end

@interface JiaShareMenuView : UIView

//一行有几个
@property(nonatomic)NSInteger rowNumberItem;

//菜单文字设置
@property(nonatomic,strong)UIFont *shareItemButtonFont;
@property(nonatomic,strong)UIColor *shareItemButtonColor;

//底部取消相关设置
@property(nonatomic,strong)UIColor *cancelBackgroundColor;
@property(nonatomic,copy)NSString *cancelButtonText;
@property(nonatomic,strong)UIFont *cancelButtonFont;
@property(nonatomic,strong)UIColor *cancelButtonColor;

/**
 *  弹出分享
 *
 *  @param superView       父视图
 *  @param shareItems      QQ/WeChat/Weibo
 *  @param selectShareItem 点击回调
 */
- (void)addShareItems:(UIView *)superView  shareItems:(NSArray *)shareItems selectShareItem:(selectItemBlock)selectShareItem;

@end
