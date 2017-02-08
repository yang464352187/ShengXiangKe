//
//  MyMaintainCell.h
//  SXK
//
//  Created by 杨伟康 on 2017/2/4.
//  Copyright © 2017年 ywk. All rights reserved.
//

#import "BaseCell.h"

@protocol MyMaintainCellDelegate <NSObject>

-(void)returnIndex:(NSInteger)index;

@end

@interface MyMaintainCell : BaseCell
@property (nonatomic, assign)NSInteger index;
@property (nonatomic, weak)id<MyMaintainCellDelegate>delegate;

@end
