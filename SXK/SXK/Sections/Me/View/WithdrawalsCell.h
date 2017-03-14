//
//  WithdrawalsCell.h
//  SXK
//
//  Created by 杨伟康 on 2017/2/24.
//  Copyright © 2017年 ywk. All rights reserved.
//

#import "BaseCell.h"

@protocol WithdrawalsCellDelegate <NSObject>

-(void)returnText:(NSString *)text  type:(NSInteger)type;

@end


@interface WithdrawalsCell : BaseCell

@property (nonatomic, weak)id <WithdrawalsCellDelegate>delegate;
@property (nonatomic, assign) NSInteger type;
-(void) fillWithTitle:(NSString *)title;
@end
