//
//  OrderReturnCell1.m
//  SXK
//
//  Created by 杨伟康 on 2017/2/6.
//  Copyright © 2017年 ywk. All rights reserved.
//

#import "OrderReturnCell1.h"
#import "FEPlaceHolderTextView.h"

@interface OrderReturnCell1()<UITextViewDelegate>

@end

@implementation OrderReturnCell1{
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
        ViewBorder(_content, 0.5, [UIColor lightGrayColor]);
        _content.delegate = self;
        [self addSubview:_content];
        
        [_content mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).offset(0);
            make.left.equalTo(self.mas_left).offset(12);
            make.right.equalTo(self.mas_right).offset(-12);
            make.bottom.equalTo(self.mas_bottom).offset(0);
        }];

        
    }
    return  self;
}

-(void)fillWithTitle:(NSString *)title
{
    _content.placeholder =  title;

}
- (void)textViewDidEndEditing:(UITextView *)textView{
//    NSLog(@"%@",textView.text);
    [_delegate returnTitle:_content.placeholder Content:textView.text];
}



@end
