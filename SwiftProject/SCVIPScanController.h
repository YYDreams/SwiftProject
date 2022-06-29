//
//  SCVIPScanController.h
//  SamClub
//
//  Created by 李佳宏 on 2020/2/25.
//  Copyright © 2020 tencent. All rights reserved.
//

//#import "SCRootViewController.h"
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "SCQRCodeScanManager.h"
#import <AVFoundation/AVFoundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SCVIPScanController : UIViewController<SCQRCodeScanManagerDelegate>

@end

NS_ASSUME_NONNULL_END
