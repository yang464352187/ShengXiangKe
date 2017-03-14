//
//  FreeAppraiseCell.m
//  SXK
//
//  Created by 杨伟康 on 2017/2/10.
//  Copyright © 2017年 ywk. All rights reserved.
//

#import "FreeAppraiseCell.h"

@implementation FreeAppraiseCell{
    UILabel *_title;
    UILabel *_content;
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
        _title = [UILabel createLabelWithFrame:VIEWFRAME(90,18, SCREEN_WIDTH - 120, 14)
                                          andText:@"鉴定须知"
                                     andTextColor:[UIColor lightGrayColor]
                                       andBgColor:[UIColor clearColor]
                                          andFont:SYSTEMFONT(14)
                                 andTextAlignment:NSTextAlignmentCenter];
        
        _content = [UILabel createLabelWithFrame:VIEWFRAME(90,18, SCREEN_WIDTH - 120, 14)
                                       andText:@"只通过图片鉴定存在一定局限性,完整的鉴定流程需结合实物的皮质、气味、金属刻字、走线技术等各种细节综合考虑,鉴定结果仅供参考。此鉴定不具权威性,仅供参考,不做其他平台退换货凭证"
                                  andTextColor:[UIColor lightGrayColor]
                                    andBgColor:[UIColor clearColor]
                                       andFont:SYSTEMFONT(14)
                              andTextAlignment:NSTextAlignmentLeft];
        _content.numberOfLines = 0;
        
        UIView *leftLine = [[UIView alloc] init];
        leftLine.backgroundColor = [UIColor lightGrayColor];
        
        
        UIView *rightLine = [[UIView alloc] init];
        rightLine.backgroundColor = [UIColor lightGrayColor];

        
        [self addSubview:_title];
        [self addSubview:leftLine];
        [self addSubview:rightLine];
        [self addSubview:_content];
        
        [_title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self);
            make.top.equalTo(self).offset(10);
            make.size.mas_equalTo(CGSizeMake(60, 13));
        }];
        
        [_content mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_title.mas_bottom).offset(0);
            make.left.equalTo(self.mas_left).offset(15);
            make.right.equalTo(self.mas_right).offset(-15);
            make.height.mas_equalTo(100);
        }];

        
        [leftLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(_title);
            make.right.equalTo(_title.mas_left).offset(-18);
            make.size.mas_equalTo(CGSizeMake(34, 0.5));
        }];
        
        [rightLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(_title);
            make.left.equalTo(_title.mas_right).offset(18);
            make.size.mas_equalTo(CGSizeMake(34, 0.5));
        }];

        self.backgroundColor = APP_COLOR_GRAY_Header;

    }
    return  self;
}



@end
