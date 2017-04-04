//
//  PromulgateVC1Cell.m
//  SXK
//
//  Created by 杨伟康 on 2017/3/16.
//  Copyright © 2017年 ywk. All rights reserved.
//

#import "PromulgateVC1Cell.h"


@interface PromulgateVC1Cell ()<UITextFieldDelegate>

@end

@implementation PromulgateVC1Cell{
    UITextField *_content;
    UIView *_line;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _content = [[UITextField alloc] init];
        _content.frame = VIEWFRAME(15, 0, SCREEN_WIDTH-15, 53);
        _content.placeholder = @"心理预期售卖价格                                           ¥0";
        [_content setFont:SYSTEMFONT(14)];
        _content.delegate =self;
        
        _line = [[UIView alloc] initWithFrame:VIEWFRAME(0, 53, SCREEN_WIDTH, 1)];
        _line.backgroundColor = [UIColor colorWithHexColorString:@"f7f7f7"];
        
        UILabel *label = [UILabel createLabelWithFrame:VIEWFRAME(15, 0, 150, 53)                                                 andText:@"通常为全新品(专柜价)的3-5折"
                                           andTextColor:APP_COLOR_GREEN
                                             andBgColor:[UIColor clearColor]
                                                andFont:SYSTEMFONT(14)
                                       andTextAlignment:NSTextAlignmentLeft];

        
        [self addSubview:_content];
        [self addSubview:_line];
        [self addSubview:label];
        
        [_content mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(15);
            make.top.equalTo(self.mas_top).offset(15);
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 30, 15));
        }];
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(15);
            make.top.equalTo(_content.mas_bottom).offset(10);
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 30, 15));
        }];
        
    }
    return  self;
}

-(void)fillWithTitle:(NSString *)title
{
    _content.placeholder = title;
    if ([title isEqualToString:@"心理预期售卖价格                    ¥0"]) {
        _content.keyboardType = UIKeyboardTypeDecimalPad;
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField;
{
    [_delegate SendTextValue1:textField.text title:textField.placeholder];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
