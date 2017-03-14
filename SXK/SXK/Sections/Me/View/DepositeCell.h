//
//  DepositeCell.h
//  SXK
//
//  Created by 杨伟康 on 2017/2/21.
//  Copyright © 2017年 ywk. All rights reserved.
//

#import "BaseCell.h"

@protocol DepositeCellDelegate <NSObject>

-(void)returnText:(NSString *)text;

@end


@interface DepositeCell : BaseCell


@property (nonatomic, weak)id <DepositeCellDelegate>delegate;

@end
