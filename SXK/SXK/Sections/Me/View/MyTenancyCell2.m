//
//  MyTenancyCell2.m
//  SXK
//
//  Created by 杨伟康 on 2016/12/26.
//  Copyright © 2016年 ywk. All rights reserved.
//

#import "MyTenancyCell2.h"
#import "MyRentModel.h"
@implementation MyTenancyCell2{
    UIImageView *_headImageView;
    UILabel *_title;
    UILabel *_content;
    UILabel *_price;
    UILabel *_priceTitle;
    UILabel *_marketPrice;
    UILabel *_orderNum;
//    UILabel *_backOrderNum;
    UIButton *_button;
    UIButton *_button1;
    NSNumber *_orderid;
    NSNumber *_rentid;
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
        _headImageView = [[UIImageView alloc] init];
        _headImageView.image = [UIImage imageNamed:@"20141212145127_VLcnU"];
        
        _title = [UILabel createLabelWithFrame:VIEWFRAME(15, 0, 150, 53)                                                 andText:@"专业腕表养护"
                                  andTextColor:[UIColor blackColor]
                                    andBgColor:[UIColor clearColor]
                                       andFont:SYSTEMFONT(14)
                              andTextAlignment:NSTextAlignmentLeft];
        
        _content = [UILabel createLabelWithFrame:VIEWFRAME(150, 60, 100, 50)                                                 andText:@"专业腕表养护阿斯利康的房间爱快乐圣诞节算开"
                                    andTextColor:APP_COLOR_GRAY_Font
                                      andBgColor:[UIColor clearColor]
                                         andFont:SYSTEMFONT(11)
                                andTextAlignment:NSTextAlignmentLeft];
        
        _priceTitle = [UILabel createLabelWithFrame:VIEWFRAME(150, 60, 100, 50)                                                 andText:@"租价"
                                       andTextColor:[UIColor blackColor]
                                         andBgColor:[UIColor clearColor]
                                            andFont:SYSTEMFONT(12)
                                   andTextAlignment:NSTextAlignmentLeft];
        
        _price = [UILabel createLabelWithFrame:VIEWFRAME(150, 60, 100, 50)                                                 andText:@"¥1500"
                                  andTextColor:APP_COLOR_GREEN
                                    andBgColor:[UIColor clearColor]
                                       andFont:SYSTEMFONT(12)
                              andTextAlignment:NSTextAlignmentLeft];
        
        _marketPrice = [UILabel createLabelWithFrame:VIEWFRAME(150, 60, 100, 50)                                                 andText:@"市场价 ¥3456.77"
                                        andTextColor:APP_COLOR_GREEN
                                          andBgColor:[UIColor clearColor]
                                             andFont:SYSTEMFONT(12)
                                    andTextAlignment:NSTextAlignmentLeft];
        
        _orderNum = [UILabel createLabelWithFrame:VIEWFRAME(150, 60, 100, 50)                                                 andText:@"单号 8231748971238947109"
                                     andTextColor:[UIColor blackColor]
                                       andBgColor:[UIColor clearColor]
                                          andFont:SYSTEMFONT(12)
                                 andTextAlignment:NSTextAlignmentLeft];
//        _backOrderNum = [UILabel createLabelWithFrame:VIEWFRAME(150, 60, 100, 50)                                                 andText:@"退回 8231748971238947109"
//                                         andTextColor:[UIColor blackColor]
//                                           andBgColor:[UIColor clearColor]
//                                              andFont:SYSTEMFONT(12)
//                                     andTextAlignment:NSTextAlignmentLeft];
        
        
        _content.numberOfLines = 0;
        [_content sizeToFit];
        
        _button = [UIButton buttonWithType:UIButtonTypeSystem];
        [_button setTitle:@"退回" forState:UIControlStateNormal];
        [_button setTitleColor:APP_COLOR_GREEN forState:UIControlStateNormal];
        [_button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        _button1 = [UIButton buttonWithType:UIButtonTypeSystem];
        [_button1 setTitle:@"购买" forState:UIControlStateNormal];
        [_button1 setTitleColor:APP_COLOR_GREEN forState:UIControlStateNormal];

        ViewBorderRadius(_button, 5, 0.5, APP_COLOR_GREEN);
        ViewBorderRadius(_button1, 5, 0.5, APP_COLOR_GREEN);
        
        [self addSubview:_headImageView];
        [self addSubview:_title];
        [self addSubview:_content];
        [self addSubview:_price];
        [self addSubview:_priceTitle];
        [self addSubview:_marketPrice];
        [self addSubview:_orderNum];
//        [self addSubview:_backOrderNum];
        [self addSubview:_button];
//        [self addSubview:_button1];

        
        [_headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(15);
            make.top.equalTo(self.mas_top).offset(20);
            //            make.bottom.equalTo(self.mas_bottom).offset(-33);
            make.size.mas_equalTo(CGSizeMake(150, 100));
        }];
        
        [_title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_headImageView.mas_right).offset(10);
            make.top.equalTo(self.mas_top).offset(24);
            make.right.equalTo(self.mas_right).offset(-25);
            //            make.size.mas_equalTo(CGSizeMake(100, 14));
            make.height.mas_equalTo(14);
        }];
        
        [_content mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_headImageView.mas_right).offset(10);
            make.top.equalTo(_title.mas_bottom).offset(5);
            make.right.equalTo(self.mas_right).offset(-25);
            make.height.mas_equalTo(@(30));
        }];
        
        [_priceTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_headImageView.mas_right).offset(10);
            make.top.equalTo(_content.mas_bottom).offset(5);
            make.size.mas_equalTo(CGSizeMake(26, 13));
        }];
        
        [_price mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_priceTitle.mas_right).offset(5);
            make.top.equalTo(_content.mas_bottom).offset(5);
            make.right.equalTo(self.mas_right).offset(-25);
            make.height.mas_equalTo(@(13));
            //            make.size.mas_equalTo(CGSizeMake(100, 13));
        }];
        
        [_marketPrice mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_headImageView.mas_right).offset(10);
            make.top.equalTo(_priceTitle.mas_bottom).offset(5);
            make.height.mas_equalTo(@(13));
            make.right.equalTo(self.mas_right).offset(-25);
            //            make.size.mas_equalTo(CGSizeMake(150, 13));
        }];
        
        [_orderNum mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).offset(-25);
            make.top.equalTo(_marketPrice.mas_bottom).offset(5);
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 200, 13));
        }];
        
//        [_backOrderNum mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.right.equalTo(self.mas_right).offset(-25);
//            make.top.equalTo(_orderNum.mas_bottom).offset(5);
//            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 200, 13));
//        }];
    
        [_button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).offset(-20);
            make.bottom.equalTo(self.mas_bottom).offset(-15);
            make.size.mas_equalTo(CGSizeMake(92, 26));
        }];
        
//        [_button1 mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.right.equalTo(_button.mas_left).offset(-15);
//            make.bottom.equalTo(self.mas_bottom).offset(-15);
//            make.size.mas_equalTo(CGSizeMake(92, 26));
//        }];
        
    }
    return  self;
}
-(void)setModel:(id)model
{
    MyRentModel *_model = model;
    _title.text = _model.rent[@"name"];
    _content.text = _model.rent[@"keyword"];
    _price.text = [NSString stringWithFormat:@"¥%.2f",[_model.rent[@"rentPrice"] floatValue] / 100];
    [_headImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",APP_BASEIMG,_model.rent[@"imgList"][0]]] placeholderImage:[UIImage imageNamed:@"占位-0"]];
    _marketPrice.text = [NSString stringWithFormat:@"市场价 ¥%.2f",[_model.rent[@"marketPrice"] floatValue] / 100];
    _orderNum.text = [NSString stringWithFormat:@"单号 %@",_model.oddNumber];
    _orderid = _model.orderid;
    _rentid = _model.rentid;
}


-(void)buttonClick:(UIButton *)sender
{
    NSDictionary *dic = @{
                          @"orderid":_orderid,
                          @"rentid":_rentid,
                          };
    [[PushManager sharedManager] pushToVCWithClassName:@"OrderReturnVC" info:dic];
}


@end
