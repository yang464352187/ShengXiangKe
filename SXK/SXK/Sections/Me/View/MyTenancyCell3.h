//
//  MyTenancyCell3.h
//  SXK
//
//  Created by 杨伟康 on 2017/2/7.
//  Copyright © 2017年 ywk. All rights reserved.
//

#import "BaseCell.h"

@protocol MyTenancyCell3Delegate <NSObject>

-(void)returnIndex:(NSInteger)index;

@end

@interface MyTenancyCell3 : BaseCell

@property (nonatomic, assign)NSInteger index;
@property (nonatomic, weak)id<MyTenancyCell3Delegate>delegate;


@end
