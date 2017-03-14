//
//  WithdrawalsCell.m
//  SXK
//
//  Created by 杨伟康 on 2017/2/24.
//  Copyright © 2017年 ywk. All rights reserved.
//

#import "WithdrawalsCell.h"
#import "UserModel.h"
#import "NSTimer+Addtions.h"

@interface WithdrawalsCell()<UITextFieldDelegate>

@end

@implementation WithdrawalsCell{
    UITextField *_text;
    UIButton *_button;
    NSTimer *_timer;
    NSInteger _secs;
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

        _text = [[UITextField alloc] init];
        _text.placeholder = @"";
        _text.font = SYSTEMFONT(15);
        _text.delegate = self;
        [self addSubview:_text];
        
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_button setTitleColor:APP_COLOR_GREEN forState:UIControlStateNormal];
        _button.titleLabel.font = SYSTEMFONT(10);
        ViewBorderRadius(_button, 10, 0.5, APP_COLOR_GREEN);
        [_button addTarget:self  action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [_text mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo (self.mas_top).offset(0);
            make.left.equalTo(self.mas_left).offset(15);
            make.right.equalTo(self.mas_right).offset(0);
            make.bottom.equalTo(self.mas_bottom).offset(0);
        }];
        
        
    }
    return  self;
}
-(void)fillWithTitle:(NSString *)title
{
    if ([title isEqualToString:@"请输入验证码"]) {
        [self addSubview:_button];
        [_button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).offset(-30);
            make.centerY.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(80, 21));
        }];

    }else{
        [_button removeFromSuperview];
    }
    _text.placeholder = title;
}

- (void)textFieldDidEndEditing:(UITextField *)textField;
{
    [_delegate returnText:_text.text type:self.type];
}


-(void)btnAction:(UIButton *)sender
{
    
    UserModel *model =   [LoginModel curLoginUser];
    
    [BaseRequest sendSmsWithmobile:model.mobile succesBlock:^(id data) {
        
        _weekSelf(weakSelf);
        _timer = [NSTimer sf_scheduledTimerWithTimeInterval:1.0 block:^{
            _strongSelf(self);
            [self timerAction];
        } repeats:YES];
        
        _secs = 60;
        [_button setTitle:@"发送中(60s)" forState:UIControlStateNormal];
        _button.userInteractionEnabled = NO;

        
        
    } failue:^(id data, NSError *error) {
        
    }];
}


- (void)timerAction{
    _secs -- ;
    
    _secs -- ;
    
    if (_secs == 0) {
        [_button setTitle:@"获取验证码" forState:UIControlStateNormal];
        //        self.verifybtn.backgroundColor = APP_COLOR_BASE_YELLOW;
        _button.userInteractionEnabled = YES;
        [_timer invalidate];
    }else{
        [_button setTitle:[NSString stringWithFormat:@"发送中(%2ds)",(int)_secs] forState:UIControlStateNormal];
    }
    
}


@end
