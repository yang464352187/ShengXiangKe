//
//  MyBoobeValue.m
//  SXK
//
//  Created by 杨伟康 on 2017/2/22.
//  Copyright © 2017年 ywk. All rights reserved.
//

#import "MyBoobeValue.h"
#import "MyWalletCell.h"
#import "MyBoobeCell.h"
#import "RcordModel.h"


@interface MyBoobeValue ()

@property (strong, nonatomic) UIView *headView;

@property (strong, nonatomic) UIView *titleView;

@property (strong, nonatomic) UIButton *leftBtn;

@property (strong, nonatomic) UILabel *titleLabel;

@property (strong, nonatomic) UILabel *moneyLabel;

@end

@implementation MyBoobeValue


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadingRequest];
    
    
}

-(void)loadingRequest
{
    
    _weekSelf(weakSelf);
    [BaseRequest GetRecordListWithPageNo:0 PageSize:0 order:1 succesBlock:^(id data) {
        NSArray *models = [RcordModel modelsFromArray:data[@"recordList"]];
        [weakSelf handleModels:models total:[data[@"total"] integerValue]];
//        weakSelf.moneyLabel.text = [NSString stringWithFormat:@"%@",self.myDict[@"score"]];
    } failue:^(id data, NSError *error) {
        
    }];
    
    

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"我的啵值";
    self.navigationController.navigationBarHidden = YES;

    [self.view addSubview:self.tableView];
    
    [self initUI];
    
}


-(void)initUI
{
    
    UIImage *image = [UIImage imageNamed:@"返回-拷贝1"];
    self.leftBtn= [UIButton buttonWithType:UIButtonTypeSystem];
    [self.leftBtn setImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [self.leftBtn addTarget:self  action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    //    leftBtn.backgroundColor = [UIColor redColor];
    
    
    self.titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    self.titleView.backgroundColor = [UIColor whiteColor];
    
    
    self.titleLabel = [UILabel createLabelWithFrame:VIEWFRAME(55, 5.5, 100, 41)                                                 andText:@"我的啵值"
                                       andTextColor:[UIColor whiteColor]
                                         andBgColor:[UIColor clearColor]
                                            andFont:SYSTEMFONT(16)
                                   andTextAlignment:NSTextAlignmentCenter];
    
    
    [self.view addSubview:self.titleView];
    [self.view addSubview:self.leftBtn];
    [self.view addSubview:self.titleLabel];
    
    
    [self.leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(15);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.leftBtn);
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(100, 20));
    }];
    
}

#pragma mark -- UITabelViewDelegate And DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.listData.count+1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        MyWalletCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyWalletCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell fillWithTitle:@"啵值明细"];
        
        return cell;
    }

    MyBoobeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyBoobeCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    RcordModel *model = self.listData[indexPath.section-1];
    [cell setModel:model];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 60;
    }
    return 78;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.000000001;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.000000001;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = APP_COLOR_GRAY_Header;
    return view;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = APP_COLOR_GRAY_Header;
    return view;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}




#pragma mark -- getters and setters


- (UITableView *)tableView{
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:VIEWFRAME(0, -20, SCREEN_WIDTH, SCREEN_HIGHT+20) style:UITableViewStyleGrouped];
        _tableView.dataSource      = self;
        _tableView.delegate        = self;
        _tableView.showsVerticalScrollIndicator = NO;
        [_tableView registerClass:[MyWalletCell class] forCellReuseIdentifier:@"MyWalletCell"];
        [_tableView registerClass:[MyBoobeCell class] forCellReuseIdentifier:@"MyBoobeCell"];
        _tableView.backgroundColor = APP_COLOR_BASE_BACKGROUND;
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.tableHeaderView = self.headView;
        _tableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
        _tableView.sectionHeaderHeight = 0.0;
        _tableView.sectionFooterHeight = 0.0;
        //        _tableView.header = [MJChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshHeaderAction)];
        //        _tableView.footer = [MJChiBaoZiFooter footerWithRefreshingTarget:self refreshingAction:@selector(refreshFooterAction)];
    }
    return _tableView;
}

- (UIView *)headView{
    if (!_headView) {
        _headView = [[UIView alloc] initWithFrame:VIEWFRAME(0, 0, SCREEN_WIDTH, 223.0000)];
        _headView.backgroundColor = [UIColor whiteColor];
        
        UIImageView *BGImage = [[UIImageView alloc] initWithFrame:VIEWFRAME(0, 0, SCREEN_WIDTH, 223.0000)];
        BGImage.image = [UIImage imageNamed:@"矩形-51"];
        
        self.moneyLabel = [UILabel createLabelWithFrame:VIEWFRAME(55, 5.5, 100, 41)                                                 andText:@""
                                           andTextColor:[UIColor whiteColor]
                                             andBgColor:[UIColor clearColor]
                                                andFont:SYSTEMFONT(23)
                                       andTextAlignment:NSTextAlignmentCenter];
        
        UILabel *title = [UILabel createLabelWithFrame:VIEWFRAME(55, 5.5, 100, 41)                                                 andText:@"啵值规则"
                                          andTextColor:[UIColor whiteColor]
                                            andBgColor:[UIColor clearColor]
                                               andFont:SYSTEMFONT(13)
                                      andTextAlignment:NSTextAlignmentCenter];
        
        
        [_headView addSubview:BGImage];
        [_headView addSubview:self.moneyLabel];
        [_headView addSubview:title];
        
//        [_headView addSubview:view];
//        [view addSubview:line];
//        [_headView addSubview:btn];
//        [_headView addSubview:btn1];
        
        [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_headView.mas_top).offset(100);
            make.centerX.equalTo(_headView);
            make.size.mas_equalTo(CGSizeMake(200, 25));
        }];
        
        [title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.moneyLabel.mas_bottom).offset(20);
            make.centerX.equalTo(_headView);
            make.size.mas_equalTo(CGSizeMake(200, 15));
        }];
        
        CGFloat score = [self.myDict[@"score"] floatValue];
        self.moneyLabel.text = [NSString stringWithFormat:@"¥%.2f",score];
        
    }
    return _headView;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //    CGFloat minAlphaOffset = 0;
    //    CGFloat maxAlphaOffset = 100;
    CGFloat offset = scrollView.contentOffset.y + 20;
    //    CGFloat alpha = (offset - minAlphaOffset) / (maxAlphaOffset - minAlphaOffset);
    CGFloat alpha = 1 - ((150 - offset) / 150);
    //    self.titleLabel.textColor = [UIColor colorWithRed:1-alpha green:1-alpha blue:1-alpha alpha:1];
    
    self.titleView.alpha = alpha;
    if (alpha>0.6) {
        UIImage *image = [UIImage imageNamed:@"返回"];
        [self.leftBtn setImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        //        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];//设置电池条颜色为白色
        self.titleLabel.textColor = [UIColor blackColor];
        
    }else{
        UIImage *image = [UIImage imageNamed:@"返回-拷贝1"];
        [self.leftBtn setImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        //        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];//设置电池条颜色为白色
        self.titleLabel.textColor = [UIColor whiteColor];
        
    }
    NSLog(@"%lf       %lf",alpha,offset);
    //    _barImageView.alpha = alpha;
}


-(void)btnAction:(UIButton *)sender
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];//设置电池条颜色为白色
    [self popGoBack];
    
    
}

-(void)depositAction:(UIButton *)sender
{
    [self PushViewControllerByClassName:@"DepositeVC" info:nil];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];//设置电池条颜色为黑色
    
}
-(void)withdrawAction:(UIButton *)sender
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
