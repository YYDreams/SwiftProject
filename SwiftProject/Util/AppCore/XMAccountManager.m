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
    onceToken = 0; //只有置成0,GCD才会认为它从未执行过.这样才能保证下次再次调用shareInstance的时候,再次创建对象.
}
@end
