//
//  MaintainCell1.m
//  SXK
//
//  Created by 杨伟康 on 2017/4/19.
//  Copyright © 2017年 ywk. All rights reserved.
//

#import "MaintainCell1.h"
#import "MaintainCellModel.h"
#import "BrandDetailModel.h"

@implementation MaintainCell1{
    UIImageView *_headImageView;
    UILabel *_title;
    UILabel *_content;
    UILabel *_price;
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
                                  andTextColor:APP_COLOR_GREEN
                                    andBgColor:[UIColor clearColor]
                                       andFont:SYSTEMFONT(13)
                              andTextAlignment:NSTextAlignmentLeft];
        
        _content.numberOfLines = 0;
        [_content sizeToFit];
        
        
        
        [self addSubview:_headImageView];
        [self addSubview:_title];
        [self addSubview:_content];
        [self addSubview:_price];
        
        UIView *deleteBgView = [UIView new];
        deleteBgView.backgroundColor = APP_COLOR_GREEN;
        [self addSubview:deleteBgView];
        
        UIButton *deleteBtn = [UIButton new];
        [deleteBtn setTitle:@"取消收藏" forState:UIControlStateNormal];
        deleteBtn.titleLabel.font = SYSTEMFONT(14);
        [deleteBgView addSubview:deleteBtn];
        
        [deleteBgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset([UIScreen mainScreen].bounds.size.width);
            make.top.equalTo(self.contentView);
            make.bottom.equalTo(self.contentView).offset(1);
            make.width.mas_equalTo(180);
        }];
        
        [deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.offset(80);
            make.top.equalTo(deleteBgView);
            make.bottom.equalTo(deleteBgView);
            make.left.equalTo(deleteBgView);
        }];
        
        
    }
    return  self;
}

-(void)setModel:(id)model
{
    MaintainCellModel *_model = model;
    [_headImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",APP_BASEIMG,_model.img]]];
    _title.text = _model.name;
    CGFloat height = [UILabel getHeightByWidth:(SCREEN_WIDTH - 150 - 15 -10 -25) title:_model.keyword font:SYSTEMFONT(11)];
    if (height > 26.5) {
        height = 26.5;
    }
    [self reSetSize:height];
    
    _content.text = _model.keyword;
    _price.text = [NSString stringWithFormat:@"¥%.2f",[_model.price floatValue] / 100];
}

-(void)setModel1:(id)model
{
    BrandDetailModel *_model = model;
    NSString *image = _model.imgList[0];
    [_headImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",APP_BASEIMG,image]]];
    _title.text = _model.name;
    CGFloat height = [UILabel getHeightByWidth:(SCREEN_WIDTH - 150 - 15 -10 -25) title:_model.keyword font:SYSTEMFONT(11)];
    if (height > 26.5) {
        height = 26.5;
    }
    [self reSetSize:height];
    
    _content.text = _model.keyword;
    _price.text = [NSString stringWithFormat:@"¥%lld",[_model.counterPrice longLongValue]];
}

-(void)reSetSize:(CGFloat)height
{
    
    [_headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(15);
        make.top.equalTo(self.mas_top).offset(20);
        make.bottom.equalTo(self.mas_bottom).offset(-20);
        make.width.mas_equalTo(150);
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
    
}

@end
