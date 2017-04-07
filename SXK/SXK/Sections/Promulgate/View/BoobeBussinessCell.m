//
//  BoobeBussinessCell.m
//  SXK
//
//  Created by 杨伟康 on 2017/4/7.
//  Copyright © 2017年 ywk. All rights reserved.
//

#import "BoobeBussinessCell.h"

@implementation BoobeBussinessCell{
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

        
        _title = [UILabel createLabelWithFrame:VIEWFRAME(15, 0, 150, 53)                                                    andText:@""
                                  andTextColor:APP_COLOR_GRAY_Font
                                    andBgColor:[UIColor clearColor]
                                       andFont:SYSTEMFONT(14)
                              andTextAlignment:NSTextAlignmentLeft];
        
        _title.numberOfLines = 0;
        [self addSubview:_title];
        
        [_title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(15);
            make.right.equalTo(self).offset(-15);
            make.top.equalTo(self).offset(0);
            make.bottom.equalTo(self).offset(0);
        }];
        
        self.backgroundColor =[UIColor colorWithHexColorString:@"f7f7f7"];
    }
    return  self;
}

-(void)fillTitleWithContent:(NSString *)str
{
    _title.text = str;
}


@end
