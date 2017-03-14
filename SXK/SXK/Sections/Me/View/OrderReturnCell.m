//
//  OrderReturnCell.m
//  SXK
//
//  Created by 杨伟康 on 2017/2/6.
//  Copyright © 2017年 ywk. All rights reserved.
//

#import "OrderReturnCell.h"

@implementation OrderReturnCell{
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
        
        _text = [[UITextField alloc] initWithFrame:CGRectZero];
        _text.placeholder = @"请输入单号";
        _text.font = SYSTEMFONT(13);
        
        ViewBorder(_text, 0.5, [UIColor lightGrayColor]);
        [self addSubview:_text];
        
        
        [_text mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).offset(0);
            make.left.equalTo(self.mas_left).offset(12);
            make.right.equalTo(self.mas_right).offset(-12);
            make.bottom.equalTo(self.mas_bottom).offset(0);
        }];
        
        
    }
    return  self;
}


@end
