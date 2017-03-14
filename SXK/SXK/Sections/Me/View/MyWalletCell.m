//
//  MyWalletCell.m
//  SXK
//
//  Created by 杨伟康 on 2017/2/21.
//  Copyright © 2017年 ywk. All rights reserved.
//

#import "MyWalletCell.h"

@implementation MyWalletCell{
    UILabel *_title;
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
        
        _title = [UILabel createLabelWithFrame:VIEWFRAME(15, 0, 150, 53)                                                 andText:@"余额明细"
                                  andTextColor:[UIColor blackColor]
                                    andBgColor:[UIColor clearColor]
                                       andFont:SYSTEMFONT(13)
                              andTextAlignment:NSTextAlignmentCenter];
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = [UIColor blackColor];
        
        UIView *line1 = [[UIView alloc] init];
        line1.backgroundColor = [UIColor blackColor];

        
        
        [self addSubview:_title];
        [self addSubview:line1];
        [self addSubview:line];
        
        [_title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.centerY.equalTo(self).offset(10);
            make.size.mas_equalTo(CGSizeMake(60, 15));
        }];
        
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_title);
            make.right.equalTo(_title.mas_left).offset(-15);
            make.size.mas_equalTo(CGSizeMake(35, 0.5));
        }];
        
        [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_title);
            make.left.equalTo(_title.mas_right).offset(15);
            make.size.mas_equalTo(CGSizeMake(35, 0.5));
        }];

        
    }
    return  self;
}


-(void)fillWithTitle:(NSString *)title
{
    _title.text = title;
}

@end
