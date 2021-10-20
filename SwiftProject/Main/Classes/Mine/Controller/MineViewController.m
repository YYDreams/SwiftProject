//
//  MineViewController.m
//  RACProject
//
//  Created by flowerflower on 2020/4/23.
//  Copyright © 2020 flowerflower. All rights reserved.
//

#import "MineViewController.h"
#import "MineOrderView.h"
#import "HHMyOrderController.h"
#import "MineAccountCell.h"
#import "MineViewModel.h"
#import "MineCell.h"

static NSString * const MineAccountCellID = @"MineAccountCellID";
static NSString * const SpacingHeaderID = @"SpacingHeaderID";

static NSString * const MineCellID = @"MineCellID";

@interface MineViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

//@property(nonatomic ,strong)MineHeaderView *headerView;

@property(nonatomic ,strong)MineViewModel *viewModel;


@end

@implementation MineViewController


#pragma mark - CycLife
- (void)viewDidLoad{
    [super viewDidLoad];
    [self setupSubView];
    
}
- (void)setupSubView{
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"我的订单" style:0 target:self action:@selector(orderOnClick)];

    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.right.mas_equalTo(self.view);
    }];

    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:SpacingHeaderID];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:SpacingHeaderID];
    [self.collectionView registerClass:[MineCell class] forCellWithReuseIdentifier:MineCellID];
    [self.collectionView registerClass:[MineAccountCell class] forCellWithReuseIdentifier:MineAccountCellID];

    
}

- (void)orderOnClick{
    [self.navigationController pushViewController:[HHMyOrderController new] animated:YES];

    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

}
#pragma mark - Settings, Gettings


#pragma mark - Methods

#pragma mark - <UICollectionViewDelegate,UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return  self.viewModel.sectionArr.count;
    
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
//    return  self.viewModel.dataArr.count;
    if (section == 0) {
        return 1;
    }
    return 22;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        MineAccountCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:MineAccountCellID forIndexPath:indexPath];
//        cell.backgroundColor = 
        return  cell;
    }
    
    
    
    MineCell * recommandCell = [collectionView dequeueReusableCellWithReuseIdentifier:MineCellID forIndexPath:indexPath];
    return  recommandCell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return  CGSizeMake(Screen_Width, 700);
    }
    CGFloat width = (Screen_Width -  34.f) / 2;
//    SCRecommendCellViewModel * vm = self.recommendViewModel.viewModels[indexPath.row];
    return CGSizeMake(width, 300);
    
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 10.f;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 10.f;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 12, 0, 12);
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.navigationController pushViewController:[HHMyOrderController new] animated:YES];
}


#pragma mark --------------------
#pragma mark - NSNotification



- (MineViewModel *)viewModel{
    if (!_viewModel) {
        _viewModel = [[MineViewModel alloc]init];
    }
    return _viewModel;
    
}
@end
