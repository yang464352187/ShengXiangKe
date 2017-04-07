//
//  BusinessCell1.m
//  SXK
//
//  Created by 杨伟康 on 2017/3/16.
//  Copyright © 2017年 ywk. All rights reserved.
//

#import "BusinessCell1.h"
#import "AddressModel.h"
@implementation BusinessCell1{
    UIView *_view;
    UILabel *_title;
    UILabel *_name;
    UILabel *_mobile;
    UILabel *_address;
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
        _view = [[UIView alloc] init];
        _view.backgroundColor = [UIColor whiteColor];
        ViewBorder(_view, 1, [UIColor blackColor]);
        
        UILabel *label = [UILabel createLabelWithFrame:VIEWFRAME(15, 0, 150, 53)                                                 andText:@""
                                          andTextColor:[UIColor blackColor]
                                            andBgColor:[UIColor clearColor]
                                               andFont:[UIFont fontWithName:@"Helvetica-Bold" size:14]                                     andTextAlignment:NSTextAlignmentCenter];

        UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cdxc"]];
        
        UILabel *label1 = [UILabel createLabelWithFrame:VIEWFRAME(15, 0, 150, 53)                                                 andText:@"请将商品邮寄至:福建省厦门市吕岭路185号之十六C3室"
                                          andTextColor:APP_COLOR_GREEN
                                             andBgColor:[UIColor clearColor]
                                               andFont:SYSTEMFONT(14)
                                       andTextAlignment:NSTextAlignmentLeft];
        label1.numberOfLines = 0;
        
        UILabel *label2 = [UILabel createLabelWithFrame:VIEWFRAME(15, 0, 150, 53)                                                 andText:@"TEL:400-9633-012"
                                           andTextColor:APP_COLOR_GREEN
                                             andBgColor:[UIColor clearColor]
                                                andFont:SYSTEMFONT(14)
                                       andTextAlignment:NSTextAlignmentLeft];
        
        CGFloat height = [UILabel getHeightByWidth:SCREEN_WIDTH - 30 title:@"请将商品邮寄至:福建省厦门市吕岭路185号之十六C3室" font:SYSTEMFONT(14)];
        
        _name = [UILabel createLabelWithFrame:VIEWFRAME(15, 0, 150, 53)                                                 andText:@""
                                          andTextColor:[UIColor blackColor]
                                            andBgColor:[UIColor clearColor]
                                                andFont:SYSTEMFONT(14)
                                      andTextAlignment:NSTextAlignmentLeft];
        
        _mobile = [UILabel createLabelWithFrame:VIEWFRAME(15, 0, 150, 53)                                                 andText:@""
                                 andTextColor:[UIColor blackColor]
                                   andBgColor:[UIColor clearColor]
                                      andFont:SYSTEMFONT(14)
                             andTextAlignment:NSTextAlignmentLeft];

        _address = [UILabel createLabelWithFrame:VIEWFRAME(15, 0, 150, 53)                                                 andText:@""
                                 andTextColor:[UIColor blackColor]
                                   andBgColor:[UIColor clearColor]
                                      andFont:SYSTEMFONT(14)
                             andTextAlignment:NSTextAlignmentLeft];

        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [_view addGestureRecognizer:tap];
        
        [self addSubview:_view];
        [self addSubview:label1];
        [_view addSubview:label];
        [_view addSubview:image];
        [self addSubview:label2];
        
        [_view addSubview:_name];
        [_view addSubview:_mobile];
        [_view addSubview:_address];
        
        
        
        [_view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).offset(0);
            make.left.equalTo(self.mas_left).offset(15);
            make.right.equalTo(self.mas_right).offset(-15);
            make.height.mas_equalTo(85);
        }];
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_view);
            make.centerY.equalTo(_view);
            make.size.mas_equalTo(CGSizeMake(60, 20));
        }];
        
        [image mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_view);
            make.right.equalTo(_view.mas_right).offset(-10);
            make.size.mas_equalTo(CGSizeMake(10, 21));
        }];
        
        [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_view.mas_bottom).offset(10);
            make.left.equalTo(self.mas_left).offset(15);
            make.right.equalTo(self.mas_right).offset(-13);
            make.height.mas_equalTo(height);
        }];
        
        [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(label1.mas_bottom).offset(-3);
            make.left.equalTo(self.mas_left).offset(15);
            make.right.equalTo(self.mas_right).offset(-15);
            make.height.mas_equalTo(15);
        }];
        
        _title = label;
        
        [_name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_view).offset(-10);
            make.left.equalTo(_view.mas_left).offset(10);
            make.size.mas_equalTo(CGSizeMake(100, 14));
        }];
        
        [_mobile mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_view).offset(-10);
            make.right.equalTo(_view.mas_right).offset(-10);
            make.left.equalTo(_name.mas_right).offset(5);
            make.height.mas_equalTo(@(14));
        }];
        
        [_address mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_view).offset(10);
            make.right.equalTo(_view.mas_right).offset(-10);
            make.left.equalTo(_view.mas_left).offset(10);
            make.height.mas_equalTo(@(14));

        }];
        

    }
    
    return  self;
}


-(void)setModel:(id)model
{
    AddressModel *_model = model;
    
    if (_model.mobile.length > 10) {
        _name.text = [NSString stringWithFormat:@"姓名:%@",_model.name];
        _mobile.text = [NSString stringWithFormat:@"电话:%@",_model.mobile];
        _address.text = [NSString stringWithFormat:@"地址:%@%@%@%@",_model.state,_model.city,_model.district,_model.address];
        _title.text = @"";
    }else{
        _title.text = @"添加地址";
        _name.text = @"";
        _mobile.text = @"";
        _address.text = @"";
    }
    
}


-(void)tap:(UITapGestureRecognizer *)tap
{
//     [self PushViewControllerByClassName:@"AddressManagerVC" info:nil];
    
    [[PushManager sharedManager] pushToVCWithClassName:@"AddressManagerVC" info:nil];
}
@end
