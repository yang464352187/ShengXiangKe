//
//  ShowVC.m
//  SXK
//
//  Created by 杨伟康 on 2017/2/6.
//  Copyright © 2017年 ywk. All rights reserved.
//

#import "ShowVC.h"
#import "MaintainCell.h"
#import "BrandDetailModel.h"
#import "MyBussinesModel.h"
#import "HomeBuyCell.h"
@interface ShowVC ()



@end

@implementation ShowVC
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadingRequest];
    
}

-(void)loadingRequest
{
    
    
    _weekSelf(weakSelf)
    
    if ([self.myDict[@"title"] isEqualToString:@"寄租"]) {
        
        [BaseRequest GetRentList1WithPageNo:0 PageSize:0 order:-1 succesBlock:^(id data) {
            NSArray *models = [MyBussinesModel modelsFromArray:data[@"rentList"]];
            [weakSelf handleModels:models total:[data[@"total"] integerValue]];
        } failue:^(id data, NSError *error) {
            
        }];
        
    }else{
        
//        [BaseRequest GetShowSetupListWithSetupID:1 succesBlock:^(id data) {
//            //        NSLog(@"%@",describe(data));
//            NSArray *models = [BrandDetailModel modelsFromArray:data[@"setup"][@"rentList"]];
//            [weakSelf handleModels:models total:[data[@"total"] integerValue]];
//            
//        } failue:^(id data, NSError *error) {
//            
//        }];
        
        [BaseRequest GetPurchaseList1WithPageNo:0 PageSize:0 order:-1 status:3 succesBlock:^(id data) {
            NSArray *models = [MyBussinesModel modelsFromArray:data[@"purchaseList"]];
            [weakSelf handleModels:models total:[data[@"total"] integerValue]];

        } failue:^(id data, NSError *error) {
            
        }];
        
    }
    
    

}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = self.myDict[@"title"];
    [self.view addSubview:self.tableView];
    
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
    HomeBuyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeBuyCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setModel:model];
    //        cell.delegate = self;
    //        cell.index = indexPath.section;
    return cell;
    
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
    if ([self.myDict[@"title"] isEqualToString:@"寄租"]) {
        MyBussinesModel *model = self.listData[indexPath.section];
        NSDictionary *dic = @{@"rentid":model.rentid};
        [self PushViewControllerByClassName:@"BrandDetailVC" info:dic];

    }else{
        MyBussinesModel *model = self.listData[indexPath.section];
        NSDictionary *dic = @{@"purchaseid":model.purchaseid};
        [self PushViewControllerByClassName:@"BrandDetailVC1" info:dic];

    }
    
    
    
}

- (UITableView *)tableView{
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:VIEWFRAME(0, 0, SCREEN_WIDTH, SCREEN_HIGHT-64) style:UITableViewStyleGrouped];
        _tableView.dataSource      = self;
        _tableView.delegate        = self;
        [_tableView registerClass:[MaintainCell class] forCellReuseIdentifier:@"MaintainCell"];
        [_tableView registerClass:[HomeBuyCell class] forCellReuseIdentifier:@"HomeBuyCell"];
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
