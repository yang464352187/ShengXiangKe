//
//  MyDistributeVC.m
//  SXK
//
//  Created by 杨伟康 on 2016/12/28.
//  Copyright © 2016年 ywk. All rights reserved.
//

#import "MyDistributeVC.h"
#import "MyPromulgateCell.h"
#import "MyPromulgateModel.h"
#import "MyPromulgateCell1.h"
#import "MyPromulgateCell2.h"

@interface MyDistributeVC ()<MyPromulgateCell1Delegate,MyPromulgateCellDelegate,MyPromulgateCell2Delegate>
@property (nonatomic, assign)NSInteger index;

@end

@implementation MyDistributeVC


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
//        [weakSelf.tableView reloadData];
        
    } failue:^(id data, NSError *error) {
        
    }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"我的发布";
    for (int i =0; i < self.tableViewArr.count; i++) {
        UITableView *tableView = self.tableViewArr[i];
        tableView.dataSource      = self;
        tableView.delegate        = self;
        [tableView registerClass:[MyPromulgateCell class] forCellReuseIdentifier:@"MyPromulgateCell"];
        [tableView registerClass:[MyPromulgateCell1 class] forCellReuseIdentifier:@"MyPromulgateCell1"];
        [tableView registerClass:[MyPromulgateCell2 class] forCellReuseIdentifier:@"MyPromulgateCell2"];
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
    self.index =1;
    
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
        cell.index = indexPath.section;
        cell.delegate = self;
        [cell setModel:model];
        return cell;
    }
    if (self.index == 3) {
        MyPromulgateCell2 *cell = [tableView dequeueReusableCellWithIdentifier:@"MyPromulgateCell2"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setModel:model];
        cell.delegate = self;
        cell.index = indexPath.section;
        return cell;
    }
    
    MyPromulgateCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyPromulgateCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setModel:model];
    cell.index = indexPath.section;
    cell.delegate = self;
    if (self.index == 4 || self.index == 5) {
        [cell reName:@"删除"];
    }
    
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

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


-(void)setAnimationWithOrigin:(CGFloat)x{
    [super setAnimationWithOrigin:x];
    
    for (int i = 0; i < self.tableViewArr.count ; i++) {
        UITableView *tableView = self.tableViewArr[i];
        if (x/SCREEN_WIDTH == i) {
            self.tableView = tableView;
            self.index = i +1;
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
