//
//  RegisterVC.m
//  SXK
//
//  Created by 杨伟康 on 2016/11/24.
//  Copyright © 2016年 ywk. All rights reserved.
//

#import "RegisterVC.h"

@interface RegisterVC ()

@property (strong, nonatomic) CustomField *userName;
@property (strong, nonatomic) CustomField *passWord;
@property (strong, nonatomic) CustomField *identifying;



@end

@implementation RegisterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"注册";

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


    
    UIButton *registeBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    registeBtn.backgroundColor = APP_COLOR_GRAY_333333;
    registeBtn.frame = CGRectMake(15, 263.5, SCREEN_WIDTH-30, 44);
    [registeBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    registeBtn.tag =101;
    [registeBtn setTitle:@"注册" forState:UIControlStateNormal];
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
    
    UILabel *explainLab = [[UILabel alloc] init];
    explainLab.text = @"绑定后意味着你同意BOOBE的";
    explainLab.textColor = [UIColor blackColor];
    explainLab.font = [UIFont systemFontOfSize:12];
//    [loginView addSubview:explainLab];
    
    UIButton *explainBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [explainBtn setTitle:@"《用户协议》" forState:UIControlStateNormal];
    [explainBtn setTitleColor:APP_COLOR_GRAY_333333 forState:UIControlStateNormal];
    explainBtn.titleLabel.font = [UIFont systemFontOfSize:12];
//    [loginView addSubview:explainBtn];
    UIButton *seeBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    UIImage *image = [UIImage imageNamed:@"眼睛"];
    [seeBtn setImage:  [image imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)]  forState:UIControlStateNormal];
    seeBtn.frame = VIEWFRAME(SCREEN_WIDTH - 80, 95, 100, 45);
    [seeBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];

    
//    [self.view addSubview:line];
    [self.view addSubview:line1];
    [self.view addSubview:line2];
    [self.view addSubview:line3];
    
    [self.view addSubview:self.userName];
    [self.view addSubview:self.passWord];
    [self.view addSubview:self.identifying];
    [self.view addSubview:line4];
    [self.view addSubview:identify];

    [self.view addSubview:explainLab];
    [self.view addSubview:registeBtn];
    [self.view addSubview:explainBtn];
    [self.view addSubview:seeBtn];

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
                                       AndValidateType:validateTypePassWord];
        
        //        ViewBorderRadius(_passWord, 7, SINGLE_LINE_WIDTH, [UIColor grayColor]);
    }
    return _identifying;
}
-(void)btnAction:(UIButton *)sender
{
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
