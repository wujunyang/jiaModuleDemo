//
//  JiaWebShareHelper.h
//  jiaModuleDemo 用于H5页跟JS交互分享
//  sina（新浪微博）wechatsession（微信好友）wechattimeline（微信朋友圈）tencentwb（腾讯微博）qzone(QQ空间) qq（QQ）
//  JSExportAs可以传递多个参数  也可以不用但传多个参时可以用字典
//  Created by wujunyang on 16/10/9.
//  Copyright © 2016年 wujunyang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>


@protocol JiaWebShareHelperDelegate <JSExport>

/**
 纯文本分享

 @param platformType sina（新浪微博）wechatsession（微信好友）wechattimeline（微信朋友圈）tencentwb（腾讯微博）qzone(QQ空间) qq（QQ）
 @param text         <#text description#>
 */
JSExportAs(shareTextWithPlatform,-(void)shareTextWithPlatform:(NSString *)platformType withText:(NSString *)text);


/**
 URL分享

 @param platformType sina（新浪微博）wechatsession（微信好友）wechattimeline（微信朋友圈）tencentwb（腾讯微博）qzone(QQ空间) qq（QQ）
 @param shareUrl     <#shareUrl description#>
 @param title        <#title description#>
 @param descr        <#descr description#>
 @param thumImageUrl <#thumImageUrl description#>
 */
JSExportAs(shareUrlWithPlatformType,-(void)shareUrlWithPlatformType:(NSString *)platformType withShareUrl:(NSString *)shareUrl withTitle:(NSString *)title withDescr:(NSString *)descr withThumImageUrl:(NSString *)thumImageUrl);


/**
 图文分享

 @param platformType  sina（新浪微博）wechatsession（微信好友）wechattimeline（微信朋友圈）tencentwb（腾讯微博）qzone(QQ空间) qq（QQ）
 @param shareImageUrl <#shareImageUrl description#>
 @param title         <#title description#>
 @param descr         <#descr description#>
 @param thumImageUrl  <#thumImageUrl description#>
 */
JSExportAs(shareImageTextWithPlatform,- (void)shareImageTextWithPlatform:(NSString *)platformType withShareImageUrl:(NSString *)shareImageUrl withTitle:(NSString *)title withDescr:(NSString *)descr withThumImageUrl:(NSString *)thumImageUrl);

@end


@interface JiaWebShareHelper : NSObject<JiaWebShareHelperDelegate>
@property (nonatomic, weak) JSContext *jsContext;
@property (nonatomic, weak) UIWebView *webView;
@end
