//
//  AddressManagerVC.m
//  SXK
//
//  Created by 杨伟康 on 2016/12/5.
//  Copyright © 2016年 ywk. All rights reserved.
//

#import "AddressManagerVC.h"
#import "AddressManagerCell.h"
#import "AddressModel.h"

@interface AddressManagerVC ()<UITableViewDataSource,UITableViewDelegate>


@property (nonatomic, strong) UIView *footerView;

@end

@implementation AddressManagerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"常用地址";
    [self.view addSubview:self.tableView];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadingRequest];
}
- (void)loadingRequest{
//    [self startLoadingView:self.tableView.frame];
    _weekSelf(weakSelf);
    [BaseRequest getAddressWithPageNo:1 PageSize:10 order:nil succesBlock:^(id data) {
        NSArray *models = [AddressModel modelsFromArray:data[@"receiverList"]];
        [weakSelf handleModels:models total:0];
    } failue:^(id data, NSError *error) {
        
    }];

}

#pragma mark -- getters and setters
- (UITableView *)tableView{
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:VIEWFRAME(0, 0, SCREEN_WIDTH, SCREEN_HIGHT-64) style:UITableViewStyleGrouped];
        _tableView.dataSource      = self;
        _tableView.delegate        = self;
//        [_tableView registerClass:[AddressManagerCell class] forCellReuseIdentifier:@"AddressManagerCell"];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.backgroundColor = [UIColor colorWithHexColorString:@"f7f7f7"];
        _tableView.tableFooterView = self.footerView;
        //        _tableView.tableHeaderView = [[UIView alloc] init];
        _tableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
        _tableView.sectionHeaderHeight = 0.0;
        _tableView.sectionFooterHeight = 0.0;
        _tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshHeaderAction)];
        _tableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(refreshFooterAction)];
    }
    return _tableView;
}

-(UIView *)footerView
{
    if (!_footerView) {
        _footerView = [[UIView alloc] initWithFrame:VIEWFRAME(0, 0, SCREEN_WIDTH, 80)];
        _footerView.backgroundColor = [UIColor colorWithHexColorString:@"f7f7f7"];
        
        UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [addBtn setTitle:@"增加收货地址" forState:UIControlStateNormal];
        addBtn.backgroundColor = APP_COLOR_GREEN;
        [addBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [addBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        addBtn.tag = 101;
        addBtn.titleLabel.font = SYSTEMFONT(14);
        addBtn.frame = VIEWFRAME(15, 20, CommonWidth(335), 40);
        ViewRadius(addBtn, addBtn.frame.size.height/2);

        [_footerView addSubview:addBtn];
    }
    return _footerView;
}

#pragma mark -- UITabelViewDelegate And DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.listData.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *CellIdentifier = [NSString stringWithFormat:@"cell%ld%ld",indexPath.section,indexPath.row];//不使用复用
    
    AddressManagerCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[AddressManagerCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setModel:self.listData[indexPath.section]];
//    if (indexPath.row % 2  == 0) {
//        cell.backgroundColor =[UIColor greenColor];
//    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 35;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *header = [[UIView alloc] init];
    header.backgroundColor = [UIColor colorWithHexColorString:@"f7f7f7"];
    return header;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footer = [[UIView alloc ] init];
    footer.backgroundColor = [UIColor whiteColor];
    
    UIImage *deleteImage = [UIImage imageNamed:@"删除"];
    UIImage *editImage = [UIImage imageNamed:@"编辑"];
    
    UIButton *deleteBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
    [deleteBtn setImage:[deleteImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    deleteBtn.frame = VIEWFRAME(SCREEN_WIDTH - 65, 11, 50, 15);
    deleteBtn.titleLabel.font = SYSTEMFONT(12);
    deleteBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 8, 0, 0);
    [deleteBtn setTintColor:[UIColor blackColor]];
    
    UIButton *editBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [editBtn setTitle:@"编辑" forState:UIControlStateNormal];
    [editBtn setImage:[editImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    editBtn.frame = VIEWFRAME(SCREEN_WIDTH - 130, 11, 50, 15);
    editBtn.titleLabel.font = SYSTEMFONT(12);
    editBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 8, 0, 0);
    [editBtn setTintColor:[UIColor blackColor]];
    
    [footer addSubview: deleteBtn];
    [footer addSubview: editBtn];
    
    return footer;
}
- (void)getDataByNetwork{
    _weekSelf(weakSelf);
    [BaseRequest getAddressWithPageNo:1 PageSize:5 order:nil succesBlock:^(id data) {
        [weakSelf stopRefresh];
        NSArray *models = [AddressModel modelsFromArray:data[@"receiverList"]];
        [weakSelf handleModels:models total:0];
    } failue:^(id data, NSError *error) {
        [weakSelf stopRefresh];
    }];
}


-(void)buttonAction:(UIButton *)sender{
    switch (sender.tag) {
        case 101:{
            [self PushViewControllerByClassName:@"AddAddress" info:nil];
            break;
        }
            
        default:
            break;
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
