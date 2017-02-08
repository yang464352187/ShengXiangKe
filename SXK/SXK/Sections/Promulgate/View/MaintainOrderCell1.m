//
//  MaintainOrderCell1.m
//  SXK
//
//  Created by 杨伟康 on 2017/1/22.
//  Copyright © 2017年 ywk. All rights reserved.
//

#import "MaintainOrderCell1.h"
#import "MaintainCellModel.h"

@implementation MaintainOrderCell1{
    UILabel *_postage;
    UILabel *_postagePrice;
    UILabel *_order;
    UILabel *_orderPrice;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _postage = [UILabel createLabelWithFrame:VIEWFRAME(15, 0, 150, 53)                                                 andText:@"邮费"
                                  andTextColor:[UIColor blackColor]
                                    andBgColor:[UIColor clearColor]
                                       andFont:SYSTEMFONT(14)
                              andTextAlignment:NSTextAlignmentLeft];
        
        _order = [UILabel createLabelWithFrame:VIEWFRAME(15, 0, 150, 53)                                                 andText:@"订单金额"
                                    andTextColor:[UIColor blackColor]
                                      andBgColor:[UIColor clearColor]
                                         andFont:SYSTEMFONT(14)
                                andTextAlignment:NSTextAlignmentLeft];
        
        _postagePrice = [UILabel createLabelWithFrame:VIEWFRAME(15, 0, 150, 53)                                                 andText:@"包邮"
                                  andTextColor:[UIColor blackColor]
                                    andBgColor:[UIColor clearColor]
                                       andFont:SYSTEMFONT(14)
                              andTextAlignment:NSTextAlignmentRight];

        _orderPrice = [UILabel createLabelWithFrame:VIEWFRAME(15, 0, 150, 53)                                                 andText:@""
                                  andTextColor:[UIColor blackColor]
                                    andBgColor:[UIColor clearColor]
                                       andFont:SYSTEMFONT(14)
                              andTextAlignment:NSTextAlignmentRight];
        
        [self addSubview:_postage];
        [self addSubview:_order];
        [self addSubview:_postagePrice];
        [self addSubview:_orderPrice];
        
        [_postage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(15);
            make.top.equalTo(self.mas_top).offset(18);
            make.size.mas_equalTo(CGSizeMake(100, 15));
        }];
        
        [_order mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(15);
            make.top.equalTo(_postage.mas_bottom).offset(18);
            make.size.mas_equalTo(CGSizeMake(100, 15));
        }];
        
        [_postagePrice mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_postage.mas_right).offset(0);
            make.centerY.equalTo(_postage);
            make.right.equalTo(self.mas_right).offset(-15);
            make.height.mas_equalTo(15);
        }];

        [_orderPrice mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_order.mas_right).offset(0);
            make.centerY.equalTo(_order);
            make.right.equalTo(self.mas_right).offset(-15);
            make.height.mas_equalTo(15);
        }];

    }
    return  self;
}

-(void)setModel:(id)model
{
    MaintainCellModel *_model = model;
    _orderPrice.text = [NSString stringWithFormat:@"¥%.2f",[_model.price floatValue] / 100];
}

@end
