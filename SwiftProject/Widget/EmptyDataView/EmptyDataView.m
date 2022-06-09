//
//  EmptyDataView.m
//  SwiftProject
//
//  Created by flower on 2022/5/28.
//

#import "EmptyDataView.h"
#import <objc/runtime.h>
@interface EmptyDataView()

@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *detailLabel;
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) UITapGestureRecognizer *tapGesture;

@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, weak) UIView *customView;

@end
@implementation EmptyDataView

- (instancetype)init{
    self =  [super init];
    if (self) {
        [self addSubview:self.contentView];
    }
    return self;
}
#pragma mark - Getters

- (UIView *)contentView{
    if (!_contentView){
        _contentView = [UIView new];
        _contentView.translatesAutoresizingMaskIntoConstraints = NO;
        _contentView.backgroundColor = [UIColor clearColor];
        _contentView.userInteractionEnabled = YES;
        _contentView.alpha = 0;
    }
    return _contentView;
}

- (UIImageView *)imageView{
    if (!_imageView){
        _imageView = [UIImageView new];
        _imageView.translatesAutoresizingMaskIntoConstraints = NO;
        _imageView.backgroundColor = [UIColor clearColor];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        _imageView.userInteractionEnabled = NO;
        _imageView.accessibilityIdentifier = @"empty set background image";
        [_contentView addSubview:_imageView];
    }
    return _imageView;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel){
        _titleLabel = [UILabel new];
        _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.font = [UIFont systemFontOfSize:27.0];
        _titleLabel.textColor = [UIColor colorWithWhite:0.6 alpha:1.0];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _titleLabel.numberOfLines = 0;
        _titleLabel.accessibilityIdentifier = @"empty set title";
        [_contentView addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UILabel *)detailLabel
{
    if (!_detailLabel)
    {
        _detailLabel = [UILabel new];
        _detailLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _detailLabel.backgroundColor = [UIColor clearColor];
        _detailLabel.font = [UIFont systemFontOfSize:17.0];
        _detailLabel.textColor = [UIColor colorWithWhite:0.6 alpha:1.0];
        _detailLabel.textAlignment = NSTextAlignmentCenter;
        _detailLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _detailLabel.numberOfLines = 0;
        _detailLabel.accessibilityIdentifier = @"empty set detail label";
        [_contentView addSubview:_detailLabel];
    }
    return _detailLabel;
}


- (UIButton *)button
{
    if (!_button){
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        _button.translatesAutoresizingMaskIntoConstraints = NO;
        _button.backgroundColor = [UIColor clearColor];
        _button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        _button.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _button.accessibilityIdentifier = @"empty set button";
        
        [_button addTarget:self action:@selector(didTapButton:) forControlEvents:UIControlEventTouchUpInside];
        
        [_contentView addSubview:_button];
    }
    return _button;
}


@end


#pragma mark - UIScrollView+EmptyDataSet

static char const * const kEmptyDataSetSource =     "emptyDataSetSource";
static char const * const kEmptyDataSetDelegate =   "emptyDataSetDelegate";
static char const * const kEmptyDataSetView =       "emptyDataSetView";

#define kEmptyImageViewAnimationKey @"com.dzn.emptyDataSet.imageViewAnimation"

@interface UIScrollView () <UIGestureRecognizerDelegate>
@property (nonatomic, readonly) EmptyDataView *emptyDataSetView;
@end

@implementation UIScrollView (EmptyDataSet)

- (void)setSp_emptyDataView:(EmptyDataView *)sp_emptyDataView{
    if (sp_emptyDataView != self.sp_emptyDataView) {
        [self.sp_emptyDataView removeFromSuperview];
        [self addSubview:sp_emptyDataView];
        objc_setAssociatedObject(self,&kEmptyDataSetView, sp_emptyDataView, OBJC_ASSOCIATION_COPY);
    }
}

- (EmptyDataView *)sp_emptyDataView{
    return  objc_getAssociatedObject(self, &kEmptyDataSetView);
}


- (NSInteger)sp_totalDataCount{
    NSInteger totalCount = 0;
    if ([self isKindOfClass:[UITableView class]]) {
        UITableView *tableView = (UITableView *)self;
        for (NSInteger section = 0; section < tableView.numberOfSections; section ++) {
            totalCount += [tableView numberOfRowsInSection:section];
        }
    }else if ([self isKindOfClass:[UICollectionView class]]){
        UICollectionView *collectionView = (UICollectionView *)self;
        for (NSInteger section = 0; section < collectionView.numberOfSections; section ++) {
            totalCount += [collectionView numberOfItemsInSection:section];
        }
    }
    return  totalCount;
}


@end

