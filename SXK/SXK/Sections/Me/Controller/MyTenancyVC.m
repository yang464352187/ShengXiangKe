//
//  MyTenancyVC.m
//  SXK
//
//  Created by 杨伟康 on 2016/12/26.
//  Copyright © 2016年 ywk. All rights reserved.
//

#import "MyTenancyVC.h"
#import "MyTenancyCell.h"
#import "MyTenancyCell1.h"
#import "MyTenancyCell2.h"

@interface MyTenancyVC ()
@property (nonatomic, assign)NSInteger index;

@end

@implementation MyTenancyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"我的租赁";
    NSArray *array = @[@"待收货",@"已收货",@"已完成",@"已退回"];
    [self setupTitlesView:array];
    [self.view addSubview:self.tableView];
    
    
}


#pragma mark -- UITabelViewDelegate And DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MyTenancyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyTenancyCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    if (self.index == 3) {
        MyTenancyCell1 *cell = [tableView dequeueReusableCellWithIdentifier:@"MyTenancyCell1"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    if (self.index == 2) {
        MyTenancyCell2 *cell = [tableView dequeueReusableCellWithIdentifier:@"MyTenancyCell2"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        return cell;
    }
    if (self.index == 1) {
        [cell reSetName];
        return cell;
    }
    [cell reName];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.index == 3) {
        return 195;
    }
    if (self.index == 2) {
        return 205;
    }

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

#pragma mark -- getters and setters

- (UITableView *)tableView{
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:VIEWFRAME(0, 35, SCREEN_WIDTH, SCREEN_HIGHT-64-35) style:UITableViewStyleGrouped];
        _tableView.dataSource      = self;
        _tableView.delegate        = self;
        [_tableView registerClass:[MyTenancyCell class] forCellReuseIdentifier:@"MyTenancyCell"];
        [_tableView registerClass:[MyTenancyCell1 class] forCellReuseIdentifier:@"MyTenancyCell1"];
        [_tableView registerClass:[MyTenancyCell2 class] forCellReuseIdentifier:@"MyTenancyCell2"];
        _tableView.showsVerticalScrollIndicator = NO;;
        _tableView.backgroundColor = APP_COLOR_BASE_BACKGROUND;
        _tableView.tableFooterView = [[UIView alloc] init];
        //        _tableView.tableHeaderView = self.headView;
        _tableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
        _tableView.sectionHeaderHeight = 0.0;
        _tableView.sectionFooterHeight = 0.0;
        
    }
    return _tableView;
}

- (void)titleClick:(UIButton *)button
{
    [self buttonStateChange:button];
    // 滚动
    //    [self setShowingIndex:button.tag animate:YES];
}

- (void)buttonStateChange:(UIButton *)button
{
    self.index = button.tag;
    [self.tableView reloadData];
    // 修改按钮状态
    self.selectedButton.enabled = YES;
    button.enabled = NO;
    self.selectedButton = button;
    [UIView animateWithDuration:0.25 animations:^{
        self.indicatorView.width = button.titleLabel.width;
        self.indicatorView.centerX = button.centerX;
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
