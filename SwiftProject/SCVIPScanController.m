//
//  SCVIPScanController.m
//  SamClub
//
//  Created by 李佳宏 on 2020/2/25.
//  Copyright © 2020 tencent. All rights reserved.
//

#import "SCVIPScanController.h"
#import "SCVIPScanView.h"
#import "SCQRCodeScanManager.h"

#define SCREEN_BOUNDS [UIScreen mainScreen].bounds
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface SCVIPScanController ()

@property (nonatomic, strong) SCQRCodeScanManager *manager;
@property (nonatomic, strong) SCVIPScanView *scanningView;
@property (nonatomic, strong) UILabel *promptLabel;
@property (nonatomic, assign) BOOL isSelectedFlashlightBtn;
@property (nonatomic, strong) UIButton * backButton;

@end

@implementation SCVIPScanController
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.modalPresentationStyle = UIModalPresentationOverFullScreen;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.scanningView addTimer];
    [_manager resetSampleBufferDelegate];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.scanningView removeTimer];
    [_manager cancelSampleBufferDelegate];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)dealloc {
    NSLog(@"WCQRCodeScanningVC - dealloc");
    [self removeScanningView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    
    [self.view addSubview:self.scanningView];
    [self setupNavigationBar];
    [self setupQRCodeScanning];
    [self.view addSubview:self.promptLabel];
    /// 为了 UI 效果
    [self.view addSubview:self.backButton];
}

- (void)setupNavigationBar {
    self.navigationItem.title = @"Membership";
}


- (void)removeScanningView {
    [self.scanningView removeTimer];
    [self.scanningView removeFromSuperview];
    self.scanningView = nil;
}

- (void)setupQRCodeScanning {
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType: AVMediaTypeVideo];
    //读取设备授权状态
    if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied){
        return;
    }
    self.manager = [SCQRCodeScanManager sharedManager];
    NSArray *arr = @[AVMetadataObjectTypeQRCode,//二维码
                     //以下为条形码，如果项目只需要扫描二维码，下面都不要写
                     AVMetadataObjectTypeEAN13Code,
                     AVMetadataObjectTypeEAN8Code,
                     AVMetadataObjectTypeUPCECode,
                     AVMetadataObjectTypeCode39Code,
                     AVMetadataObjectTypeCode39Mod43Code,
                     AVMetadataObjectTypeCode93Code,
                     AVMetadataObjectTypeCode128Code,];
//     AVCaptureSessionPreset1920x1080 推荐使用，对于小型的二维码读取率较高
    [_manager setupSessionPreset:AVCaptureSessionPreset1920x1080 metadataObjectTypes:arr currentController:self];
    _manager.delegate = self;
}

- (void)backButtonPressed:(UIButton * )sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - - - SGQRCodeScanManagerDelegate
- (void)QRCodeScanManager:(SCQRCodeScanManager *)scanManager didOutputMetadataObjects:(NSArray *)metadataObjects {
    NSLog(@"metadataObjects - - %@", metadataObjects);
    if (metadataObjects != nil && metadataObjects.count > 0) {
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects firstObject];
        NSString * resultStr = metadataObject.stringValue;
        NSLog(@"resultStrresultStr-----",resultStr);
        
//        NSString * filterNumberStr = [NSString filterNumber:resultStr];
//        if (resultStr.length == 17 && resultStr.length == filterNumberStr.length) {
//            void(^scanCompletion)(NSString * resultStr) = [self.info objectForKey:@"completion"];
//            if (scanCompletion) {
//                scanCompletion(resultStr);
//            }
            [self dismissViewControllerAnimated:YES completion:nil];
//        }else{
////            [self showHudWithText:SCLocalizedStringTable(@"Membership.ScanningErrorTips", @"Membership")];
//        }
    } else {
        NSLog(@"暂未识别出扫描的二维码");
    }
}

- (UILabel *)promptLabel {
    if (!_promptLabel) {
        _promptLabel = [[UILabel alloc] init];
        _promptLabel.backgroundColor = [UIColor clearColor];
        _promptLabel.numberOfLines = 0;
        CGFloat promptLabelW = 195.f;
        CGFloat promptLabelH = 38.f;
        CGFloat promptLabelX = (SCREEN_WIDTH - promptLabelW) / 2;
        CGFloat promptLabelY = 0.62 * SCREEN_HEIGHT + 64;
        _promptLabel.frame = CGRectMake(promptLabelX, promptLabelY, promptLabelW, promptLabelH);
        _promptLabel.textAlignment = NSTextAlignmentCenter;
        _promptLabel.font = [UIFont boldSystemFontOfSize:16.f];
        _promptLabel.textColor = UIColor.redColor;
//        [UIColor colorWithHex:0xFFFFFF];
        _promptLabel.text = @"Membership";
    }
    return _promptLabel;
}



- (UIButton *)backButton{
    if (!_backButton) {
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backButton setImage:[UIImage imageNamed:@"icon／返回"] forState:UIControlStateNormal];
        _backButton.frame = CGRectMake(24.f, 49.f, 32.f, 32.f);
        [_backButton addTarget:self action:@selector(backButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backButton;
}


- (SCVIPScanView *)scanningView {
    if (!_scanningView) {
        _scanningView = [[SCVIPScanView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _scanningView.cornerColor = [UIColor colorWithRed:29.f/255.f green:149.f/255.f blue:252.f/255.f alpha:1.f];
    }
    return _scanningView;
}
@end
