//
//  Foundation+Category.h
//  SamClub
//
//  Created by flower on 2019/12/19.
//  Copyright © 2019 tencent. All rights reserved.
//

#import <Foundation/Foundation.h>
#import  <UIKit/UIKit.h>
#import <objc/message.h>

NS_ASSUME_NONNULL_BEGIN


@interface NSDictionary(Category)
// 读取本地JSON文件
+ (NSDictionary *)readLocalFileWithName:(NSString *)name;

// jsonString 转 NSDictionary
+ (NSDictionary *)convertJsonStringToNSDictionary:(NSString *)jsonString;
@end

@interface UIImage(Category)


+ (NSData *)compressQualityWithImageStr:(NSString *)imageStr;
/**
 获取网络图片高度
 */
+ (CGSize)getImageSizeWithURL:(id)URL;
@end



@interface UIViewController(NavigationBar)

/// 设置状态栏类型
@property (nonatomic, assign) UIStatusBarStyle      sp_statusBarStyle;

@end

NS_ASSUME_NONNULL_END
