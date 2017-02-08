//
//  MyPromulgateCell.m
//  SXK
//
//  Created by 杨伟康 on 2016/12/26.
//  Copyright © 2016年 ywk. All rights reserved.
//

#import "MyPromulgateCell.h"
#import "MyPromulgateModel.h"
#import "PopView1.h"

@interface MyPromulgateCell()<PopView1Delegate>


@end
@implementation MyPromulgateCell{
    UIImageView *_headImageView;
    UILabel *_title;
    UILabel *_content;
    UILabel *_price;
    UILabel *_priceTitle;
    UILabel *_marketPrice;
    UIButton *_button;
    NSInteger _rentid;
    PopView1 *_popView;
    NSString *_title1;

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
        
        _content.numberOfLines = 0;
        [_content sizeToFit];
        
        _button = [UIButton buttonWithType:UIButtonTypeSystem];
        [_button setTitle:@"下架" forState:UIControlStateNormal];
        [_button setTitleColor:APP_COLOR_GREEN forState:UIControlStateNormal];
        [_button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        ViewBorderRadius(_button, 5, 0.5, APP_COLOR_GREEN);
        
        _popView =  [[PopView1 alloc] initWithFrame:VIEWFRAME(0, 0, SCREEN_WIDTH, SCREEN_HIGHT)];
        _popView.delegate = self;
        
        [self addSubview:_headImageView];
        [self addSubview:_title];
        [self addSubview:_content];
        [self addSubview:_price];
        [self addSubview:_priceTitle];
        [self addSubview:_marketPrice];
        [self addSubview:_button];
        
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
    [_headImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",APP_BASEIMG,_model.imgList[0]]] placeholderImage:[UIImage imageNamed:@"占位-0"]];
    _rentid = [_model.rentid integerValue];

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
    
    [_button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-20);
        make.bottom.equalTo(self.mas_bottom).offset(-15);
        make.size.mas_equalTo(CGSizeMake(92, 26));
    }];

}

-(void)reName:(NSString *)title
{
    [_button setTitle:title forState:UIControlStateNormal];
    _title1 = title;
}

-(void)buttonAction:(UIButton *)sender
{
    if ([_title1 isEqualToString:@"删除"]) {
        [_popView changeTitle:@"是否删除订单?" andIdex:_rentid];
    }else{
        [_popView changeTitle:@"是否下架商品?" andIdex:_rentid];
    }
    [_popView show];

}

-(void)success
{
    if ([self.delegate respondsToSelector:@selector(returnIndex:)]) {
        [self.delegate returnIndex:self.index];
    }
}

@end
