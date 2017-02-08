//
//  MyPromulgateCell1.h
//  SXK
//
//  Created by 杨伟康 on 2016/12/27.
//  Copyright © 2016年 ywk. All rights reserved.
//

#import "BaseCell.h"

@protocol MyPromulgateCell1Delegate <NSObject>

-(void)returnIndex:(NSInteger)index;

@end

@interface MyPromulgateCell1 : BaseCell

@property (nonatomic, assign)NSInteger index;
@property (nonatomic, weak)id<MyPromulgateCell1Delegate>delegate;

@end
