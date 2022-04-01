//
//  XMAccountManager.h
//  SwiftProject
//
//  Created by flowerflower on 2022/3/31.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XMAccountManager : NSObject

@property (copy, nonatomic) NSString *phone;

+ (instancetype)shareInstance;

- (void)clear;

@end

NS_ASSUME_NONNULL_END
