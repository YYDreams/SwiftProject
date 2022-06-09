//
//  EmptyDataView.h
//  SwiftProject
//
//  Created by flower on 2022/5/28.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,PageStatus) {
    PageStatusNo,
    PageStatusError,
    PageStatusSucceed
};

NS_ASSUME_NONNULL_BEGIN



@interface EmptyDataView : UIView

@end







@interface UIScrollView (EmptyDataSet)

/// 为UIScrollView添加占位图
@property (nonatomic, strong) EmptyDataView *sp_emptyDataView;

/// UIScrollView是否正在刷新，如果为YES，占位图将不显示
@property (nonatomic, assign) BOOL sp_isRefreshing;



/// UITableView或UICollectionView数据源个数
- (NSInteger)sp_totalDataCount;


@end

NS_ASSUME_NONNULL_END
