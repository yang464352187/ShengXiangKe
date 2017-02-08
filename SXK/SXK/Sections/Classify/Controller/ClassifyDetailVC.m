//
//  ClassifyDetailVC.m
//  SXK
//
//  Created by 杨伟康 on 2016/12/21.
//  Copyright © 2016年 ywk. All rights reserved.
//

#import "ClassifyDetailVC.h"
#import "MaintainCell.h"
#import "BrandDetailModel.h"
@interface ClassifyDetailVC ()

@property (nonatomic, assign)NSInteger index;

@end

@implementation ClassifyDetailVC

-(void)loadingRequest
{
    _weekSelf(weakSelf)
    [BaseRequest GetRentListWithPageNo:0 PageSize:0 order:-1 succesBlock:^(id data) {
        NSArray *models = [BrandDetailModel modelsFromArray:data[@"rentList"]];
        [weakSelf handleModels:models total:[data[@"total"] integerValue]];

//        NSLog(@"------%@------",describe(models));
        
    } failue:^(id data, NSError *error) {
        
    }];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadingRequest];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = self.myDict[@"title"];
    [self setupTitlesView];
    [self.view addSubview:self.tableView];
//    [self initUI];
}

#pragma mark -- UITabelViewDelegate And DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.listData.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MaintainCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MaintainCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    BrandDetailModel *model = self.listData[indexPath.section];
    [cell setModel1:model];
    return cell;
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
    
    BrandDetailModel *model = self.listData[indexPath.section];
    NSDictionary *dic = @{@"rentid":model.rentid};
    [self PushViewControllerByClassName:@"BrandDetailVC" info:dic];
}

- (UITableView *)tableView{
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:VIEWFRAME(0, 35, SCREEN_WIDTH, SCREEN_HIGHT-64-35) style:UITableViewStyleGrouped];
        _tableView.dataSource      = self;
        _tableView.delegate        = self;
        [_tableView registerClass:[MaintainCell class] forCellReuseIdentifier:@"MaintainCell"];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.backgroundColor = APP_COLOR_BASE_BACKGROUND;
        _tableView.tableFooterView = [[UIView alloc] init];
        //        _tableView.tableHeaderView = self.headView;
        _tableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
        _tableView.sectionHeaderHeight = 0.0;
        _tableView.sectionFooterHeight = 0.0;
        
    }
    return _tableView;
}


/**
 * 设置顶部的标签栏
 */
- (void)setupTitlesView
{
    // 标签栏整体
    UIView *titlesView = [[UIView alloc] init];
    titlesView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1];
    titlesView.width = self.view.width;
    titlesView.height = 40;
    titlesView.y = 0;
    [self.view addSubview:titlesView];
    self.titlesView = titlesView;
    
    // 底部的红色指示器
    UIView *indicatorView = [[UIView alloc] init];
    indicatorView.backgroundColor = APP_COLOR_GRAY_333333;
    indicatorView.height = 2;
    indicatorView.tag = -1;
    indicatorView.y = titlesView.height - indicatorView.height-5;
    self.indicatorView = indicatorView;
    NSArray *array = [NSArray arrayWithObjects:@"时间",@"价格",@"人气", nil];

    // 内部的子标签
    CGFloat width = titlesView.width / 3;
    CGFloat height = titlesView.height;
    for (NSInteger i = 0; i<3; i++) {
        UIButton *button = [[UIButton alloc] init];
        button.tag = i;
        button.height = height;
        button.width = width;
        button.x = i * width;
        NSString *title = array[i];
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button setTitleColor:APP_COLOR_GREEN forState:UIControlStateDisabled];

        UIImage *image = [UIImage imageNamed:@"未选择"];
        UIImage *image1 = [UIImage imageNamed:@"下"];
        [button setImage:[image1 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateSelected];
        [button setImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        [button setImage:[image1 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateHighlighted];
        [button setHighlighted:NO];
        [button setAdjustsImageWhenHighlighted:NO];
        button.titleEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        button.imageEdgeInsets = UIEdgeInsetsMake(0, button.titleLabel.x+button.titleLabel.width+8, 0, 0);
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        [titlesView addSubview:button];
        
        // 默认点击了第一个按钮
        if (i == 0) {
            [button setSelected:YES];
            self.selectedButton = button;
            self.index =1;
            // 让按钮内部的label根据文字内容来计算尺寸
            [button.titleLabel sizeToFit];
            self.indicatorView.width = button.titleLabel.width+13;
            self.indicatorView.centerX = button.centerX;
        }
    }
    
    [titlesView addSubview:indicatorView];
}


- (void)titleClick:(UIButton *)button
{
    [self buttonStateChange:button];
    // 滚动
//    [self setShowingIndex:button.tag animate:YES];
}
- (void)buttonStateChange:(UIButton *)button
{
    // 修改按钮状态
    if (self.selectedButton == button) {
        
        if (self.index == 1) {
            self.index =2;
            UIImage *image = [UIImage imageNamed:@"上"];
            [button setImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateSelected];
            [button setImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateHighlighted];

        }else{
            UIImage *image = [UIImage imageNamed:@"下"];
            [button setImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateSelected];
            [button setImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateHighlighted];
            self.index =1;
        }
        
        
    }else{
        
        [self.selectedButton setSelected:NO];
        UIImage *image = [UIImage imageNamed:@"下"];
        [button setImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateSelected];
        [button setImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateHighlighted];
        self.index =1;
        [button setSelected:YES];
        
    }
    
    
    self.selectedButton = button;
    [UIView animateWithDuration:0.25 animations:^{
        self.indicatorView.width = button.titleLabel.width+13;
        self.indicatorView.centerX = button.centerX;
    }];
    
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
