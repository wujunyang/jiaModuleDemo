//
//  JiaPathchModel.h
//  jiaModuleDemo
//
//  Created by wujunyang on 16/9/26.
//  Copyright © 2016年 wujunyang. All rights reserved.
//

#import <Foundation/Foundation.h>

//补丁状态枚举
typedef enum : NSUInteger {
    JiaPatchModelStatusUnKnownError, //!< 未知错误.
    JiaPatchModelStatusUnInstall, //!< 尚未开始安装.应用初始时,所有本地补丁状态均为此;补丁更新或新增的补丁;在下载完成后,状态也会设置为此.
    JiaPatchModelStatusSuccess, //!< 安装成功.
    JiaPatchModelStatusFileNotExit, //!< 本地补丁文件不存在.
    JiaPatchModelStatusFileNotMatch, //!< 本地补丁MD5与给定的MD5值不匹配.
    JiaPatchModelStatusUpdate, //!< 此补丁有更新.即服务器最新返回的补丁列表中包含此补丁,但补丁的md5或url已改变.
    JiaPatchModelStatusAdd //!< 此补丁为新增的.即服务器最新返回的补丁列表中新添加的补丁.
} JiaPatchModelStatus;



@interface JiaPathchModel : NSObject

@property (copy, nonatomic) NSString * patchId; //补丁id.用于唯一标记一个补丁.因为补丁,后期可能需要更新,删除,添加等操作.
@property (copy, nonatomic) NSString * md5; //文件的md5值,用于校验.
@property (copy, nonatomic) NSString * url; //文件的URL路径.
@property (copy, nonatomic) NSString * ver; //补丁对应的APP版本.不需要服务器返回,但需要本地存储此值.这个值在涉及到多个版本的补丁共存时,在应用升级时会很有价值.
@property (assign, nonatomic) JiaPatchModelStatus status; //补丁状态.此状态值由本地管理和维护.

@end
