//
//  MaintainCell.m
//  SXK
//
//  Created by 杨伟康 on 2016/12/21.
//  Copyright © 2016年 ywk. All rights reserved.
//

#import "MaintainCell.h"
#import "MaintainCellModel.h"

@implementation MaintainCell{
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
            make.height.mas_equalTo(@(30));
        }];
        
        [_price mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_headImageView.mas_right).offset(10);
            make.top.equalTo(_content.mas_bottom).offset(5);
            make.right.equalTo(self.mas_right).offset(-25);
            make.height.mas_equalTo(@(13));
        }];

        
    }
    return  self;
}

-(void)setModel:(id)model
{
    MaintainCellModel *_model = model;
    [_headImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",APP_BASEIMG,_model.img]]];
    _title.text = _model.name;
    _content.text = _model.keyword;
    _price.text = [NSString stringWithFormat:@"¥%lld",[_model.price longLongValue]];
}


@end
