//
//  ForgetVC.m
//  SXK
//
//  Created by 杨伟康 on 2016/11/24.
//  Copyright © 2016年 ywk. All rights reserved.
//

#import "ForgetVC.h"
#import "NSTimer+Addtions.h"

@interface ForgetVC ()


@property (strong, nonatomic) CustomField *userName;
@property (strong, nonatomic) CustomField *passWord;
@property (strong, nonatomic) CustomField *rePassWord;
@property (strong, nonatomic) CustomField *identifying;

@property (strong, nonatomic)UIButton    *verifybtn;
@property (assign, nonatomic) NSInteger   secs;
@property (strong, nonatomic) NSTimer     *timer;
@property (assign, nonatomic) BOOL        isSee;


@end

@implementation ForgetVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = self.myDict[@"title"];
    [self initUI];
    self.isSee = 1;

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
    
    UIView *line4 = [[UIView alloc] initWithFrame:CGRectMake(CommonWidth(SCREEN_WIDTH - 121), 109, 1, 16)];
    line4.backgroundColor = [UIColor colorWithHexColorString:@"dcdcdc"];
    
    UIView *line5 = [[UIView alloc] initWithFrame:CGRectMake(15, 291, SCREEN_WIDTH, 0.5)];
    line5.backgroundColor = [UIColor colorWithHexColorString:@"dcdcdc"];

    
    
    
    UIButton *registeBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    registeBtn.backgroundColor = APP_COLOR_GRAY_333333;
    registeBtn.frame = CGRectMake(15, 333.5, SCREEN_WIDTH-30, 44);
    [registeBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    registeBtn.tag =101;
    [registeBtn setTitle:@"提交" forState:UIControlStateNormal];
    [registeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    registeBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    ViewRadius(registeBtn, 22);
    
    
    UIButton *identify = [UIButton buttonWithType:UIButtonTypeSystem];
    [identify setTitle:@"发送验证码" forState:UIControlStateNormal];
    identify.frame = VIEWFRAME(SCREEN_WIDTH - 110, 95, 100, 45);
    identify.tag = 103;
    [identify setTitleColor:APP_COLOR_GRAY_333333 forState:UIControlStateNormal];
    [identify addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    identify.titleLabel.font = [UIFont systemFontOfSize:16];
    self.verifybtn = identify;
    
    UIButton *seeBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    UIImage *image = [UIImage imageNamed:@"眼睛"];
    [seeBtn setImage:  [image imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)]  forState:UIControlStateNormal];
    seeBtn.frame = VIEWFRAME(SCREEN_WIDTH - 80, 170, 100, 45);
    [seeBtn addTarget:self action:@selector(seeAction:) forControlEvents:UIControlEventTouchUpInside];
    

    
    //    [self.view addSubview:line];
    [self.view addSubview:line1];
    [self.view addSubview:line2];
    [self.view addSubview:line3];
    [self.view addSubview:line5];

    
    [self.view addSubview:self.userName];
    [self.view addSubview:self.passWord];
    [self.view addSubview:self.identifying];
    [self.view addSubview:self.rePassWord];

    [self.view addSubview:line4];
    [self.view addSubview:identify];
    [self.view addSubview:registeBtn];
    [self.view addSubview:seeBtn];
    
    
    
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
        _passWord = [[CustomField alloc] initWithFrame:VIEWFRAME(22.5, 170, SCREEN_WIDTH-80, 45)
                                        andPlaceholder:@"请输入新密码"
                                      andLeftViewImage:[UIImage imageNamed:@"密码"]
                                       AndValidateType:validateTypePassWord];
        
        //        ViewBorderRadius(_passWord, 7, SINGLE_LINE_WIDTH, [UIColor grayColor]);
    }
    return _passWord;
}

- (CustomField *)identifying{
    if (!_identifying) {
        _identifying = [[CustomField alloc] initWithFrame:VIEWFRAME(22.5, 95, SCREEN_WIDTH-80, 45)
                                           andPlaceholder:@"请输入验证码"
                                         andLeftViewImage:[UIImage imageNamed:@"验证码"]
                                          AndValidateType:validateTypePassWord];
        _identifying.clearButtonMode = UITextFieldViewModeNever;

        //        ViewBorderRadius(_passWord, 7, SINGLE_LINE_WIDTH, [UIColor grayColor]);
    }
    return _identifying;
}

- (CustomField *)rePassWord{
    if (!_rePassWord) {
        _rePassWord = [[CustomField alloc] initWithFrame:VIEWFRAME(22.5, 245, SCREEN_WIDTH-80, 45)
                                           andPlaceholder:@"请输入确认密码"
                                         andLeftViewImage:[UIImage imageNamed:@"密码"]
                                          AndValidateType:validateTypePassWord];
        
        //        ViewBorderRadius(_passWord, 7, SINGLE_LINE_WIDTH, [UIColor grayColor]);
    }
    return _rePassWord;
}

-(void)btnAction:(UIButton *)sender
{
    if (sender.tag == 101) {
        if ([self.userName validate] && [self.passWord validate] && [self.rePassWord validate] && [self.identifying validate]) {
            if (![self.passWord.text isEqualToString:self.rePassWord.text]) {
                [ProgressHUDHandler showHudTipStr:@"两次密码不一致"];
            }else if (self.identifying.text.length != 6){
                [self.identifying becomeFirstResponder];
                [ProgressHUDHandler showHudTipStr:@"请输入验证码"];
            }else{
                [ProgressHUDHandler showProgressHUD];
                _weekSelf(weakSelf);
                [BaseRequest resetPassWordWithmobile:self.userName.text
                                            password:self.rePassWord.text
                                              verify:self.identifying.text
                                         succesBlock:^(id data) {
                                             [ProgressHUDHandler dismissProgressHUD];
                                             [ProgressHUDHandler showHudTipStr:@"重置成功"];
                                             [weakSelf popGoBack];
                                         } failue:^(id data, NSError *error) {
                                             [ProgressHUDHandler dismissProgressHUD];
                                         }];
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

-(void)seeAction:(UIButton *)sender
{
    if (self.isSee) {
        self.isSee = 0;
    }else{
        self.isSee = 1;
        
    }
    
    self.passWord.secureTextEntry = self.isSee;
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
