//
//  RegisterVC.m
//  SXK
//
//  Created by 杨伟康 on 2016/11/24.
//  Copyright © 2016年 ywk. All rights reserved.
//

#import "RegisterVC.h"
#import "NSTimer+Addtions.h"

@interface RegisterVC ()

@property (strong, nonatomic) CustomField *userName;
@property (strong, nonatomic) CustomField *passWord;
@property (strong, nonatomic) CustomField *identifying;
@property (strong, nonatomic) CustomField *inviteCode;
@property (assign, nonatomic) NSInteger   secs;
@property (strong, nonatomic) NSTimer     *timer;
@property (strong, nonatomic)UIButton    *verifybtn;
@property (strong, nonatomic) UIButton    *inviteBtn;
@property (strong, nonatomic) UIView      *lineView;
@property (assign, nonatomic) BOOL        isSelect;
@property (assign, nonatomic) BOOL        isSee;

@end

@implementation RegisterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"注册";
    self.isSelect = 0;
    self.isSee = 1;

    [self initUI];

}

-(void)initUI
{
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
    line.backgroundColor = [UIColor colorWithHexColorString:@"dcdcdc"];
    
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(15, 80, SCREEN_WIDTH, 0.5)];
    line1.backgroundColor = [UIColor colorWithHexColorString:@"dcdcdc"];
    
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(15, 151, SCREEN_WIDTH, 0.5)];
    line2.backgroundColor = [UIColor colorWithHexColorString:@"dcdcdc"];
    
    UIView *line3 = [[UIView alloc] initWithFrame:CGRectMake(15, 221, SCREEN_WIDTH, 0.5)];
    line3.backgroundColor = [UIColor colorWithHexColorString:@"dcdcdc"];
    
    UIView *line4 = [[UIView alloc] initWithFrame:CGRectMake(CommonWidth(SCREEN_WIDTH - 121), 183, 1, 16)];
    line4.backgroundColor = [UIColor colorWithHexColorString:@"dcdcdc"];
    
    UIView *line5 = [[UIView alloc] initWithFrame:VIEWFRAME(0, 49.5,  SCREEN_WIDTH-22.5, 0.5)];
    line5.backgroundColor = [UIColor colorWithHexColorString:@"dcdcdc"];
    
    UIButton *registeBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    registeBtn.backgroundColor = APP_COLOR_GRAY_333333;
    registeBtn.frame = CGRectMake(15, 350.5, SCREEN_WIDTH-30, 44);
    [registeBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    registeBtn.tag =101;
    [registeBtn setTitle:@"立即绑定" forState:UIControlStateNormal];
    [registeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    registeBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    ViewRadius(registeBtn, 22);
    
    UIButton *identify = [UIButton buttonWithType:UIButtonTypeSystem];
    [identify setTitle:@"发送验证码" forState:UIControlStateNormal];
    identify.frame = VIEWFRAME(SCREEN_WIDTH - 110, 170, 100, 45);
    identify.tag = 103;
    [identify setTitleColor:APP_COLOR_GRAY_333333 forState:UIControlStateNormal];
    [identify addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    identify.titleLabel.font = [UIFont systemFontOfSize:16];
    self.verifybtn = identify;
    
    UILabel *explainLab = [[UILabel alloc] init];
    explainLab.text = @"绑定后意味着你同意BOOBE的";
    explainLab.textColor = [UIColor blackColor];
    explainLab.font = [UIFont systemFontOfSize:12];
    //    [loginView addSubview:explainLab];
    
    UIButton *explainBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [explainBtn setTitle:@"《用户协议》" forState:UIControlStateNormal];
    [explainBtn setTitleColor:APP_COLOR_GRAY_333333 forState:UIControlStateNormal];
    explainBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [explainBtn addTarget:self action:@selector(explainAction:) forControlEvents:UIControlEventTouchUpInside];
    //    [loginView addSubview:explainBtn];
    UIButton *seeBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    UIImage *image = [UIImage imageNamed:@"眼睛"];
    [seeBtn setImage:  [image imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)]  forState:UIControlStateNormal];
    seeBtn.frame = VIEWFRAME(SCREEN_WIDTH - 55, 95, 45, 45);
    [seeBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    seeBtn.tag = 300;
    
    UIButton *invite = [UIButton buttonWithType:UIButtonTypeSystem];
    [invite setTitle:@"点击填写邀请码" forState:UIControlStateNormal];
    [invite setTitleColor:APP_COLOR_GREEN forState:UIControlStateNormal];
    [invite addTarget:self action:@selector(inviteAction:) forControlEvents:UIControlEventTouchUpInside];
    invite.titleLabel.font = SYSTEMFONT(12);
    
    //    [self.view addSubview:line];
    [self.view addSubview:line1];
    [self.view addSubview:line2];
    [self.view addSubview:line3];
    
    [self.view addSubview:self.userName];
    [self.view addSubview:self.passWord];
    [self.view addSubview:self.identifying];
    [self.view addSubview: self.inviteCode];
    [self.view addSubview:line4];
    [self.view addSubview:identify];
    
    [self.view addSubview:explainLab];
    [self.view addSubview:registeBtn];
    [self.view addSubview:explainBtn];
    [self.view addSubview:seeBtn];
    [self.view addSubview:invite];
    [self.view addSubview:line5];
    
    self.inviteBtn = invite;
    self.lineView = line5;
    CGFloat explainHeight = [UILabel getHeightByWidth:SCREEN_WIDTH title:@"登录后意味着你同意BOOBE的" font:[UIFont systemFontOfSize:12]];
    
    CGFloat explainWith = [UILabel getWidthWithTitle:@"登录后意味着你同意BOOBE的" font:[UIFont systemFontOfSize:12]];
    CGFloat explainBtnWidth = [UILabel getWidthWithTitle:@"《用户协议》"font:[UIFont systemFontOfSize:12]];
    CGFloat left = (SCREEN_WIDTH - explainWith - explainBtnWidth)/2;
    
    [explainLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(registeBtn.mas_bottom).offset(28.0000/667*SCREEN_HIGHT);
        make.left.equalTo(self.view.mas_left).offset(left);
        make.size.mas_equalTo(CGSizeMake(explainWith, explainHeight));
    }];
    
    [explainBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(explainLab.mas_right).offset(0);
        make.top.equalTo(registeBtn.mas_bottom).offset(28.0000/667*SCREEN_HIGHT);
        make.size.mas_equalTo(CGSizeMake(explainBtnWidth, explainHeight));
    }];
    
    [invite mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(30);
        make.top.equalTo(line4.mas_bottom).offset(40);
        make.size.mas_equalTo(CGSizeMake(100, 14));
    }];
    
    
    [self.inviteCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(invite.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(22.5);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 80, 45));
    }];
    self.inviteCode.alpha = 0;
    
    [line5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(22.5);
        make.top.equalTo(self.inviteCode.mas_bottom).offset(5);
        make.size.mas_equalTo(CGSizeMake( SCREEN_WIDTH-22.5, 0.5));
    }];
    
    line5.alpha = 0;
}

- (CustomField *)userName{
    if (!_userName) {
        _userName = [[CustomField alloc] initWithFrame:VIEWFRAME(22.5, 20, SCREEN_WIDTH-80, 45)
                                        andPlaceholder:@"请输入手机号码"
                                      andLeftViewImage:[UIImage imageNamed:@"手机-(1)"]
                                       AndValidateType:validateTypeMobile];
        //        ViewBorderRadius(_userName, 7, SINGLE_LINE_WIDTH, [UIColor grayColor]);
        
    }
    return _userName;
}

- (CustomField *)passWord{
    if (!_passWord) {
        _passWord = [[CustomField alloc] initWithFrame:VIEWFRAME(22.5, 95, SCREEN_WIDTH-80, 45)
                                        andPlaceholder:@"请输入密码(至少6位数)"
                                      andLeftViewImage:[UIImage imageNamed:@"密码"]
                                       AndValidateType:validateTypePassWord];
        
        //        ViewBorderRadius(_passWord, 7, SINGLE_LINE_WIDTH, [UIColor grayColor]);
    }
    return _passWord;
}

- (CustomField *)identifying{
    if (!_identifying) {
        _identifying = [[CustomField alloc] initWithFrame:VIEWFRAME(22.5, 170, SCREEN_WIDTH-80, 45)
                                        andPlaceholder:@"请输入手机验证码"
                                      andLeftViewImage:[UIImage imageNamed:@"验证码"]
                                       AndValidateType:validateTypeDefualt];
        _identifying.clearButtonMode = UITextFieldViewModeNever;
        
        //        ViewBorderRadius(_passWord, 7, SINGLE_LINE_WIDTH, [UIColor grayColor]);
    }
    return _identifying;
}

- (CustomField *)inviteCode{
    if (!_inviteCode) {
        _inviteCode = [[CustomField alloc] initWithFrame:VIEWFRAME(22.5, 170, SCREEN_WIDTH-80, 45)
                                          andPlaceholder:@"请输入邀请码"
                                        andLeftViewImage:[UIImage imageNamed:@"密码"]
                                         AndValidateType:validateTypeDefualt];
        //        _inviteCode.backgroundColor = [UIColor redColor];
        //        ViewBorderRadius(_passWord, 7, SINGLE_LINE_WIDTH, [UIColor grayColor]);
        
    }
    return _inviteCode;
}
-(void)btnAction:(UIButton *)sender
{
    if (sender.tag == 300) {
        if (self.isSee) {
            self.isSee = 0;
        }else{
            self.isSee = 1;
        }
        self.passWord.secureTextEntry = self.isSee;
    }
    
    if (sender.tag == 101) {
        
        if ([self.userName validate] && [self.passWord validate] && [self.identifying validate]) {
            
            if (self.identifying.text.length !=6 ) {
                [self.identifying becomeFirstResponder];
                [ProgressHUDHandler showHudTipStr:@"请输入验证码"];
            }else if (self.inviteCode.text.length == 7 || self.inviteCode.text.length == 0){
                [ProgressHUDHandler showProgressHUD];
                _weekSelf(weakSelf);
                
                [BaseRequest registerWithUserName:self.userName.text password:self.passWord.text verify:self.identifying.text inviteCode:self.inviteCode.text succesBlock:^(id data) {
                    
                    NSDictionary *params = @{@"nickname":self.userName.text};
    
                    [BaseRequest SetPersonalInfoWithParams:params succesBlock:^(id data) {
                    } failue:^(id data, NSError *error) {
                        [ProgressHUDHandler showHudTipStr:@"注册成功"];
                        [weakSelf PopToRootViewController];
                        [ProgressHUDHandler dismissProgressHUD];
                    }];

                } failue:^(id data, NSError *error) {
                    [ProgressHUDHandler dismissProgressHUD];
                    
                }];

            }
            else{
                
                [ProgressHUDHandler showHudTipStr:@"验证码是7位"];
//                [BaseRequest registerWithUserName:self.userName.text password:self.passWord.text verify:self.identifying.text succesBlock:^(id data) {
//                    NSLog(@"%@",data);
//                    [ProgressHUDHandler showHudTipStr:@"注册成功"];
//                    [weakSelf PopToRootViewController];
//                    [ProgressHUDHandler dismissProgressHUD];
//                } failue:^(id data, NSError *error) {
//                    [ProgressHUDHandler dismissProgressHUD];
//                }];

            }
        }
        
    }
    
    
    if (sender.tag == 103) {
        if ([self.userName validate]) {
            [ProgressHUDHandler showProgressHUD];
            [BaseRequest sendSmsWithmobile:self.userName.text succesBlock:^(id data) {
                _weekSelf(weakSelf);
                self.timer = [NSTimer sf_scheduledTimerWithTimeInterval:1.0 block:^{
                    _strongSelf(self);
                [self timerAction];
                } repeats:YES];
                
                _secs = 60;
                [self.verifybtn setTitle:@"发送中(60s)" forState:UIControlStateNormal];
                self.verifybtn.userInteractionEnabled = NO;
                [ProgressHUDHandler dismissProgressHUD];
            } failue:^(id data, NSError *error) {
                [ProgressHUDHandler dismissProgressHUD];
            }];
        }
    }
    
}

- (void)timerAction{
    _secs -- ;
    
    if (_secs == 0) {
        [self.verifybtn setTitle:@"发送验证码" forState:UIControlStateNormal];
        //        self.verifybtn.backgroundColor = APP_COLOR_BASE_YELLOW;
        self.verifybtn.userInteractionEnabled = YES;
        [self.timer invalidate];
    }else{
        [self.verifybtn setTitle:[NSString stringWithFormat:@"发送中(%2ds)",(int)_secs] forState:UIControlStateNormal];
    }
    
}


-(void)inviteAction:(UIButton *)sender
{
    
    if (self.isSelect) {
        self.isSelect = 0;
    }else{
        self.isSelect = 1;
        
    }
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    
    dispatch_async(queue, ^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [UIView animateWithDuration:0.5 animations:^{
                
                self.inviteCode.alpha = self.isSelect;
                self.lineView.alpha = self.isSelect;
                
            } completion:^(BOOL finished) {
                
            }];
        });
    });
    
}

-(void)explainAction:(UIButton *)sender
{
    NSDictionary *dic = @{@"title":@"用户协议"};
    [self PushViewControllerByClassName:@"UserProtocolVC" info:dic];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
