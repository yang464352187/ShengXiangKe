//
//  MyPromulgateCell2.m
//  SXK
//
//  Created by 杨伟康 on 2017/1/19.
//  Copyright © 2017年 ywk. All rights reserved.
//

#import "MyPromulgateCell2.h"
#import "MyPromulgateModel.h"
#import "PopView1.h"
#import "PopView.h"
@interface MyPromulgateCell2 ()<PopView1Delegate, PopViewDelegate>

@end

@implementation MyPromulgateCell2{
    UIImageView *_headImageView;
    UILabel *_title;
    UILabel *_content;
    UILabel *_price;
    UILabel *_priceTitle;
    UILabel *_marketPrice;
    UILabel *_orderNum;
    UILabel *_order;
    UIButton *_button;
    UIButton *_button1;
//    UITextField *_text;
    UIView *_line;
    PopView1 *_popView;
    NSInteger _rentid;
    PopView *_pop;
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
                                        andTextColor:[UIColor blackColor]
                                          andBgColor:[UIColor clearColor]
                                             andFont:SYSTEMFONT(12)
                                    andTextAlignment:NSTextAlignmentLeft];
        
        _orderNum = [UILabel createLabelWithFrame:VIEWFRAME(150, 60, 100, 50)                                                 andText:@"单号:"
                                        andTextColor:[UIColor blackColor]
                                          andBgColor:[UIColor clearColor]
                                             andFont:SYSTEMFONT(12)
                                    andTextAlignment:NSTextAlignmentLeft];
        
        _order = [UILabel createLabelWithFrame:VIEWFRAME(150, 60, 100, 50)                                                 andText:@""
                                     andTextColor:[UIColor blackColor]
                                       andBgColor:[UIColor clearColor]
                                          andFont:SYSTEMFONT(12)
                                 andTextAlignment:NSTextAlignmentLeft];


//        _text = [[UITextField alloc] initWithFrame:CGRectZero];
//        _text.placeholder = @"请输入单号";
//        _text.font = SYSTEMFONT(14);
//        [_text setTextColor:APP_COLOR_GRAY_Font];
        
//        _line = [[UIView alloc] initWithFrame:CGRectZero];
//        _line.backgroundColor = [UIColor blackColor];
        
        _pop =  [[PopView alloc] initWithFrame:VIEWFRAME(0, 0, SCREEN_WIDTH, SCREEN_HIGHT)];
        _pop.delegate =self;

        
        _content.numberOfLines = 0;
        [_content sizeToFit];
        
        _popView =  [[PopView1 alloc] initWithFrame:VIEWFRAME(0, 0, SCREEN_WIDTH, SCREEN_HIGHT)];
        _popView.delegate = self;

        
        _button = [UIButton buttonWithType:UIButtonTypeSystem];
        [_button setTitle:@"确认回收" forState:UIControlStateNormal];
        [_button addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [_button setTitleColor:APP_COLOR_GREEN forState:UIControlStateNormal];
        ViewBorderRadius(_button, 5, 0.5, APP_COLOR_GREEN);
        
        _button1 = [UIButton buttonWithType:UIButtonTypeSystem];
        [_button1 setTitle:@"输入单号" forState:UIControlStateNormal];
        [_button1 addTarget:self action:@selector(btnAction1:) forControlEvents:UIControlEventTouchUpInside];
        [_button1 setTitleColor:APP_COLOR_GREEN forState:UIControlStateNormal];
        ViewBorderRadius(_button1, 5, 0.5, APP_COLOR_GREEN);

        
        [self addSubview:_headImageView];
        [self addSubview:_title];
        [self addSubview:_content];
        [self addSubview:_price];
        [self addSubview:_priceTitle];
        [self addSubview:_marketPrice];
        [self addSubview:_button];
        [self addSubview:_button1];
        [self addSubview:_orderNum];
        [self addSubview:_order];
//        [self addSubview:_line];
    }
    return  self;
}


-(void)setModel:(id)model
{
    MyPromulgateModel *_model = model;
    
    _title.text = _model.name;
    _content.text = _model.keyword;
    CGFloat height = [UILabel getHeightByWidth:(SCREEN_WIDTH - 150 - 15 -10 -25) title:_model.keyword font:SYSTEMFONT(11)];
    if (height > 26.5) {
        height = 26.5;
    }
    [self reSetSize:height];
    
    _price.text = [NSString stringWithFormat:@"%lld",[_model.rentPrice longLongValue]];
    _marketPrice.text = [NSString stringWithFormat:@"市场价:%lld",[_model.marketPrice longLongValue]];
    _rentid = [_model.rentid integerValue];
    _order.text = _model.oddNumber;
    [_headImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",APP_BASEIMG,_model.imgList[0]]] placeholderImage:[UIImage imageNamed:@"占位-0"]];

}
-(void)reSetSize:(CGFloat)height
{
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
        make.height.mas_equalTo(@(height));
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
        make.left.equalTo(_headImageView.mas_right).offset(10);
        make.top.equalTo(_marketPrice.mas_bottom).offset(5);
        make.size.mas_equalTo(CGSizeMake(36, 15));
    }];
    
    [_order mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_orderNum);
        make.left.equalTo(_orderNum.mas_right).offset(0);
        make.right.equalTo(self.mas_right).offset(-20);
        make.height.mas_equalTo(14);
    }];
    
//    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(_text.mas_bottom).offset(0);
//        make.left.equalTo(_orderNum.mas_right).offset(0);
//        make.right.equalTo(self.mas_right).offset(-20);
//        make.height.mas_equalTo(0.5);
//    }];
    
    [_button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-20);
        make.bottom.equalTo(self.mas_bottom).offset(-15);
        make.size.mas_equalTo(CGSizeMake(92, 26));
    }];
    
    [_button1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_button.mas_left).offset(-20);
        make.bottom.equalTo(self.mas_bottom).offset(-15);
        make.size.mas_equalTo(CGSizeMake(92, 26));
    }];

    
}

-(void)reName:(NSString *)title
{
    [_button setTitle:title forState:UIControlStateNormal];
    
}

-(void)btnAction:(UIButton *)sender
{
//    [_text resignFirstResponder];
    [_popView changeTitle:@"是否确认回收?" andIdex:_rentid];
    [_popView show];

}

-(void)btnAction1:(UIButton *)sender
{
    [_pop fillWithTitle:@"修改单号"];
    _pop.rentid = _rentid;
    [_pop show];

}

-(void)sendInfo:(NSString *)info andType:(NSInteger)type
{
    _order.text = info;
}

-(void)success
{
    if ([self.delegate respondsToSelector:@selector(returnIndex:)]) {
        [self.delegate returnIndex:self.index];
    }
}


@end
