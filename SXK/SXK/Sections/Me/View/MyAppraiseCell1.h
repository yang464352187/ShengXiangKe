//
//  MyAppraiseCell1.h
//  SXK
//
//  Created by 杨伟康 on 2017/2/24.
//  Copyright © 2017年 ywk. All rights reserved.
//

#import "BaseCell.h"
@protocol MyAppraiseCell1Delegate <NSObject>

-(void)returnIndex:(NSInteger)index;

@end

@interface MyAppraiseCell1 : BaseCell
@property (nonatomic, assign)NSInteger index;
@property (nonatomic, weak)id<MyAppraiseCell1Delegate>delegate;



@end
