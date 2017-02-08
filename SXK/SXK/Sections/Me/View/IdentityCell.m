//
//  IdentityCell.m
//  SXK
//
//  Created by 杨伟康 on 2017/1/22.
//  Copyright © 2017年 ywk. All rights reserved.
//

#import "IdentityCell.h"


@interface IdentityCell ()<UITextFieldDelegate>

@end

@implementation IdentityCell{
    UILabel *_title;
    UITextField *_text;
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
                                  andTextColor:[UIColor blackColor]
                                    andBgColor:[UIColor clearColor]
                                       andFont:SYSTEMFONT(14)
                              andTextAlignment:NSTextAlignmentLeft];
        
        _text = [[UITextField alloc] initWithFrame:VIEWFRAME(SCREEN_WIDTH - 185, 0, 150, 53)                                                 ];
        _text.textAlignment = NSTextAlignmentRight;
        _text.placeholder = @"请输入";
        _text.font = SYSTEMFONT(14);
        _text.textColor = [UIColor colorWithHexColorString:@"a1a1a1"];
        _text.delegate = self;
        
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = APP_COLOR_GRAY_Line;
        
        [self addSubview:_text];
        [self addSubview:_title];
        [self addSubview:view];
        
        [_title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.equalTo(self.mas_left).offset(23);
            make.size.mas_equalTo(CGSizeMake(100, 20));
        }];
        
        [_text mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.right.equalTo(self.mas_right).offset(-23);
            make.left.equalTo(_title.mas_right).offset(0);
            make.height.mas_equalTo(20);
        }];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(15);
            make.right.equalTo(self.mas_right).offset(-15);
            make.bottom.equalTo(self.mas_bottom).offset(0);
            make.height.mas_equalTo(0.5);
        }];

    }
    return  self;
}

- (void)textFieldDidEndEditing:(UITextField *)textField;
{
    [_delegate SendTextValue:textField.text title:_title.text];
}

-(void)fillWithTitle:(NSString *)title
{
    _title.text = title;
}

@end
