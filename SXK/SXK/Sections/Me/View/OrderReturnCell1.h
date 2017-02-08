//
//  OrderReturnCell1.h
//  SXK
//
//  Created by 杨伟康 on 2017/2/6.
//  Copyright © 2017年 ywk. All rights reserved.
//

#import "BaseCell.h"

@protocol OrderReturnCell1Delegate <NSObject>

-(void)returnTitle:(NSString *)title Content:(NSString *)content;

@end


@interface OrderReturnCell1 : BaseCell

-(void)fillWithTitle:(NSString *)title;

@property (nonatomic, weak)id<OrderReturnCell1Delegate>delegate;

@end
