//
//  SummaryCell.m
//  SXK
//
//  Created by 杨伟康 on 2016/11/22.
//  Copyright © 2016年 ywk. All rights reserved.
//

#import "SummaryCell.h"

@interface SummaryCell()<UITextFieldDelegate>



@end


@implementation SummaryCell{
    UITextField *_content;
    UIView *_line;
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
        _content = [[UITextField alloc] init];
        _content.frame = VIEWFRAME(15, 0, SCREEN_WIDTH-15, 53);
        _content.placeholder = @"";
        [_content setFont:SYSTEMFONT(14)];
        _content.delegate =self;
        
        _line = [[UIView alloc] initWithFrame:VIEWFRAME(0, 53, SCREEN_WIDTH, 1)];
        _line.backgroundColor = [UIColor colorWithHexColorString:@"f7f7f7"];
        
        [self addSubview:_content];
        [self addSubview:_line];
        
    }
    return  self;
}

-(void)fillWithTitle:(NSString *)title
{
    _content.placeholder = title;
    if ([title isEqualToString:@"专柜价 (必填)"]) {
        _content.keyboardType = UIKeyboardTypeDecimalPad;
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField;
{
    [_delegate SendTextValue:textField.text title:textField.placeholder];
}


@end
