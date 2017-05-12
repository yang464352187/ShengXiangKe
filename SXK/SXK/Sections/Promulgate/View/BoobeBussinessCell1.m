//
//  BoobeBussinessCell1.m
//  SXK
//
//  Created by 杨伟康 on 2017/4/7.
//  Copyright © 2017年 ywk. All rights reserved.
//

#import "BoobeBussinessCell1.h"

@implementation BoobeBussinessCell1{
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
        
        
        _title = [UILabel createLabelWithFrame:VIEWFRAME(15, 0, 150, 53)                                                    andText:@""
                                  andTextColor:[UIColor blackColor]
                                    andBgColor:[UIColor clearColor]
                                       andFont:SYSTEMFONT(15)
                              andTextAlignment:NSTextAlignmentLeft];
        
        _content = [UILabel createLabelWithFrame:VIEWFRAME(15, 0, 150, 53)                                                    andText:@""
                                  andTextColor:APP_COLOR_GRAY_Font
                                    andBgColor:[UIColor clearColor]
                                       andFont:SYSTEMFONT(14)
                              andTextAlignment:NSTextAlignmentLeft];

        
        _title.numberOfLines = 0;
        _content.numberOfLines = 0;
        
        [self addSubview:_title];
        [self addSubview:_content];
        
        
        [_title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(15);
            make.right.equalTo(self).offset(-15);
            make.top.equalTo(self).offset(0);
//            make.bottom.equalTo(self).offset(0);
            make.height.mas_equalTo(16);
        }];
        
        [_content mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(15);
            make.right.equalTo(self).offset(-15);
            make.top.equalTo(_title.mas_bottom).offset(0);
            make.bottom.equalTo(self).offset(-10);

        }];
        
        self.backgroundColor =[UIColor colorWithHexColorString:@"f7f7f7"];
    }
    return  self;
}

-(void)fillWithTitle:(NSString *)title andContent:(NSString *)content
{
    _title.text = title;
    _content.text = content;
}


@end
