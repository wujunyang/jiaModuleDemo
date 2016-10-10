//
//  UMSocialMessageObject.h
//  SocialSDK
//
//  Created by umeng on 16/4/22.
//  Copyright © 2016年 dongjianxiong. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface UMSocialMessageObject : NSObject


/**
 * @param text 文本内容
 * @note 非纯文本分享文本
 */
@property (nonatomic, copy) NSString  *text;

/**
 * 分享的所媒体内容对象
 */
@property (nonatomic, strong) id shareObject;

+ (UMSocialMessageObject *)messageObject;

+ (UMSocialMessageObject *)messageObjectWithMediaObject:(id)mediaObject;


@end


@interface UMShareObject : NSObject

/**
 * 标题
 * @note 标题的长度依各个平台的要求而定
 */
@property (nonatomic, copy) NSString *title;

/**
 * 描述
 * @note 描述内容的长度依各个平台的要求而定
 */
@property (nonatomic, copy) NSString *descr;

/**
 * 缩略图 UIImage或者NSData类型或者NSString类型（图片url）
 */
@property (nonatomic, strong) id thumbImage;

///**
// * 缩略图url（优先判断thumbImage， thumbImage为空才使用thumImageUrl）
// */
//@property (nonatomic, copy) NSString *thumImageUrl;

/**
 * @param title 标题
 * @param descr 描述
 * @param thumImage 缩略图（UIImage或者NSData类型，或者image_url）
 *
 */
+ (id)shareObjectWithTitle:(NSString *)title
                     descr:(NSString *)descr
                 thumImage:(id)thumImage;
//- (NSData*)getImageData;
+ (void)um_imageDataWithImage:(id)image completion:(void (^)(NSData *image))completion;
@end

@interface UMShareTextObject : UMShareObject


+ (UMShareTextObject *)shareObjectWithContent:(NSString *)shareText;

/** 分享内容
 *@param shareText 分享的文本
 */
@property (nonatomic, copy) NSString  *shareText;

@end


@interface UMShareImageObject : UMShareObject

/** 图片内容 （可以是UIImage类对象，也可以是NSdata类对象，也可以是图片链接imageUrl NSString类对象）
 * @note 图片大小根据各个平台限制而定
 */
@property (nonatomic, retain) id shareImage;

@end


@interface UMShareMusicObject : UMShareObject

/** 音乐网页的url地址
 * @note 长度不能超过10K
 */
@property (nonatomic, retain) NSString *musicUrl;
/** 音乐lowband网页的url地址
 * @note 长度不能超过10K
 */
@property (nonatomic, retain) NSString *musicLowBandUrl;
/** 音乐数据url地址
 * @note 长度不能超过10K
 */
@property (nonatomic, retain) NSString *musicDataUrl;

/**音乐lowband数据url地址
 * @note 长度不能超过10K
 */
@property (nonatomic, retain) NSString *musicLowBandDataUrl;

@end


@interface UMShareVideoObject : UMShareObject

/**
 视频网页的url
 
 @warning 不能为空且长度不能超过255
 */
@property (nonatomic, strong) NSString *videoUrl;

/**
 视频lowband网页的url
 
 @warning 长度不能超过255
 */
@property (nonatomic, strong) NSString *videoLowBandUrl;

/**
 视频数据流url
 
 @warning 长度不能超过255
 */
@property (nonatomic, strong) NSString *videoStreamUrl;

/**
 视频lowband数据流url
 
 @warning 长度不能超过255
 */
@property (nonatomic, strong) NSString *videoLowBandStreamUrl;

@end


@interface UMShareWebpageObject : UMShareObject

/** 网页的url地址
 * @note 不能为空且长度不能超过10K
 */
@property (nonatomic, retain) NSString *webpageUrl;

@end


/**
 *  表情的类
 *  表请的缩略图数据请存放在LWApiImageObject中
 *  注意：emotionData和emotionURL成员不能同时为空,若同时出现则取emotionURL
 */
@interface UMShareEmotionObject : UMShareObject

/**
 *  表情数据，如GIF等
 * @note 微信的话大小不能超过10M
 */
@property (nonatomic, strong) NSData *emotionData;

/**
 *  表情链接地址
 */
@property (nonatomic, strong) NSString *emotionURL;

@end


#pragma mark - UMSAppExtendObject
/*! @brief 多媒体消息中包含的App扩展数据对象
 *
 * 第三方程序向微信终端发送包含WXAppExtendObject的多媒体消息，
 * 微信需要处理该消息时，会调用该第三方程序来处理多媒体消息内容。
 * @note url，extInfo和fileData不能同时为空
 * @see WXMediaMessage
 */
@interface UMShareExtendObject : UMShareObject
/*! @brief 返回一个WXAppExtendObject对象
 *
 * @note 返回的WXAppExtendObject对象是自动释放的
 */
+(UMShareExtendObject *) object;

/** 若第三方程序不存在，微信终端会打开该url所指的App下载地址
 * @note 长度不能超过10K
 */
@property (nonatomic, retain) NSString *url;
/** 第三方程序自定义简单数据，微信终端会回传给第三方程序处理
 * @note 长度不能超过2K
 */
@property (nonatomic, retain) NSString *extInfo;
/** App文件数据，该数据发送给微信好友，微信好友需要点击后下载数据，微信终端会回传给第三方程序处理
 * @note 大小不能超过10M
 */
@property (nonatomic, retain) NSData   *fileData;

@end


#pragma mark - UMFileObject
/*! @brief 多媒体消息中包含的文件数据对象
 *
 * @see WXMediaMessage
 */
@interface UMShareFileObject : UMShareObject

/*! @brief 返回一个WXFileObject对象
 *
 * @note 返回的WXFileObject对象是自动释放的
 */
+(UMShareFileObject *) object;

/** 文件后缀名
 * @note 长度不超过64字节
 */
@property (nonatomic, retain) NSString  *fileExtension;

/** 文件真实数据内容
 * @note 大小不能超过10M
 */
@property (nonatomic, retain) NSData    *fileData;

@end

/*! @brief 分享消息中的邮件分享对象
 *
 * @see UMSocialMessageObject
 */
@interface UMShareEmailObject : UMShareObject

/**
 * 接收人
 */
@property (nonatomic, strong) NSArray *toRecipients;

/**
 * 抄送人
 */
@property (nonatomic, strong) NSArray *ccRecipients;

/**
 * 密送人
 */
@property (nonatomic, strong) NSArray *bccRecipients;

/**
 * 文本内容
 */
@property (nonatomic, copy) NSString *emailContent;

/**
 * 图片
 */
@property (nonatomic, strong) id emailImage;

/**
 * 文件（NSData）
 */
@property (nonatomic, strong) NSData *emailSendData;

/**
 * 文件格式
 */
@property (nonatomic, copy) NSString *fileType;

/**
 * 文件名
 */
@property (nonatomic, copy) NSString *fileName;

@end


/*! @brief 分享消息中的短信分享对象
 *
 * @see UMSocialMessageObject
 */
@interface UMShareSmsObject : UMShareObject

/**
 * 接收人
 */
@property (nonatomic, strong) NSArray *recipients;

/**
 * 文本内容
 */
@property (nonatomic, copy) NSString *smsContent;

/**
 * 图片
 */
@property (nonatomic, strong) id smsImage;

/**
 * 文件数据（NSData）
 */
@property (nonatomic, strong) NSData *smsSendData;

/**
 * 文件格式
 */
@property (nonatomic, copy) NSString *fileType;

/**
 * 文件名称
 */
@property (nonatomic, copy) NSString *fileName;

/**
 * 文件地址url
 */
@property (nonatomic, copy) NSString *fileUrl;

@end
