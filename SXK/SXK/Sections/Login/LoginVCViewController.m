//
//  LoginVCViewController.m
//  SXK
//
//  Created by 杨伟康 on 2016/11/18.
//  Copyright © 2016年 ywk. All rights reserved.
//

#import "LoginVCViewController.h"

@interface LoginVCViewController ()

@property (strong, nonatomic) CustomField *userName;
@property (strong, nonatomic) CustomField *passWord;


@end

@implementation LoginVCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"登录";

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
    
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    loginBtn.backgroundColor = APP_COLOR_GRAY_333333;
    loginBtn.frame = CGRectMake(15, 192, SCREEN_WIDTH-30, 44);
    [loginBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    loginBtn.tag =101;
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    loginBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    ViewRadius(loginBtn, 22);
    
    UIButton *registeBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [registeBtn setTitle:@"立即注册" forState:UIControlStateNormal];
    registeBtn.frame = CGRectMake(30, 261, 60, 16);
    registeBtn.tag = 102;
    [registeBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [registeBtn setTitleColor:[UIColor colorWithHexColorString:@"16a5af"] forState:UIControlStateNormal];
    registeBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    
    UIButton *forgetBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [forgetBtn setTitle:@"忘记密码？" forState:UIControlStateNormal];
    forgetBtn.frame = CGRectMake(SCREEN_WIDTH - 30 - 75, 261, 80, 16);
    forgetBtn.tag = 103;
    [forgetBtn setTitleColor:[UIColor colorWithHexColorString:@"a1a1a1"] forState:UIControlStateNormal];
    [forgetBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    forgetBtn.titleLabel.font = [UIFont systemFontOfSize:14];

    
    
    
//    [self.view addSubview:line];
    [self.view addSubview:line1];
    [self.view addSubview:line2];
    [self.view addSubview:self.userName];
    [self.view addSubview:self.passWord];
    [self.view addSubview:loginBtn];
    [self.view addSubview:registeBtn];
    [self.view addSubview:forgetBtn];
    
    
    
}

-(void)btnAction:(UIButton *)sender
{
    switch (sender.tag) {
        case 101:{
            _weekSelf(weakSelf);
            if ([self.userName validate] && [self.passWord validate]) {
                [ProgressHUDHandler showProgressHUD];
                [BaseRequest loginWithUserName:self.userName.text password:self.passWord.text succesBlock:^(id data) {
                    [ProgressHUDHandler showHudTipStr:@"登录成功"];
                    [weakSelf popGoBack];
                    [ProgressHUDHandler dismissProgressHUD];

                } failue:^(id data, NSError *error) {
                    if (error.code == 2000) {
                        [ProgressHUDHandler showHudTipStr:@"账户或密码错误"];
                    }
                    [ProgressHUDHandler dismissProgressHUD];
                }];
            }
            break;
        }
            
        case 102:
            [self PushViewControllerByClassName:@"RegisterVC" info:nil];
            break;
        case 103:
        {
            NSDictionary *dic = @{@"title":@"忘记密码"};
            [self PushViewControllerByClassName:@"ForgetVC" info:dic];

        }
            break;
            
        default:
            break;
    }
    
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
                                        andPlaceholder:@"请输入密码"
                                      andLeftViewImage:[UIImage imageNamed:@"密码"]
                                       AndValidateType:validateTypePassWord];
        
//        ViewBorderRadius(_passWord, 7, SINGLE_LINE_WIDTH, [UIColor grayColor]);
    }
    return _passWord;
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
