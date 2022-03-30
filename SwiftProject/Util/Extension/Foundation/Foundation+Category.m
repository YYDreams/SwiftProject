//
//  Foundation+Category.m
//  SamClub
//
//  Created by flower on 2019/12/19.
//  Copyright © 2019 tencent. All rights reserved.
//

#import "Foundation+Category.h"


@implementation NSDictionary (Category)

// jsonString 转 NSDictionary
+ (NSDictionary *)convertJsonStringToNSDictionary:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
    if (error) {
        NSLog(@"jsonString解析失败:%@", error);
        return nil;
    }
    return json;
}

// 读取本地JSON文件
+ (NSDictionary *)readLocalFileWithName:(NSString *)name {
    
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"json"];
    
    return [NSJSONSerialization JSONObjectWithData:[[NSData alloc] initWithContentsOfFile:path] options:kNilOptions error:nil];
}

- (NSString *)descriptionWithLocale:(id)locale {

    NSString *string;
    
    @try {
        NSError *error;
        string = [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:&error] encoding:NSUTF8StringEncoding];
        
    } @catch (NSException *exception) {
        
        NSString *reason = [NSString stringWithFormat:@"reason:%@",exception.reason];
        string = [NSString stringWithFormat:@"转换失败:\n%@,\n转换终止,输出如下:\n%@",reason,self.description];
        
    } @finally {
        
    }
    
    return string;
}
@end

@implementation UIImage (Category)

+ (NSData *)compressQualityWithImageStr:(NSString *)imageStr {
   //小程序分享hdImageData： 限制大小不超过128KB
 NSInteger maxLength =  130048;
   CGFloat compression = 1;
    NSURL *url = [NSURL URLWithString:imageStr];
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
   NSData *data = UIImageJPEGRepresentation(image, compression);
   //NSLog(@"Before compressing quality, image size = %ld KB",data.length/1024);
   if (data.length < maxLength) return data;
   
   CGFloat max = 1;
   CGFloat min = 0;
   for (int i = 0; i < 6; ++i) {
       compression = (max + min) / 2;
       data = UIImageJPEGRepresentation(image, compression);
       NSLog(@"Compression = %.1f", compression);
       NSLog(@"In compressing quality loop, image size = %ld KB", data.length / 1024);
       if (data.length < maxLength * 0.9) {
           min = compression;
       } else if (data.length > maxLength) {
           max = compression;
       } else {
           break;
       }
   }
   NSLog(@"After compressing quality, image size = %ld KB", data.length / 1024);
   if (data.length < maxLength) return data;
   UIImage *resultImage = [UIImage imageWithData:data];
   // Compress by size
   NSUInteger lastDataLength = 0;
   while (data.length > maxLength && data.length != lastDataLength) {
       lastDataLength = data.length;
       CGFloat ratio = (CGFloat)maxLength / data.length;
       //NSLog(@"Ratio = %.1f", ratio);
       CGSize size = CGSizeMake((NSUInteger)(resultImage.size.width * sqrtf(ratio)),
                                (NSUInteger)(resultImage.size.height * sqrtf(ratio))); // Use NSUInteger to prevent white blank
       UIGraphicsBeginImageContext(size);
       [resultImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
       resultImage = UIGraphicsGetImageFromCurrentImageContext();
       UIGraphicsEndImageContext();
       data = UIImageJPEGRepresentation(resultImage, compression);
       NSLog(@"In compressing size loop, image size = %ld KB", data.length / 1024);
   }
   NSLog(@"After compressing size loop, image size = %ld KB", data.length / 1024);
   return data;
}

/**
 获取网络图片高度
 */
+ (CGSize)getImageSizeWithURL:(id)URL{
    NSURL * url = nil;
    if ([URL isKindOfClass:[NSURL class]]) {
        url = URL;
    }
    if ([URL isKindOfClass:[NSString class]]) {
        url = [NSURL URLWithString:URL];
    }
    if (!URL) {
        return CGSizeZero;
    }
    CGImageSourceRef imageSourceRef = CGImageSourceCreateWithURL((CFURLRef)url, NULL);
    CGFloat width = 0, height = 0;
    
    if (imageSourceRef) {
        
        // 获取图像属性
        CFDictionaryRef imageProperties = CGImageSourceCopyPropertiesAtIndex(imageSourceRef, 0, NULL);
        
        //以下是对手机32位、64位的处理
        if (imageProperties != NULL) {
            
            CFNumberRef widthNumberRef = CFDictionaryGetValue(imageProperties, kCGImagePropertyPixelWidth);
            
#if defined(__LP64__) && __LP64__
            if (widthNumberRef != NULL) {
                CFNumberGetValue(widthNumberRef, kCFNumberFloat64Type, &width);
            }
            
            CFNumberRef heightNumberRef = CFDictionaryGetValue(imageProperties, kCGImagePropertyPixelHeight);
            
            if (heightNumberRef != NULL) {
                CFNumberGetValue(heightNumberRef, kCFNumberFloat64Type, &height);
            }
#else
            if (widthNumberRef != NULL) {
                CFNumberGetValue(widthNumberRef, kCFNumberFloat32Type, &width);
            }
            
            CFNumberRef heightNumberRef = CFDictionaryGetValue(imageProperties, kCGImagePropertyPixelHeight);
            
            if (heightNumberRef != NULL) {
                CFNumberGetValue(heightNumberRef, kCFNumberFloat32Type, &height);
            }
#endif
            /***************** 此处解决返回图片宽高相反问题 *****************/
            // 图像旋转的方向属性
            NSInteger orientation = [(__bridge NSNumber *)CFDictionaryGetValue(imageProperties, kCGImagePropertyOrientation) integerValue];
            CGFloat temp = 0;
            switch (orientation) {  // 如果图像的方向不是正的，则宽高互换
                case UIImageOrientationLeft: // 向左逆时针旋转90度
                case UIImageOrientationRight: // 向右顺时针旋转90度
                case UIImageOrientationLeftMirrored: // 在水平翻转之后向左逆时针旋转90度
                case UIImageOrientationRightMirrored: { // 在水平翻转之后向右顺时针旋转90度
                    temp = width;
                    width = height;
                    height = temp;
                }
                    break;
                default:
                    break;
            }
            /***************** 此处解决返回图片宽高相反问题 *****************/
            
            CFRelease(imageProperties);
        }
        CFRelease(imageSourceRef);
    }
    return CGSizeMake(width, height);
    
}
@end
