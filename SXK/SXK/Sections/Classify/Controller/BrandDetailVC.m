//
//  BrandDetailVC.m
//  SXK
//
//  Created by 杨伟康 on 2016/12/27.
//  Copyright © 2016年 ywk. All rights reserved.
//

#import "BrandDetailVC.h"
#import "StringAttributeHelper.h"
#import "BrandDetailCell1.h"
#import "BrandDetailCell2.h"
#import "BrandDetailModel.h"
#import "ProductDesCell.h"
#import "ProductCommentCell.h"
#import "ProductParamCell.h"
#import "UserIdModel.h"
#import "BrandStoryCell.h"

@interface BrandDetailVC ()<SDCycleScrollViewDelegate>

@property (strong, nonatomic) UIView            *headView;
@property (strong, nonatomic) SDCycleScrollView *cycleScrollView;// 头顶滑动视图
@property (strong, nonatomic) UILabel *indexLab;
@property (strong, nonatomic) UILabel *titleLab;
@property (strong, nonatomic) UILabel *content;
@property (strong, nonatomic) UILabel *minRentPrice;
@property (strong, nonatomic) UILabel *markPrice;
@property (strong, nonatomic) NSDictionary *dataDic;
@property (strong, nonatomic) NSArray *titleArr;
@property (strong, nonatomic) NSArray *desArr;
@property (assign, nonatomic) CGFloat cellHeight;
@property (strong, nonatomic) BrandDetailModel *model;
@property (strong, nonatomic) UserIdModel *useridModel;

@end

@implementation BrandDetailVC
-(void)loadingRequest
{
    _weekSelf(weakSelf)
    [BaseRequest GetProductlWithRentID:[self.myDict[@"rentid"] integerValue] succesBlock:^(id data) {
        BrandDetailModel *model = [BrandDetailModel modelFromDictionary:data[@"rent"]];
        weakSelf.dataDic = [model transformToDictionary];
        weakSelf.model = model;
        self.cellHeight = [UILabel getHeightByWidth:SCREEN_WIDTH - 30 title:model.description1 font:SYSTEMFONT(13)];
        
//        NSLog(@"=========%@=======",describe(model));
        [weakSelf initData];
        [weakSelf.tableView reloadData];
        NSMutableArray *imgArr = [[NSMutableArray alloc] init];
        for (NSString *img in weakSelf.model.imgList) {
            NSString *image = [NSString stringWithFormat:@"%@%@",APP_BASEIMG,img];
            [imgArr addObject:image];
        }
        weakSelf.cycleScrollView.localizationImageNamesGroup = imgArr;

        
    } failue:^(id data, NSError *error) {
        
    }];
}

-(void)initData
{
    NSArray *array = [[NSArray alloc] initWithObjects:@"99成新（未使用）",@"98成新",@"95成新",@"9成新",@"85成新",@"8成新", nil];
    if (self.dataDic.count > 0) {
//        NSLog(@"-----------%@--------",describe(self.dataDic));
        self.titleLab.text = self.dataDic[@"name"];
        self.content.text = [NSString stringWithFormat:@"%@ %@",array[[self.dataDic[@"condition"] integerValue]],self.dataDic[@"keyword"]];
        CGFloat rentPrice = [self.dataDic[@"rentPrice"] floatValue] / 100;
        NSString *minRent = [NSString stringWithFormat:@"最低租价:¥%.2lf/天",rentPrice];
        NSString *price = [NSString stringWithFormat:@"¥%.2lf",rentPrice];
        CGFloat width = [UILabel getWidthWithTitle:@"最低租价:/天" font:SYSTEMFONT(13)];
        CGFloat width1 = [UILabel getWidthWithTitle:price font:SYSTEMFONT(18)];
        FontAttribute *fullFont = [FontAttribute new];
        fullFont.font           = SYSTEMFONT(18);
        fullFont.effectRange    = NSMakeRange(5,price.length);
        ForegroundColorAttribute *fullColor = [ForegroundColorAttribute new];
        fullColor.color                     = APP_COLOR_GREEN;
        fullColor.effectRange               = NSMakeRange(5, minRent.length -5);
        self.minRentPrice.attributedText = [minRent mutableAttributedStringWithStringAttributes:@[fullFont,fullColor]];
        CGFloat markPrice1 = [self.dataDic[@"marketPrice"] floatValue]/100;
        self.markPrice.text = [NSString stringWithFormat:@"市场价:¥%.2lf",markPrice1];
        
        [self.minRentPrice mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.headView.mas_left).offset(15);
            make.top.equalTo(self.content.mas_bottom).offset(10);
            make.size.mas_equalTo(CGSizeMake(width+width1, 15));
        }];
        
        [self.markPrice mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.minRentPrice.mas_right).offset(5);
            make.centerY.equalTo(self.minRentPrice);
            make.right.equalTo(self.headView.mas_right).offset(0);
            make.height.mas_equalTo(15);
        }];

    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadingRequest];
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;

}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"产品详情";
    self.titleArr = [[NSArray alloc] initWithObjects:@"商品评价",@"商品描述",@"商品参数",@"品牌故事", nil];
    self.desArr = [[NSArray alloc] initWithObjects:@"Comment",@"Description",@"Production infomation",@"Brand story" ,nil];
    [self initUI];
    
  
}

-(void)initUI
{
    [self.view addSubview:self.tableView];
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor whiteColor];
    UIButton *certainBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [certainBtn setTitle:@"租呗" forState:UIControlStateNormal];
    certainBtn.backgroundColor = APP_COLOR_GREEN;
    [certainBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    certainBtn.titleLabel.font = SYSTEMFONT(14);
    certainBtn.frame = VIEWFRAME(15, 20, CommonWidth(335), 40);
    [certainBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    ViewRadius(certainBtn, certainBtn.frame.size.height/2);
    
    [view addSubview:certainBtn];
    [self.view addSubview:view];
    
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.bottom.equalTo(self.view.mas_bottom).offset(0);
        make.height.mas_equalTo(80);
    }];


}
#pragma mark -- UITabelViewDelegate And DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 6;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    MaintainCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MaintainCell"];
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    if (indexPath.section == 0) {
        BrandDetailCell1 *cell = [tableView dequeueReusableCellWithIdentifier:@"BrandDetailCell1"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    if (indexPath.section == 3) {
        ProductDesCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProductDesCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell fillWithContent:self.dataDic[@"description"]];
        return cell;
    }
    if (indexPath.section == 4) {
        ProductParamCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProductParamCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setModel:self.model];
        return cell;
    }
    if (indexPath.section == 5) {
        BrandStoryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BrandStoryCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setModel:self.model];
        return cell;
    }
    
    BrandDetailCell2 *cell = [tableView dequeueReusableCellWithIdentifier:@"BrandDetailCell2"];
    [cell setModel:self.model];
    cell.vc = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        if (SCREEN_WIDTH <= 320) {
            return 150;
        }
        if (SCREEN_WIDTH > 750) {
            return 210;
        }
        return 180;

    }
    
    if (indexPath.section == 3) {
        return self.cellHeight+30;
    }
    if (indexPath.section == 4) {
        return 170;
    }
    if (indexPath.section == 5) {
        return 270;
    }


    return 75;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0 || section == 1) {
        return 15;
    }
    return 50;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return 0.000001;
    }
    return 15;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = APP_COLOR_GRAY_Header;
    return view;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    if (section == 0 || section ==1) {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = APP_COLOR_GRAY_Header;
        return view;

    }
    NSString *title, *des;
    switch (section) {
        case 2:{
            title = self.titleArr[0];
            des = self.desArr[0];
            break;
        }
        case 3:{
            title = self.titleArr[1];
            des = self.desArr[1];

            break;
        }
        case 4:{
            title = self.titleArr[2];
            des = self.desArr[2];

            break;
        }
        case 5:{
            title = self.titleArr[3];
            des = self.desArr[3];

            break;
        }
            
        default:
            break;
    }
    
    
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 66)];
    view.backgroundColor =  [UIColor whiteColor];
    UILabel *title2 = [UILabel createLabelWithFrame:CommonVIEWFRAME(18, 13.5, 50, 12)
                                            andText:title
                                       andTextColor:[UIColor blackColor]
                                         andBgColor:[UIColor clearColor]
                                            andFont:SYSTEMFONT(13)
                                   andTextAlignment:NSTextAlignmentLeft];
    title2.adjustsFontSizeToFitWidth =YES;
    
    UIView * line =[[UIView alloc] initWithFrame:CommonVIEWFRAME(77, 13.5, 0.5, 12)];
    line.backgroundColor = [UIColor colorWithHexColorString:@"a0a0a0"];
    
    UILabel *title1 = [UILabel createLabelWithFrame:CommonVIEWFRAME(86, 8.5, 150, 22)
                                            andText:des
                                       andTextColor:[UIColor colorWithHexColorString:@"a1a1a1"]                                                andBgColor:[UIColor clearColor]
                                            andFont:SYSTEMFONT(12)
                                   andTextAlignment:NSTextAlignmentLeft];
    title1.adjustsFontSizeToFitWidth =YES;
    
    UIView * underLine =[[UIView alloc] initWithFrame:CommonVIEWFRAME(15, 74.5, SCREEN_WIDTH - 30, 0.5)];
    underLine.backgroundColor = [UIColor colorWithHexColorString:@"a0a0a0"];

    
    [view addSubview:title2];
    [view addSubview:line];
    [view addSubview:title1];
    [view addSubview:underLine];
    
    [title2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(view);
        make.left.equalTo(view.mas_left).offset(18);
        make.size.mas_equalTo(CGSizeMake(50, 12));
    }];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(view);
        make.left.equalTo(title2.mas_right).offset(9);
        make.size.mas_equalTo(CGSizeMake(0.5, 12));
    }];
    
    [title1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(view);
        make.left.equalTo(line.mas_right).offset(9);
        make.size.mas_equalTo(CGSizeMake(150, 22));
    }];
    
    [underLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(view.mas_bottom).offset(-0.5);
        make.left.equalTo(view.mas_left).offset(15);
        make.right.equalTo(view.mas_right).offset(-15);
        make.height.mas_equalTo(0.5);
    }];


    return view;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


#pragma mark -- getters and setters


- (UITableView *)tableView{
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:VIEWFRAME(0, 0, SCREEN_WIDTH, SCREEN_HIGHT-64-80) style:UITableViewStyleGrouped];
        _tableView.dataSource      = self;
        _tableView.delegate        = self;
        [_tableView registerClass:[BrandDetailCell1 class] forCellReuseIdentifier:@"BrandDetailCell1"];
        [_tableView registerClass:[BrandDetailCell2 class] forCellReuseIdentifier:@"BrandDetailCell2"];
        [_tableView registerClass:[ProductDesCell class] forCellReuseIdentifier:@"ProductDesCell"];
        [_tableView registerClass:[ProductParamCell class] forCellReuseIdentifier:@"ProductParamCell"];
        [_tableView registerClass:[BrandStoryCell class] forCellReuseIdentifier:@"BrandStoryCell"];

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
        _headView = [[UIView alloc] initWithFrame:VIEWFRAME(0, 0, SCREEN_WIDTH, 274.0000/667*SCREEN_HIGHT+100)];
        _headView.backgroundColor = [UIColor whiteColor];
        
        self.indexLab = [UILabel createLabelWithFrame:CommonVIEWFRAME(0,115.5 , 105, 12)
                                               andText:@"1/9"
                                          andTextColor:[UIColor colorWithHexColorString:@"2c2c2c"]
                                            andBgColor:[UIColor whiteColor]
                                               andFont:SYSTEMFONT(12)
                                      andTextAlignment:NSTextAlignmentCenter];
        self.indexLab.alpha = 0.6;
        
        UILabel *title = [UILabel createLabelWithFrame:CommonVIEWFRAME(0,115.5 , 105, 12)
                                               andText:@""
                                          andTextColor:[UIColor blackColor]
                                            andBgColor:[UIColor whiteColor]
                                               andFont:SYSTEMFONT(14)
                                      andTextAlignment:NSTextAlignmentLeft];
        self.titleLab = title;
   
        
        UILabel *content = [UILabel createLabelWithFrame:CommonVIEWFRAME(0,115.5 , 105, 12)
                                               andText:@""
                                          andTextColor:APP_COLOR_GRAY_Font
                                            andBgColor:[UIColor whiteColor]
                                               andFont:SYSTEMFONT(13)
                                      andTextAlignment:NSTextAlignmentLeft];
        self.content = content;
        
        UILabel *minPrice = [UILabel createLabelWithFrame:CommonVIEWFRAME(0,200 , 0, 0)
                                                 andText:@""
                                            andTextColor:[UIColor blackColor]
                                              andBgColor:[UIColor whiteColor]
                                                 andFont:SYSTEMFONT(13)
                                        andTextAlignment:NSTextAlignmentLeft];
        self.minRentPrice = minPrice;

        UILabel *marketPrice1 = [UILabel createLabelWithFrame:CommonVIEWFRAME(0,115.5 , 0, 0)
                                               andText:@""
                                          andTextColor:[UIColor blackColor]
                                            andBgColor:[UIColor whiteColor]
                                               andFont:SYSTEMFONT(13)
                                      andTextAlignment:NSTextAlignmentLeft];
        self.markPrice = marketPrice1;

        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        UIImage *image = [UIImage imageNamed:@"嘴型@2x"];
        [btn setImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        [btn setTitle:@"啵一个" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(likeAciton:) forControlEvents:UIControlEventTouchUpInside];
        btn.titleLabel.font = SYSTEMFONT(13);
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 20, -40);
        btn.titleEdgeInsets = UIEdgeInsetsMake(20, -30, -10, -8);
        
        
        [_headView addSubview:self.cycleScrollView];
        [_headView addSubview:self.indexLab];
        [_headView addSubview:title];
        [_headView addSubview:content];
        [_headView addSubview:minPrice];
        [_headView addSubview:marketPrice1];
        [_headView addSubview:btn];
    
        [self.indexLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(_headView.mas_right).offset(-15);
            make.bottom.equalTo(self.cycleScrollView.mas_bottom).offset(-15);
            make.size.mas_equalTo(CGSizeMake(34, 20));
        }];
        
        [title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_headView.mas_left).offset(15);
            make.top.equalTo(self.cycleScrollView.mas_bottom).offset(15);
            make.size.mas_equalTo(CGSizeMake((SCREEN_WIDTH - 150), 15));
        }];
        
        [content mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_headView.mas_left).offset(15);
            make.top.equalTo(title.mas_bottom).offset(10);
            make.size.mas_equalTo(CGSizeMake((SCREEN_WIDTH - 150), 15));
        }];
        
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.cycleScrollView.mas_bottom).offset(12);
            make.right.equalTo(_headView.mas_right).offset(0);
            make.size.mas_equalTo(CGSizeMake(60, 50));
        }];
        
    }
    return _headView;
}


- (SDCycleScrollView *)cycleScrollView{
    if (!_cycleScrollView) {
//        占位-0
//        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:VIEWFRAME(0, 0, SCREEN_WIDTH, 274.0000/667*SCREEN_HIGHT) imageNamesGroup:@[@"背景",@"图层-1-副本-2"]];
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:VIEWFRAME(0, 0, SCREEN_WIDTH, 274.0000/667*SCREEN_HIGHT)
                                                              delegate:self
                                                      placeholderImage:[UIImage imageNamed:@"占位-0"]];
        _cycleScrollView.showPageControl = YES;
        _cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleNone;
        _cycleScrollView.autoScrollTimeInterval = 3;
        _cycleScrollView.backgroundColor = APP_COLOR_BASE_BACKGROUND;
        _cycleScrollView.pageDotColor = [UIColor whiteColor];
        _cycleScrollView.currentPageDotColor = APP_COLOR_BASE_BAR;
    }
    return _cycleScrollView;
}


- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index
{
    self.indexLab.text = [NSString stringWithFormat:@"%ld/9",index+1];
//    NSLog(@"图片%d",index);
    
}


-(void)buttonClick:(UIButton *)sender
{
    [self PushViewControllerByClassName:@"OrderVC" info:self.dataDic];
}

-(void)likeAciton:(UIButton *)sender
{
    [BaseRequest AddKeepWithRentID:[self.model.rentid integerValue] succesBlock:^(id data) {
        if ([data[@"code"] integerValue] == 1) {
            [ProgressHUDHandler showHudTipStr:@"收藏成功"];
        }

    } failue:^(id data, NSError *error) {
        
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];


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
