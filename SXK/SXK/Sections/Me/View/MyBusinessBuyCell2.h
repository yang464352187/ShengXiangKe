//
//  MyBusinessBuyCell2.h
//  SXK
//
//  Created by 杨伟康 on 2017/4/5.
//  Copyright © 2017年 ywk. All rights reserved.
//

#import "BaseCell.h"
@protocol MyBusinessBuyCell2Delegate <NSObject>

-(void)returnIndex:(NSInteger)index;

@end

@interface MyBusinessBuyCell2 : BaseCell

@property (nonatomic, assign)NSInteger index;
@property (nonatomic, weak)id<MyBusinessBuyCell2Delegate>delegate;


@end
