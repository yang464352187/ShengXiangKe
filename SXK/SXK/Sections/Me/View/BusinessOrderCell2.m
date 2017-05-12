//
//  BusinessOrderCell2.m
//  SXK
//
//  Created by 杨伟康 on 2017/4/20.
//  Copyright © 2017年 ywk. All rights reserved.
//

#import "BusinessOrderCell2.h"
#import "OrderDetailModel.h"

@implementation BusinessOrderCell2{

    UILabel *_insurance;
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
        
        [self addSubview:_insurance];
        [self addSubview:self.insurancePrice];
        
        
        [_insurance mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.equalTo(self.mas_left).offset(15);
            make.size.mas_equalTo(CGSizeMake(75, 15));
        }];
        
        
        [self.insurancePrice mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.right.equalTo(self.mas_right).offset(-15);
            make.size.mas_equalTo(CGSizeMake(175, 15));
        }];
        
        //        _certain = 0;
    }
    return  self;
}

-(void)setModel:(OrderDetailModel *)model
{

    self.insurancePrice.text = [NSString stringWithFormat:@"¥:%.2f",[model.purchase[@"risk"] floatValue] /100];
    
}



@end
