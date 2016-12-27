//
//  MyPromulgateVC.m
//  SXK
//
//  Created by 杨伟康 on 2016/12/26.
//  Copyright © 2016年 ywk. All rights reserved.
//

#import "MyPromulgateVC.h"
#import "MyPromulgateCell.h"
#import "MyPromulgateModel.h"
#import "MyPromulgateCell1.h"

@interface MyPromulgateVC ()

@property (nonatomic, assign)NSInteger index;

@end

@implementation MyPromulgateVC


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadingRequest];
}


-(void)loadingRequest
{
    _weekSelf(weakSelf)
    [BaseRequest GetTenancyListWithPageNo:0 PageSize:0 order:1 status:self.index succesBlock:^(id data) {
        
        NSArray *models = [MyPromulgateModel modelsFromArray:data[@"rentList"]];
        [weakSelf handleModels:models total:[data[@"total"] integerValue]];
        //        NSLog(@"++++++++++%@+++++++++",describe(weakSelf.listData));
        [weakSelf.tableView reloadData];
    } failue:^(id data, NSError *error) {
        
    }];

}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"我的发布";
    NSArray *array = @[@"待审核",@"发布中",@"租赁中",@"已下架",@"未通过"];
    self.index = 1;
//    [self setupTitlesView:array];
    [self.view addSubview:self.tableView];
    
}

- (void)buttonStateChange:(UIButton *)button
{
    self.index = button.tag ;
    NSLog(@"kkkkkkk%dkkkkkkkk",self.index);
    [self loadingRequest];
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
  
    MyPromulgateModel *model = self.listData[indexPath.section];
    if (self.index == 1) {
        MyPromulgateCell1 *cell = [tableView dequeueReusableCellWithIdentifier:@"MyPromulgateCell1"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setModel:model];
        return cell;
    }
    
    MyPromulgateCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyPromulgateCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setModel:model];
    if (self.index == 4 || self.index == 5) {
        [cell reName:@"删除"];
    }

    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.index == 1) {
        return 140;
    }
    return 166;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0.0000001;
    }
    return 15;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == self.listData.count) {
        return 15;
    }
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
        
        _tableView = [[UITableView alloc] initWithFrame:VIEWFRAME(0, 35, SCREEN_WIDTH, SCREEN_HIGHT-64-35) style:UITableViewStyleGrouped];
        _tableView.dataSource      = self;
        _tableView.delegate        = self;
        [_tableView registerClass:[MyPromulgateCell class] forCellReuseIdentifier:@"MyPromulgateCell"];
        [_tableView registerClass:[MyPromulgateCell1 class] forCellReuseIdentifier:@"MyPromulgateCell1"];
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
