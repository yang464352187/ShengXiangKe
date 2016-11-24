//
//  TypeCell.m
//  SXK
//
//  Created by 杨伟康 on 2016/11/22.
//  Copyright © 2016年 ywk. All rights reserved.
//

#import "TypeCell.h"

@implementation TypeCell{
    UILabel *_title;
    UIView *_line;
    UILabel *_select;
    UIImageView *_back;
    UITextField *_text;
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
        _title = [UILabel createLabelWithFrame:VIEWFRAME(15, 0, 100, 53)                                                 andText:@"类别"
                                          andTextColor:[UIColor blackColor]
                                            andBgColor:[UIColor clearColor]
                                               andFont:SYSTEMFONT(14)
                                      andTextAlignment:NSTextAlignmentLeft];
        
        _line = [[UIView alloc] initWithFrame:VIEWFRAME(0, 54, SCREEN_WIDTH, 1)];
        _line.backgroundColor = [UIColor colorWithHexColorString:@"f7f7f7"];
        
        _select = [UILabel createLabelWithFrame:VIEWFRAME(SCREEN_WIDTH - 185, 0, 150, 53)                                                 andText:@"(必选)"
                                  andTextColor:[UIColor colorWithHexColorString:@"a1a1a1"]
                                    andBgColor:[UIColor clearColor]
                                       andFont:SYSTEMFONT(14)
                              andTextAlignment:NSTextAlignmentRight];
//        _select.backgroundColor = [UIColor redColor];
        
        
        _back = [[UIImageView alloc] init];
        _back.image = [UIImage imageNamed:@"返回-"];

        [self addSubview:_title];
        [self addSubview:_line];
        [self addSubview:_select];
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
    if ([title isEqualToString:@"颜色"]) {
        [_select removeFromSuperview];
        _text = [[UITextField alloc] initWithFrame:VIEWFRAME(SCREEN_WIDTH - 185, 0, 150, 53)                                                 ];
        _text.textAlignment = NSTextAlignmentRight;
        [self addSubview:_text];
    }
    if ([title isEqualToString:@"附件"]) {
        _select.text = @"";
    }
    _title.text = title;

}

-(void)changeTitle:(NSString *)title
{
    _select.text = title;
}


@end
