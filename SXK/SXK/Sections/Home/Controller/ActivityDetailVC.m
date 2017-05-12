//
//  ActivityDetailVC.m
//  SXK
//
//  Created by 杨伟康 on 2016/12/8.
//  Copyright © 2016年 ywk. All rights reserved.
//

#import "ActivityDetailVC.h"
#import "AppDelegate.h"

@interface ActivityDetailVC ()

@property (nonatomic, strong)UIScrollView *myScrollView;

@property (nonatomic, strong)UIImageView *headImage;

@property (nonatomic, strong)UILabel *titleLab;

@property (nonatomic, strong)UILabel *addressLab;

@property (nonatomic, strong)UILabel *timeLab;

@property (nonatomic, strong)UILabel *contentLab;

@property (nonatomic, strong)UILabel *detailLab;

@property (nonatomic, strong)UIWebView *webView;

@property (nonatomic, strong)UIView *backGroundView;

@property (nonatomic, strong)UIView *alertView;

@property (nonatomic, strong)UILabel *name;

@property (nonatomic, strong)UITextField *text;

@end

@implementation ActivityDetailVC
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadingRequest];
}

-(void)loadingRequest
{
    
    NSNumber *activity = self.myDict[@"activityid"];
    
    _weekSelf(weakSelf);
    [BaseRequest GetActivityDetailWithActivityID:[activity integerValue] succesBlock:^(id data) {
        NSDictionary *dic = data[@"activity"];
        [weakSelf handleData:dic];
        

    } failue:^(id data, NSError *error) {
        
    }];
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"活动详情";
    self.view.backgroundColor = [UIColor redColor];
    [self initUI];
}

-(void)initUI
{
    self.headImage = [[UIImageView alloc] initWithFrame:VIEWFRAME(0, 0, SCREEN_WIDTH, 219)];
    self.headImage.image = [UIImage imageNamed:@"背景"];
    
    self.titleLab = [UILabel createLabelWithFrame:VIEWFRAME(0,236.5, SCREEN_WIDTH, 14)
                                      andText:@"这是标题标题标题标题标题标题标题"
                                 andTextColor:[UIColor blackColor]
                                   andBgColor:[UIColor clearColor]
                                      andFont:SYSTEMFONT(14)
                             andTextAlignment:NSTextAlignmentCenter];
    
    
    self.addressLab = [UILabel createLabelWithFrame:VIEWFRAME(0,261.5, SCREEN_WIDTH, 11)
                                          andText:@"福建省厦门市思明区厦门国际会计学院"
                                     andTextColor:APP_COLOR_GRAY_Font
                                       andBgColor:[UIColor clearColor]
                                          andFont:SYSTEMFONT(11)
                                 andTextAlignment:NSTextAlignmentCenter];
    
    self.timeLab = [UILabel createLabelWithFrame:VIEWFRAME(0,283.5, SCREEN_WIDTH, 11)
                                          andText:@"2016-06-18   18:00"
                                     andTextColor:APP_COLOR_GRAY_Font
                                       andBgColor:[UIColor clearColor]
                                          andFont:SYSTEMFONT(11)
                                 andTextAlignment:NSTextAlignmentCenter];

    
    self.detailLab = [UILabel createLabelWithFrame:VIEWFRAME(0,283.5, SCREEN_WIDTH, 13)
                                              andText:@"详情"
                                         andTextColor:APP_COLOR_GRAY_Font
                                           andBgColor:[UIColor clearColor]
                                              andFont:SYSTEMFONT(13)
                                     andTextAlignment:NSTextAlignmentCenter];
    
    
    UIView *leftLine = [[UIView alloc] init];
    leftLine.backgroundColor = APP_COLOR_GRAY_Line;
    
    UIView *rightLine = [[UIView alloc] init];
    rightLine.backgroundColor = APP_COLOR_GRAY_Line;
    
    
    self.contentLab = [UILabel createLabelWithFrame:VIEWFRAME(15,283.5, 30, 13)
                                            andText:@"详情"
                                       andTextColor:[UIColor redColor]
                                         andBgColor:[UIColor clearColor]
                                            andFont:SYSTEMFONT(13)
                                   andTextAlignment:NSTextAlignmentCenter];
    self.contentLab.numberOfLines = 0;
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.headIndent = 20;//缩进
    
    [self.myScrollView addSubview:self.headImage];
    [self.myScrollView addSubview:self.titleLab];
    [self.myScrollView addSubview:self.addressLab];
    [self.myScrollView addSubview:self.timeLab];
    [self.myScrollView addSubview:self.detailLab];
    [self.myScrollView addSubview:leftLine];
    [self.myScrollView addSubview:rightLine];
    [self.myScrollView addSubview:self.webView];

    [self.view addSubview:self.myScrollView];
    
    [self.detailLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.equalTo(self.timeLab).offset(20);
        make.size.mas_equalTo(CGSizeMake(28, 13));
    }];
    
    [leftLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.detailLab);
        make.right.equalTo(self.detailLab.mas_left).offset(-18);
        make.size.mas_equalTo(CGSizeMake(34, 0.5));
    }];
    
    [rightLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.detailLab);
        make.left.equalTo(self.detailLab.mas_right).offset(18);
        make.size.mas_equalTo(CGSizeMake(34, 0.5));
    }];
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor whiteColor];
    
    UIButton *certainBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [certainBtn setTitle:@"我要报名" forState:UIControlStateNormal];
    certainBtn.backgroundColor = APP_COLOR_GREEN;
    [certainBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [certainBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    certainBtn.titleLabel.font = SYSTEMFONT(14);
    certainBtn.frame = VIEWFRAME(15, 20, CommonWidth(335), 40);
    ViewRadius(certainBtn, certainBtn.frame.size.height/2);
    
    UIView *line =[[UIView alloc] initWithFrame:VIEWFRAME(0, 0, SCREEN_WIDTH, 0.5)];
    line.backgroundColor = APP_COLOR_GRAY_Line;
    
    [view addSubview:certainBtn];
    [view addSubview:line];
    [self.view addSubview:view];
    
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.bottom.equalTo(self.view.mas_bottom).offset(0);
        make.height.mas_equalTo(80);
    }];
    
    
    
    self.backGroundView  = [[UIView alloc] initWithFrame:VIEWFRAME(0, 0, SCREEN_WIDTH, SCREEN_HIGHT)];
    self.backGroundView.backgroundColor = [UIColor colorWithHexColorString:@"3c3c3c"];
    self.backGroundView.alpha = 0.5;

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self.backGroundView addGestureRecognizer:tap];

    self.alertView = [[UIView alloc] initWithFrame:VIEWFRAME(30, SCREEN_HIGHT, CommonWidth(315), 190)];
    self.alertView.backgroundColor = [UIColor whiteColor];

    UILabel *title1 = [UILabel createLabelWithFrame:VIEWFRAME(15,283.5, 30, 13)
                                            andText:@"以下是您的报名信息，请确认！"
                                       andTextColor:[UIColor blackColor]
                                         andBgColor:[UIColor clearColor]
                                            andFont:SYSTEMFONT(13)
                                   andTextAlignment:NSTextAlignmentLeft];
    
    UILabel *title2 = [UILabel createLabelWithFrame:VIEWFRAME(15,283.5, 30, 13)
                                            andText:@"昵称:"
                                       andTextColor:APP_COLOR_GRAY_Font
                                         andBgColor:[UIColor clearColor]
                                            andFont:SYSTEMFONT(13)
                                   andTextAlignment:NSTextAlignmentLeft];
    
    UILabel *title3 = [UILabel createLabelWithFrame:VIEWFRAME(15,283.5, 30, 13)
                                            andText:@"电话:"
                                       andTextColor:APP_COLOR_GRAY_Font
                                         andBgColor:[UIColor clearColor]
                                            andFont:SYSTEMFONT(13)
                                   andTextAlignment:NSTextAlignmentLeft];

    self.name = [UILabel createLabelWithFrame:VIEWFRAME(15,283.5, 30, 13)
                                            andText:@""
                                       andTextColor:[UIColor blackColor]
                                   andBgColor:[UIColor clearColor]
                                            andFont:SYSTEMFONT(13)
                                   andTextAlignment:NSTextAlignmentLeft];
    
    self.text = [[UITextField alloc] init];
    self.text.font = SYSTEMFONT(13);
    
    [self.alertView addSubview:title1];
    [self.alertView addSubview:title2];
    [self.alertView addSubview:title3];
    [self.alertView addSubview:self.name];
    [self.alertView addSubview:self.text];
    
    [title1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.alertView.mas_top).offset(30);
        make.left.equalTo(self.alertView.mas_left).offset(50);
        make.right.equalTo(self.alertView.mas_right).offset(-30);
        make.height.mas_equalTo(@(16));
    }];
    
    [title2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(title1.mas_bottom).offset(15);
        make.left.equalTo(self.alertView.mas_left).offset(50);
        make.size.mas_equalTo(CGSizeMake(45, 16));
    }];
    
    [title3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(title2.mas_bottom).offset(15);
        make.left.equalTo(self.alertView.mas_left).offset(50);
        make.size.mas_equalTo(CGSizeMake(45, 16));
    }];
    
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(title2);
        make.left.equalTo(title2.mas_right).offset(10);
        make.right.equalTo(self.alertView.mas_right).offset(30);
        make.height.mas_equalTo(@(16));
    }];
    [self.text mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(title3);
        make.left.equalTo(title3.mas_right).offset(10);
        make.right.equalTo(self.alertView.mas_right).offset(30);
        make.height.mas_equalTo(@(16));
    }];

    UIButton *cancelBtn =[UIButton buttonWithType:UIButtonTypeSystem];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor colorWithHexColorString:@"aaaaaa"] forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
    cancelBtn.frame = VIEWFRAME(CommonWidth(57), 131, 81, 27);
    ViewBorderRadius(cancelBtn, 27/2, 0.5, [UIColor colorWithHexColorString:@"aaaaaa"]);
    
    UIButton *certainBtn1 =[UIButton buttonWithType:UIButtonTypeSystem];
    [certainBtn1 setTitle:@"确定" forState:UIControlStateNormal];
    [certainBtn1 setTitleColor:APP_COLOR_GREEN forState:UIControlStateNormal];
    [certainBtn1 addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    certainBtn1.frame = VIEWFRAME(CommonWidth(178), 131, 81, 27);
    ViewBorderRadius(certainBtn1, 27/2, 0.5, APP_COLOR_GREEN);

    [self.alertView addSubview:cancelBtn];
    [self.alertView addSubview:certainBtn1];

}

-(void)cancelAction:(UIButton *)sender
{
    [self disMiss];
}

-(void)buttonAction:(UIButton *)sender
{
    
    if (![LoginModel isLogin]) {
        [ProgressHUDHandler showHudTipStr:@"请先登录"];
        [[PushManager sharedManager] presentLoginVC];
        return;
    }

    
    NSNumber *activity = self.myDict[@"activityid"];

    _weekSelf(weakSelf);
    [BaseRequest EnterActivityWithActivityid:[activity integerValue]  nickname:self.name.text mobile:self.text.text succesBlock:^(id data) {
        if ([data[@"code"] integerValue ] == 1) {
            [ProgressHUDHandler showHudTipStr:@"报名成功"];
            [weakSelf disMiss];
            [weakSelf popGoBack];
        }else{
            [ProgressHUDHandler showHudTipStr:@"请勿重复报名"];
            [weakSelf disMiss];
            [weakSelf popGoBack];

        }
        
    } failue:^(id data, NSError *error) {
        [ProgressHUDHandler showHudTipStr:@"请勿重复报名"];
        [weakSelf disMiss];
        [weakSelf popGoBack];

    }];
}


#pragma mark -- UITabelViewDelegate And DataSource
-(UIScrollView *)myScrollView
{
    if (!_myScrollView) {
        _myScrollView  =  [[UIScrollView alloc] initWithFrame:VIEWFRAME(0, 0, SCREEN_WIDTH, SCREEN_HIGHT - 110)];
        _myScrollView.backgroundColor = [UIColor whiteColor];
        _myScrollView.bounces = YES;
        _myScrollView.showsHorizontalScrollIndicator = NO;
        _myScrollView.showsVerticalScrollIndicator = NO;
        _myScrollView.scrollsToTop = YES;

        _myScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, 800);

        
    }
    return _myScrollView;
}


-(void)handleData:(NSDictionary *)data
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",APP_BASEIMG,data[@"img"]]];
    [self.headImage sd_setImageWithURL:url];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:@"yyyy年MM月dd日 HH:mm"];
    
    NSDate*confromTimesp = [NSDate dateWithTimeIntervalSince1970:[data[@"time"] integerValue]];
    
    NSString*confromTimespStr = [formatter stringFromDate:confromTimesp];
    
    self.timeLab.text = confromTimespStr;
    
    self.titleLab.text = data[@"name"];
    
    CGFloat height = [UILabel getHeightByWidth:SCREEN_WIDTH - 30 title:data[@"content"] font:SYSTEMFONT(15.5)];

    NSString *jsString = [NSString stringWithFormat:@"<html> \n"
                          "<head> \n"
                          "<style type=\"text/css\"> \n"
                          "body {font-size: %f; font-family: \"%@\"; color: %@;}\n"
                          "</style> \n"
                          "</head> \n"
                          "<body>%@</body> \n"
                          "</html>", 13.0f, @"Times New Roman", @"black", data[@"content"]];
    
    [self.webView loadHTMLString:jsString baseURL:nil];
    
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.detailLab.mas_bottom).offset(15);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 30, height));
        make.left.equalTo(self.myScrollView.mas_left).offset(15);
    }];
    
    self.myScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, self.contentLab.frame.origin.y + height+40);
}


- (UIWebView *)webView
{
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
        _webView.dataDetectorTypes = UIDataDetectorTypeAll;
        _webView.backgroundColor = [UIColor clearColor];
        _webView.scrollView.bounces = NO;
        _webView.scrollView.scrollEnabled = YES;
    }
    return _webView;
}


-(void)btnAction:(UIButton *)sender
{
    [self loadingView];
}

-(void)loadingView
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate.window addSubview:self.backGroundView];
    [appDelegate.window addSubview:self.alertView];
    
    UserModel *model = [LoginModel curLoginUser];
    
    self.name.text = model.nickname;
    self.text.text = model.mobile;
    
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    
    dispatch_async(queue, ^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [UIView animateWithDuration:0.5 animations:^{
                
                self.alertView.frame = VIEWFRAME(CommonWidth(30), CommonHight(294), CommonWidth(315), 190);
                
            } completion:^(BOOL finished) {
                
            }];
        });
    });

}

-(void)tapAction:(UITapGestureRecognizer *)tap
{
    [self disMiss];
}

-(void)disMiss
{
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    
    dispatch_async(queue, ^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [UIView animateWithDuration:0.5 animations:^{
                
                  self.alertView.frame = VIEWFRAME(30, SCREEN_HIGHT,CommonWidth(315), CommonHight(190));
                
            } completion:^(BOOL finished) {
                
                [self.backGroundView removeFromSuperview];
                [self.alertView removeFromSuperview];
                
            }];
        });
    });
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    
    
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
