//
//  NoDataView.m
//  YunTShop
//
//  Created by sfgod on 16/5/31.
//  Copyright © 2016年 sufan. All rights reserved.
//

#import "NoDataView.h"

@implementation NoDataView{
    UILabel *_titleLabel;
    UIImageView *_logo;
}

- (instancetype)initWithTitle:(NSString *)title{
    if (self = [super initWithFrame:APP_BOUNDS]) {
        
        self.backgroundColor = APP_COLOR_BASE_BACKGROUND;
        
        _logo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"BaseLogo"]];
        
        _titleLabel = [UILabel createLabelWithFrame:VIEWFRAME(0, 25, SCREEN_WIDTH, 25)
                                            andText:title
                                       andTextColor:APP_COLOR_GRAY_666666
                                         andBgColor:[UIColor clearColor]
                                            andFont:SYSTEMFONT(14)
                                   andTextAlignment:NSTextAlignmentCenter];
        
        [self addSubview:_logo];
        [self addSubview:_titleLabel];
        
        [_logo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(110, 130));
            make.centerX.equalTo(self.mas_centerX);
            make.centerY.equalTo(self.mas_centerY).offset(-75);
        }];
        
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_offset(20);
            make.top.equalTo(_logo.mas_bottom).offset(20);
            make.centerX.equalTo(_logo.mas_centerX);
        }];
    }
    return self;
}

- (instancetype)init{
    return [self initWithTitle:@""];
}


- (void)setTitle:(NSString *)title{
    _titleLabel.text = title;
}

@end
