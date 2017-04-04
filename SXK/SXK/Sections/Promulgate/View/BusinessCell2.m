//
//  BusinessCell2.m
//  SXK
//
//  Created by 杨伟康 on 2017/3/17.
//  Copyright © 2017年 ywk. All rights reserved.
//

#import "BusinessCell2.h"
#import "BusinessModel.h"
@implementation BusinessCell2{
    UIView *_view;
    UILabel *_title;
    UILabel *_category;
    UILabel *_price;
    UILabel *_degree;
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
        _view.backgroundColor = APP_COLOR_GREEN;
        
        UILabel *label = [UILabel createLabelWithFrame:VIEWFRAME(15, 0, 150, 53)                                                 andText:@"心里预期售卖价:"
                                          andTextColor:[UIColor whiteColor]
                                            andBgColor:[UIColor clearColor]
                                               andFont:SYSTEMFONT(14)
                                      andTextAlignment:NSTextAlignmentRight];
        
        _title = [UILabel createLabelWithFrame:VIEWFRAME(15, 0, 150, 53)                                                    andText:@"测试一"
                                          andTextColor:[UIColor whiteColor]
                                            andBgColor:[UIColor clearColor]
                                               andFont:SYSTEMFONT(14)
                                      andTextAlignment:NSTextAlignmentLeft];
        
        _category = [UILabel createLabelWithFrame:VIEWFRAME(15, 0, 150, 53)                                                    andText:@"腕表"
                                  andTextColor:[UIColor whiteColor]
                                    andBgColor:[UIColor clearColor]
                                       andFont:SYSTEMFONT(14)
                              andTextAlignment:NSTextAlignmentLeft];
        
        _price = [UILabel createLabelWithFrame:VIEWFRAME(15, 0, 150, 53)                                                    andText:@"¥23234.00"
                                  andTextColor:[UIColor whiteColor]
                                    andBgColor:[UIColor clearColor]
                                       andFont:SYSTEMFONT(14)
                              andTextAlignment:NSTextAlignmentRight];
        
        _degree = [UILabel createLabelWithFrame:VIEWFRAME(15, 0, 150, 53)                                                    andText:@"(99成新)"
                                  andTextColor:[UIColor whiteColor]
                                    andBgColor:[UIColor clearColor]
                                       andFont:SYSTEMFONT(14)
                              andTextAlignment:NSTextAlignmentLeft];

        
    
        [self addSubview:_view];
        [_view addSubview:label];
        [_view addSubview:_title];
        [_view addSubview:_category];
        [_view addSubview:_price];
        [_view addSubview:_degree];
        
        [_view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(15);
            make.right.equalTo(self.mas_right).offset(-15);
            make.top.equalTo(self.mas_top).offset(0);
            make.bottom.equalTo(self.mas_bottom).offset(-10);
        }];
        
        [_title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_view.mas_left).offset(15);
            make.top.equalTo(_view.mas_top).offset(15);
            make.size.mas_equalTo(CGSizeMake(200, 15));
        }];
        
        [_category mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_view.mas_left).offset(15);
            make.top.equalTo(_title.mas_bottom).offset(5);
            make.size.mas_equalTo(CGSizeMake(200, 15));
        }];
        
        [_degree mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_view.mas_left).offset(15);
            make.top.equalTo(_category.mas_bottom).offset(5);
            make.size.mas_equalTo(CGSizeMake(200, 15));
        }];
        
        [_price mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_degree);
            make.right.equalTo(_view.mas_right).offset(-15);
            make.size.mas_equalTo(CGSizeMake(150, 15));
        }];

        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_title);
            make.right.equalTo(_view.mas_right).offset(-15);
            make.size.mas_equalTo(CGSizeMake(150, 15));
        }];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [_view addGestureRecognizer:tap];
        
    }
    return  self;
}


-(void)setModel:(id)model
{
    NSArray *array =  [[NSArray alloc] initWithObjects:@"99成新（未使用）",@"98成新",@"95成新",@"9成新",@"85成新",@"8成新", nil];
    BusinessModel *_model = model;
    _title.text = _model.name;
    _category.text = _model.category[@"name"];
    NSInteger i = [_model.condition integerValue];
    _degree.text = [NSString stringWithFormat:@"(%@)",array[i]];
    CGFloat k = [_model.advancePrice floatValue]/100;
    _price.text = [NSString stringWithFormat:@"¥%.2f",k];
    
}


@end
