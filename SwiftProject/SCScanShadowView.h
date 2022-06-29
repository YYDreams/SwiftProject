//
//  SCScanShadowView.h
//  SamClub
//
//  Created by zoyagzhou on 2020/1/8.
//  Copyright © 2020 tencent. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SCScanShadowView : UIView

@property (nonatomic, assign) CGSize showSize;

@property (nonatomic, assign) BOOL isNewScan;

- (BOOL)isTimerAvailable;

- (void)startTimer;

- (void)stopTimer;

@end

NS_ASSUME_NONNULL_END
