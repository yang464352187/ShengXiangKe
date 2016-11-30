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

@interface HomeVC ()<SDCycleScrollViewDelegate>


@property (strong, nonatomic) UIView            *headView;
@property (strong, nonatomic) SDCycleScrollView *cycleScrollView;// 头顶滑动视图


@end

@implementation HomeVC
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.jt_navigationController.line.backgroundColor = [UIColor clearColor];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];
    self.navigationController.navigationBar.hidden = YES;
    [self.view addSubview:self.tableView];
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
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        FirstTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FirstTableViewCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    if (indexPath.section == 1) {
        ClassifyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ClassifyCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    SpecialCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SpecialCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
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
        _headView = [[UIView alloc] initWithFrame:VIEWFRAME(0, 0, SCREEN_WIDTH, 438.0000/667*SCREEN_HIGHT)];
        _headView.backgroundColor = [UIColor whiteColor];
        
        NSArray *titleArray = @[@"租赁",@"交换",@"鉴定",@"养护",@"上新",@"活动",@"顾问",@"分享"];
        NSArray *imageArray = @[@"图层-114",@"图层-115",@"图层-118",@"养护",@"上新",@"活动",@"顾问",@"图层-139"];

        int k = 0;
        for (int j = 0; j < 2; j++) {
            
            for (int i = 0; i < 4 ; i++) {
                UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
                btn.frame = CGRectMake(40 + i * (20 + 70)/375.0000*SCREEN_WIDTH, 301.0000/667*SCREEN_HIGHT + j * 70.0000/667*SCREEN_HIGHT, 20, 40);
                UIImage *image = [UIImage imageNamed:imageArray[k]];
                [btn setImage:[image imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)] forState:UIControlStateNormal];
                [btn setTitle:titleArray[k] forState:UIControlStateNormal];
                btn.titleLabel.font = [UIFont systemFontOfSize:11];
                [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                //        CGSize titleSize = btn.titleLabel.bounds.size;
                CGSize imageSize = btn.imageView.bounds.size;
                btn.imageEdgeInsets = UIEdgeInsetsMake(0,0,21,0);
                btn.titleEdgeInsets = UIEdgeInsetsMake(imageSize.width+10,-25, 0, -4);
                [_headView addSubview:btn];
                k++;
            }
        }
        

        [_headView addSubview:self.cycleScrollView];
        
        //导航栏中的搜索栏
        UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        searchBtn.frame =  CGRectMake(49.0000/375*SCREEN_WIDTH, 27.5000/667*SCREEN_HIGHT, 274.0000/375*SCREEN_WIDTH, 30.0000/667*SCREEN_HIGHT);
        ViewBorderRadius(searchBtn, 0, 0.2, [UIColor colorWithHexColorString:@"313131"]);
        UIImage *image = [UIImage imageNamed:@"搜索-2"];
        [searchBtn setImage:[image imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)] forState:UIControlStateNormal];
        [searchBtn.imageView setContentMode:UIViewContentModeScaleAspectFill];
        //        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_headView addSubview:searchBtn];
        
        
        UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        leftBtn.frame = CommonVIEWFRAME(16.5, 33.5, 21, 19);
        UIImage *image1 = [UIImage imageNamed:@"图层-158"];
        [leftBtn setImage:[image1 imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)] forState:UIControlStateNormal];
        
        //        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_headView addSubview:leftBtn];
        
        UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        rightBtn.frame = CommonVIEWFRAME(335, 33.5, 23.5, 21);
        UIImage *image2 = [UIImage imageNamed:@"图层-157"];
        [rightBtn setImage:[image2 imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)] forState:UIControlStateNormal];
        //        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_headView addSubview:rightBtn];
    }
    return _headView;
}

- (SDCycleScrollView *)cycleScrollView{
    if (!_cycleScrollView) {
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:VIEWFRAME(0, 0, SCREEN_WIDTH, 274.0000/667*SCREEN_HIGHT) imageNamesGroup:@[@"背景",@"图层-1-副本-2"]];
        _cycleScrollView.showPageControl = YES;
        _cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
        _cycleScrollView.autoScrollTimeInterval = 3;
        _cycleScrollView.backgroundColor = APP_COLOR_BASE_BACKGROUND;
        _cycleScrollView.pageDotColor = [UIColor whiteColor];
        _cycleScrollView.currentPageDotColor = APP_COLOR_BASE_BAR;
        _cycleScrollView.delegate = self;
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



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
