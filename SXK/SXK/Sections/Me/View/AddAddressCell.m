//
//  AddAddressCell.m
//  SXK
//
//  Created by 杨伟康 on 2016/12/6.
//  Copyright © 2016年 ywk. All rights reserved.
//

#import "AddAddressCell.h"

@interface AddAddressCell()<UITextFieldDelegate>

@end

@implementation AddAddressCell{
    UITextField *_nameTF;
    NSInteger *_index;
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
        _nameTF.delegate = self;
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
    if ([placeHolder isEqualToString:@"请输入联系电话"]) {
        _nameTF.keyboardType = UIKeyboardTypeNumberPad;
    }

}
-(void)changeAddress:(NSString *)address  {
    _nameTF.text = address;
}

-(void)fillWithContent:(AddressModel *)model
{
    if ([_nameTF.placeholder isEqualToString:@"请输入收货人姓名"]) {
        _nameTF.text = model.name;
    }else if ([_nameTF.placeholder isEqualToString:@"请输入联系电话"]){
        _nameTF.text = model.mobile;
    }else{
        _nameTF.text = [NSString stringWithFormat:@"%@ %@ %@",model.state,model.city,model.district];
    }
}


-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if ([_nameTF.placeholder isEqualToString:@"请输入联系电话"]) {
        [_delegate sendInfo:textField.text andType:2];
    }else{
        [_delegate sendInfo:textField.text andType:1];
    }
}


-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [_delegate becomeFirstResponce:textField];
}
@end
