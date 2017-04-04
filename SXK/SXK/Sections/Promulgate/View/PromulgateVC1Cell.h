//
//  PromulgateVC1Cell.h
//  SXK
//
//  Created by 杨伟康 on 2017/3/16.
//  Copyright © 2017年 ywk. All rights reserved.
//

#import "BaseCell.h"
@protocol PromulgateVC1CellDelegate <NSObject>

-(void)SendTextValue1:(NSString *)content title:(NSString *)title;

@end

@interface PromulgateVC1Cell : BaseCell

@property (nonatomic, weak)id <PromulgateVC1CellDelegate>delegate;

-(void)fillWithTitle:(NSString *)title;



@end
