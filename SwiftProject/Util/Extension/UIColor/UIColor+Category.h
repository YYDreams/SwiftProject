//
//  UIColor+Category.h
//  GKXimalaya
//
//  Created by QuintGao on 2019/3/31.
//  Copyright © 2019 gaokun. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (Category)

/**
 获取图片的主色调（出现最多的颜色）

 @param image 原图
 @param scale 精准度（0~1）
 @return 主色调颜色
 */
+ (UIColor *)colorWithMostImage:(UIImage *)image scale:(CGFloat)scale;

@end

NS_ASSUME_NONNULL_END
