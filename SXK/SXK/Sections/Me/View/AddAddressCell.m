//
//  AddAddressCell.m
//  SXK
//
//  Created by 杨伟康 on 2016/12/6.
//  Copyright © 2016年 ywk. All rights reserved.
//

#import "AddAddressCell.h"

@implementation AddAddressCell{
    UITextField *_nameTF;
    
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
        _nameTF = [[UITextField alloc] initWithFrame:VIEWFRAME(21, 0, SCREEN_WIDTH-21, 53)];
        _nameTF.placeholder = @"请输入收货人姓名";
        _nameTF.font = SYSTEMFONT(14);
        
        [self addSubview:_nameTF];
    
    }
    return  self;
}


-(void)fillWithPlaceholder:(NSString *)placeHolder
{
    _nameTF.placeholder = placeHolder;
    if ([placeHolder isEqualToString:@"请选择地区街道"]) {
        _nameTF.userInteractionEnabled = NO;
    }
}

@end
