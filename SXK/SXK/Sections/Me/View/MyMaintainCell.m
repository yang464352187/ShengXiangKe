
//
//  MyMaintainCell.m
//  SXK
//
//  Created by 杨伟康 on 2017/2/4.
//  Copyright © 2017年 ywk. All rights reserved.
//

#import "MyMaintainCell.h"
#import "MyMaintainModel.h"
#import "StringAttributeHelper.h"
#import "PopView1.h"

@interface MyMaintainCell ()<PopView1Delegate>

@end


@implementation MyMaintainCell{
    UIImageView *_headImageView;
    UILabel *_title;
    UILabel *_content;
    UILabel *_price;
    UIButton *_button;
    PopView1 *_popView;
    NSInteger _orderid;

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
        
        _content = [UILabel createLabelWithFrame:VIEWFRAME(150, 60, 100, 50)                                                 andText:@"专业腕表养护打阿萨德法师打发的说法asdf算开"
                                    andTextColor:APP_COLOR_GRAY_Font
                                      andBgColor:[UIColor clearColor]
                                         andFont:SYSTEMFONT(11)
                                andTextAlignment:NSTextAlignmentLeft];
        
        _price = [UILabel createLabelWithFrame:VIEWFRAME(150, 60, 100, 50)                                                 andText:@"¥1500"
                                  andTextColor:[UIColor blackColor]
                                    andBgColor:[UIColor clearColor]
                                       andFont:SYSTEMFONT(13)
                              andTextAlignment:NSTextAlignmentLeft];
        
        _popView =  [[PopView1 alloc] initWithFrame:VIEWFRAME(0, 0, SCREEN_WIDTH, SCREEN_HIGHT)];
        _popView.delegate = self;

        
        _content.numberOfLines = 0;
        [_content sizeToFit];
        
        _button = [UIButton buttonWithType:UIButtonTypeSystem];
        [_button setTitle:@"确认完成" forState:UIControlStateNormal];
        [_button setTitleColor:APP_COLOR_GREEN forState:UIControlStateNormal];
        [_button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        ViewBorderRadius(_button, 5, 0.5, APP_COLOR_GREEN);

        
        [self addSubview:_headImageView];
        [self addSubview:_title];
        [self addSubview:_content];
        [self addSubview:_price];
        [self addSubview:_button];
        
        
    }
    return  self;
}

-(void)setModel:(id)model
{
    MyMaintainModel *_model = model;
    [_headImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",APP_BASEIMG,_model.maintain[@"img"]]]];
    _title.text = _model.maintain[@"name"];
    CGFloat height = [UILabel getHeightByWidth:(SCREEN_WIDTH - 150 - 15 -10 -25) title:_model.maintain[@"keyword"] font:SYSTEMFONT(11)];
    if (height > 26.5) {
        height = 26.5;
    }
    [self reSetSize:height];
    NSString *price = [NSString stringWithFormat:@"租价 ¥%.2f",[_model.maintain[@"price"] floatValue] / 100];
    
    _content.text = _model.maintain[@"keyword"];
    
    ForegroundColorAttribute *fullColor = [ForegroundColorAttribute new];
    fullColor.color                     = APP_COLOR_GREEN;
    fullColor.effectRange               = NSMakeRange(3, price.length -3 );
    

     _price.attributedText = [price mutableAttributedStringWithStringAttributes:@[fullColor]];
    _orderid = [_model.orderid integerValue];
}


-(void)reSetSize:(CGFloat)height
{
    
    [_headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(15);
        make.top.equalTo(self.mas_top).offset(20);
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(98);
    }];
    
    [_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_headImageView.mas_right).offset(10);
        make.top.equalTo(self.mas_top).offset(40);
        make.right.equalTo(self.mas_right).offset(-25);
        make.height.mas_equalTo(@(14));
    }];
    
    [_content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_headImageView.mas_right).offset(10);
        make.top.equalTo(_title.mas_bottom).offset(5);
        make.right.equalTo(self.mas_right).offset(-25);
        make.height.mas_equalTo(@(height));
    }];
    
    [_price mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_headImageView.mas_right).offset(10);
        make.top.equalTo(_content.mas_bottom).offset(5);
        make.right.equalTo(self.mas_right).offset(-25);
        make.height.mas_equalTo(@(13));
    }];
    
    [_button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-20);
        make.bottom.equalTo(self.mas_bottom).offset(-15);
        make.size.mas_equalTo(CGSizeMake(92, 26));
    }];

    
}

-(void)buttonAction:(UIButton *)sender
{
    [_popView changeTitle:@"是否确认完成?" andIdex:_orderid];
    [_popView show];

}

-(void)success
{
    if ([self.delegate respondsToSelector:@selector(returnIndex:)]) {
        [self.delegate returnIndex:self.index];
    }
}





@end
