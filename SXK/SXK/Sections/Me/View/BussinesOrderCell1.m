//
//  BussinesOrderCell1.m
//  SXK
//
//  Created by 杨伟康 on 2017/4/5.
//  Copyright © 2017年 ywk. All rights reserved.
//

#import "BussinesOrderCell1.h"
@implementation BussinesOrderCell1{
    UILabel *_rentLab;
    UILabel *_rent;
    UIButton *_rentBtn;
    UIButton *_depositBtn;
    UIButton *_selectBtn;
    UILabel *_insurance;
    UIButton *_insuranceBtn;
    BOOL _certain;
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
//        _rentLab = [UILabel createLabelWithFrame:VIEWFRAME(15, 0, 150, 53)                                                 andText:@"订单租金"
//                                    andTextColor:[UIColor blackColor]
//                                      andBgColor:[UIColor clearColor]
//                                         andFont:SYSTEMFONT(14)
//                                andTextAlignment:NSTextAlignmentLeft];
//        
//        self.depositLab = [UILabel createLabelWithFrame:VIEWFRAME(15, 0, 150, 53)                                                 andText:@"¥:11450.00"
//                                           andTextColor:[UIColor blackColor]
//                                             andBgColor:[UIColor clearColor]
//                                                andFont:SYSTEMFONT(14)
//                                       andTextAlignment:NSTextAlignmentRight];
//        
//        _rent = [UILabel createLabelWithFrame:VIEWFRAME(15, 0, 150, 53)
//                                      andText:@"订单押金"
//                                 andTextColor:[UIColor blackColor]
//                                   andBgColor:[UIColor clearColor]
//                                      andFont:SYSTEMFONT(14)
//                             andTextAlignment:NSTextAlignmentLeft];
//        
//        self.deposit = [UILabel createLabelWithFrame:VIEWFRAME(15, 0, 150, 53)                                                 andText:@"¥:10000.00"
//                                        andTextColor:[UIColor blackColor]
//                                          andBgColor:[UIColor clearColor]
//                                             andFont:SYSTEMFONT(14)
//                                    andTextAlignment:NSTextAlignmentRight];
        
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
        
        
        UIImage *image = [UIImage imageNamed:@"详情-(1)"];//感叹号
        UIImage *select = [UIImage imageNamed:@"1圆角矩形-1-拷贝"];//选择框
        
//        _rentBtn = [UIButton buttonWithType:UIButtonTypeSystem];
//        [_rentBtn setImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
//        
//        _depositBtn = [UIButton buttonWithType:UIButtonTypeSystem];
//        [_depositBtn setImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        
        _insuranceBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_insuranceBtn setImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        
        _selectBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_selectBtn setImage:[select imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        [_selectBtn addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
        
//        [self addSubview:_rentLab];
//        [self addSubview:_rent];
//        [self addSubview:self.depositLab];
//        [self addSubview:self.deposit];
//        [self addSubview:_rentBtn];
//        [self addSubview:_depositBtn];
        [self addSubview:_selectBtn];
        [self addSubview:_insurance];
        [self addSubview:_insuranceBtn];
        [self addSubview:self.insurancePrice];
        
//        [_rentLab mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self.mas_top).offset(30);
//            make.left.equalTo(self.mas_left).offset(15);
//            make.size.mas_equalTo(CGSizeMake(60, 15));
//        }];
//        
//        [_rent mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(_rentLab.mas_bottom).offset(20);
//            make.left.equalTo(self.mas_left).offset(15);
//            make.size.mas_equalTo(CGSizeMake(60, 15));
//        }];
//        
//        [self.depositLab mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self.mas_top).offset(30);
//            make.right.equalTo(self.mas_right).offset(-15);
//            make.size.mas_equalTo(CGSizeMake(100, 15));
//        }];
//        
//        [self.deposit mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self.depositLab.mas_bottom).offset(20);
//            make.right.equalTo(self.mas_right).offset(-15);
//            make.size.mas_equalTo(CGSizeMake(100, 15));
//        }];
//        
//        [_rentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.centerY.equalTo(_rentLab).offset(0);
//            make.left.equalTo(_rentLab.mas_right).offset(0);
//            make.size.mas_equalTo(CGSizeMake(20, 20));
//        }];
//        
//        [_depositBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.centerY.equalTo(_rent).offset(0);
//            make.left.equalTo(_rent.mas_right).offset(0);
//            make.size.mas_equalTo(CGSizeMake(20, 20));
//        }];
        
        [_selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self).offset(0);
            make.left.equalTo(self.mas_left).offset(15);
            make.size.mas_equalTo(CGSizeMake(20, 20));
        }];
        
        [_insurance mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_selectBtn).offset(0);
            make.left.equalTo(_selectBtn.mas_right).offset(0);
            make.size.mas_equalTo(CGSizeMake(75, 15));
        }];
        
        [_insuranceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_insurance).offset(0);
            make.left.equalTo(_insurance.mas_right).offset(0);
            make.size.mas_equalTo(CGSizeMake(20, 20));
        }];
        
        [self.insurancePrice mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_insuranceBtn).offset(0);
            make.left.equalTo(_insuranceBtn.mas_right).offset(0);
            make.right.equalTo(self.mas_right).offset(-15);
            make.height.mas_equalTo(15);
        }];
        
        //        _certain = 0;
    }
    return  self;
}


-(void)setModel:(BrandDetailModel *)model
{
//    
//    self.depositLab.text = [NSString stringWithFormat:@"¥:%.2f",[model.three floatValue]/100];
//    self.deposit.text = [NSString stringWithFormat:@"¥:%.2f",[model.marketPrice floatValue]/100];
    self.insurancePrice.text = [NSString stringWithFormat:@"¥:%.2f",[model.risk floatValue]/100];
    
}


-(void)selectAction:(UIButton *)sender
{
    UIImage *select = [UIImage imageNamed:@"1圆角矩形-1-拷贝"];//选择框
    UIImage *select1 = [UIImage imageNamed:@"图层-444"];//选择框
    
    if (_certain) {
        _certain = 0;
        [_selectBtn setImage:[select imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    }else{
        _certain = 1;
        [_selectBtn setImage:[select1 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    }
    
    if ([_delegate respondsToSelector:@selector(returnRisk:)]) { // 如果协议响应了sendValue:方法
        [_delegate returnRisk:_certain]; // 通知执行协议方法
    }
    
}


@end
