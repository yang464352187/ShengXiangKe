//
//  OrderCell2.h
//  SXK
//
//  Created by 杨伟康 on 2017/1/16.
//  Copyright © 2017年 ywk. All rights reserved.
//

#import "BaseCell.h"

@protocol OrderCell2Delegate <NSObject>

-(void)SendTextValue:(NSString *)content;

@end

@interface OrderCell2 : BaseCell

@property (nonatomic, weak)id <OrderCell2Delegate>delegate;

@end
