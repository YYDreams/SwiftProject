//
//  UIButton+HZSpace.h
//  MainApp
//
//  Created by long on 3/1/16.
//  Copyright © 2016 hzins. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, XEImagePosition) {
    XEImagePositionLeft = 0,              //图片在左，文字在右，默认
    XEImagePositionRight = 1,             //图片在右，文字在左
    XEImagePositionTop = 2,               //图片在上，文字在下
    XEImagePositionBottom = 3,            //图片在下，文字在上
};

@interface UIButton (XESpace)

/**
 *  利用UIButton的titleEdgeInsets和imageEdgeInsets来实现文字和图片的自由排列
 *  注意：这个方法需要在设置图片和文字之后才可以调用，且button的大小要大于 图片大小+文字大小+spacing
 *
 *  @param spactin 图片和文字的间隔
 */
- (void)setImagePosition:(XEImagePosition)postion spacing:(CGFloat)spacing;
@end
