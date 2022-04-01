//
//  XMAccountManager.m
//  SwiftProject
//
//  Created by flowerflower on 2022/3/31.
//

#import "XMAccountManager.h"

@implementation XMAccountManager

static XMAccountManager *sharedInstance;
static dispatch_once_t   onceToken;
+ (instancetype)shareInstance{
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc]init];
    });
    return  sharedInstance;
}

- (void)clear{
    onceToken = 0;
}
@end
