//
//  OrderCell.h
//  SXK
//
//  Created by 杨伟康 on 2016/12/27.
//  Copyright © 2016年 ywk. All rights reserved.
//

#import "BaseCell.h"

@protocol OrderCellDelegate <NSObject>

-(void)returnDay:(NSInteger)day;

@end

@interface OrderCell : BaseCell

@property(weak, nonatomic)id<OrderCellDelegate>delegate;

@end
