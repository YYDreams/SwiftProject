//
//  SCScanViewController.m
//  SamClub
//
//  Created by zoyagzhou on 2020/1/8.
//  Copyright © 2020 tencent. All rights reserved.
//

#import "SCScanViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "SCScanShadowView.h"

#define SCREEN_BOUNDS [UIScreen mainScreen].bounds
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#define customShowSize CGSizeMake(250, 250);

@interface SCScanViewController ()<AVCaptureMetadataOutputObjectsDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

/** 输入数据源 */
@property (nonatomic, strong) AVCaptureDeviceInput *input;
/** 输出数据源 */
@property (nonatomic, strong) AVCaptureMetadataOutput *output;
/** 输入输出的中间桥梁 负责把捕获的音视频数据输出到输出设备中 */
@property (nonatomic, strong) AVCaptureSession *session;
/** 相机拍摄预览图层 */
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *layerView;
/** 预览图层尺寸 */
@property (nonatomic, assign) CGSize layerViewSize;
/** 有效扫码范围 */
@property (nonatomic, assign) CGSize showSize;

@property (nonatomic, strong) SCScanShadowView *shadowView;

@property (nonatomic, assign) BOOL firstLoad;

@property (nonatomic, assign) BOOL cameraOk;

@property (nonatomic, strong) UILabel *hintLabel;


@end

@implementation SCScanViewController

#pragma mark - life cycle
- (id)init
{
    self = [super init];
    if (self) {
        self.navigationItem.title = @"";
        self.firstLoad = YES;
        self.cameraOk = NO;
    }
    return self;
}

- (void)configBarButtons
{
//    self.backBtn.style = kSCNavBarButtonStyleBackSmall;
//    self.backBtn.mode = SCNavBarButtonModeDark;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    if (!self.handlerBlock)  {
//        @weakify(self);
        self.handlerBlock = ^(NSString *text, id<SCScanResultHandleContext> context) {
//            @strongify(self);
//            SCLogInfo(@"no handler block for scan result!");
            [self.navigationController popViewControllerAnimated:YES];
        };
    }

    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        NSString * mediaType = AVMediaTypeVideo;
        AVAuthorizationStatus  authorizationStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
        if (authorizationStatus == AVAuthorizationStatusRestricted
            || authorizationStatus == AVAuthorizationStatusDenied) {
            self.cameraOk = NO;
            self.view.backgroundColor = UIColor.blackColor;
//            @weakify(self);
//            [SCToastAlertView showTitle:SCLocalizedStringTable(@"Toast.scanTitle", @"Toast") content:SCLocalizedStringTable(@"Toast.scanContent", @"Toast") contentAlignment:1 buttonTitles:@[SCLocalizedStringTable(@"Toast.scanCancel", @"Toast"),SCLocalizedStringTable(@"Toast.scanSetting", @"Toast")] buttonClickedBlock:^(NSInteger index) {
//                @strongify(self);
//                if (index == 0) {
//                  [self.navigationController popViewControllerAnimated:YES];
//                }else{
//                    NSURL *url = [[NSURL alloc] initWithString:UIApplicationOpenSettingsURLString];
//                    if( [[UIApplication sharedApplication] canOpenURL:url]) {
//                        [[UIApplication sharedApplication] openURL:url];
//                    }
//                }
//            }];
        } else {
            ////这里是摄像头可以使用的处理逻辑
            self.cameraOk = YES;
        }
    } else {
        /// 硬件问题提示
        self.cameraOk = NO;
        
        UIAlertController * alertC = [UIAlertController alertControllerWithTitle:@"手机摄像头设备损坏" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:alertC animated:YES completion:nil];
        UIAlertAction * action =
        [UIAlertAction actionWithTitle:(@"alert.ButtonSure")
                                 style:UIAlertActionStyleCancel
                               handler:^(UIAlertAction *action) {
                                   [self.navigationController popViewControllerAnimated:YES];
                               }];
        [alertC addAction:action];
    }

    if (self.firstLoad && self.cameraOk) {
        //显示范围
        self.showSize = customShowSize;

        [self creatScanQR];

        //添加拍摄图层
        [self.view.layer addSublayer:self.layerView];

        //开始二维码
        [self.session startRunning];

        //设置可用扫码范围
        [self allowScanRect];

        if (!self.shadowView) {
            //添加上层阴影视图
//            self.shadowView = [[SCScanShadowView alloc] initWithFrame:CGRectMake(0,
//                                                                                 0,
//                                                                                 SCREEN_WIDTH,
//                                                                                 self.view.height)];
            self.shadowView.showSize = self.showSize;
            [self.view addSubview:self.shadowView];
            [self.shadowView startTimer];
        }

        self.hintLabel = [[UILabel alloc] init];
        self.hintLabel.font = [UIFont systemFontOfSize:16];
        self.hintLabel.textColor = UIColor.redColor;
//        [UIColor colorWithHex:0xFFFFFF];
        self.hintLabel.text = (@"scanf.Tips");
        self.hintLabel.textAlignment = NSTextAlignmentCenter;
        self.hintLabel.numberOfLines = 0;
        CGSize hintLabelSize =   [self.hintLabel.text sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]}];
        [self.view addSubview:self.hintLabel];
//
//        [self.hintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//
//            if (hintLabelSize.width > SCREEN_WIDTH - 24) {
//                make.left.mas_equalTo(12);
//                make.right.mas_equalTo(-12);
//            }else{
//                make.width.mas_equalTo(hintLabelSize.width + 32);
//            }
//            make.top.mas_equalTo((self.shadowView.height + self.showSize.height) / 2.0 + 18);
//            make.height.mas_equalTo(hintLabelSize.height + 20);
//            make.centerX.mas_equalTo(self.view);
//
//        }];
    }
    
//    self.showAudioPlayer = NO;
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];

//    self.shadowView = [[SCScanShadowView alloc] initWithFrame:CGRectMake(0,
//                                                                         self.contentInsets.top,
//                                                                         self.view.width,
//                                                                         self.view.height - self.contentInsets.top)];


}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.translucent = YES;

    if (!self.firstLoad && self.cameraOk) {
        //开始二维码
        [self.session startRunning];
        
        //设置可用扫码范围
        [self allowScanRect];
        
        if (!self.shadowView) {
            //添加上层阴影视图
            self.shadowView = [[SCScanShadowView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
            self.shadowView.showSize = self.showSize;
            [self.view addSubview:self.shadowView];
            [self.shadowView startTimer];
        }
    }
    self.firstLoad = NO;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.translucent = NO;
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
        
    if (self.cameraOk) {
        [self.shadowView stopTimer];
        self.shadowView = nil;
        
        //停止扫描
        [self.session stopRunning];
    }
}

#pragma mark - private method
- (void)creatScanQR
{
    /** 创建输入数据源 */
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];  //获取摄像设备
    self.input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];  //创建输出流
    
    /** 创建输出数据源 */
    self.output = [[AVCaptureMetadataOutput alloc] init];
    [self.output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];  //设置代理 在主线程里刷新
    
    /** Session设置 */
    self.session = [[AVCaptureSession alloc] init];
    [self.session setSessionPreset:AVCaptureSessionPresetHigh];   //高质量采集
    [self.session addInput:self.input];
    [self.session addOutput:self.output];
    //设置扫码支持的编码格式
    self.output.metadataObjectTypes = @[AVMetadataObjectTypeQRCode,
                                        AVMetadataObjectTypeEAN13Code,
                                        AVMetadataObjectTypeEAN8Code,
                                        AVMetadataObjectTypeCode128Code];
    /** 扫码视图 */
    //扫描框的位置和大小
    self.layerView = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
    self.layerView.videoGravity = AVLayerVideoGravityResizeAspectFill;
    self.layerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    // 将扫描框大小定义为属行, 下面会有调用
    self.layerViewSize = CGSizeMake(self.layerView.frame.size.width, self.layerView.frame.size.height);
}

/** 配置扫码范围 */
- (void)allowScanRect
{
    /** 扫描是默认是横屏, 原点在[右上角]
     *  rectOfInterest = CGRectMake(0, 0, 1, 1);
     *  AVCaptureSessionPresetHigh = 1920×1080   摄像头分辨率
     *  需要转换坐标 将屏幕与 分辨率统一
     */
    
    //剪切出需要的大小位置
    CGRect shearRect = CGRectMake((self.layerViewSize.width - self.showSize.width) / 2,
                                  (self.layerViewSize.height - self.showSize.height) / 2,
                                  self.showSize.height,
                                  self.showSize.height);
    
    
    CGFloat deviceProportion = 1920.0 / 1080.0;
    CGFloat screenProportion = self.layerViewSize.height / self.layerViewSize.width;
    
    //分辨率比> 屏幕比 ( 相当于屏幕的高不够)
    if (deviceProportion > screenProportion) {
        //换算出 分辨率比 对应的 屏幕高
        CGFloat finalHeight = self.layerViewSize.width * deviceProportion;
        // 得到 偏差值
        CGFloat addNum = (finalHeight - self.layerViewSize.height) / 2;
        
        // (对应的实际位置 + 偏差值)  /  换算后的屏幕高
        self.output.rectOfInterest = CGRectMake((shearRect.origin.y + addNum) / finalHeight,
                                                shearRect.origin.x / self.layerViewSize.width,
                                                shearRect.size.height/ finalHeight,
                                                shearRect.size.width/ self.layerViewSize.width);
        
    }
    else {
        
        CGFloat finalWidth = self.layerViewSize.height / deviceProportion;
        
        CGFloat addNum = (finalWidth - self.layerViewSize.width) / 2;
        
        self.output.rectOfInterest = CGRectMake(shearRect.origin.y / self.layerViewSize.height,
                                                (shearRect.origin.x + addNum) / finalWidth,
                                                shearRect.size.height / self.layerViewSize.height,
                                                shearRect.size.width / finalWidth);
    }
}

#pragma mark - AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput
didOutputMetadataObjects:(NSArray *)metadataObjects
       fromConnection:(AVCaptureConnection *)connection
{
    if (metadataObjects.count > 0)
    {
        [self.shadowView stopTimer];
        self.shadowView = nil;
        
        //停止扫描
        [self.session stopRunning];
        
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];

//        SCLogDebug(@"scan result: %@", metadataObject.stringValue);
        [self.navigationController popViewControllerAnimated:NO];
        
        if (self.handlerBlock) {
            self.handlerBlock(metadataObject.stringValue ?: @"", self);
        }

        
    }
}

#pragma mark - handle context

- (void)startLoading
{
//    [self showHudLoadingView];
}

- (void)stopLoading
{
//    [self hideHudLoadingView];
}

//- (UIViewController *)backToController
//{
////    return self.controllerToPopTo;
//}

- (void)popScanController:(BOOL)animated
{
    [self.navigationController popViewControllerAnimated:animated];
}

- (void)resumeScan
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)),
    dispatch_get_main_queue(),
    ^{
        if (self.cameraOk) {
            [self.session startRunning];

            [self allowScanRect];

            if (!self.shadowView) {
                self.shadowView = [[SCScanShadowView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
                self.shadowView.showSize = self.showSize;
                [self.view addSubview:self.shadowView];
                [self.shadowView startTimer];
            }
        }
    });
}

@end
