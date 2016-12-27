//
//  TradeCell.m
//  SXK
//
//  Created by 杨伟康 on 2016/12/22.
//  Copyright © 2016年 ywk. All rights reserved.
//

#import "TradeCell.h"

@implementation TradeCell{
    UIImageView *_image;
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
        _image = [[UIImageView alloc] init];
        _image.image = [UIImage imageNamed:@"背景@2x二"];
        _image.contentMode = UIViewContentModeScaleAspectFit;
        _image.clipsToBounds = YES;
        [self addSubview:_image];
        
        [_image mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).offset(0);
            make.bottom.equalTo(self.mas_bottom).offset(0);
            make.left.equalTo(self.mas_left).offset(0);
            make.right.equalTo(self.mas_right).offset(0);
        }];
    }
    return  self;
}

@end
