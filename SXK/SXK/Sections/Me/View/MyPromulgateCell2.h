//
//  MyPromulgateCell2.h
//  SXK
//
//  Created by 杨伟康 on 2017/1/19.
//  Copyright © 2017年 ywk. All rights reserved.
//

#import "BaseCell.h"
@protocol MyPromulgateCell2Delegate <NSObject>

-(void)returnIndex:(NSInteger)index;

@end

@interface MyPromulgateCell2 : BaseCell


@property (nonatomic, assign)NSInteger index;
@property (nonatomic, weak)id<MyPromulgateCell2Delegate>delegate;

@end
