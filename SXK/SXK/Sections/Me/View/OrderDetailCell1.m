//
//  OrderDetailCell1.m
//  SXK
//
//  Created by 杨伟康 on 2017/4/20.
//  Copyright © 2017年 ywk. All rights reserved.
//

#import "OrderDetailCell1.h"
#import "OrderDetailModel.h"

@implementation OrderDetailCell1{
    UILabel *_rentLab;
    UILabel *_rent;
    UILabel *_insurance;
    BOOL _certain;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _rentLab = [UILabel createLabelWithFrame:VIEWFRAME(15, 0, 150, 53)                                                 andText:@"订单租金"
                                    andTextColor:[UIColor blackColor]
                                      andBgColor:[UIColor clearColor]
                                         andFont:SYSTEMFONT(14)
                                andTextAlignment:NSTextAlignmentLeft];
        
        self.depositLab = [UILabel createLabelWithFrame:VIEWFRAME(15, 0, 150, 53)                                                 andText:@"¥:11450.00"
                                           andTextColor:[UIColor blackColor]
                                             andBgColor:[UIColor clearColor]
                                                andFont:SYSTEMFONT(14)
                                       andTextAlignment:NSTextAlignmentRight];
        
        _rent = [UILabel createLabelWithFrame:VIEWFRAME(15, 0, 150, 53)
                                      andText:@"订单押金"
                                 andTextColor:[UIColor blackColor]
                                   andBgColor:[UIColor clearColor]
                                      andFont:SYSTEMFONT(14)
                             andTextAlignment:NSTextAlignmentLeft];
        
        self.deposit = [UILabel createLabelWithFrame:VIEWFRAME(15, 0, 150, 53)                                                 andText:@"¥:10000.00"
                                        andTextColor:[UIColor blackColor]
                                          andBgColor:[UIColor clearColor]
                                             andFont:SYSTEMFONT(14)
                                    andTextAlignment:NSTextAlignmentRight];
        
        _insurance = [UILabel createLabelWithFrame:VIEWFRAME(15, 0, 150, 53)                                                 andText:@"货物运输险"
                                      andTextColor:[UIColor blackColor]
                                        andBgColor:[UIColor clearColor]
                                           andFont:SYSTEMFONT(14)
                                  andTextAlignment:NSTextAlignmentLeft];
        
        self.insurancePrice = [UILabel createLabelWithFrame:VIEWFRAME(15, 0, 150, 53)                                                 andText:@"¥:450.00"
                                               andTextColor:[UIColor blackColor]
                                                 andBgColor:[UIColor clearColor]
                                                    andFont:SYSTEMFONT(14)
                                           andTextAlignment:NSTextAlignmentRight];
        

        [self addSubview:_rentLab];
        [self addSubview:_rent];
        [self addSubview:self.depositLab];
        [self addSubview:self.deposit];
        [self addSubview:_insurance];
        [self addSubview:self.insurancePrice];
        
        [_rentLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).offset(30);
            make.left.equalTo(self.mas_left).offset(15);
            make.size.mas_equalTo(CGSizeMake(60, 15));
        }];
        
        [_rent mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_rentLab.mas_bottom).offset(20);
            make.left.equalTo(self.mas_left).offset(15);
            make.size.mas_equalTo(CGSizeMake(60, 15));
        }];
        
        [self.depositLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).offset(30);
            make.right.equalTo(self.mas_right).offset(-15);
            make.size.mas_equalTo(CGSizeMake(100, 15));
        }];
        
        [self.deposit mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.depositLab.mas_bottom).offset(20);
            make.right.equalTo(self.mas_right).offset(-15);
            make.size.mas_equalTo(CGSizeMake(100, 15));
        }];
        
        [_insurance mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_rent.mas_bottom).offset(20);
            make.left.equalTo(self.mas_left).offset(15);
            make.size.mas_equalTo(CGSizeMake(75, 15));
        }];
        
        
        [self.insurancePrice mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_insurance).offset(0);
            make.left.equalTo(_insurance.mas_right).offset(0);
            make.right.equalTo(self.mas_right).offset(-15);
            make.height.mas_equalTo(15);
        }];
        
    }
    return  self;
}

-(void)setModel:(OrderDetailModel *)model
{
    
    self.depositLab.text = [NSString stringWithFormat:@"¥:%.2f",[model.tenancy[@"value"] floatValue]/100];
    self.deposit.text = [NSString stringWithFormat:@"¥:%.2f",[model.rent[@"marketPrice"] floatValue] /100];
    self.insurancePrice.text = [NSString stringWithFormat:@"¥:%.2f",[model.rent[@"risk"] floatValue] /100];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
