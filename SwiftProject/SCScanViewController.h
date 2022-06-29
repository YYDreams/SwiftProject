//
//  SCScanViewController.h
//  SamClub
//
//  Created by zoyagzhou on 2020/1/8.
//  Copyright © 2020 tencent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol SCScanResultHandleContext <NSObject>

- (void)startLoading;
- (void)stopLoading;

- (UIViewController *)backToController;

- (void)popScanController:(BOOL)animated;

- (void)resumeScan;

@end

@interface SCScanViewController : UIViewController

@property (nonatomic, copy) void(^handlerBlock)(NSString *text, id<SCScanResultHandleContext> context);

@end

NS_ASSUME_NONNULL_END
