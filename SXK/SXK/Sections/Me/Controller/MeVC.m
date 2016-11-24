//
//  MeVC.m
//  SXK
//
//  Created by 杨伟康 on 2016/11/11.
//  Copyright © 2016年 ywk. All rights reserved.
//

#import "MeVC.h"
#import "LoginBtn.h"

@interface MeVC ()

@property(nonatomic, strong)UIButton *loginBtn;
@property(nonatomic, strong)UILabel *firstLab;
@property(nonatomic, strong)UILabel *secondLab;
@property(nonatomic, strong)UILabel *thirdLab;
@property(nonatomic, strong)UIView *loginView;


@end

@implementation MeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //判断是否登录
    
    
    
    if(0){
        
    }else{
        [self initLoginView];
    }
    
    
    
    
    


}

-(void)initLoginView
{
    self.navigationController.navigationBar.hidden = YES;
    
    UIImageView *backGroundImage = [[UIImageView alloc] initWithFrame:APP_BOUNDS];
    backGroundImage.image = [UIImage imageNamed:@"图层-1"];
    [self.view addSubview:backGroundImage];
    
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    loginBtn.frame = CGRectMake(100, 100, 0, 0);
    UIImage *buttonimage = [UIImage imageNamed:@"BOOBE"];
    buttonimage = [buttonimage imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    [loginBtn setImage:buttonimage forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(loginBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    self.loginBtn = loginBtn;
    
    
    UILabel *firstLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    firstLab.text = @"上啵呗  租宝贝";
    firstLab.font = [UIFont systemFontOfSize:17];
    firstLab.textAlignment = NSTextAlignmentCenter;
//    firstLab.backgroundColor = [UIColor redColor];
    [self.view addSubview:firstLab];
    self.firstLab = firstLab;
    
    UILabel *secondLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 400)];
    secondLab.text = @"~~~~~~";
    secondLab.font = [UIFont systemFontOfSize:17];
    secondLab.textAlignment = NSTextAlignmentCenter;
//    secondLab.backgroundColor = [UIColor redColor];
    [self.view addSubview:secondLab];
    self.secondLab = secondLab;

    
    UILabel *thirdLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 600)];
    thirdLab.text = @"现在就登陆BOOBE吧";
    thirdLab.font = [UIFont systemFontOfSize:14];
    thirdLab.textAlignment = NSTextAlignmentCenter;
//    thirdLab.backgroundColor = [UIColor redColor];
    [self.view addSubview:thirdLab];
    self.thirdLab = thirdLab;

    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(101.0000/375*SCREEN_WIDTH, 101.0000/375*SCREEN_WIDTH));
    }];
    
    
    CGFloat firstHeight = [UILabel getHeightByWidth:SCREEN_WIDTH title:@"上啵呗  租宝贝" font:[UIFont systemFontOfSize:17]];
    [firstLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(loginBtn.mas_bottom).offset(26.50000/667*SCREEN_HIGHT);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, firstHeight));
    }];
    
    CGFloat secondHeight = [UILabel getHeightByWidth:SCREEN_WIDTH title:@"~~~~~~" font:[UIFont systemFontOfSize:17]];
    [secondLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(firstLab.mas_bottom).offset(5.00000/667*SCREEN_HIGHT);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, secondHeight));
    }];

    CGFloat thirdHeight = [UILabel getHeightByWidth:SCREEN_WIDTH title:@"现在就登陆BOOBE吧" font:[UIFont systemFontOfSize:14]];
    [thirdLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(secondLab.mas_bottom).offset(20.00000/667*SCREEN_HIGHT);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, thirdHeight));
    }];

}

-(void)loginBtnAction
{
    
    self.loginBtn.alpha = 0;
    self.firstLab.alpha = 0;
    self.secondLab.alpha = 0;
    self.thirdLab.alpha = 0;
    
    
    self.loginView = [self loadLoginView];
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    
    dispatch_async(queue, ^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            
            [UIView animateWithDuration:0.5 animations:^{
                
                CGRect frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HIGHT);
                self.loginView.frame = frame;
                
            } completion:^(BOOL finished) {
                [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];//设置电池条颜色为白色
                
            }];
        });
    });

}

-(UIView *)loadLoginView
{
    UIView *loginView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HIGHT, SCREEN_WIDTH, SCREEN_HIGHT)];
    loginView.backgroundColor = [UIColor blackColor];
    loginView.alpha = 0.9;
    [self.view addSubview:loginView];
    
    UILabel *loginLab = [[UILabel alloc] init];
    loginLab.text = @"登录BOOBE";
    loginLab.textAlignment = NSTextAlignmentLeft;
    loginLab.textColor = [UIColor whiteColor];
    [loginLab setFont:[UIFont fontWithName:@"Helvetica-Bold" size:17.5]];
    [loginView addSubview: loginLab];
    
    UILabel *selectLab = [[UILabel alloc] init];
    selectLab.text = @"你可以用以下方式登录";
    selectLab.font = [UIFont systemFontOfSize:12];
    selectLab.textAlignment = NSTextAlignmentLeft;
    selectLab.textColor = [UIColor whiteColor];
    [loginView addSubview:selectLab];
    
    UIButton *exitBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [exitBtn setBackgroundImage:[UIImage imageNamed:@"矩形-3-拷贝"] forState:UIControlStateNormal];
    exitBtn.frame = CGRectMake(100, 100, 21, 21);
    exitBtn.center = CGPointMake(301.0000/375*SCREEN_WIDTH, 174.0000/667*SCREEN_HIGHT);
    [exitBtn addTarget:self action:@selector(exit) forControlEvents:UIControlEventTouchUpInside];
    [loginView addSubview:exitBtn];
    
    UILabel *explainLab = [[UILabel alloc] init];
    explainLab.text = @"登录后意味着你同意BOOBE的";
    explainLab.textColor = [UIColor whiteColor];
    explainLab.font = [UIFont systemFontOfSize:12];
    [loginView addSubview:explainLab];
    
    UIButton *explainBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [explainBtn setTitle:@"《用户协议》" forState:UIControlStateNormal];
    [explainBtn setTitleColor:APP_COLOR_GRAY_333333 forState:UIControlStateNormal];
    explainBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [loginView addSubview:explainBtn];
    
    LoginBtn *BEBtn = [[LoginBtn alloc] initWithFrame:CGRectMake(64.0000/375*SCREEN_WIDTH,217.5000/667*SCREEN_HIGHT , 247.0000/375*SCREEN_WIDTH, 43.0000/667*SCREEN_HIGHT) andImage:[UIImage imageNamed:@"矢量智能对象"] andTitle:@"用BOOBE登录"];
    BEBtn.LoginTag = 1;
    [BEBtn addTarget:self action:@selector(BEBtnAction:)];
    
    LoginBtn *WXBtn = [[LoginBtn alloc] initWithFrame:CGRectMake(64.0000/375*SCREEN_WIDTH,284.0000/667*SCREEN_HIGHT , 247.0000/375*SCREEN_WIDTH, 43.0000/667*SCREEN_HIGHT) andImage:[UIImage imageNamed:@"微信"] andTitle:@"用微信账号登录"];
    WXBtn.LoginTag = 2;
    
    LoginBtn *WBBtn = [[LoginBtn alloc] initWithFrame:CGRectMake(64.0000/375*SCREEN_WIDTH,350.5000/667*SCREEN_HIGHT , 247.0000/375*SCREEN_WIDTH, 43.0000/667*SCREEN_HIGHT) andImage:[UIImage imageNamed:@"微博"] andTitle:@"用微博账号登录"];
    WBBtn.LoginTag = 3;
    
    LoginBtn *QQBtn = [[LoginBtn alloc] initWithFrame:CGRectMake(64.0000/375*SCREEN_WIDTH,417.0000/667*SCREEN_HIGHT , 247.0000/375*SCREEN_WIDTH, 43.0000/667*SCREEN_HIGHT) andImage:[UIImage imageNamed:@"QQ"] andTitle:@"用QQ账号登录"];
    QQBtn.LoginTag = 4;

    [loginView addSubview:BEBtn];
    [loginView addSubview:WXBtn];
    [loginView addSubview:WBBtn];
    [loginView addSubview:QQBtn];

    CGFloat selectHeight = [UILabel getHeightByWidth:SCREEN_WIDTH title:@"你可以用以下方式登录" font:[UIFont systemFontOfSize:12]];
    [selectLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(BEBtn.mas_top).offset(-18.5000/667*SCREEN_HIGHT);
        make.left.equalTo(loginView.mas_left).offset(64.0000/375*SCREEN_WIDTH);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, selectHeight));
    }];
    
    CGFloat loginHeight = [UILabel getHeightByWidth:SCREEN_WIDTH title:@"登录BOOBE" font:[UIFont systemFontOfSize:17.5]];
    [loginLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(selectLab.mas_top).offset(-12.0000/667*SCREEN_HIGHT);
        make.left.equalTo(loginView.mas_left).offset(64.0000/375*SCREEN_WIDTH);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, loginHeight));
    }];
    
    CGFloat explainHeight = [UILabel getHeightByWidth:SCREEN_WIDTH title:@"登录后意味着你同意BOOBE的" font:[UIFont systemFontOfSize:12]];
    CGFloat explainWith = [UILabel getWidthWithTitle:@"登录后意味着你同意BOOBE的" font:[UIFont systemFontOfSize:12]];
    CGFloat explainBtnWidth = [UILabel getWidthWithTitle:@"《用户协议》"font:[UIFont systemFontOfSize:12]];
    CGFloat left = (SCREEN_WIDTH - explainWith - explainBtnWidth)/2;
    
    [explainLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(QQBtn.mas_bottom).offset(28.0000/667*SCREEN_HIGHT);
        make.left.equalTo(loginView.mas_left).offset(left);
        make.size.mas_equalTo(CGSizeMake(explainWith, explainHeight));
    }];
    
    [explainBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(explainLab.mas_right).offset(0);
        make.top.equalTo(QQBtn.mas_bottom).offset(28.0000/667*SCREEN_HIGHT);
        make.size.mas_equalTo(CGSizeMake(explainBtnWidth, explainHeight));
    }];
    
    return loginView;
}

-(void)exit
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];//设置电池条颜色为黑色

    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    
    dispatch_async(queue, ^{
        
        dispatch_async(dispatch_get_main_queue(), ^{

            [UIView animateWithDuration:0.5 animations:^{
                
                self.loginBtn.alpha = 1;
                self.firstLab.alpha = 1;
                self.secondLab.alpha = 1;
                self.thirdLab.alpha = 1;

                self.loginView.frame = CGRectMake(0, SCREEN_HIGHT, SCREEN_WIDTH, SCREEN_HIGHT);
                
            } completion:^(BOOL finished) {
                
                [self.loginView removeFromSuperview];
                
            }];
        });
    });

}

-(void)BEBtnAction:(LoginBtn *)sender
{
    if (sender.LoginTag == 1) {
        [self PushViewControllerByClassName:@"LoginVCViewController" info:nil];
    }
}

-(void)viewDidDisappear:(BOOL)animated
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];//设置电池条颜色为黑色

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
