//
//  MyAppraiseCell.h
//  SXK
//
//  Created by 杨伟康 on 2017/2/17.
//  Copyright © 2017年 ywk. All rights reserved.
//

#import "BaseCell.h"

@protocol MyAppraiseCellDelegate <NSObject>

-(void)returnIndex:(NSInteger)index;

@end

@interface MyAppraiseCell : BaseCell

@property (nonatomic, assign)NSInteger index;
@property (nonatomic, weak)id<MyAppraiseCellDelegate>delegate;


@end
