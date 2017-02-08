//
//  MyRentVC.m
//  SXK
//
//  Created by 杨伟康 on 2016/12/28.
//  Copyright © 2016年 ywk. All rights reserved.
//

#import "MyRentVC.h"
#import "MyTenancyCell.h"
#import "MyTenancyCell1.h"
#import "MyTenancyCell2.h"
#import "MyTenancyCell3.h"
#import "MyRentModel.h"

@interface MyRentVC ()<MyTenancyDelegate,MyTenancyCell3Delegate>

@property (nonatomic, assign)NSInteger index;

@end

@implementation MyRentVC

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadingRequest];
}

-(void)loadingRequest
{
    _weekSelf(weakSelf);
    [BaseRequest GetRentorderListWithPageNo:0 PageSize:0 order:-1 status:self.index succesBlock:^(id data) {
       
        NSArray *models = [MyRentModel modelsFromArray:data[@"brandList"]];
        [weakSelf handleModels:models total:[data[@"total"] integerValue]];

//        NSLog(@"%@",describe(models));
        
    } failue:^(id data, NSError *error) {
        
    }];

}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"我的租赁";
    for (int i =0; i < self.tableViewArr.count; i++) {
        UITableView *tableView = self.tableViewArr[i];
        tableView.dataSource      = self;
        tableView.delegate        = self;
        [tableView registerClass:[MyTenancyCell class] forCellReuseIdentifier:@"MyTenancyCell"];
        [tableView registerClass:[MyTenancyCell1 class] forCellReuseIdentifier:@"MyTenancyCell1"];
        [tableView registerClass:[MyTenancyCell2 class] forCellReuseIdentifier:@"MyTenancyCell2"];
        [tableView registerClass:[MyTenancyCell3 class] forCellReuseIdentifier:@"MyTenancyCell3"];

        tableView.showsVerticalScrollIndicator = NO;
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
    
    MyRentModel *model = self.listData[indexPath.section];
    
    MyTenancyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyTenancyCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.index = indexPath.section;
    cell.delegate = self;
    [cell setModel:model];

    if (self.index == 4) {
        MyTenancyCell1 *cell = [tableView dequeueReusableCellWithIdentifier:@"MyTenancyCell1"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setModel:model];
        
        return cell;
    }
    
    if (self.index == 3) {
        MyTenancyCell2 *cell = [tableView dequeueReusableCellWithIdentifier:@"MyTenancyCell2"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setModel:model];
        
        return cell;
    }
    
    if (self.index == 5) {
        MyTenancyCell3 *cell = [tableView dequeueReusableCellWithIdentifier:@"MyTenancyCell3"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setModel:model];
        cell.index = indexPath.section;
        cell.delegate = self;

        return cell;
    }
    
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.index == 5) {
        return 195;
    }
    
//    if (self.index == 3) {
//        return 205;
//    }
    
    return 180;
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



-(void)setAnimationWithOrigin:(CGFloat)x{
    [super setAnimationWithOrigin:x];
    
    for (int i = 0; i < self.tableViewArr.count ; i++) {
        UITableView *tableView = self.tableViewArr[i];
        if (x/SCREEN_WIDTH == i) {
            self.tableView = tableView;
            self.index = i+2;
//            [self.tableView reloadData];
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
