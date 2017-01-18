//
//  OrderCell1.h
//  SXK
//
//  Created by 杨伟康 on 2016/12/28.
//  Copyright © 2016年 ywk. All rights reserved.
//

#import "BaseCell.h"
#import "BrandDetailModel.h"

@protocol OrderCell1Delegate <NSObject>

-(void)returnRisk:(BOOL)certain;

@end

@interface OrderCell1 : BaseCell

@property (nonatomic, weak)id<OrderCell1Delegate>delegate;


@property (nonatomic, strong)UILabel *depositLab;
@property (nonatomic, strong)UILabel *deposit;
@property (nonatomic, strong)UILabel *insurancePrice;
@property (nonatomic, strong)UIButton *selectBtn;



@end
