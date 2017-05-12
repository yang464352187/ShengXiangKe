//
//  Search1VC.m
//  SXK
//
//  Created by 杨伟康 on 2017/4/12.
//  Copyright © 2017年 ywk. All rights reserved.
//

#import "Search1VC.h"
#import "HomeBuyCell.h"
#import "HomeBuyCell1.h"
#import "BrandDetailModel.h"
#import "MyBussinesModel.h"

@interface Search1VC ()

@property (nonatomic, assign)NSInteger index;

@end

@implementation Search1VC

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadingRequest];
    
}

-(void)loadingRequest
{
    _weekSelf(weakSelf);

    if (self.index == 1) {
        
        if ([self.dic[@"type"] isEqualToString:@"1"]) {
            
            [BaseRequest GetPurchaseList1WithPageNo:0 PageSize:0 order:-1 status:3 brandid:[self.dic[@"brandid"] integerValue] type:1 succesBlock:^(id data) {
                NSArray *models = [MyBussinesModel modelsFromArray:data[@"purchaseList"]];
                [weakSelf handleModels:models total:[data[@"total"] integerValue]];
                if (models.count > 0) {
                    [self.noDataView removeFromSuperview];
                }

            } failue:^(id data, NSError *error) {
                
            }];
        }else{
        
        _weekSelf(weakSelf);
        
        [BaseRequest GetBussinessSearchListWithPageNo:0 PageSize:0 order:1 word:self.dic[@"content"] succesBlock:^(id data) {
            NSArray *models = [MyBussinesModel modelsFromArray:data[@"purchaseList"]];
            [weakSelf handleModels:models total:[data[@"total"] integerValue]];
            if (models.count > 0) {
                [self.noDataView removeFromSuperview];
            }

        } failue:^(id data, NSError *error) {
            
        }];
            
        }
        
        
        
        
    }else{
        if ([self.dic[@"type"] isEqualToString:@"1"]) {
            [BaseRequest GetRentListWithPageNo:0 PageSize:0 order:-1 brandid:[self.dic[@"brandid"] integerValue] type:1 succesBlock:^(id data) {
                
                NSArray *models = [BrandDetailModel modelsFromArray:data[@"rentList"]];
                [weakSelf handleModels:models total:[data[@"total"] integerValue]];
                if (models.count > 0) {
                    [self.noDataView removeFromSuperview];
                }

            } failue:^(id data, NSError *error) {
                
            }];

        }else{
            [BaseRequest GetSearchListWithPageNo:0 PageSize:0 order:-1 word:self.dic[@"content"] succesBlock:^(id data) {
                NSLog(@"%@",self.dic[@"content"]);
                NSArray *models = [BrandDetailModel modelsFromArray:data[@"rentList"]];
                [weakSelf handleModels:models total:[data[@"total"] integerValue]];
                if (models.count > 0) {
                    [self.noDataView removeFromSuperview];
                }

            } failue:^(id data, NSError *error) {
                
            }];
        }
        
        


    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"搜索结果";
    
    for (int i =0; i < self.tableViewArr.count; i++) {
        UITableView *tableView = self.tableViewArr[i];
        tableView.dataSource      = self;
        tableView.delegate        = self;
        tableView.showsVerticalScrollIndicator = NO;
        [tableView registerClass:[HomeBuyCell class] forCellReuseIdentifier:@"HomeBuyCell"];
        [tableView registerClass:[HomeBuyCell1 class] forCellReuseIdentifier:@"HomeBuyCell1"];
        tableView.backgroundColor = APP_COLOR_BASE_BACKGROUND;
        tableView.tableFooterView = [[UIView alloc] init];
        //        _tableView.tableHeaderView = self.headView;
        tableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
        tableView.sectionHeaderHeight = 0.0;
        tableView.sectionFooterHeight = 0.0;
        
        if (i == 0) {
            self.tableView = tableView;
        }
    }
    self.isUseNoDataView = YES;
    [self.noDataView setTitle:@"没有搜索到商品~"];

    self.index = 1;
}


#pragma mark -- UITabelViewDelegate And DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.listData.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    if ([self.myDict[@"title"] isEqualToString:@"寄租"]) {
        MyBussinesModel *model = self.listData[indexPath.section];
        HomeBuyCell1 *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeBuyCell1"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setModel:model];
        //        cell.delegate = self;
        //        cell.index = indexPath.section;
        return cell;
        
    }
    
    MyBussinesModel *model = self.listData[indexPath.section];
    HomeBuyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeBuyCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setModel:model];
    //        cell.delegate = self;
    //        cell.index = indexPath.section;
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
    
    if (self.index == 1) {
        MyBussinesModel *model = self.listData[indexPath.section];
        NSDictionary *dic = @{@"purchaseid":model.purchaseid};
        [self PushViewControllerByClassName:@"BrandDetailVC1" info:dic];
        
    }else{
        MyBussinesModel *model = self.listData[indexPath.section];
        NSDictionary *dic = @{@"rentid":model.rentid};
        [self PushViewControllerByClassName:@"BrandDetailVC" info:dic];
        
    }
    
}



-(void)setAnimationWithOrigin:(CGFloat)x{
    [super setAnimationWithOrigin:x];
    
    for (int i = 0; i < self.tableViewArr.count ; i++) {
        UITableView *tableView = self.tableViewArr[i];
        if (x/SCREEN_WIDTH == i) {
            self.tableView = tableView;
            self.index = i+1;
            self.isUseNoDataView = YES;
            [self.noDataView setTitle:@"没有搜索到商品~"];
            //            [self.tableView reloadData];
            [self loadingRequest];
            break;
        }
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
