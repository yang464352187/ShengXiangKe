//
//  OrderVC.m
//  SXK
//
//  Created by 杨伟康 on 2016/12/27.
//  Copyright © 2016年 ywk. All rights reserved.
//

#import "OrderVC.h"
#import "OrderCell.h"

@interface OrderVC ()

@property (nonatomic, strong) UIView *footView;


@end

@implementation OrderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"账单";
    [self initUI];
}

-(void)initUI
{
    [self.view addSubview:self.footView];
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
    OrderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderCell"];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 180;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 64;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.000000001;
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = APP_COLOR_GRAY_Header;
    
    UILabel *address = [UILabel createLabelWithFrame:VIEWFRAME(30, 0, 100, 44)                                                 andText:@"请选择收货地址"
                                      andTextColor:[UIColor blackColor]
                                        andBgColor:[UIColor clearColor]
                                           andFont:SYSTEMFONT(13)
                                  andTextAlignment:NSTextAlignmentLeft];

    [view addSubview:address];
    
    [address mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(view);
        make.left.equalTo(view.mas_left).offset(23.5);
        make.size.mas_equalTo(CGSizeMake(150, 14));
    }];
    
    
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


- (UITableView *)tableView{
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:VIEWFRAME(0, 0, SCREEN_WIDTH, SCREEN_HIGHT-64-44) style:UITableViewStyleGrouped];
        _tableView.dataSource      = self;
        _tableView.delegate        = self;
        [_tableView registerClass:[OrderCell class] forCellReuseIdentifier:@"OrderCell"];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.backgroundColor = [UIColor colorWithHexColorString:@"f7f7f7"];
        _tableView.tableFooterView = [[UIView alloc] init];
//        _tableView.tableHeaderView = self.headView;
        _tableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
        _tableView.sectionHeaderHeight = 0.0;
        _tableView.sectionFooterHeight = 0.0;
        
    }
    return _tableView;
}



- (UIView *)footView{
    if (!_footView) {
        _footView = [[UIView alloc] initWithFrame:VIEWFRAME(0, SCREEN_HIGHT - 44 - 64, SCREEN_WIDTH, 44)];
        _footView.backgroundColor = [UIColor whiteColor];
        
        UIButton *payBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        payBtn.backgroundColor = [UIColor colorWithHexColorString:@"14a8ad"];
        payBtn.frame = VIEWFRAME(SCREEN_WIDTH-CommonWidth(154), 0, CommonWidth(154), 44);
        [payBtn setTitle:@"立即付款" forState:UIControlStateNormal];
        [payBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        UILabel *first = [UILabel createLabelWithFrame:VIEWFRAME(30, 0, 100, 44)                                                 andText:@"租金及其他:¥ 450000"
                                          andTextColor:[UIColor blackColor]
                                            andBgColor:[UIColor clearColor]
                                               andFont:SYSTEMFONT(13)
                                      andTextAlignment:NSTextAlignmentLeft];
        
        UILabel *second = [UILabel createLabelWithFrame:VIEWFRAME(30, 0, 100, 44)                                                 andText:@"押金:¥ 1000000"
                                          andTextColor:[UIColor blackColor]
                                            andBgColor:[UIColor clearColor]
                                               andFont:SYSTEMFONT(13)
                                      andTextAlignment:NSTextAlignmentLeft];

        [_footView addSubview:payBtn];
        [_footView addSubview:first];
        [_footView addSubview:second];
        
        [first mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_footView.mas_left).offset(30);
            make.top.equalTo(_footView.mas_top).offset(5);
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH-CommonWidth(154) - 30, 15));
        }];
        
        [second mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_footView.mas_left).offset(30);
            make.top.equalTo(first.mas_bottom).offset(5);
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH-CommonWidth(154) - 30, 15));
        }];


    }
    
    return _footView;
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
