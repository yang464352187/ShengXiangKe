//
//  ThreeVC.m
//  SXK
//
//  Created by 杨伟康 on 2017/1/17.
//  Copyright © 2017年 ywk. All rights reserved.
//

#import "ThreeVC.h"
#import "MaintainCell.h"
#import "BrandDetailModel.h"
@interface ThreeVC ()

@end

@implementation ThreeVC
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if ([self.myDict[@"title"] isEqualToString:@"私人定制"]) {
        
        _weekSelf(weakSelf)
        [BaseRequest GetLeftSetupWithSetupID:1 succesBlock:^(id data) {
//            NSLog(@"%@",describe(data));
            NSArray *models = [BrandDetailModel modelsFromArray:data[@"setup"][@"rentList"]];
            [weakSelf handleModels:models total:[data[@"total"] integerValue]];

        } failue:^(id data, NSError *error) {
            
        }];
        
    }else if ([self.myDict[@"title"] isEqualToString:@"啵呗优选"]){
        _weekSelf(weakSelf)

        [BaseRequest GetRightUpSetupWithSetupID:1 succesBlock:^(id data) {
            NSArray *models = [BrandDetailModel modelsFromArray:data[@"setup"][@"rentList"]];
            [weakSelf handleModels:models total:[data[@"total"] integerValue]];

        } failue:^(id data, NSError *error) {
            
        }];
        
    }else if ([self.myDict[@"title"] isEqualToString:@"放心租"]){
        _weekSelf(weakSelf)

        [BaseRequest GetRightDownSetupWithSetupID:1 succesBlock:^(id data) {
            NSArray *models = [BrandDetailModel modelsFromArray:data[@"setup"][@"rentList"]];
            [weakSelf handleModels:models total:[data[@"total"] integerValue]];

        } failue:^(id data, NSError *error) {
            
        }];
        
    }else if ([self.myDict[@"title"] isEqualToString:@"精选分类"]) {
        _weekSelf(weakSelf)
        [BaseRequest GetHomeClassWithSetupID:[self.myDict[@"classid"] integerValue] succesBlock:^(id data) {
            NSArray *models = [BrandDetailModel modelsFromArray:data[@"class"][@"rentList"]];
            [weakSelf handleModels:models total:[data[@"total"] integerValue]];

        } failue:^(id data, NSError *error) {
            
        }];
    }else{
        _weekSelf(weakSelf)
        [BaseRequest GetHomeTopicWithSetupID:[self.myDict[@"topicid"] integerValue] succesBlock:^(id data) {
            NSArray *models = [BrandDetailModel modelsFromArray:data[@"topic"][@"rentList"]];
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
    MaintainCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MaintainCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    BrandDetailModel *model = self.listData[indexPath.section];
    [cell setModel1:model];
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
    
    BrandDetailModel *model = self.listData[indexPath.section];
    NSDictionary *dic = @{@"rentid":model.rentid};
    [self PushViewControllerByClassName:@"BrandDetailVC" info:dic];
}

- (UITableView *)tableView{
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:VIEWFRAME(0, 0, SCREEN_WIDTH, SCREEN_HIGHT-64) style:UITableViewStyleGrouped];
        _tableView.dataSource      = self;
        _tableView.delegate        = self;
        [_tableView registerClass:[MaintainCell class] forCellReuseIdentifier:@"MaintainCell"];
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
