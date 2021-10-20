//
//  MineModel.h
//  RACProject
//
//  Created by flowerflower on 2021/8/1.
//  Copyright © 2021 flowerflower. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MineModel : BaseModel
@property(nonatomic ,copy)NSString *title;

@property(nonatomic ,copy)NSString *imageStr;

@property(nonatomic ,copy)NSString *bageCount;

@end

NS_ASSUME_NONNULL_END
