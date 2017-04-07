//
//  BussinesOrderCell.m
//  SXK
//
//  Created by 杨伟康 on 2017/4/5.
//  Copyright © 2017年 ywk. All rights reserved.
//

#import "BussinesOrderCell.h"
#import "BrandDetailModel.h"
@implementation BussinesOrderCell{
    UIImageView *_headImageView;
    UILabel *_title;
    UILabel *_content;
    UILabel *_price;
    UILabel *_priceTitle;
    UILabel *_marketPrice;
    UILabel *_time;
    NSInteger _index;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _headImageView = [[UIImageView alloc] init];
        _headImageView.image = [UIImage imageNamed:@"20141212145127_VLcnU"];
        
        _title = [UILabel createLabelWithFrame:VIEWFRAME(15, 0, 150, 53)                                                 andText:@"N1 PRADA/普拉达 手提包"
                                  andTextColor:[UIColor blackColor]
                                    andBgColor:[UIColor clearColor]
                                       andFont:SYSTEMFONT(13)
                              andTextAlignment:NSTextAlignmentLeft];
        
        _content = [UILabel createLabelWithFrame:VIEWFRAME(150, 60, 100, 50)                                                 andText:@"95新 经典款 办公休闲均可"
                                    andTextColor:APP_COLOR_GRAY_Font
                                      andBgColor:[UIColor clearColor]
                                         andFont:SYSTEMFONT(13)
                                andTextAlignment:NSTextAlignmentLeft];
        
        _priceTitle = [UILabel createLabelWithFrame:VIEWFRAME(150, 60, 100, 50)                                                 andText:@"市场价:"
                                       andTextColor:[UIColor blackColor]
                                         andBgColor:[UIColor clearColor]
                                            andFont:SYSTEMFONT(13)
                                   andTextAlignment:NSTextAlignmentLeft];
        
        _price = [UILabel createLabelWithFrame:VIEWFRAME(150, 60, 100, 50)                                                 andText:@"¥1500"
                                  andTextColor:APP_COLOR_GREEN
                                    andBgColor:[UIColor clearColor]
                                       andFont:SYSTEMFONT(13)
                              andTextAlignment:NSTextAlignmentLeft];
        
        _marketPrice = [UILabel createLabelWithFrame:VIEWFRAME(150, 60, 100, 50)                                                 andText:@"市场价 ¥3456.77"
                                        andTextColor:[UIColor blackColor]
                                          andBgColor:[UIColor clearColor]
                                             andFont:SYSTEMFONT(13)
                                    andTextAlignment:NSTextAlignmentLeft];
        
        _time = [UILabel createLabelWithFrame:VIEWFRAME(150, 60, 100, 50)                                                 andText:@"选择租期:"
                                 andTextColor:[UIColor blackColor]
                                   andBgColor:[UIColor clearColor]
                                      andFont:SYSTEMFONT(13)
                             andTextAlignment:NSTextAlignmentLeft];
        
        
        _content.numberOfLines = 0;
        [_content sizeToFit];
        
        
        
        [self addSubview:_headImageView];
        [self addSubview:_title];
        [self addSubview:_content];
        [self addSubview:_price];
        [self addSubview:_priceTitle];
        [self addSubview:_marketPrice];
//        [self addSubview:_time];
        

        
        
        [_headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(15);
            make.top.equalTo(self.mas_top).offset(24);
            //            make.bottom.equalTo(self.mas_bottom).offset(-33);
            make.size.mas_equalTo(CGSizeMake(100, 100));
        }];
        
        [_title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_headImageView.mas_right).offset(10);
            make.top.equalTo(self.mas_top).offset(24);
            make.right.equalTo(self.mas_right).offset(-25);
            //            make.size.mas_equalTo(CGSizeMake(100, 14));
            make.height.mas_equalTo(15);
        }];
        
        [_content mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_headImageView.mas_right).offset(10);
            make.top.equalTo(_title.mas_bottom).offset(5);
            make.right.equalTo(self.mas_right).offset(-25);
            make.height.mas_equalTo(@(15));
        }];
        
        [_priceTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_headImageView.mas_right).offset(10);
            make.top.equalTo(_content.mas_bottom).offset(5);
            make.size.mas_equalTo(CGSizeMake(60, 15));
        }];
        
        [_price mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_priceTitle.mas_right).offset(5);
            make.top.equalTo(_content.mas_bottom).offset(5);
            make.right.equalTo(self.mas_right).offset(-25);
            make.height.mas_equalTo(@(15));
            //            make.size.mas_equalTo(CGSizeMake(100, 13));
        }];
        
        [_marketPrice mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_headImageView.mas_right).offset(10);
            make.top.equalTo(_priceTitle.mas_bottom).offset(5);
            make.height.mas_equalTo(@(13));
            make.right.equalTo(self.mas_right).offset(-25);
            //            make.size.mas_equalTo(CGSizeMake(150, 13));
        }];
        
//        [_time mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.right.equalTo(self.mas_right).offset(-25);
//            make.top.equalTo(_marketPrice.mas_bottom).offset(5);
//            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 150, 13));
//        }];
        
//        NSArray *array = @[@"3天",@"7天",@"15天",@"25天"];
//        
//        for (int i = 0; i < 4; i++) {
//            
//            UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
//            [btn setTitle:array[i] forState:UIControlStateNormal];
//            btn.titleLabel.font = SYSTEMFONT(13);
//            btn.frame = VIEWFRAME(125 + 47 * i , 124, 32, 32);
//            
//            if (i == 0) {
//                [btn setTitleColor:APP_COLOR_GREEN forState:UIControlStateNormal];
//                ViewBorder(btn, 0.5, APP_COLOR_GREEN);
//            }else{
//                [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//                ViewBorder(btn, 0.5, APP_COLOR_GRAY_Font);
//            }
//            btn.tag = i+1;
//            [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
//            [self addSubview:btn];
//            
//        }
        
        _index = 1;
    }
    return  self;
}

-(void)setModel:(id)model
{
    BrandDetailModel *_model = model;
    _title.text = _model.name;
    
//    NSArray *array = [[NSArray alloc] initWithObjects:@"99成新（未使用）",@"98成新",@"95成新",@"9成新",@"85成新",@"8成新", nil];
    _content.text = [NSString stringWithFormat:@"%@",_model.description1];
    
    _price.text = [NSString stringWithFormat:@"%.2f元/天",[_model.marketPrice floatValue]/100];
    _marketPrice.text = [NSString stringWithFormat:@"售价:¥%.2f",[_model.sellingPrice floatValue] /100];
    [_headImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",APP_BASEIMG,_model.imgList[0]]]];
}

-(void)btnAction:(UIButton *)sender
{
    if (_index != sender.tag) {
        UIButton *btn = (UIButton *)[self viewWithTag:_index];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        ViewBorder(btn, 0.5, APP_COLOR_GRAY_Font);
        [sender setTitleColor:APP_COLOR_GREEN forState:UIControlStateNormal];
        ViewBorder(sender, 0.5,APP_COLOR_GREEN);
        _index = sender.tag;
        
        if ([_delegate respondsToSelector:@selector(returnDay:)]) { // 如果协议响应了sendValue:方法
            [_delegate returnDay:sender.tag]; // 通知执行协议方法
        }
        
    }
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
