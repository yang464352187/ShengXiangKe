//
//  BusinessOrderDetail3.m
//  SXK
//
//  Created by 杨伟康 on 2017/4/20.
//  Copyright © 2017年 ywk. All rights reserved.
//

#import "BusinessOrderDetail3.h"
#import "OrderDetailModel.h"

@implementation BusinessOrderDetail3{
    UIImageView *_headImageView;
    UILabel *_title;
    UILabel *_content;
    UILabel *_price;
    UILabel *_priceTitle;
    UILabel *_marketPrice;
    UILabel *_time;
    UILabel *_time1;
    NSInteger _index;
    
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _headImageView = [[UIImageView alloc] init];
        _headImageView.image = [UIImage imageNamed:@"20141212145127_VLcnU"];
        
        _title = [UILabel createLabelWithFrame:VIEWFRAME(15, 0, 150, 53)                                                 andText:@""
                                  andTextColor:[UIColor blackColor]
                                    andBgColor:[UIColor clearColor]
                                       andFont:SYSTEMFONT(13)
                              andTextAlignment:NSTextAlignmentLeft];
        
        _content = [UILabel createLabelWithFrame:VIEWFRAME(150, 60, 100, 50)                                                 andText:@""
                                    andTextColor:APP_COLOR_GRAY_Font
                                      andBgColor:[UIColor clearColor]
                                         andFont:SYSTEMFONT(13)
                                andTextAlignment:NSTextAlignmentLeft];
        
        _priceTitle = [UILabel createLabelWithFrame:VIEWFRAME(150, 60, 100, 50)                                                 andText:@"市场价:"
                                       andTextColor:[UIColor blackColor]
                                         andBgColor:[UIColor clearColor]
                                            andFont:SYSTEMFONT(13)
                                   andTextAlignment:NSTextAlignmentLeft];
        
        _price = [UILabel createLabelWithFrame:VIEWFRAME(150, 60, 100, 50)                                                 andText:@""
                                  andTextColor:APP_COLOR_GREEN
                                    andBgColor:[UIColor clearColor]
                                       andFont:SYSTEMFONT(13)
                              andTextAlignment:NSTextAlignmentLeft];
        
        _marketPrice = [UILabel createLabelWithFrame:VIEWFRAME(150, 60, 100, 50)                                                 andText:@""
                                        andTextColor:[UIColor blackColor]
                                          andBgColor:[UIColor clearColor]
                                             andFont:SYSTEMFONT(13)
                                    andTextAlignment:NSTextAlignmentLeft];
        
        _time = [UILabel createLabelWithFrame:VIEWFRAME(150, 60, 100, 50)                                                 andText:@""
                                 andTextColor:[UIColor blackColor]
                                   andBgColor:[UIColor clearColor]
                                      andFont:SYSTEMFONT(13)
                             andTextAlignment:NSTextAlignmentLeft];
        
        _time1 = [UILabel createLabelWithFrame:VIEWFRAME(150, 60, 100, 50)                                                 andText:@""
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
        [self addSubview:_priceTitle];
        [self addSubview:_marketPrice];
        [self addSubview:_time];
        [self addSubview:_time1];
        
        
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
        
        [_time mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_headImageView.mas_right).offset(10);
            make.top.equalTo(_marketPrice.mas_bottom).offset(5);
            make.size.mas_equalTo(CGSizeMake(38, 13));
        }];
        
        [_time1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).offset(-25);
            make.centerY.equalTo(_time);
            make.left.equalTo(_time.mas_right).offset(0);
            make.height.mas_equalTo(@(15));
        }];
        
        
    }
    return  self;
}

-(void)setModel:(id)model
{
    OrderDetailModel *_model = model;
    _title.text = _model.purchase[@"name"];
    
//    NSArray *array = [[NSArray alloc] initWithObjects:@"99成新（未使用）",@"98成新",@"95成新",@"9成新",@"85成新",@"8成新", nil];
    _content.text = [NSString stringWithFormat:@"%@",_model.purchase[@"description"]];
//    _time1.text = _model.tenancy[@"name"];
    //    NSLog(@"----------%@",_model.tenancy[@"name"]);
    _price.text = [NSString stringWithFormat:@"%.2f元/天",[_model.purchase[@"marketPrice"] floatValue]/100];
    _marketPrice.text = [NSString stringWithFormat:@"售价:¥%.2f",[_model.purchase[@"advancePrice"] floatValue] /100];
    
    
    [_headImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",APP_BASEIMG,_model.purchase[@"imgList"][0]]]];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
