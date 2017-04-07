//
//  BussinesOrderCell1.h
//  SXK
//
//  Created by 杨伟康 on 2017/4/5.
//  Copyright © 2017年 ywk. All rights reserved.
//

#import "BaseCell.h"
#import "BrandDetailModel.h"

@protocol BussinesOrderCell1Delegate <NSObject>

-(void)returnRisk:(BOOL)certain;

@end

@interface BussinesOrderCell1 : BaseCell


@property (nonatomic, weak)id<BussinesOrderCell1Delegate>delegate;
@property (nonatomic, strong)UILabel *depositLab;
@property (nonatomic, strong)UILabel *deposit;
@property (nonatomic, strong)UILabel *insurancePrice;
@property (nonatomic, strong)UIButton *selectBtn;


@end
