//
//  HomeVC.m
//  SXK
//
//  Created by 杨伟康 on 2016/11/11.
//  Copyright © 2016年 ywk. All rights reserved.
//

#import "HomeVC.h"
#import "FirstTableViewCell.h"
#import "ClassifyCell.h"
#import "SpecialCell.h"
#import "MQChatViewManager.h"
#import "MQChatDeviceUtil.h"
#import <MeiQiaSDK/MeiQiaSDK.h>
#import "NSArray+MQFunctional.h"
#import "MQBundleUtil.h"
#import "MQAssetUtil.h"
#import "MQImageUtil.h"
#import "MQToast.h"
#import "TopicModel.h"
#import "UserModel.h"
#import <RongIMKit/RongIMKit.h>
#import "RCConversationListVC.h"
#import "UMessage.h"
#import "AppDelegate.h"
#import <AVFoundation/AVFoundation.h>
#import "QRCodeGenerateVC.h"
#import "QRCodeScanningVC.h"
#import "UIView+UIView_Boom.h"

@interface HomeVC ()<SDCycleScrollViewDelegate>


@property (strong, nonatomic) UIView *headView;
@property (strong, nonatomic) SDCycleScrollView *cycleScrollView;// 头顶滑动视图
@property (strong, nonatomic) NSArray *dataArr;
@property (strong, nonatomic) NSArray *topicArr;
@property (strong, nonatomic) UIView *view1;
@property (strong, nonatomic) UIView *view2;

@property (strong, nonatomic) NSTimer *timer;

@property (strong, nonatomic) UIView *view3;
@property (strong, nonatomic) UIView *view4;
@property (strong, nonatomic) UIView *view5;


@property (nonatomic, assign) NSInteger index;

@property (nonatomic, assign) NSInteger total;

@property (nonatomic, strong) NSMutableArray *webArr;

@end

@implementation HomeVC


-(void)viewWillAppear:(BOOL)animated
{
    
//    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];

//    [UMessage addLaunchMessageWithWindow:self.view.window finishViewController:self];
//    [UMessage addCardMessageWithLabel:@"home"];

    
    [super viewWillAppear:animated];
    _weekSelf(weakSelf);
    [BaseRequest GetAdvertisesetupWithSetupID:1 succesBlock:^(id data) {
//        NSLog(@"%@",describe(data));
        NSDictionary *dic = data[@"setup"];
        NSArray *imageArr = dic[@"list"];
        NSMutableArray *images = [[NSMutableArray alloc] init];
        for (NSDictionary *image in imageArr) {
            NSString *str = [NSString stringWithFormat:@"%@%@",APP_BASEIMG,image[@"img"]];
            [weakSelf.webArr addObject:image[@"link"]];
            [images addObject:str];
        }
        
        
        weakSelf.cycleScrollView.localizationImageNamesGroup = images;
        
    } failue:^(id data, NSError *error) {
        
    }];
    
    [BaseRequest GetHomeClassListWithPageNo:0 PageSize:0 order:-1 succesBlock:^(id data) {
        self.dataArr = data[@"classList"];
//        NSArray *models = [BrandDetailModel modelsFromArray:data[@"setup"][@"rentList"]];
        [weakSelf.tableView reloadData];
        
    } failue:^(id data, NSError *error) {
        
    }];
    
    [BaseRequest GetHomeTopicListWithPageNo:0 PageSize:0 order:-1 succesBlock:^(id data) {
//        NSLog(@"%@",describe(data));
        self.topicArr = [TopicModel modelsFromArray:data[@"topicList"]];
        [weakSelf.tableView reloadData];
        
    } failue:^(id data, NSError *error) {
        
    }];
}


- (void)viewDidLoad {
    [super viewDidLoad];
//     Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];
    self.navigationController.navigationBar.hidden = YES;
    [self.view addSubview:self.tableView];

    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(CloseKeyBoardToolBar) name:MQ_NOTIFICATION_CHAT_BEGIN object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(OpenKeyBoardToolBar) name:MQ_NOTIFICATION_CHAT_END object:nil];
    
    UserModel *model =   [LoginModel curLoginUser];
    [RCIM sharedRCIM].currentUserInfo = [[RCUserInfo alloc] initWithUserId:[NSString stringWithFormat:@"%@",model.userid] name:model.nickname portrait:model.headimgurl];
    self.index = 1;
    self.total = 0;

    [self initView];
    [UIApplication sharedApplication].applicationIconBadgeNumber  =  10;

    self.webArr = [[NSMutableArray alloc] init];
}

-(void)initView
{
    UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 150.0f, 110.0f)];
    
    [self.view addSubview:containerView];
    
    UIView *fromView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, containerView.frame.size.width, containerView.frame.size.height)];
    fromView.backgroundColor = [UIColor clearColor];
    
    UIImageView * image1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, containerView.frame.size.width, containerView.frame.size.height)];
    image1.image = [UIImage imageNamed:@"提示框-5"];
    UILabel *title1 = [UILabel createLabelWithFrame:VIEWFRAME(90,18, SCREEN_WIDTH - 120, 14)
                                            andText:@"这里可以发布属于你自己的商品和使用鉴定服务哦!"
                                       andTextColor:[UIColor blackColor]
                                         andBgColor:[UIColor clearColor]
                                            andFont:SYSTEMFONT(10)
                                   andTextAlignment:NSTextAlignmentCenter];
    title1.numberOfLines = 0;
    [fromView addSubview:image1];
    [image1 addSubview:title1];
    
    UIView *toView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, containerView.frame.size.width, containerView.frame.size.height)];
    toView.backgroundColor = [UIColor clearColor];
    
    UIImageView * image2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, containerView.frame.size.width, containerView.frame.size.height)];
    image2.image = [UIImage imageNamed:@"提示框-5"];
    
    UILabel *title2 = [UILabel createLabelWithFrame:VIEWFRAME(90,18, SCREEN_WIDTH - 120, 14)
                                            andText:@"快点发布属于自己的奢侈品吧!"
                                       andTextColor:[UIColor blackColor]
                                         andBgColor:[UIColor clearColor]
                                            andFont:SYSTEMFONT(10)
                                   andTextAlignment:NSTextAlignmentCenter];
    title2.numberOfLines = 0;
    
    [toView addSubview:image2];
    [toView addSubview:title2];
    [containerView addSubview:fromView];
    
    UIView *containerView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 150.0f, 110.0f)];
    containerView1.alpha = 0;
    [self.view addSubview:containerView1];
    
    [containerView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom).offset(-55);
        make.size.mas_equalTo(CGSizeMake(150, 110));
    }];
    
    [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom).offset(-55);
        make.size.mas_equalTo(CGSizeMake(150, 110));
    }];
    
    [title1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(fromView);
        make.top.equalTo(fromView.mas_top).offset(0);
        make.bottom.equalTo(fromView.mas_bottom).offset(0);
        make.width.mas_equalTo(130);
    }];
    
    [title2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(toView);
        make.top.equalTo(toView.mas_top).offset(0);
        make.bottom.equalTo(toView.mas_bottom).offset(0);
        make.width.mas_equalTo(120);
    }];
    
    
    
    self.view3 = fromView;
    self.view4 = toView;
    self.view5 = containerView;
    
    
    
    NSTimer  *timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(checkUnreadCount) userInfo:nil repeats:YES];
    
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
    self.timer  = timer;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
    [self.view5 addGestureRecognizer:tap];
    

}

-(void)tapped:(UIGestureRecognizer *)gesture
{
    [self GCDMethod:self.view5 afterTime:0];
    [self.timer invalidate];
}


-(void)checkUnreadCount
{
    if (self.total == 10) {
        [self.timer invalidate];
        //        [self.view1 removeFromSuperview];
        //        [self.view2 removeFromSuperview];
        self.timer = nil;
        
        return;
    }else{
        self.total ++;
    }
    
    
    
    if (self.index == 1) {
        [CATransaction flush];
        
        [UIView transitionFromView:self.view3 toView:self.view4 duration:1.0f options:UIViewAnimationOptionTransitionFlipFromLeft completion:NULL];
        self.index = 2;
    }else{
        self.index =1;
        [CATransaction flush];
        
        [UIView transitionFromView:self.view4 toView:self.view3 duration:1.0f options:UIViewAnimationOptionTransitionFlipFromLeft completion:NULL];
    }
    
}

-(void)GCDMethod:(UIView *)myView afterTime:(NSTimeInterval)interval{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(interval * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [myView boom];
    });
}



-(void)changeview
{
    
    self.view1 = [[UIView alloc] initWithFrame:VIEWFRAME(100, 100, 100, 100)];
    self.view1.backgroundColor = [UIColor redColor];
    UIImageView *image = [[UIImageView alloc] initWithFrame:VIEWFRAME(0, 0, 100, 100)];
    image.image = [UIImage imageNamed:@"占位-0"];
    [self.view1 addSubview: image];
    [self.view addSubview:self.view1];
    
    

}


+ (void)animateWithDuration:(NSTimeInterval)duration animations:(void (^)(void))animations completion:(void (^ __nullable)(BOOL finished))completion NS_AVAILABLE_IOS(4_0);{
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- UITabelViewDelegate And DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    if (section == 1) {
        return self.dataArr.count;
    }
    return self.topicArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        FirstTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FirstTableViewCell"];
        cell.vc = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    if (indexPath.section == 1) {
        ClassifyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ClassifyCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSDictionary *dic = self.dataArr[indexPath.row];
        [cell fillWithDic:dic];
        cell.vc = self;
        return cell;
    }
    
    SpecialCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SpecialCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    TopicModel *model = self.topicArr[indexPath.row];
    cell.vc = self;
    [cell setModel:model];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return CommonHight(173);
    }
    if (indexPath.section == 1) {
        return CommonHight(460);
    }
    return CommonHight(224);
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *view = [[UIView alloc] init];

    switch (section) {
        case 0:
            view.backgroundColor = [UIColor colorWithHexColorString:@"f7f7f7"];
            break;
        case 1:{
            view = [self sectionViewWithTitle:@"精选分类" andContent:@"Classify"];
        }
            break;
            
        case 2:{
            view = [self sectionViewWithTitle:@"热门专题" andContent:@"Hot topics"];
        }
            break;

        default:
            break;
    }
    
    
    return view;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    
    switch (section) {
        case 0:
            view.backgroundColor = [UIColor colorWithHexColorString:@"f7f7f7"];
            break;
        case 1:
            view.backgroundColor = [UIColor colorWithHexColorString:@"f7f7f7"];
            break;
            
        case 2:
            view.backgroundColor = [UIColor grayColor];
            break;
            
        default:
            break;
    }

    return view;

}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 15;
    }
    if (section == 1) {
        return CommonHight(42.5);
    }
    return CommonHight(42.5);
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section ==2 || section == 1) {
        return 0;
    }
    return 15;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

#pragma mark -- getters and setters


- (UITableView *)tableView{
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:VIEWFRAME(0, -20, SCREEN_WIDTH, SCREEN_HIGHT+40) style:UITableViewStyleGrouped];
        _tableView.dataSource      = self;
        _tableView.delegate        = self;
        [_tableView registerClass:[FirstTableViewCell class] forCellReuseIdentifier:@"FirstTableViewCell"];
        [_tableView registerClass:[ClassifyCell class] forCellReuseIdentifier:@"ClassifyCell"];
        [_tableView registerClass:[SpecialCell class] forCellReuseIdentifier:@"SpecialCell"];

        _tableView.showsVerticalScrollIndicator = NO;
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
        _headView = [[UIView alloc] initWithFrame:VIEWFRAME(0, 0, SCREEN_WIDTH, 530.0000/667*SCREEN_HIGHT)];
        _headView.backgroundColor = [UIColor whiteColor];
        
        
        NSArray *titleArray = @[@"交换",@"租赁",@"活动",@"鉴定",@"养护"];
        NSArray *imageArray = @[@"图层-115",@"图层-114",@"活动",@"顾问",@"养护"];

        int k = 0;
        for (int j = 0; j < 5; j++) {
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
            btn.frame = CGRectMake(42.5+j * (42.5+24)/375.0000*SCREEN_WIDTH, 301.0000/667*SCREEN_HIGHT, 24, 40);
            UIImage *image = [UIImage imageNamed:imageArray[k]];
            [btn setImage:[image imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)] forState:UIControlStateNormal];
            [btn setTitle:titleArray[k] forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:11];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            CGSize imageSize = btn.imageView.bounds.size;
            btn.imageEdgeInsets = UIEdgeInsetsMake(0,0,21,0);
            btn.titleEdgeInsets = UIEdgeInsetsMake(imageSize.width+10,-25, 0, -4);
            if (k == 0) {
                btn.titleEdgeInsets = UIEdgeInsetsMake(imageSize.width+5,-25, 0, -4);
            }
            if (k == 1) {
                btn.imageEdgeInsets = UIEdgeInsetsMake(0,0,21,0);
                btn.titleEdgeInsets = UIEdgeInsetsMake(imageSize.width+10,-25, 0, -4);
            }
            if (k == 2) {
                btn.titleEdgeInsets = UIEdgeInsetsMake(imageSize.width+7,-25, 0, -4);
            }
            if (k == 3) {
                btn.imageEdgeInsets = UIEdgeInsetsMake(0,3,21,0);
                btn.titleEdgeInsets = UIEdgeInsetsMake(imageSize.width+10,-20, 0, -4);
            }
            if (k == 4) {
                btn.titleEdgeInsets = UIEdgeInsetsMake(imageSize.width+15,-20, 0, -8);
                btn.imageEdgeInsets = UIEdgeInsetsMake(0,6,18,0);
            }
            btn.tag = 100 + k;
            [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
            [_headView addSubview:btn];
            k++;
        }
        
        UIImage *leftImage = [UIImage imageNamed:@"shouyejizu"];
        UIImage *rightImage = [UIImage imageNamed:@"shouyejishou"];
        
        UIButton *leftBtn1 = [UIButton buttonWithType:UIButtonTypeSystem];
        [leftBtn1 setImage:[leftImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        [leftBtn1 addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        leftBtn1.tag = 1000;
        
        UIButton *rightBtn1 = [UIButton buttonWithType:UIButtonTypeSystem];
        [rightBtn1 setImage:[rightImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        [rightBtn1 addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        rightBtn1.tag = 2000;
        
        leftBtn1.frame = VIEWFRAME(10, 361.0000/667*SCREEN_HIGHT, (SCREEN_WIDTH - 30)/2, CommonHight(150));
        rightBtn1.frame = VIEWFRAME(20+(SCREEN_WIDTH - 30)/2, 361.0000/667*SCREEN_HIGHT, (SCREEN_WIDTH - 30)/2, CommonHight(150));

        [_headView addSubview:leftBtn1];
        [_headView addSubview:rightBtn1];
        [_headView addSubview:self.cycleScrollView];
        
        //导航栏中的搜索栏
        UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        searchBtn.frame =  CGRectMake(49.0000/375*SCREEN_WIDTH, 27.5000/667*SCREEN_HIGHT, 274.0000/375*SCREEN_WIDTH, 30.0000/667*SCREEN_HIGHT);
        if (SCREEN_HIGHT <= 667 ) {
            ViewBorderRadius(searchBtn, 0, 0.2, [UIColor colorWithHexColorString:@"313131"]);
        }
        UIImage *image = [UIImage imageNamed:@"搜索-2"];
        [searchBtn setImage:[image imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)] forState:UIControlStateNormal];
        [searchBtn.imageView setContentMode:UIViewContentModeScaleAspectFill];
        searchBtn.alpha = 0.9;
        [searchBtn addTarget:self action:@selector(searchBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_headView addSubview:searchBtn];
        
        
        UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        leftBtn.frame = CommonVIEWFRAME(0, 27, 50.5, 30);
        UIImage *image1 = [UIImage imageNamed:@"图层-158"];
        [leftBtn setImage:[image1 imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)] forState:UIControlStateNormal];
        [leftBtn addTarget:self action:@selector(leftBtn) forControlEvents:UIControlEventTouchUpInside];
        [_headView addSubview:leftBtn];
        
        UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        rightBtn.frame = CommonVIEWFRAME(323, 27, 50.5, 30);
        UIImage *image2 = [UIImage imageNamed:@"图层-157"];
        rightBtn.tag = 201;
        [rightBtn setImage:[image2 imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)] forState:UIControlStateNormal];
        [rightBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [_headView addSubview:rightBtn];
        
    }
    return _headView;
}

- (SDCycleScrollView *)cycleScrollView{
    if (!_cycleScrollView) {
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:VIEWFRAME(0, 0, SCREEN_WIDTH, 274.0000/667*SCREEN_HIGHT)
                                                              delegate:self
                                                      placeholderImage:[UIImage imageNamed:@"占位-0"]];

        _cycleScrollView.showPageControl = YES;
        _cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
        _cycleScrollView.autoScrollTimeInterval = 3;
        _cycleScrollView.backgroundColor = APP_COLOR_BASE_BACKGROUND;
        _cycleScrollView.pageDotColor = [UIColor whiteColor];
        _cycleScrollView.currentPageDotColor = APP_COLOR_GREEN;
//        _cycleScrollView.delegate = self;
    }
    return _cycleScrollView;
}

#pragma mark -- SDCycle Delegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
//    if (self.sliderList.count) {
//        SliderModel *slider = self.sliderList[index];
//        if (slider.type.integerValue == 1) {
//            NSDictionary *info = @{@"sellerid":slider.sellerid};
//            [self PushViewControllerByClassName:@"ShopVC" info:info];
//        }
//        
//    }
    
    NSDictionary *dic = @{@"url":self.webArr[index]};
    [self PushViewControllerByClassName:@"WebVC" info:dic];
//    NSLog(@"%@",self.webArr[index]);
}


- (void)getHeightsByModels:(NSArray *)models{
    
//    if (self.pageNo == 1) {
//        self.cellHeights = [NSMutableArray array];
//    }
//    for (HomeModel *model in models) {
//        CGFloat h = !model.mjj? 90: 125;
//        [self.cellHeights addObject:@(h)];
//    }

}

-(UIView *)sectionViewWithTitle:(NSString *)title andContent:(NSString *)content
{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor whiteColor];
    UILabel *title2 = [UILabel createLabelWithFrame:CommonVIEWFRAME(18, 13.5, 50, 12)
                                           andText:title
                                      andTextColor:[UIColor blackColor]
                                        andBgColor:[UIColor clearColor]
                                           andFont:SYSTEMFONT(12)
                                  andTextAlignment:NSTextAlignmentLeft];
    title2.adjustsFontSizeToFitWidth =YES;
    
    UIView * line =[[UIView alloc] initWithFrame:CommonVIEWFRAME(77, 13.5, 0.5, 12)];
    line.backgroundColor = [UIColor colorWithHexColorString:@"a0a0a0"];
    UILabel *title1 = [UILabel createLabelWithFrame:CommonVIEWFRAME(86, 8.5, 150, 22)
                                            andText:content
                                       andTextColor:[UIColor colorWithHexColorString:@"a1a1a1"]                                                andBgColor:[UIColor clearColor]
                                            andFont:SYSTEMFONT(12)
                                   andTextAlignment:NSTextAlignmentLeft];
    title1.adjustsFontSizeToFitWidth =YES;
    [view addSubview:title2];
    [view addSubview:line];
    [view addSubview:title1];
    
    return view;
}

-(void)btnAction:(UIButton *)sender
{
    
    switch (sender.tag) {
            
        case 100:{
            [self PushViewControllerByClassName:@"ExchangeVC" info:nil];
//            self.view1.transform = CGAffineTransformScale(self.view1.transform, 1.0, -1.0);
//            self.view1.layer.transform=CATransform3DMakeRotation(M_PI/2, 0, 0.5,0.5);
            
//            [self.view addSubview:fromView];
            
//            [CATransaction flush];
//            
//            [UIView transitionFromView:self.view1 toView:self.view2 duration:1.0f options:UIViewAnimationOptionTransitionFlipFromLeft completion:NULL];

            break;
        }
        case 101:{
            [self PushViewControllerByClassName:@"RentVC" info:nil];
//            [CATransaction flush];
//            
//            [UIView transitionFromView:self.view2 toView:self.view1 duration:1.0f options:UIViewAnimationOptionTransitionFlipFromLeft completion:NULL];
            break;
        }
        case 102:{
            [self PushViewControllerByClassName:@"ActivityVC" info:nil];
            break;
        }
        case 103:{
            [self PushViewControllerByClassName:@"Appraise1VC" info:nil];
            break;
        }
        case 104:{
            [self PushViewControllerByClassName:@"MaintainVC" info:nil];
            break;
        }
            
        case 201:{
//            UserModel *model =   [LoginModel curLoginUser];
//            MQChatViewManager *chatViewManager = [[MQChatViewManager alloc] init];
//            [chatViewManager.chatViewStyle setEnableRoundAvatar:YES];
//            [chatViewManager setClientInfo:@{@"name":model.nickname,@"avatar":model.headimgurl} override:YES];
//            [chatViewManager setLoginCustomizedId:[NSString stringWithFormat:@"%@",model.userid]];
//            [chatViewManager pushMQChatViewControllerInViewController:self];
            
            if (![LoginModel isLogin]) {
                [ProgressHUDHandler showHudTipStr:@"请先登录"];
                [[PushManager sharedManager] presentLoginVC];
                return;
            }

            RCConversationListVC *vc = [[RCConversationListVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];

            break;
        }
        default:
            break;
    }
    
}

-(void)CloseKeyBoardToolBar
{
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
}


-(void)OpenKeyBoardToolBar
{
    [IQKeyboardManager sharedManager].enableAutoToolbar = YES;
}

-(void)buttonClick:(UIButton *)sender
{
    NSDictionary *dic;
    if (sender.tag == 1000) {
        dic = @{@"title":@"寄租"};
    }else{
        dic = @{@"title":@"寄售"};
    }
    [self PushViewControllerByClassName:@"ShowVC" info:dic];
}

-(void)searchBtn:(UIButton *)btn
{
    [self PresentViewControllerByClassName:@"SearchVC" info:nil];
}

-(void)leftBtn
{
    // 1、 获取摄像设备
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (device) {
        AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (status == AVAuthorizationStatusNotDetermined) {
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                if (granted) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        QRCodeScanningVC *vc = [[QRCodeScanningVC alloc] init];
                        [self.navigationController pushViewController:vc animated:YES];
                    });
                    
                    SGQRCodeLog(@"当前线程 - - %@", [NSThread currentThread]);
                    // 用户第一次同意了访问相机权限
                    SGQRCodeLog(@"用户第一次同意了访问相机权限");
                    
                } else {
                    
                    // 用户第一次拒绝了访问相机权限
                    SGQRCodeLog(@"用户第一次拒绝了访问相机权限");
                }
            }];
        } else if (status == AVAuthorizationStatusAuthorized) { // 用户允许当前应用访问相机
            QRCodeScanningVC *vc = [[QRCodeScanningVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        } else if (status == AVAuthorizationStatusDenied) { // 用户拒绝当前应用访问相机
            UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"⚠️ 警告" message:@"请去-> [设置 - 隐私 - 相机 - SGQRCodeExample] 打开访问开关" preferredStyle:(UIAlertControllerStyleAlert)];
            UIAlertAction *alertA = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            
            [alertC addAction:alertA];
            [self presentViewController:alertC animated:YES completion:nil];
            
        } else if (status == AVAuthorizationStatusRestricted) {
            NSLog(@"因为系统原因, 无法访问相册");
        }
    } else {
        UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"未检测到您的摄像头" preferredStyle:(UIAlertControllerStyleAlert)];
        UIAlertAction *alertA = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        [alertC addAction:alertA];
        [self presentViewController:alertC animated:YES completion:nil];
    }
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
