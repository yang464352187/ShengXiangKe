//
//  ConsigneeCell.m
//  SXK
//
//  Created by 杨伟康 on 2016/11/29.
//  Copyright © 2016年 ywk. All rights reserved.
//

#import "ConsigneeCell.h"

@implementation ConsigneeCell{
    UILabel *_title;
    UIView *_line;
    UIImageView *_back;

}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _title = [UILabel createLabelWithFrame:VIEWFRAME(15, 0, 100, 53)                                                 andText:@"请选择收货地址"
                                  andTextColor:[UIColor colorWithHexColorString:@"a1a1a1"]
                                    andBgColor:[UIColor clearColor]
                                       andFont:SYSTEMFONT(14)
                              andTextAlignment:NSTextAlignmentLeft];
        
        _line = [[UIView alloc] initWithFrame:VIEWFRAME(0, 53, SCREEN_WIDTH, 1)];
        _line.backgroundColor = [UIColor colorWithHexColorString:@"f7f7f7"];
        
        
        _back = [[UIImageView alloc] init];
        _back.image = [UIImage imageNamed:@"返回-"];

        [self addSubview:_title];
        [self addSubview:_line];
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


@end
