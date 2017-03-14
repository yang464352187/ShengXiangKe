//
//  DepositeCell.m
//  SXK
//
//  Created by 杨伟康 on 2017/2/21.
//  Copyright © 2017年 ywk. All rights reserved.
//

#import "DepositeCell.h"


@interface DepositeCell()<UITextFieldDelegate>


@end

@implementation DepositeCell{
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
        
        UILabel *title = [UILabel createLabelWithFrame:VIEWFRAME(15, 0, 150, 53)                                                 andText:@"金额(元)"
                                  andTextColor:[UIColor blackColor]
                                    andBgColor:[UIColor clearColor]
                                       andFont:SYSTEMFONT(14)
                              andTextAlignment:NSTextAlignmentCenter];
        
        _text = [[UITextField alloc] init];
        _text.placeholder = @"请输入充值金额";
        _text.font = SYSTEMFONT(14);
        _text.delegate = self;
        [self addSubview:title];
        [self addSubview:_text];
        
        [title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo (self);
            make.left.equalTo(self.mas_left).offset(15);
            make.size.mas_equalTo(CGSizeMake(80, 15));
        }];
        
        [_text mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo (self);
            make.left.equalTo(title.mas_right).offset(0);
            make.size.mas_equalTo(CGSizeMake(150, 15));
        }];
        
    }
    return  self;
}


- (void)textFieldDidEndEditing:(UITextField *)textField;
{
    [_delegate returnText:_text.text];
}


@end
