//
//  MyTenancyCell.h
//  SXK
//
//  Created by 杨伟康 on 2016/12/26.
//  Copyright © 2016年 ywk. All rights reserved.
//

#import "BaseCell.h"

@protocol MyTenancyDelegate <NSObject>

-(void)returnIndex:(NSInteger)index;

@end


@interface MyTenancyCell : BaseCell

@property (nonatomic, assign)NSInteger index;
@property (nonatomic, weak)id<MyTenancyDelegate>delegate;

-(void)reSetName;
-(void)reName;
@end
