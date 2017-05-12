//
//  MyBusinessBuy.m
//  SXK
//
//  Created by 杨伟康 on 2017/4/5.
//  Copyright © 2017年 ywk. All rights reserved.
//

#import "MyBusinessBuy.h"
#import "MyBussinessBuyModel.h"
#import "MyBussinesCell.h"
#import "MyBussinessCell1.h"
#import "MybusinessBuyCell.h"
#import "MyBussinessBuyCell1.h"
#import "MyBusinessBuyCell2.h"
@interface MyBusinessBuy ()<MyBusinessBuyCell2Delegate,MyBusinessBuyCell1Delegate>

@property (nonatomic, assign)NSInteger index;

@end

@implementation MyBusinessBuy

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadingRequest];
}


-(void)loadingRequest
{
    _weekSelf(weakSelf);

        [BaseRequest GetPutchaseOrderListWithPageNo:0 PageSize:0 order:1 status:self.index succesBlock:^(id data) {
            NSArray *models = [MyBussinessBuyModel modelsFromArray:data[@"orderList"]];
            [weakSelf handleModels:models total:[data[@"total"] integerValue]];
//            NSLog(@"+++++++%@+++++",describe(models));
            if (models.count > 0) {
                [self.noDataView removeFromSuperview];
            }

        } failue:^(id data, NSError *error) {
    
        }];
    
//    [BaseRequest GetPurchaseListWithPageNo:0 PageSize:0 order:-1 status:self.index succesBlock:^(id data) {
//        NSArray *models = [MyBussinesModel modelsFromArray:data[@"purchaseList"]];
//        [weakSelf handleModels:models total:[data[@"total"] integerValue]];
//        
//        NSLog(@"+++++++++%@++++++++",describe(models));
//    } failue:^(id data, NSError *error) {
//        
//    }];
    
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"我的买入";
    for (int i =0; i < self.tableViewArr.count; i++) {
        UITableView *tableView = self.tableViewArr[i];
        tableView.dataSource      = self;
        tableView.delegate        = self;
        [tableView registerClass:[MybusinessBuyCell class] forCellReuseIdentifier:@"MybusinessBuyCell"];
        [tableView registerClass:[MyBussinessBuyCell1 class] forCellReuseIdentifier:@"MyBussinessBuyCell1"];
        [tableView registerClass:[MyBusinessBuyCell2 class] forCellReuseIdentifier:@"MyBusinessBuyCell2"];
        tableView.showsVerticalScrollIndicator = NO;
        tableView.backgroundColor = APP_COLOR_BASE_BACKGROUND;
        tableView.tableFooterView = [[UIView alloc] init];
        tableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
        tableView.sectionHeaderHeight = 0.0;
        tableView.sectionFooterHeight = 0.0;
        
        if (i == 0) {
            self.tableView = tableView;
        }
    }
    self.isUseNoDataView = YES;
    [self.noDataView setTitle:@"暂无订单~"];

    self.index = 2;
    
}

#pragma mark -- UITabelViewDelegate And DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.listData.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MyBussinessBuyModel *model = self.listData[indexPath.section];
//    if (self.index == 5) {
//        MyBussinessCell1 *cell = [tableView dequeueReusableCellWithIdentifier:@"MyBussinessCell1"];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        [cell setModel:model];
//        //        cell.delegate = self;
//        //        cell.index = indexPath.section;
//        return cell;
//        
//    }
    if (self.index == 2) {
        MybusinessBuyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MybusinessBuyCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setModel:model];
        //        cell.delegate = self;
        //        cell.index = indexPath.section;
        return cell;

    }
    if (self.index == 3) {
        MyBussinessBuyCell1 *cell = [tableView dequeueReusableCellWithIdentifier:@"MyBussinessBuyCell1"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setModel:model];
        cell.delegate = self;
        cell.index = indexPath.section;
        return cell;

    }
    
    MyBusinessBuyCell2 *cell = [tableView dequeueReusableCellWithIdentifier:@"MyBusinessBuyCell2"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setModel:model];
    cell.delegate = self;
    cell.index = indexPath.section;
    return cell;


    
    
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.index == 2) {
        return 135;
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
    MyBussinessBuyModel *model = self.listData[indexPath.section];
    NSDictionary *dic = @{@"orderid":model.orderid,@"type":@"2"};
    [self PushViewControllerByClassName:@"OrderDetailVC" info:dic];
}


-(void)setAnimationWithOrigin:(CGFloat)x{
    [super setAnimationWithOrigin:x];
    
    for (int i = 0; i < self.tableViewArr.count ; i++) {
        UITableView *tableView = self.tableViewArr[i];
        if (x/SCREEN_WIDTH == i) {
            self.tableView = tableView;
            self.index = i + 2;
            self.isUseNoDataView = YES;
            [self.noDataView setTitle:@"暂无订单~"];

            [self loadingRequest];
            
            break;
        }
        
    }
}

-(void)returnIndex:(NSInteger)index
{
    [self.listData removeObjectAtIndex:index];
    NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:index];
    [self.tableView deleteSections:indexSet withRowAnimation:UITableViewRowAnimationFade];
    
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
