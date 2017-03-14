//
//  MyMaintainVC.m
//  SXK
//
//  Created by 杨伟康 on 2016/12/26.
//  Copyright © 2016年 ywk. All rights reserved.
//

#import "MyMaintainVC.h"
#import "MyMaintainCell.h"
#import "MyMaintainCell1.h"
#import "MyMaintainModel.h"

@interface MyMaintainVC ()<MyMaintainCellDelegate>

@property (nonatomic, assign)NSInteger index;

@end

@implementation MyMaintainVC



-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadingRequest];
    
}

-(void)loadingRequest
{
    _weekSelf(weakSelf);
    [BaseRequest GetMyMaintainListWithPageNo:0 PageSize:0 order:-1 status:self.index succesBlock:^(id data) {
        
        NSArray *models = [MyMaintainModel modelsFromArray:data[@"orderList"]];
        [weakSelf handleModels:models total:[data[@"total"] integerValue]];
        
    } failue:^(id data, NSError *error) {
        
    }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"我的养护";
    
    for (int i =0; i < self.tableViewArr.count; i++) {
        UITableView *tableView = self.tableViewArr[i];
        tableView.dataSource      = self;
        tableView.delegate        = self;
        tableView.showsVerticalScrollIndicator = NO;
        [tableView registerClass:[MyMaintainCell class] forCellReuseIdentifier:@"MyMaintainCell"];
        [tableView registerClass:[MyMaintainCell1 class] forCellReuseIdentifier:@"MyMaintainCell1"];
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
    MyMaintainModel *model = self.listData[indexPath.section];
    MyMaintainCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyMaintainCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setModel:model];
    cell.delegate = self;
    cell.index = indexPath.section;
    
    if (self.index == 3) {
        MyMaintainCell1 *cell = [tableView dequeueReusableCellWithIdentifier:@"MyMaintainCell1"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setModel:model];
        
        return cell;
    }
    
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.index == 3) {
        return 138;
    }
    return 160;
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
