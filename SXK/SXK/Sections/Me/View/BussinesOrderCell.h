//
//  BussinesOrderCell.h
//  SXK
//
//  Created by 杨伟康 on 2017/4/5.
//  Copyright © 2017年 ywk. All rights reserved.
//

#import "BaseCell.h"
@protocol BussinesOrderCellDelegate <NSObject>

-(void)returnDay:(NSInteger)day;

@end

@interface BussinesOrderCell : BaseCell

@property(weak, nonatomic)id<BussinesOrderCellDelegate>delegate;

@end
