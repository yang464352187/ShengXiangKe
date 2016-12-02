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

@interface MeVC ()

@property(nonatomic, strong)UIButton *loginBtn;
@property(nonatomic, strong)UILabel *firstLab;
@property(nonatomic, strong)UILabel *secondLab;
@property(nonatomic, strong)UILabel *thirdLab;
@property(nonatomic, strong)UIView *loginView;
@property (strong, nonatomic)UIView *headView;
@property (nonatomic, strong)NSMutableArray *titleArr;
@property (nonatomic, strong)NSMutableArray *imageArr;


@end

@implementation MeVC
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];//设置电池条颜色为白色


}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //判断是否登录
    self.navigationController.navigationBar.hidden = YES;

    int login = 1;
    if(login){
        [self.view addSubview:self.tableView];
    }else{
        [self initLoginView];
    }
    
}

-(void)initData
{
    
}
-(void)initLoginView
{
    
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
        headImage.image = [UIImage imageNamed:@"广告"];
        ViewRadius(headImage, headImage.frame.size.width/2);
        
        UIImageView *sexImage = [[UIImageView alloc] initWithFrame:VIEWFRAME(CommonWidth(205), CommonHight(125), CommonHight(18), CommonHight(18))];
        sexImage.image = [UIImage imageNamed:@"女生"];
        ViewRadius(sexImage, CommonHight(18)/2);
        
        UILabel *nickLab = [UILabel createLabelWithFrame:CommonVIEWFRAME(0, 161, 375, 14)
                                          andText:@"好肥一只鱼"
                                     andTextColor:[UIColor colorWithHexColorString:@"4e817f"]
                                       andBgColor:[UIColor clearColor]
                                          andFont:SYSTEMFONT(14)
                                 andTextAlignment:NSTextAlignmentCenter];
        UIFont *font;
        if (SCREEN_HIGHT < 568) {
            font = SYSTEMFONT(10);
        }else{
            font = SYSTEMFONT(12);
        }
        
        UIButton *followBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [followBtn setTitle:@"我的关注" forState:UIControlStateNormal];
        [followBtn setTintColor:[UIColor whiteColor]];
        followBtn.titleLabel.font = font;
        followBtn.frame = CommonVIEWFRAME(82, 185.5, 79, 26);
        ViewBorderRadius(followBtn, CommonHight(26)/2, 1, [UIColor whiteColor]);
        
        UIButton *identifyBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [identifyBtn setTitle:@"身份认证" forState:UIControlStateNormal];
        [identifyBtn setTintColor:[UIColor whiteColor]];
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
        
        NSArray *titleArray = @[@"我的发布",@"我的租赁",@"我的养护",@"我的鉴定"];
        NSArray *imageArray = @[@"发布",@"图层-114",@"养护",@"图层-118"];
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
    if (indexPath.row == 8) {
        [self PushViewControllerByClassName:@"SetVC" info:nil];
    }
}

-(NSMutableArray *)titleArr
{
    if (!_titleArr) {
        _titleArr = [[NSMutableArray alloc] initWithObjects:@"我的钱包",@"我的积分",@"分享奖励",@"我的信用",@"服务中心",@"我的买卖",@"我的收藏",@"联系客服",@"设置", nil];
    }
    return _titleArr;
}

-(NSMutableArray *)imageArr
{
    if (!_imageArr) {
        _imageArr = [[NSMutableArray alloc] initWithObjects:@"钱包",@"积分",@"奖励",@"信用",@"服务-(3)",@"买买买买",@"收藏",@"联系客服",@"设置-(1)", nil];
    }
    return _imageArr;
}


-(void)viewDidDisappear:(BOOL)animated
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];//设置电池条颜色为黑色
}

-(void)btnAction:(UIButton *)sender
{
    if (sender.tag == 103) {
        [self PushViewControllerByClassName:@"PersonalInfoVC" info:nil];
    }
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
