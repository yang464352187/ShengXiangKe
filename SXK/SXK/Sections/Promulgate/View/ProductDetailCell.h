//
//  ProductDetailCell.h
//  SXK
//
//  Created by 杨伟康 on 2016/12/22.
//  Copyright © 2016年 ywk. All rights reserved.
//

#import "BaseCell.h"

@protocol ProductDetailCellDelegate <NSObject>

-(void)getHeight:(CGFloat)height;

@end

@interface ProductDetailCell : BaseCell

@property (nonatomic, weak)id<ProductDetailCellDelegate>delegate;

@end
