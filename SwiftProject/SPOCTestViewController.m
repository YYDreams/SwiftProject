//
//  SPOCTestViewController.m
//  SwiftProject
//
//  Created by flowerflower on 2022/11/26.
//

#import "SPOCTestViewController.h"

@interface SPOCTestModel : NSObject

@property (nonatomic, assign) NSInteger index;

@end

@implementation SPOCTestModel
@end

@interface SPOCTestViewController ()

@end

@implementation SPOCTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSMutableArray *array = [NSMutableArray array];
    SPOCTestModel *model = [[SPOCTestModel alloc]init];
    model.index = 3;
    [array addObject:model];
    
    SPOCTestModel *model1 = [[SPOCTestModel alloc]init];
    model1.index = 1;
    [array addObject:model1];

    
    SPOCTestModel *model2 = [[SPOCTestModel alloc]init];
    model2.index = 2;
    [array addObject:model2];

    
   NSArray *arr1 =   [array sortedArrayUsingComparator:^NSComparisonResult(SPOCTestModel  *obj1, SPOCTestModel *obj2) {
       return [@(obj2.index) compare:@(obj1.index)];
    }];
    
    myUILabel *lable = [[myUILabel alloc]initWithFrame:CGRectMake(0, 100, 200, 50)];
    lable.text = @"电话费哈哈 122323000000";
    [lable sizeToFit];

    lable.verticalAlignment = VerticalAlignmentBottom;
    [self.view addSubview:lable];
    lable.backgroundColor = [UIColor redColor];
    NSLog(@"arr------OC%@",arr1);
    
}



@end
//
// myUILabel.m
//
//
// Created by yexiaozi_007 on 3/4/13.
// Copyright (c) 2013 yexiaozi_007. All rights reserved.
//
@implementation myUILabel
@synthesize verticalAlignment = verticalAlignment_;
  
- (id)initWithFrame:(CGRect)frame {
 if (self = [super initWithFrame:frame]) {
 self.verticalAlignment = VerticalAlignmentMiddle;
 }
 return self;
}
- (void)setVerticalAlignment:(VerticalAlignment)verticalAlignment {
 verticalAlignment_ = verticalAlignment;
 [self setNeedsDisplay];
}
- (CGRect)textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines {
 CGRect textRect = [super textRectForBounds:bounds limitedToNumberOfLines:numberOfLines];
 switch (self.verticalAlignment) {
 case VerticalAlignmentTop:
  textRect.origin.y = bounds.origin.y;
  break;
 case VerticalAlignmentBottom:
  textRect.origin.y = bounds.origin.y + bounds.size.height - textRect.size.height;
  break;
 case VerticalAlignmentMiddle:
  // Fall through.
 default:
  textRect.origin.y = bounds.origin.y + (bounds.size.height - textRect.size.height) / 2.0;
 }
 return textRect;
}
-(void)drawTextInRect:(CGRect)requestedRect {
 CGRect actualRect = [self textRectForBounds:requestedRect limitedToNumberOfLines:self.numberOfLines];
 [super drawTextInRect:actualRect];
}
@end
