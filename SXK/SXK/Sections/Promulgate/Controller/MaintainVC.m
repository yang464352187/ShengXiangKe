//
//  MaintainVC.m
//  SXK
//
//  Created by 杨伟康 on 2016/12/21.
//  Copyright © 2016年 ywk. All rights reserved.
//

#import "MaintainVC.h"
#import "MaintainCell.h"
#import "MaintainModel.h"
#import "MaintainCellModel.h"

@interface MaintainVC ()

@property (nonatomic, strong) NSArray *ListArr;

@end

@implementation MaintainVC




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"养护";
    self.isUseNoDataView = YES;
    [self.noDataView setTitle:@"暂时没有养护信息"];
    
    _weekSelf(weakSelf);
    [BaseRequest GetMaintainListWithPageNo:0 PageSize:0 order:1 succesBlock:^(id data) {
        NSArray *models = [MaintainModel modelsFromArray:data[@"classifyList"]];
        [weakSelf setupTitlesView:models];
        weakSelf.ListArr = models;
        MaintainModel *model = models[0];
        [weakSelf loadList:model];
        
    } failue:^(id data, NSError *error) {
        
    }];
    
    [self.view addSubview:self.tableView];
}

-(void)loadList:(MaintainModel *)model
{
    _weekSelf(weakSelf);
    [BaseRequest GetMaintainListWithPageNo:0 PageSize:0 order:1 classifyid:[model.classifyid integerValue]  succesBlock:^(id data) {
//        NSLog(@"---------%@----------",describe(data));
        NSArray *models = [MaintainCellModel modelsFromArray:data[@"maintainList"]];
//        self.dataArr = models;
        [weakSelf handleModels:models total:[data[@"total"] integerValue]];

        [self.tableView reloadData];
    } failue:^(id data, NSError *error) {
        
    }];

}




/**
 * 设置顶部的标签栏
 */
- (void)setupTitlesView:(NSArray *)array
{
    // 标签栏整体
    UIView *titlesView = [[UIView alloc] init];
    titlesView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1];
    titlesView.width = self.view.width;
    titlesView.height = 35;
    titlesView.y = 0;
//    titlesView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:titlesView];
    self.titlesView = titlesView;
    
    // 底部的红色指示器
    UIView *indicatorView = [[UIView alloc] init];
    indicatorView.backgroundColor = APP_COLOR_GREEN;
    indicatorView.height = 2;
    indicatorView.tag = -1;
    indicatorView.y = titlesView.height - indicatorView.height;
    self.indicatorView = indicatorView;
    
    // 内部的子标签
    CGFloat width = titlesView.width / array.count;
    CGFloat height = titlesView.height;
    for (NSInteger i = 0; i< array.count; i++) {
        UIButton *button = [[UIButton alloc] init];
        button.tag = i;
        button.height = height;
        button.width = width;
        button.x = i * width;
        MaintainModel *model = array[i];
        NSString *title = model.name;
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button setTitleColor:APP_COLOR_GREEN forState:UIControlStateDisabled];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        [titlesView addSubview:button];
        button.tag = i;
        // 默认点击了第一个按钮
        if (i == 0) {
            button.enabled = NO;
            self.selectedButton = button;
            
            // 让按钮内部的label根据文字内容来计算尺寸
            [button.titleLabel sizeToFit];
            self.indicatorView.width = button.titleLabel.width;
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
    MaintainModel *model = self.ListArr[button.tag];
    [self loadList:model];
    // 修改按钮状态
    self.selectedButton.enabled = YES;
    button.enabled = NO;
    self.selectedButton = button;
    [UIView animateWithDuration:0.25 animations:^{
        self.indicatorView.width = button.titleLabel.width;
        self.indicatorView.centerX = button.centerX;
    }];
    
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
    MaintainCellModel *model = self.listData[indexPath.row];
    [cell setModel:model];
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
    MaintainCellModel *model = self.listData[indexPath.row];
    NSDictionary *dic = @{@"maintainid":model.maintainid};
    [self PushViewControllerByClassName:@"MaintainDetailVC" info:dic];
}

#pragma mark -- getters and setters

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
