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
@interface MyKeepVC ()

@end

@implementation MyKeepVC

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    _weekSelf(weakSelf);
    [BaseRequest GetKeepListsuccesBlock:^(id data) {
        NSArray *models = [MyPromulgateModel modelsFromArray:data[@"collection"][@"rentList"]];
        [weakSelf handleModels:models total:models.count];
    } failue:^(id data, NSError *error) {
        
    }];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"我的收藏";
    [self.view addSubview:self.tableView];
}

#pragma mark -- getters and setters
- (UITableView *)tableView{
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:VIEWFRAME(0, 0, SCREEN_WIDTH, SCREEN_HIGHT-64) style:UITableViewStyleGrouped];
        _tableView.dataSource      = self;
        _tableView.delegate        = self;
        _tableView.showsVerticalScrollIndicator = NO;
        [_tableView registerClass:[MyKeepCell class] forCellReuseIdentifier:@"MyKeepCell"];
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
    
    MyPromulgateModel *model = self.listData[indexPath.section];
    MyKeepCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyKeepCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setModel:model];

    
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
    
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyPromulgateModel *model = self.listData[indexPath.section];
    _weekSelf(weakSelf);
    [BaseRequest CancelKeepWithRentID:[model.rentid integerValue] succesBlock:^(id data) {
        [self.listData removeObjectAtIndex:indexPath.section];
        [weakSelf.tableView reloadData];

    } failue:^(id data, NSError *error) {
        
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
