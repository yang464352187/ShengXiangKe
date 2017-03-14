//
//  MyAppraiseCell1.m
//  SXK
//
//  Created by 杨伟康 on 2017/2/24.
//  Copyright © 2017年 ywk. All rights reserved.
//

#import "MyAppraiseCell1.h"
#import "MyAppraiseModel.h"
@implementation MyAppraiseCell1
{
    UIImageView *_headImageView;
    UILabel *_title;
    UILabel *_content;
    UIButton *_button;
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
        
        _content = [UILabel createLabelWithFrame:VIEWFRAME(150, 60, 100, 50)                                                 andText:@"目前状态:已完成"
                                    andTextColor:APP_COLOR_GRAY_Font
                                      andBgColor:[UIColor clearColor]
                                         andFont:SYSTEMFONT(14)
                                andTextAlignment:NSTextAlignmentLeft];
            
        
        _content.numberOfLines = 0;
        [_content sizeToFit];
        
        _button = [UIButton buttonWithType:UIButtonTypeSystem];
        [_button setTitle:@"已完成" forState:UIControlStateNormal];
        [_button setTitleColor:APP_COLOR_GREEN forState:UIControlStateNormal];
//        [_button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        ViewBorderRadius(_button, 5, 0.5, APP_COLOR_GREEN);
        
        
        [self addSubview:_headImageView];
        [self addSubview:_title];
        [self addSubview:_content];
        [self addSubview:_button];
        
        [_headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(15);
            make.top.equalTo(self.mas_top).offset(20);
            make.width.mas_equalTo(118);
            make.height.mas_equalTo(98);
        }];
        
        [_title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_headImageView.mas_right).offset(10);
            make.bottom.equalTo(self.mas_centerY).offset(-10);
            make.right.equalTo(self.mas_right).offset(-25);
            make.height.mas_equalTo(@(14));
        }];
        
        
        [_content mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_headImageView.mas_right).offset(10);
            make.bottom.equalTo(self.mas_centerY).offset(10);
            make.right.equalTo(self.mas_right).offset(-25);
            make.height.mas_equalTo(@(14));
        }];
        
        
        [_button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).offset(-20);
            make.bottom.equalTo(self.mas_bottom).offset(-15);
            make.size.mas_equalTo(CGSizeMake(92, 26));
        }];
        
        
    }
    return  self;
}

-(void)setModel:(id)model
{
    MyAppraiseModel *_model = model;
    _title.text = [NSString stringWithFormat:@"订单号:%@",_model.orderNo];
    [_headImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",APP_BASEIMG,_model.setup[@"campaign"]]]];
    _orderid = [_model.orderid integerValue];
    
}

@end
