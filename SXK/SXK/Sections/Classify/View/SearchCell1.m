//
//  SearchCell1.m
//  SXK
//
//  Created by 杨伟康 on 2017/3/3.
//  Copyright © 2017年 ywk. All rights reserved.
//

#import "SearchCell1.h"

@implementation SearchCell1{
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
        _title = [UILabel createLabelWithFrame:VIEWFRAME(15, 0, 150, 53)                                                 andText:@""
                                  andTextColor:APP_COLOR_GRAY_Font
                                    andBgColor:[UIColor clearColor]
                                       andFont:SYSTEMFONT(13)
                              andTextAlignment:NSTextAlignmentLeft];

        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        [btn setTitle:@"×" forState:UIControlStateNormal];
        [btn setTitleColor:APP_COLOR_GRAY_Font forState:UIControlStateNormal];
        btn.titleLabel.font = SYSTEMFONT(25);
        [btn addTarget:self action:@selector(clearBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        
//        [self addSubview:btn];
        [self addSubview:_title];
        
        [_title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.equalTo(self.mas_left).offset(15);
            make.size.mas_equalTo(CGSizeMake(200, 20));
        }];
        
//        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.centerY.equalTo(self);
//            make.right.equalTo(self.mas_right).offset(-15);
//            make.size.mas_equalTo(CGSizeMake(60, 30));
//
//        }];
    }
    return  self;
}

-(void)clearBtn:(UIButton *)sender
{
    
}


-(void)fillTitleWithStr:(NSString *)str
{
    _title.text = str;
}



@end
