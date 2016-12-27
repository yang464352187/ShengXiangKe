//
//  BrandDetailVC.m
//  SXK
//
//  Created by 杨伟康 on 2016/12/27.
//  Copyright © 2016年 ywk. All rights reserved.
//

#import "BrandDetailVC.h"
#import "StringAttributeHelper.h"

@interface BrandDetailVC ()<SDCycleScrollViewDelegate>

@property (strong, nonatomic) UIView            *headView;
@property (strong, nonatomic) SDCycleScrollView *cycleScrollView;// 头顶滑动视图
@property (strong, nonatomic) UILabel *indexLab;
@property (strong, nonatomic) UILabel *titleLab;
@end

@implementation BrandDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    MaintainCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MaintainCell"];
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 138;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.0000001;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 15;
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
        
        _tableView = [[UITableView alloc] initWithFrame:VIEWFRAME(0, 0, SCREEN_WIDTH, SCREEN_HIGHT-64) style:UITableViewStyleGrouped];
        _tableView.dataSource      = self;
        _tableView.delegate        = self;
        
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
        _headView = [[UIView alloc] initWithFrame:VIEWFRAME(0, 0, SCREEN_WIDTH, 403.0000/667*SCREEN_HIGHT)];
        _headView.backgroundColor = [UIColor whiteColor];
        
        self.indexLab = [UILabel createLabelWithFrame:CommonVIEWFRAME(0,115.5 , 105, 12)
                                               andText:@"1/9"
                                          andTextColor:[UIColor colorWithHexColorString:@"2c2c2c"]
                                            andBgColor:[UIColor whiteColor]
                                               andFont:SYSTEMFONT(12)
                                      andTextAlignment:NSTextAlignmentCenter];
        self.indexLab.alpha = 0.6;
        
        UILabel *title = [UILabel createLabelWithFrame:CommonVIEWFRAME(0,115.5 , 105, 12)
                                               andText:@"N1 PRADA/普拉达 手提包"
                                          andTextColor:[UIColor blackColor]
                                            andBgColor:[UIColor whiteColor]
                                               andFont:SYSTEMFONT(14)
                                      andTextAlignment:NSTextAlignmentLeft];
        
        UILabel *content = [UILabel createLabelWithFrame:CommonVIEWFRAME(0,115.5 , 105, 12)
                                               andText:@"95新 经典款 办公休闲均可"
                                          andTextColor:APP_COLOR_GRAY_Font
                                            andBgColor:[UIColor whiteColor]
                                               andFont:SYSTEMFONT(13)
                                      andTextAlignment:NSTextAlignmentLeft];
        
        UILabel *minPrice = [UILabel createLabelWithFrame:CommonVIEWFRAME(0,200 , 200, 30)
                                                 andText:@""
                                            andTextColor:[UIColor blackColor]
                                              andBgColor:[UIColor whiteColor]
                                                 andFont:SYSTEMFONT(13)
                                        andTextAlignment:NSTextAlignmentLeft];

        UILabel *marketPrice = [UILabel createLabelWithFrame:CommonVIEWFRAME(0,115.5 , 105, 12)
                                               andText:@"市场价:¥100000"
                                          andTextColor:[UIColor blackColor]
                                            andBgColor:[UIColor whiteColor]
                                               andFont:SYSTEMFONT(13)
                                      andTextAlignment:NSTextAlignmentLeft];

        NSString *str = @"最低租价:¥64/天";
        FontAttribute *fullFont = [FontAttribute new];
        fullFont.font           = SYSTEMFONT(18);
        fullFont.effectRange    = NSMakeRange(5,3);
        
        ForegroundColorAttribute *fullColor = [ForegroundColorAttribute new];
        fullColor.color                     = APP_COLOR_GREEN;
        fullColor.effectRange               = NSMakeRange(5, str.length -5);
        
        minPrice.attributedText = [str mutableAttributedStringWithStringAttributes:@[fullFont,
                                                                                     fullColor]];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *image = [UIImage imageNamed:@"嘴型@2x"];
        [btn setImage:image forState:UIControlStateNormal];
        
        [_headView addSubview:self.cycleScrollView];
        [_headView addSubview:self.indexLab];
        [_headView addSubview:title];
        [_headView addSubview:content];
        [_headView addSubview:minPrice];
        [_headView addSubview:marketPrice];
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
        
        [minPrice mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_headView.mas_left).offset(15);
            make.top.equalTo(content.mas_bottom).offset(10);
            make.size.mas_equalTo(CGSizeMake(120, 15));
        }];
        
        [marketPrice mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(minPrice.mas_right).offset(0);
            make.centerY.equalTo(minPrice);
            make.size.mas_equalTo(CGSizeMake(100, 15));
        }];
        
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.cycleScrollView.mas_bottom).offset(15);
            make.right.equalTo(_headView.mas_right).offset(-15);
            make.size.mas_equalTo(CGSizeMake(20, 20));

        }];


        
    }
    return _headView;
}


- (SDCycleScrollView *)cycleScrollView{
    if (!_cycleScrollView) {
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:VIEWFRAME(0, 0, SCREEN_WIDTH, 274.0000/667*SCREEN_HIGHT) imageNamesGroup:@[@"背景",@"图层-1-副本-2"]];
        _cycleScrollView.showPageControl = YES;
        _cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleNone;
        _cycleScrollView.autoScrollTimeInterval = 3;
        _cycleScrollView.backgroundColor = APP_COLOR_BASE_BACKGROUND;
        _cycleScrollView.pageDotColor = [UIColor whiteColor];
        _cycleScrollView.currentPageDotColor = APP_COLOR_BASE_BAR;
        _cycleScrollView.delegate = self;
    }
    return _cycleScrollView;
}


- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index
{
    self.indexLab.text = [NSString stringWithFormat:@"%d/9",index+1];
    NSLog(@"图片%d",index);
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
