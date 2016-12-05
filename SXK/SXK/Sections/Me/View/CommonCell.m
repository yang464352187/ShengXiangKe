//
//  CommonCell.m
//  SXK
//
//  Created by 杨伟康 on 2016/11/30.
//  Copyright © 2016年 ywk. All rights reserved.
//

#import "CommonCell.h"

@implementation CommonCell{
    UIImageView *_headImage;
    UILabel *_title;
    UIView *_line;
    UIImageView *_back;

}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _headImage =[[UIImageView alloc] initWithFrame:VIEWFRAME(23, 15.5, 21, 21)];
        _headImage.image =[UIImage imageNamed:@"图层-10"];
        
        
        _title = [UILabel createLabelWithFrame:VIEWFRAME(51, 5.5, 100, 41)                                                 andText:@"微信支付"
                                  andTextColor:[UIColor blackColor]
                                    andBgColor:[UIColor clearColor]
                                       andFont:SYSTEMFONT(14)
                              andTextAlignment:NSTextAlignmentLeft];
        
        
        _line = [[UIView alloc] initWithFrame:VIEWFRAME(0, 53, SCREEN_WIDTH, 1)];
        _line.backgroundColor = [UIColor colorWithHexColorString:@"f7f7f7"];
        
        _back = [[UIImageView alloc] init];
        _back.image = [UIImage imageNamed:@"返回-"];

        [self addSubview:_line];
        [self addSubview:_title];
        [self addSubview:_headImage];
        [self addSubview:_back];
        
        [_back mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).offset(20);
            //            make.bottom.equalTo(self.mas_bottom).offset(-18);
            make.right.equalTo(self.mas_right).offset(-18);
            make.width.equalTo(@8);
            make.height.equalTo(@13);
        }];

    }
    return  self;
}

-(void)fillWithTitle:(NSString *)title
{
    _headImage.image = [UIImage imageNamed:title];
    _title.text = title;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
