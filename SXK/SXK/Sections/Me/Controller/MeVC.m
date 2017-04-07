//
//  MeVC.m
//  SXK
//
//  Created by 杨伟康 on 2016/11/11.
//  Copyright © 2016年 ywk. All rights reserved.
//

#import "MeVC.h"
#import "LoginBtn.h"
#import "MeCell.h"
#import <UMSocialCore/UMSocialCore.h>
#import "MyDistributeVC.h"
#import "MyRentVC.h"
#import "ServeceCenterVC.h"
#import "MQChatViewManager.h"
#import "MQChatDeviceUtil.h"
#import <MeiQiaSDK/MeiQiaSDK.h>
#import "NSArray+MQFunctional.h"
#import "MQBundleUtil.h"
#import "MQAssetUtil.h"
#import "MQImageUtil.h"
#import "MQToast.h"
#import "MyMaintainVC.h"
#import "MyAppraiseVC.h"
#import "MyBusiness.h"
@interface MeVC ()

@property (nonatomic, strong)UIButton *loginBtn;
@property (nonatomic, strong)UILabel *firstLab;
@property (nonatomic, strong)UILabel *secondLab;
@property (nonatomic, strong)UILabel *thirdLab;
@property (nonatomic, strong)UIView *loginView;
@property (nonatomic, strong)UIImageView *backgroundImage;
@property (strong, nonatomic)UIView *headView;
@property (nonatomic, strong)NSMutableArray *titleArr;
@property (nonatomic, strong)NSMutableArray *imageArr;
@property (nonatomic, strong)UIView *backgroundView;
@property (nonatomic, strong)UIImageView *headImage;
@property (nonatomic, strong)UIImageView *sexImage;
@property (nonatomic, strong)UILabel *titleLab;
@property (nonatomic, assign)NSInteger type;
@property (nonatomic, assign)float score;
@end

@implementation MeVC
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.type = 0;

    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];//设置电池条颜色为白色
    
    if ([LoginModel isLogin]) {
        for(UIView *view in [self.view subviews])
        {
            [view removeFromSuperview];
        }
        
        [self.view addSubview:self.tableView];
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view.mas_top).offset(-20);
            make.left.equalTo(self.view.mas_left).offset(0);
            make.right.equalTo(self.view.mas_right).offset(0);
            make.bottom.equalTo(self.view.mas_bottom).offset(0);
        }];
        [self loadingRequest];
        
    }else{
        [self initLoginView];
        
    }
    
}


-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //判断是否登录
    self.navigationController.navigationBar.hidden = YES;
//    int login = 0;
//    if(login){
//        [self.view addSubview:self.tableView];
//    }else{
//        [self initLoginView];
//    }
    
}

-(void)loadingRequest
{
    NSDictionary *params = @{};
    [BaseRequest GetPersonalInfoWithParams:params succesBlock:^(id data) {
        
        self.myDict = data[@"user"];
        
        NSString *imageUrl = self.myDict[@"headimgurl"];
        
        if (imageUrl.length < 5) {
            self.headImage.image = [UIImage imageNamed:@"zhanweitouxiang"];
        }else{
            
        [self.headImage sd_setImageWithURL:[NSURL URLWithString:self.myDict[@"headimgurl"]]];
        }
        
        if ([self.myDict[@"sex"] integerValue] == 1) {
            self.sexImage.image = [UIImage imageNamed:@"男"];
        }else{
            self.sexImage.image = [UIImage imageNamed:@"女生"];
        }
        self.titleLab.text = self.myDict[@"nickname"];
        
//         NSLog(@"--------%@-------",[LoginModel curLoginUser]);
        
        NSString *mobile = self.myDict[@"mobile"];
        self.score = [data[@"user"][@"score"] floatValue];
        
//        NSLog(@"-------%lf-------",[data[@"score"] floatValue]);
        if (mobile.length != 11) {
            
            [self.tableView removeFromSuperview];
            [self initLoginView];
        }

        
    } failue:^(id data, NSError *error) {
        
    }];

}

-(void)loadingRequest1
{
    NSDictionary *params = @{};
    [BaseRequest GetPersonalInfoWithParams:params succesBlock:^(id data) {
        
        self.myDict = data[@"user"];
        
        
        
        NSString *mobile = self.myDict[@"mobile"];
        
        if (mobile.length != 11) {
            
            
            [self PresentViewControllerByClassName:@"BindMobileVC" info:nil];
            //            [self PushViewControllerByClassName:@"BindMobileVC" info:nil];
            
        }else{
            
            for(UIView *view in [self.view subviews])
            {
                [view removeFromSuperview];
            }
            
            [self.view addSubview:self.tableView];
//            self.tableView.frame = VIEWFRAME(0, 0, SCREEN_WIDTH, SCREEN_HIGHT-40);
            [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.view.mas_top).offset(-20);
                make.left.equalTo(self.view.mas_left).offset(0);
                make.right.equalTo(self.view.mas_right).offset(0);
                make.bottom.equalTo(self.view.mas_bottom).offset(0);
            }];

        }

        
        
        
        NSString *imageUrl = self.myDict[@"headimgurl"];
        
        if (imageUrl.length < 5) {
            self.headImage.image = [UIImage imageNamed:@"zhanweitouxiang"];
        }else{
            
            [self.headImage sd_setImageWithURL:[NSURL URLWithString:self.myDict[@"headimgurl"]]];
        }
        
        if ([self.myDict[@"sex"] integerValue] == 1) {
            self.sexImage.image = [UIImage imageNamed:@"男"];
        }else{
            self.sexImage.image = [UIImage imageNamed:@"女生"];
        }
        self.titleLab.text = self.myDict[@"nickname"];
        
        //         NSLog(@"--------%@-------",[LoginModel curLoginUser]);
        
        self.score = [data[@"user"][@"score"] floatValue];
        
    } failue:^(id data, NSError *error) {
        
    }];
    
}



-(void)initData
{
    
}
-(void)initLoginView
{
 

    UIImageView *backGroundImage = [[UIImageView alloc] initWithFrame:APP_BOUNDS];
    backGroundImage.image = [UIImage imageNamed:@"图层-1"];
    [self.view addSubview:backGroundImage];
    self.backgroundView = backGroundImage;
    
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
    
    LoginBtn *BEBtn = [[LoginBtn alloc] initWithFrame:CGRectMake(64.0000/375*SCREEN_WIDTH,217.5000/667*SCREEN_HIGHT , 247.0000/375*SCREEN_WIDTH, 43.0000/667*SCREEN_HIGHT) andImage:[UIImage imageNamed:@"boobe"] andTitle:@"用BOOBE登录"];
    
    
    BEBtn.LoginTag = 1;
    [BEBtn addTarget:self action:@selector(BEBtnAction:)];
    
    LoginBtn *WXBtn = [[LoginBtn alloc] initWithFrame:CGRectMake(64.0000/375*SCREEN_WIDTH,284.0000/667*SCREEN_HIGHT , 247.0000/375*SCREEN_WIDTH, 43.0000/667*SCREEN_HIGHT) andImage:[UIImage imageNamed:@"微信"] andTitle:@"用微信账号登录"];
    WXBtn.LoginTag = 2;
    [WXBtn addTarget:self action:@selector(BEBtnAction:)];
    
    LoginBtn *WBBtn = [[LoginBtn alloc] initWithFrame:CGRectMake(64.0000/375*SCREEN_WIDTH,350.5000/667*SCREEN_HIGHT , 247.0000/375*SCREEN_WIDTH, 43.0000/667*SCREEN_HIGHT) andImage:[UIImage imageNamed:@"微博"] andTitle:@"用微博账号登录"];
    WBBtn.LoginTag = 3;
    [WBBtn addTarget:self action:@selector(BEBtnAction:)];

    LoginBtn *QQBtn = [[LoginBtn alloc] initWithFrame:CGRectMake(64.0000/375*SCREEN_WIDTH,417.0000/667*SCREEN_HIGHT , 247.0000/375*SCREEN_WIDTH, 43.0000/667*SCREEN_HIGHT) andImage:[UIImage imageNamed:@"QQ"] andTitle:@"用QQ账号登录"];
    QQBtn.LoginTag = 4;
    [QQBtn addTarget:self action:@selector(BEBtnAction:)];


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
    if (sender.LoginTag == 2) {
        [self getUserInfoForPlatform:UMSocialPlatformType_WechatSession andType:3];
    }
    if (sender.LoginTag == 3) {
        [self getUserInfoForPlatform:UMSocialPlatformType_Sina andType:4];
    }
    if (sender.LoginTag == 4) {
        [self getUserInfoForPlatform:UMSocialPlatformType_QQ andType:2];
    }

}

#pragma mark -- getters and setters


- (UITableView *)tableView{
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:VIEWFRAME(0, -20, SCREEN_WIDTH, SCREEN_HIGHT+40) style:UITableViewStyleGrouped];
        _tableView.dataSource      = self;
        _tableView.delegate        = self;
        [_tableView registerClass:[MeCell class] forCellReuseIdentifier:@"meCell"];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.tableHeaderView = self.headView;
        _tableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
        _tableView.sectionHeaderHeight = 0.0;
        _tableView.sectionFooterHeight = 0.0;

    }
    return _tableView;
}

- (UIView *)headView{
    if (!_headView) {
        _headView = [[UIView alloc] initWithFrame:VIEWFRAME(0, 0, SCREEN_WIDTH, 324.0000/667*SCREEN_HIGHT)];
        _headView.backgroundColor = [UIColor whiteColor];
        
        UIImageView *BGImage = [[UIImageView alloc] initWithFrame:VIEWFRAME(0, 0, SCREEN_WIDTH, 236.0000/667*SCREEN_HIGHT)];
        BGImage.image = [UIImage imageNamed:@"背景1"];
        
        UIImageView *headImage = [[UIImageView alloc] initWithFrame:VIEWFRAME( (SCREEN_WIDTH - CommonHight(86))/2, CommonHight(59.5), CommonHight(86), CommonHight(86))];
        headImage.image = [UIImage imageNamed:@""];
        ViewRadius(headImage, headImage.frame.size.width/2);
        self.headImage = headImage;
        
        UIImageView *sexImage = [[UIImageView alloc] initWithFrame:VIEWFRAME(CommonWidth(205), CommonHight(125), CommonHight(18), CommonHight(18))];
        sexImage.image = [UIImage imageNamed:@""];
        ViewRadius(sexImage, CommonHight(18)/2);
        self.sexImage = sexImage;
        
        UILabel *nickLab = [UILabel createLabelWithFrame:CommonVIEWFRAME(0, 161, 375, 14)
                                          andText:@""
                                     andTextColor:[UIColor colorWithHexColorString:@"4e817f"]
                                       andBgColor:[UIColor clearColor]
                                          andFont:SYSTEMFONT(14)
                                 andTextAlignment:NSTextAlignmentCenter];
        self.titleLab = nickLab;
        UIFont *font;
        if (SCREEN_HIGHT < 568) {
            font = SYSTEMFONT(10);
        }else{
            font = SYSTEMFONT(12);
        }
        
        UIButton *followBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [followBtn setTitle:@"我的关注" forState:UIControlStateNormal];
        [followBtn setTintColor:[UIColor whiteColor]];
        [followBtn addTarget:self action:@selector(followAction:) forControlEvents:UIControlEventTouchUpInside];
        followBtn.titleLabel.font = font;
        followBtn.frame = CommonVIEWFRAME(82, 185.5, 79, 26);
        ViewBorderRadius(followBtn, CommonHight(26)/2, 1, [UIColor whiteColor]);
        
        UIButton *identifyBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [identifyBtn setTitle:@"身份认证" forState:UIControlStateNormal];
        [identifyBtn setTintColor:[UIColor whiteColor]];
        [identifyBtn addTarget:self action:@selector(identityAction:) forControlEvents:UIControlEventTouchUpInside];
        identifyBtn.titleLabel.font = font;
        identifyBtn.frame = CommonVIEWFRAME(212, 185.5, 79, 26);
        ViewBorderRadius(identifyBtn, CommonHight(26)/2, 1, [UIColor whiteColor]);
        
        UIButton *personBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [personBtn setTitle:@"个人资料" forState:UIControlStateNormal];
        [personBtn setTintColor:[UIColor whiteColor]];
        personBtn.tag = 103;
        [personBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        personBtn.titleLabel.font = SYSTEMFONT(14);
        personBtn.frame = VIEWFRAME(CommonWidth(375-90), CommonHight(50), 80, 14);
        
        NSArray *titleArray = @[@"我的租赁",@"我的买卖",@"我的养护",@"我的鉴定"];
        NSArray *imageArray = @[@"图层-114",@"买买买买",@"养护",@"图层-118"];
        CGFloat width = (SCREEN_WIDTH - 192)/5;
        NSLog(@"width %lf",width);
        int k = 0;
        for (int i = 0; i < 4 ; i++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
            btn.frame = CGRectMake(width + i * (48 + width), CommonHight(236)+(CommonHight(78)-48)/2, 48, 48);
            UIImage *image = [UIImage imageNamed:imageArray[k]];
            [btn setImage:[image imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)] forState:UIControlStateNormal];
            [btn setTitle:titleArray[k] forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:13];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            //        CGSize titleSize = btn.titleLabel.bounds.size;
            CGSize imageSize = btn.imageView.bounds.size;
            [btn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
            btn.tag = k;
            if (k == 0 || k == 1) {
                btn.imageEdgeInsets = UIEdgeInsetsMake(0,10,21,0);
                btn.titleEdgeInsets = UIEdgeInsetsMake(imageSize.width+10,-25, 0, -4);
            }
            if (k == 2) {
                btn.imageEdgeInsets = UIEdgeInsetsMake(0,4,21,0);
                btn.titleEdgeInsets = UIEdgeInsetsMake(imageSize.width+15,-25, 0, -4);
            }
            if (k == 3) {
                btn.imageEdgeInsets = UIEdgeInsetsMake(0,10,21,0);
                btn.titleEdgeInsets = UIEdgeInsetsMake(imageSize.width+3,-25, 0, -4);
            }

            [_headView addSubview:btn];
            k++;
        }
        
        [_headView addSubview:BGImage];
        [_headView addSubview:headImage];
        [_headView addSubview:sexImage];
        [_headView addSubview:nickLab];
        [_headView addSubview:followBtn];
        [_headView addSubview:identifyBtn];
        [_headView addSubview:personBtn];
        
        [personBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(80, 14));
            make.top.equalTo(_headView.mas_top).offset(CommonHight(45));
            make.right.equalTo(_headView.mas_right).offset(CommonWidth(-10));
        }];
    }
    return _headView;
}

#pragma mark -- UITabelViewDelegate And DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 9;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"meCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell fillTitle:self.titleArr[indexPath.row] andImage:self.imageArr[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 52;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor colorWithHexColorString:@"f7f7f7"];
    return view;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 4:{
            NSMutableArray *vcArr = [NSMutableArray array];
            for (int i =0; i<2; i++) {
                UIViewController *vc = [[UIViewController alloc] init];
                vc.view.backgroundColor = [UIColor whiteColor];
                [vcArr addObject:vc];
            }
            NSArray *array = @[@"我的啵客",@"我的啵主"];
            ServeceCenterVC *vc = [[ServeceCenterVC alloc] initWithControllers:vcArr titles:array type:2];
            [self pushViewController:vc];

        }
            break;
        case 5:{
            [self PushViewControllerByClassName:@"MyKeepVC" info:nil];
            
        }
            break;
        case 7:{
            [self PushViewControllerByClassName:@"SetVC" info:nil];

        }
            break;
        case 6:{
            MQChatViewManager *chatViewManager = [[MQChatViewManager alloc] init];
            [chatViewManager.chatViewStyle setEnableRoundAvatar:YES];
            [chatViewManager setClientInfo:@{@"name":@"updated",@"avatar":@"http://pic1a.nipic.com/2008-10-27/2008102715429376_2.jpg"} override:YES];
            [chatViewManager pushMQChatViewControllerInViewController:self];

        }
            break;

        case 2:{
            [self PushViewControllerByClassName:@"ShareVC" info:nil];
            
        }
            break;

        case 0:{
            self.type = 1;
            [self PushViewControllerByClassName:@"MyWallet" info:nil];
            
        }
        case 1:{
            NSDictionary *dic = @{@"score" :@(self.score)};
            [self PushViewControllerByClassName:@"MyBoobeValue" info:dic];
            
        }
            break;
        case 8:{
            [self initLoginView];

            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            [userDefaults setBool:NO forKey:kLoginState];

        }

            break;

        default:
            break;
    }
    
    
}

-(NSMutableArray *)titleArr
{
    if (!_titleArr) {
        _titleArr = [[NSMutableArray alloc] initWithObjects:@"我的钱包",@"我的啵值",@"分享奖励",@"我的信用",@"服务中心",@"我的收藏",@"联系客服",@"设置",@"退出", nil];
    }
    return _titleArr;
}

-(NSMutableArray *)imageArr
{
    if (!_imageArr) {
        _imageArr = [[NSMutableArray alloc] initWithObjects:@"钱包",@"积分",@"奖励",@"信用",@"服务-(3)",@"收藏",@"联系客服",@"设置-(1)",@"mine_loginout", nil];
    }
    return _imageArr;
}

- (void)getUserInfoForPlatform:(UMSocialPlatformType)platformType andType:(NSInteger)type
{
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:platformType currentViewController:self completion:^(id result, NSError *error) {
        UMSocialUserInfoResponse *userinfo =result;
//        NSString *message = [NSString stringWithFormat:@"name: %@\n icon: %@\n gender: %@\n",userinfo.openid,userinfo.iconurl,userinfo.gender];
        
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"UserInfo"
//                                                        message:message
//                                                       delegate:nil
//                                              cancelButtonTitle:NSLocalizedString(@"确定", nil)
//                                              otherButtonTitles:nil];
//        [alert show];
//        
//        UMSocialUserInfoResponse *resp = result;
//
//        NSLog(@" uid: %@", resp.uid);
//        NSLog(@" openid: %@", resp.openid);
//        NSLog(@" accessToken: %@", resp.accessToken);
//        NSLog(@" refreshToken: %@", resp.refreshToken);
//        NSLog(@" expiration: %@", resp.expiration);
//        
//        // 用户数据
//        NSLog(@" name: %@", resp.name);
//        NSLog(@" iconurl: %@", resp.iconurl);
//        NSLog(@" gender: %@", resp.gender);
//        
//        // 第三方平台SDK原始数据
//        NSLog(@" originalResponse: %@", resp.originalResponse);
//        
        if (userinfo.gender.length > 0) {
            
            if (type == 4) {
                
                
                
                [BaseRequest ThirdLoginWithOpenID:userinfo.uid nickname:userinfo.name headimgurl:userinfo.iconurl pf:type succesBlock:^(id data) {
                    //                NSLog(@"====%@=====",describe(data));
                
                    
                    
                    [self loadingRequest1];
                    
                    
                } failue:^(id data, NSError *error) {
                    
                }];
                
                
                

            }else{
                [BaseRequest ThirdLoginWithOpenID:userinfo.openid nickname:userinfo.name headimgurl:userinfo.iconurl pf:type succesBlock:^(id data) {
                    //                NSLog(@"====%@=====",describe(data));
          
                    [self loadingRequest1];
                    
                    
                } failue:^(id data, NSError *error) {
                    
                }];

            }
            
            

        }
//            [self PushViewControllerByClassName:@"BindMobileVC" info:nil];
    }];
}




-(void)viewDidDisappear:(BOOL)animated
{
    if (self.type == 0) {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];//设置电池条颜色为黑色

    }
}

-(void)btnAction:(UIButton *)sender
{
    if (sender.tag == 103) {
        [self PushViewControllerByClassName:@"PersonalInfoVC" info:self.myDict];
    }
}


-(void)buttonAction:(UIButton *)sender
{
    NSMutableArray *vcArr = [NSMutableArray array];
    for (int i =0; i<4; i++) {
        UIViewController *vc = [[UIViewController alloc] init];
        vc.view.backgroundColor = [UIColor whiteColor];
        [vcArr addObject:vc];
    }
    switch (sender.tag) {
        case 0:{
//            NSMutableArray *vcArr1 = [NSMutableArray array];
//            for (int i =0; i<5; i++) {
//                UIViewController *vc = [[UIViewController alloc] init];
//                vc.view.backgroundColor = [UIColor whiteColor];
//                [vcArr1 addObject:vc];
//            }
//            NSArray *array = @[@"待审核",@"发布中",@"租赁中",@"已下架",@"未通过"];
//            MyDistributeVC *vc = [[MyDistributeVC alloc] initWithControllers:vcArr1 titles:array type:1];
//            
//            [self pushViewController:vc];
            [self PushViewControllerByClassName:@"MyTenancyVC" info:nil];
            break;
        }
        case 1:{
//            NSArray *array = @[@"啵客待收",@"进行中",@"啵主确认",@"已完成"];
//            MyRentVC *vc = [[MyRentVC alloc] initWithControllers:vcArr titles:array type:1];
//            [self pushViewController:vc];
            [self PushViewControllerByClassName:@"MyBusiness" info:nil];
            break;
        }

        case 2:{
            NSMutableArray *vcArr2 = [NSMutableArray array];
            for (int i =0; i<2; i++) {
                UIViewController *vc = [[UIViewController alloc] init];
                vc.view.backgroundColor = [UIColor whiteColor];
                [vcArr2 addObject:vc];
            }
            NSArray *array = @[@"养护中",@"已完成"];
            MyMaintainVC *vc = [[MyMaintainVC alloc] initWithControllers:vcArr2 titles:array type:1];
            [self pushViewController:vc];
//            [self PushViewControllerByClassName:@"MyMaintainVC" info:nil];

            break;
        }

        case 3:{
//            [self PushViewControllerByClassName:@"MyAppraiseVC" info:nil];
            NSMutableArray *vcArr2 = [NSMutableArray array];
            for (int i =0; i<2; i++) {
                UIViewController *vc = [[UIViewController alloc] init];
                vc.view.backgroundColor = [UIColor whiteColor];
                [vcArr2 addObject:vc];
            }
            NSArray *array = @[@"鉴定中",@"已完成"];
            MyAppraiseVC *vc = [[MyAppraiseVC alloc] initWithControllers:vcArr2 titles:array type:1];
            [self pushViewController:vc];

            break;
        }

        default:
            break;
    }
}

-(void)identityAction:(UIButton *)sender
{
    [self PushViewControllerByClassName:@"IdentityVC" info:nil];
}

-(void)followAction:(UIButton *)sender
{
    [self PushViewControllerByClassName:@"MyFollowVC" info:nil];
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
