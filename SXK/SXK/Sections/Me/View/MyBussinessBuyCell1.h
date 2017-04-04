//
//  MyBussinessBuyCell1.h
//  SXK
//
//  Created by 杨伟康 on 2017/4/5.
//  Copyright © 2017年 ywk. All rights reserved.
//

#import "BaseCell.h"
#import "MyBussinessBuyModel.h"


@protocol MyBusinessBuyCell1Delegate <NSObject>

-(void)returnIndex:(NSInteger)index;

@end

@interface MyBussinessBuyCell1 : BaseCell

@property (nonatomic, assign)NSInteger index;
@property (nonatomic, weak)id<MyBusinessBuyCell1Delegate>delegate;


@end
