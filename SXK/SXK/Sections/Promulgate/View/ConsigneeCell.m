//
//  ConsigneeCell.m
//  SXK
//
//  Created by 杨伟康 on 2016/11/29.
//  Copyright © 2016年 ywk. All rights reserved.
//

#import "ConsigneeCell.h"
@implementation ConsigneeCell{
    UILabel *_title;
    UIView *_line;
    UIImageView *_back;
    UILabel *_name;
    UILabel *_address;
    UILabel *_phone;

}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _title = [UILabel createLabelWithFrame:VIEWFRAME(15, 0, 100, 53)                                                 andText:@""
                                  andTextColor:[UIColor colorWithHexColorString:@"a1a1a1"]
                                    andBgColor:[UIColor clearColor]
                                       andFont:SYSTEMFONT(14)
                              andTextAlignment:NSTextAlignmentLeft];
        
        _name = [UILabel createLabelWithFrame:VIEWFRAME(15, 10, SCREEN_WIDTH - 30, 15)                                                 andText:@""
                                  andTextColor:[UIColor colorWithHexColorString:@"a1a1a1"]
                                    andBgColor:[UIColor clearColor]
                                       andFont:SYSTEMFONT(14)
                              andTextAlignment:NSTextAlignmentLeft];
        
        _address = [UILabel createLabelWithFrame:VIEWFRAME(15, 30, SCREEN_WIDTH - 30, 15)                                                 andText:@""
                                 andTextColor:[UIColor colorWithHexColorString:@"a1a1a1"]
                                   andBgColor:[UIColor clearColor]
                                      andFont:SYSTEMFONT(14)
                             andTextAlignment:NSTextAlignmentLeft];
        
        _phone = [UILabel createLabelWithFrame:VIEWFRAME(15, 30, SCREEN_WIDTH - 30, 15)                                                 andText:@""
                                    andTextColor:[UIColor colorWithHexColorString:@"a1a1a1"]
                                      andBgColor:[UIColor clearColor]
                                         andFont:SYSTEMFONT(14)
                                andTextAlignment:NSTextAlignmentLeft];


        
        _line = [[UIView alloc] initWithFrame:VIEWFRAME(0, 53, SCREEN_WIDTH, 1)];
        _line.backgroundColor = [UIColor colorWithHexColorString:@"f7f7f7"];
        
        _back = [[UIImageView alloc] init];
        _back.image = [UIImage imageNamed:@"返回-"];

        [self addSubview:_title];
        [self addSubview:_line];
        [self addSubview:_back];
        [self addSubview:_name];
        [self addSubview:_address];
        [self addSubview:_phone];

        [_title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.equalTo(self.mas_left).offset(15);
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(53);
        }];

        
        [_back mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.right.equalTo(self.mas_right).offset(-18);
            make.size.mas_equalTo(CGSizeMake(8, 13));
        }];
        
        [_name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).offset(11);
            make.left.equalTo(self.mas_left).offset(23.5);
            make.size.mas_equalTo(CGSizeMake(80, 15));
        }];
        
        [_phone mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_name);
            make.left.equalTo(_name.mas_right).offset(30);
            make.size.mas_equalTo(CGSizeMake(200, 14));
        }];
        
        [_address mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_phone.mas_bottom).offset(11);
            make.left.equalTo(self.mas_left).offset(23.5);
            make.size.mas_equalTo(CGSizeMake(300, 14));
        }];

        
        
//        _weekSelf(weakSelf);
//        [BaseRequest GetAddressWithReceiverid:0 succesBlock:^(id data) {
//            
////            weakSelf.dic = [AddressModel modelFromDictionary:data[@"receiver"]];
//            //        NSLog(@"%ld",[data[@"code"] integerValue]);
//            _name.text = [NSString stringWithFormat:@"姓名:%@",data[@"receiver"][@"name"]];
//            _phone.text = [NSString stringWithFormat:@"电话:%@",data[@"receiver"][@"mobile"]];
////            weakSelf.addressLab.text = [NSString stringWithFormat:@"地址:%@%@%@%@",weakSelf.model.state,weakSelf.model.city,weakSelf.model.district,weakSelf.model.address];
////            weakSelf.name = [NSString stringWithFormat:@"姓名:%@",weakSelf.model.name];
////            weakSelf.mobile = [NSString stringWithFormat:@"电话:%@",weakSelf.model.mobile];
//            _address.text = [NSString stringWithFormat:@"地址:%@%@%@%@",data[@"receiver"][@"state"],data[@"receiver"][@"city"],data[@"receiver"][@"district"],data[@"receiver"][@"address"]];
//            _title.text = @"";
//            
//        } failue:^(id data, NSError *error) {
//            _title.text = data[@"message"];
//            
//        }];

        
    }
    return  self;
}

-(void)fillWithModel:(AddressModel *)model str:(NSString *)str
{
    if (str.length > 0) {
        _title.text = str;
    }else{
        _name.text =  [NSString stringWithFormat:@"姓名:%@",model.name];
        _phone.text = [NSString stringWithFormat:@"电话:%@",model.mobile];
        _address.text = [NSString stringWithFormat:@"地址:%@%@%@%@",model.state,model.city,model.district,model.address];
        _title.text = @"";
    }
}

-(void)fillWithTitle:(NSString *)str
{
    _title.text = str;
    _name.text = @"";
    _phone.text = @"";
    _address.text = @"";
}


@end
