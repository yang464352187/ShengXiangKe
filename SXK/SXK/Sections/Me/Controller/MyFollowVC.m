//
//  MyFollowVC.m
//  SXK
//
//  Created by 杨伟康 on 2017/1/20.
//  Copyright © 2017年 ywk. All rights reserved.
//

#import "MyFollowVC.h"
#import "FollowListModel.h"
#import "FollowListCell.h"
@interface MyFollowVC ()

@end

@implementation MyFollowVC

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    _weekSelf(weakSelf);
    [BaseRequest GetFollowListsuccesBlock:^(id data) {
        NSArray *models = [FollowListModel modelsFromArray:data[@"follow"][@"userList"]];
        NSLog(@"%@",describe(models));
        [weakSelf handleModels:models total:models.count];
    } failue:^(id data, NSError *error) {
        
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"我的关注";
    [self.view addSubview:self.tableView];
}

#pragma mark -- getters and setters
- (UITableView *)tableView{
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:VIEWFRAME(0, 0, SCREEN_WIDTH, SCREEN_HIGHT-64) style:UITableViewStyleGrouped];
        _tableView.dataSource      = self;
        _tableView.delegate        = self;
        [_tableView registerClass:[FollowListCell class] forCellReuseIdentifier:@"FollowListCell"];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.backgroundColor = [UIColor colorWithHexColorString:@"f7f7f7"];
        _tableView.separatorStyle  = UITableViewCellSeparatorStyleSingleLine;
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
    
    FollowListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FollowListCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setModel:self.listData[indexPath.row]];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.0000001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.0000001;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    FollowListModel *model = self.listData[indexPath.section];
    _weekSelf(weakSelf);
    [BaseRequest DeleteFollowWithUserID:[model.userid integerValue] succesBlock:^(id data) {
        [self.listData removeObjectAtIndex:indexPath.section];
//        NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:indexPath.section];
//        [self.tableView deleteSections:indexSet withRowAnimation:UITableViewRowAnimationFade];
        [weakSelf.tableView reloadData];
    } failue:^(id data, NSError *error) {
        
    }];
    
}

//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return YES;
//}
//
//- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//    return UITableViewCellEditingStyleDelete;
//}
//
////设置编辑状态下cell删除按钮的名字
//- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//    return @"删除";
//}



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
