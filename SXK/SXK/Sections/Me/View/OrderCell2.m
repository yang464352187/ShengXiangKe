//
//  OrderCell2.m
//  SXK
//
//  Created by 杨伟康 on 2017/1/16.
//  Copyright © 2017年 ywk. All rights reserved.
//

#import "OrderCell2.h"
#import "FEPlaceHolderTextView.h"

@interface OrderCell2 ()<UITextViewDelegate>

@end

@implementation OrderCell2{
    FEPlaceHolderTextView *_content;
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
        _content = [[FEPlaceHolderTextView alloc] initWithFrame:CommonVIEWFRAME(0, 8, 375, 95)];
        _content.backgroundColor = [UIColor clearColor];
        [_content setTintColor:[UIColor blackColor]];
        _content.placeholderColor = [UIColor colorWithHexColorString:@"b6b6b6"];
        [_content setFont:SYSTEMFONT(13)];
        _content.placeholder =  @"给啵主留言(最多250字)";
        _content.delegate = self;
        [self addSubview:_content];
        
        [_content mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).offset(0);
            make.bottom.equalTo(self.mas_bottom).offset(0);
            make.left.equalTo(self.mas_left).offset(0);
            make.right.equalTo(self.mas_right).offset(0);
 
        }];
    }
    return  self;
}

- (void)textViewDidEndEditing:(UITextView *)textView;
{
   
    [_delegate SendTextValue:textView.text ];
}

@end
