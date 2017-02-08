//
//  IdentityCell.h
//  SXK
//
//  Created by 杨伟康 on 2017/1/22.
//  Copyright © 2017年 ywk. All rights reserved.
//

#import "BaseCell.h"
@protocol IdentityCellDelegate <NSObject>

-(void)SendTextValue:(NSString *)content title:(NSString *)title;

@end

@interface IdentityCell : BaseCell

@property (nonatomic, weak)id <IdentityCellDelegate>delegate;

-(void)fillWithTitle:(NSString *)title;
@end
