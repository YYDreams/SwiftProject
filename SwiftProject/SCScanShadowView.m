//
//  SCScanShadowView.m
//  SamClub
//
//  Created by zoyagzhou on 2020/1/8.
//  Copyright © 2020 tencent. All rights reserved.
//

#import "SCScanShadowView.h"

@interface SCScanShadowView ()

@property (nonatomic, strong) UIImageView *lineView;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation SCScanShadowView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        self.lineView = [[UIImageView alloc] init];
        self.lineView.image = [UIImage imageNamed:@"Frame 774034"];
        [self addSubview:self.lineView];
//        self.lineView.layer.borderColor = [UIColor colorWithHex:0x0165B8].CGColor;
//        self.lineView.layer.borderWidth = 1;
    }
    return self;
}

- (void)playAnimation
{
    [UIView animateWithDuration:2.4 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        
        if (self.isNewScan) {
            self.lineView .frame = CGRectMake((self.frame.size.width - self.showSize.width) / 2,
                                              103 + self.showSize.height,
                                              self.showSize.width,
                                              2);
        }else {
            self.lineView .frame = CGRectMake((self.frame.size.width - self.showSize.width) / 2,
                                              (self.frame.size.height + self.showSize.height) / 2,
                                              self.showSize.width,
                                              2);
        }
        
    } completion:^(BOOL finished) {
        
        if (self.isNewScan) {
            self.lineView .frame = CGRectMake((self.frame.size.width - self.showSize.width) / 2,
                                              103,
                                              self.showSize.width, 2);
        }else {
            self.lineView .frame = CGRectMake((self.frame.size.width - self.showSize.width) / 2,
                                              (self.frame.size.height - self.showSize.height) /2,
                                              self.showSize.width, 2);
        }
        
        
    }];
}

- (void)startTimer
{
//    self.lineView .frame = CGRectMake((self.frame.size.width - self.showSize.width) / 2,
//                                      (self.frame.size.height - self.showSize.height) / 2,
//                                      self.showSize.width, 2);
    
    if (self.isNewScan) {
        self.lineView .frame = CGRectMake((self.frame.size.width - self.showSize.width) / 2,
                                          103 + self.showSize.height,
                                          self.showSize.width,
                                          2);
    }else {
        self.lineView .frame = CGRectMake((self.frame.size.width - self.showSize.width) / 2,
                                          (self.frame.size.height + self.showSize.height) / 2,
                                          self.showSize.width,
                                          2);
    }

    if (!_timer) {

        [self playAnimation];
        /* 自动播放 */
        self.timer = [NSTimer scheduledTimerWithTimeInterval:2.5 target:self selector:@selector(playAnimation) userInfo:nil repeats:YES];
    }
}

- (void)stopTimer
{
    [_timer invalidate];
    _timer = nil;
}

- (BOOL)isTimerAvailable
{
    if (_timer) {
        return YES;
    }
    return NO;
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 整体颜色
    CGContextSetRGBFillColor(ctx, 0.15, 0.15, 0.15, 0.6);
    CGContextFillRect(ctx, rect);   //draw the transparent layer
    
    //中间清空矩形框
    CGRect clearDrawRect = CGRectMake((rect.size.width - self.showSize.width) / 2, (rect.size.height - self.showSize.height) / 2, self.showSize.width, self.showSize.height);
    if (self.isNewScan) {
        clearDrawRect = CGRectMake((rect.size.width - self.showSize.width) / 2, 103, self.showSize.width, self.showSize.height);
    }
    
    CGContextClearRect(ctx, clearDrawRect);
    
    //边框
    CGContextStrokeRect(ctx, clearDrawRect);
    CGContextSetRGBStrokeColor(ctx, 1, 1, 1, 1);  //颜色
    CGContextSetLineWidth(ctx, 0.5);             //线宽
    CGContextAddRect(ctx, clearDrawRect);       //矩形
    CGContextStrokePath(ctx);
    
    [self addCornerLineWithContext:ctx rect:clearDrawRect];
}

- (void)addCornerLineWithContext:(CGContextRef)ctx rect:(CGRect)rect
{
    float cornerWidth = 4.0;
    
    float cornerLong = 16.0;
    
    //画四个边角 线宽
    CGContextSetLineWidth(ctx, cornerWidth);
    
    //颜色
    UIColor *color = UIColor.redColor;
    const CGFloat *components = CGColorGetComponents(color.CGColor);
    
    CGContextSetRGBStrokeColor(ctx, components[0], components[1], components[2], 1);
    
    //左上角
    CGPoint poinsTopLeftA[] = {CGPointMake(rect.origin.x + cornerWidth/2, rect.origin.y),
        CGPointMake(rect.origin.x + cornerWidth/2, rect.origin.y + cornerLong)};
    
    CGPoint poinsTopLeftB[] = {CGPointMake(rect.origin.x, rect.origin.y + cornerWidth/2),
        CGPointMake(rect.origin.x + cornerLong, rect.origin.y + cornerWidth/2)};
    
    [self addLine:poinsTopLeftA pointB:poinsTopLeftB ctx:ctx];
    
    //左下角
    CGPoint poinsBottomLeftA[] = {CGPointMake(rect.origin.x + cornerWidth/2, rect.origin.y + rect.size.height - cornerLong),
        CGPointMake(rect.origin.x + cornerWidth/2, rect.origin.y + rect.size.height)};
    
    CGPoint poinsBottomLeftB[] = {CGPointMake(rect.origin.x, rect.origin.y + rect.size.height - cornerWidth/2),
        CGPointMake(rect.origin.x + cornerLong, rect.origin.y + rect.size.height - cornerWidth/2)};
    
    [self addLine:poinsBottomLeftA pointB:poinsBottomLeftB ctx:ctx];
    
    //右上角
    CGPoint poinsTopRightA[] = {CGPointMake(rect.origin.x+ rect.size.width - cornerLong, rect.origin.y + cornerWidth/2),
        CGPointMake(rect.origin.x + rect.size.width, rect.origin.y + cornerWidth/2 )};
    
    CGPoint poinsTopRightB[] = {CGPointMake(rect.origin.x+ rect.size.width - cornerWidth/2, rect.origin.y),
        CGPointMake(rect.origin.x + rect.size.width- cornerWidth/2, rect.origin.y + cornerLong)};
    
    [self addLine:poinsTopRightA pointB:poinsTopRightB ctx:ctx];
    
    //右下角
    CGPoint poinsBottomRightA[] = {CGPointMake(rect.origin.x+ rect.size.width - cornerWidth/2, rect.origin.y+rect.size.height - cornerLong),
        CGPointMake(rect.origin.x- cornerWidth/2 + rect.size.width, rect.origin.y +rect.size.height )};
    
    CGPoint poinsBottomRightB[] = {CGPointMake(rect.origin.x+ rect.size.width - cornerLong, rect.origin.y + rect.size.height - cornerWidth/2),
        CGPointMake(rect.origin.x + rect.size.width, rect.origin.y + rect.size.height - cornerWidth/2 )};
    
    [self addLine:poinsBottomRightA pointB:poinsBottomRightB ctx:ctx];
    
    CGContextStrokePath(ctx);
}

- (void)addLine:(CGPoint[])pointA pointB:(CGPoint[])pointB ctx:(CGContextRef)ctx
{
    CGContextAddLines(ctx, pointA, 2);
    CGContextAddLines(ctx, pointB, 2);
}

@end
