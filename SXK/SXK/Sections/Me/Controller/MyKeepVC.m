//
//  MyKeepVC.m
//  SXK
//
//  Created by 杨伟康 on 2017/1/20.
//  Copyright © 2017年 ywk. All rights reserved.
//

#import "MyKeepVC.h"
#import "MyKeepCell.h"
#import "MyPromulgateModel.h"
#import "MyBussinesModel.h"
#import "HomeBuyCell.h"
#import "HomeBuyCell1.h"
#import "MaintainCell1.h"
#import "MaintainCellModel.h"
@interface MyKeepVC ()

@property (nonatomic, strong) NSString *url;

@property (nonatomic, assign) NSInteger type;

@end

@implementation MyKeepVC

-(void)viewWillAppear:(BOOL)animated
{
//    [super viewWillAppear:animated];
//    _weekSelf(weakSelf);
//    [BaseRequest GetKeepListsuccesBlock:^(id data) {
//        NSArray *models = [MyPromulgateModel modelsFromArray:data[@"collection"][@"rentList"]];
//        [weakSelf handleModels:models total:models.count];
//    } failue:^(id data, NSError *error) {
//        
//    }];
    [self loadingRequest];
}


-(void)loadingRequest
{
    _weekSelf(weakSelf);
    [BaseRequest GetKeepListWithUrl:self.url succesBlock:^(id data) {
        NSArray *models = [MyBussinesModel modelsFromArray:data[@"collection"][@"purchaseList"]];
        [weakSelf handleModels:models total:models.count];

    } failue:^(id data, NSError *error) {
        
    }];
}
-(void)loadingRequest1
{
    _weekSelf(weakSelf);
    [BaseRequest GetKeepListWithUrl:self.url succesBlock:^(id data) {
        NSArray *models = [MyBussinesModel modelsFromArray:data[@"collection"][@"rentList"]];
        [weakSelf handleModels:models total:models.count];
        
    } failue:^(id data, NSError *error) {
        
    }];
}
-(void)loadingRequest2
{
    _weekSelf(weakSelf);
    [BaseRequest GetKeepListWithUrl:self.url succesBlock:^(id data) {
        NSArray *models = [MaintainCellModel modelsFromArray:data[@"collection"][@"maintainList"]];
        [weakSelf handleModels:models total:models.count];
        
    } failue:^(id data, NSError *error) {
        
    }];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"我的收藏";
    [self setupTitlesView:@[@"寄卖",@"寄租",@"养护"]];
    self.url = APPINTERFACE__BusinessKeepList;
    self.type = 0;
    [self.view addSubview:self.tableView];
    self.isUseNoDataView = YES;
    [self.noDataView setTitle:@"暂无订单~"];

}


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
//        MaintainModel *model = array[i];
        NSString *title = array[i];
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
    self.type = button.tag;
    switch (button.tag) {
        case 0:{
            self.url = APPINTERFACE__BusinessKeepList;
            [self loadingRequest];
            break;
        }
        case 1:{
            self.url = APPINTERFACE__GetKeepList;
            [self loadingRequest1];
            break;
        }
        case 2:{
            self.url = APPINTERFACE__MaintainKeepList;
            [self loadingRequest2];
            break;
        }
            
        default:
            break;
    }
    
    // 修改按钮状态
    self.selectedButton.enabled = YES;
    button.enabled = NO;
    self.selectedButton = button;
    [UIView animateWithDuration:0.25 animations:^{
        self.indicatorView.width = button.titleLabel.width;
        self.indicatorView.centerX = button.centerX;
    }];
    
}


#pragma mark -- getters and setters
- (UITableView *)tableView{
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:VIEWFRAME(0, 35, SCREEN_WIDTH, SCREEN_HIGHT-64-35) style:UITableViewStyleGrouped];
        _tableView.dataSource      = self;
        _tableView.delegate        = self;
        _tableView.showsVerticalScrollIndicator = NO;
        [_tableView registerClass:[MyKeepCell class] forCellReuseIdentifier:@"MyKeepCell"];
        [_tableView registerClass:[HomeBuyCell class] forCellReuseIdentifier:@"HomeBuyCell"];
        [_tableView registerClass:[HomeBuyCell1 class] forCellReuseIdentifier:@"HomeBuyCell1"];
        [_tableView registerClass:[MaintainCell1 class] forCellReuseIdentifier:@"MaintainCell"];

        _tableView.backgroundColor = [UIColor colorWithHexColorString:@"f7f7f7"];
        _tableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
        _tableView.sectionHeaderHeight = 0.0;
        _tableView.sectionFooterHeight = 0.0;
        
    }
    return _tableView;
}

#pragma mark -- UITabelViewDelegate And DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.listData.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MyBussinesModel *model = self.listData[indexPath.section];

    if (self.type == 0) {
        HomeBuyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeBuyCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setModel:model];
        //        cell.delegate = self;
        //        cell.index = indexPath.section;
        return cell;

    }
    if (self.type == 1) {

        HomeBuyCell1 *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeBuyCell1"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setModel:model];
        //        cell.delegate = self;
        //        cell.index = indexPath.section;
        return cell;
    }
    MaintainCellModel *model1 = self.listData[indexPath.section];

    MaintainCell1 *cell = [tableView dequeueReusableCellWithIdentifier:@"MaintainCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    MaintainCellModel *model = self.listData[indexPath.row];
    [cell setModel:model1];
//    
//    MyPromulgateModel *model = self.listData[indexPath.section];
//    MyKeepCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyKeepCell"];
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    [cell setModel:model];

    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return 140;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.00000001;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 15;
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
//    MyPromulgateModel *model = self.listData[indexPath.section];
    if (self.type == 0) {
        MyBussinesModel *model = self.listData[indexPath.section];
        NSDictionary *dic = @{@"purchaseid":model.purchaseid};
        [self PushViewControllerByClassName:@"BrandDetailVC1" info:dic];

    }
    if (self.type == 1) {
        MyBussinesModel *model = self.listData[indexPath.section];
        NSDictionary *dic = @{@"rentid":model.rentid};
        [self PushViewControllerByClassName:@"BrandDetailVC" info:dic];

    }
    if (self.type == 2) {
        MaintainCellModel *model = self.listData[indexPath.section];
        NSDictionary *dic = @{@"maintainid":model.maintainid};
        [self PushViewControllerByClassName:@"MaintainDetailVC" info:dic];

    }

    

}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (self.type == 0) {
        MyBussinesModel*model = self.listData[indexPath.section];
        _weekSelf(weakSelf);
        [BaseRequest CancelKeepWithPurchaseID:[model.purchaseid integerValue] succesBlock:^(id data) {
            [self.listData removeObjectAtIndex:indexPath.section];
            [weakSelf.tableView reloadData];

        } failue:^(id data, NSError *error) {
            
        }];
    }
    
    
    if (self.type == 1) {
         MyBussinesModel*model = self.listData[indexPath.section];
        _weekSelf(weakSelf);
        [BaseRequest CancelKeepWithRentID:[model.rentid integerValue] succesBlock:^(id data) {
            [self.listData removeObjectAtIndex:indexPath.section];
            [weakSelf.tableView reloadData];
            
        } failue:^(id data, NSError *error) {
            
        }];
    }
    
    if (self.type == 2) {
        MaintainCellModel *model = self.listData[indexPath.section];
        _weekSelf(weakSelf);
        [BaseRequest CancelKeepWithMaintainID:[model.maintainid integerValue] succesBlock:^(id data) {
            [self.listData removeObjectAtIndex:indexPath.section];
            [weakSelf.tableView reloadData];

        } failue:^(id data, NSError *error) {
            
        }];
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
