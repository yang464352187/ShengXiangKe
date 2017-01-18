//
//  OrderVC.m
//  SXK
//
//  Created by 杨伟康 on 2016/12/27.
//  Copyright © 2016年 ywk. All rights reserved.
//

#import "OrderVC.h"
#import "OrderCell.h"
#import "OrderCell1.h"
#import "OrderCell2.h"
#import "BrandDetailModel.h"
@interface OrderVC ()<OrderCellDelegate,OrderCell1Delegate>

@property (nonatomic, strong) UIView *footView;

@property (nonatomic, assign) NSInteger selectDay;

@property (nonatomic, strong) UILabel *total;

@property (nonatomic, strong) UILabel *deposit;

@property (nonatomic, assign) CGFloat rent;

@property (nonatomic, assign) BOOL isRisk;

@property (nonatomic, strong) OrderCell1 *cell;

@property (nonatomic, assign) NSInteger day;
@end

@implementation OrderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"账单";
    [self initUI];
    self.selectDay = 1;
    self.isRisk = 0;
    NSLog(@"%@===========",describe(self.myDict));
}

-(void)initUI
{
    [self.view addSubview:self.footView];
    [self.view addSubview:self.tableView];

}

#pragma mark -- UITabelViewDelegate And DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BrandDetailModel *model = [BrandDetailModel modelFromDictionary:self.myDict];

    if (indexPath.section == 1) {
        OrderCell1 *cell1 = [tableView dequeueReusableCellWithIdentifier:@"OrderCell1"];
        cell1.delegate = self;
        [cell1 setModel:model];
        self.cell = cell1;
        cell1.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell1;
    }
    if (indexPath.section == 2) {
        OrderCell2 *cell2 = [tableView dequeueReusableCellWithIdentifier:@"OrderCell2"];
        cell2.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell2;
    }
    OrderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setModel:model];
    cell.delegate = self;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        return 150;
    }
    if (indexPath.section == 2) {
        return 125;
    }
    return 180;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 64;
    }
    return 15;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 2) {
        return 80;
    }
    return 0.000000001;
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = APP_COLOR_GRAY_Header;
    
    if (section == 0) {
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

    }
    
    
    return view;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = APP_COLOR_GRAY_Header;
    
    if (section != 2) {
        return view;
    }
    //添加下划线
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:@"查看违约金规则"];
    NSRange titleRange = {0,[title length]};
    [title addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:titleRange];
    [title addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13.0] range:titleRange];
    [title addAttribute:NSForegroundColorAttributeName value:APP_COLOR_GREEN range:titleRange];
    
    //违约金规则
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setAttributedTitle:title forState:UIControlStateNormal];
    
    //选择按钮
    UIImage *select = [UIImage imageNamed:@"1圆角矩形-1-拷贝"];//选择框
    UIButton *selectBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [selectBtn setImage:[select imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];

    //条款正文
    UILabel *titleLab = [UILabel createLabelWithFrame:VIEWFRAME(15, 0, 150, 53)                                                     andText:@"已阅读并同意"
                                         andTextColor:APP_COLOR_GRAY_Font
                                  andBgColor:[UIColor clearColor]
                                     andFont:SYSTEMFONT(13)
                            andTextAlignment:NSTextAlignmentLeft];
    
    //用户协议
    UIButton *ProtocolBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [ProtocolBtn setTitle:@"《啵呗平台用户协议》" forState:UIControlStateNormal];
    [ProtocolBtn setTitleColor:APP_COLOR_GREEN forState:UIControlStateNormal];
    ProtocolBtn.titleLabel.font = SYSTEMFONT(13);

    [view addSubview:selectBtn];
    [view addSubview:button];
    [view addSubview:titleLab];
    [view addSubview:ProtocolBtn];
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view.mas_top).offset(19);
        make.left.equalTo(view.mas_left).offset(15);
        make.size.mas_equalTo(CGSizeMake(13*8, 14));
    }];
    
    [selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(button.mas_bottom).offset(10);
        make.left.equalTo(view.mas_left).offset(15);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(selectBtn).offset(0);
        make.left.equalTo(selectBtn.mas_right).offset(0);
        make.size.mas_equalTo(CGSizeMake(13*7, 15));
    }];

    [ProtocolBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(titleLab).offset(0);
        make.left.equalTo(titleLab.mas_right).offset(-20);
        make.size.mas_equalTo(CGSizeMake(140, 15));
    }];

    
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
        [_tableView registerClass:[OrderCell1 class] forCellReuseIdentifier:@"OrderCell1"];
        [_tableView registerClass:[OrderCell2 class] forCellReuseIdentifier:@"OrderCell2"];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.backgroundColor = [UIColor colorWithHexColorString:@"f7f7f7"];
        _tableView.tableFooterView = [[UIView alloc] init];
//      _tableView.tableHeaderView = self.headView;
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
        [payBtn setTitle:@"提交订单" forState:UIControlStateNormal];
        [payBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [payBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
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

        self.total = first;
        self.deposit = second;
        
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

        BrandDetailModel *model = [BrandDetailModel modelFromDictionary:self.myDict];

        self.total.text = [NSString stringWithFormat:@"租金及其他:¥%.2f",[model.three floatValue]/100];
        self.deposit.text = [NSString stringWithFormat:@"押金:¥%.2f",[model.marketPrice floatValue]/100];
        
    }
    
    return _footView;
}


-(void)btnClick:(UIButton *)sender
{
    BrandDetailModel *model = [BrandDetailModel modelFromDictionary:self.myDict];
    
    NSDictionary *dic =@{@"name":@"three",
                         @"value":model.three
                         };
//    NSArray *array = @[dic];
    
    NSInteger i = [model.three integerValue] + [model.marketPrice integerValue];
    
    
    NSDictionary *params = @{@"rentid":model.rentid,
                             @"isRisk":@(2),
                             @"tenancy":dic,
                             @"total":@(i),
                             @"receiverid":@(112),
                             @"message":@"测试测试测试测试测试测试测试测试测试"
                          };
    _weekSelf(weakSelf);
    [BaseRequest CreatOrderWithParams:params succesBlock:^(id data) {
//        NSLog(@"%@",data);
        if ([data[@"code"] integerValue] == 1) {
            NSInteger orderid = [data[@"orderid"] integerValue];
            NSDictionary *dic = @{@"orderid":@(orderid),
                                  };
            [weakSelf PushViewControllerByClassName:@"PayVC" info:dic];
        }
        
    } failue:^(id data, NSError *error) {
        
    }];
}

-(void)returnDay:(NSInteger)day
{
    BrandDetailModel *model = [BrandDetailModel modelFromDictionary:self.myDict];
    
    switch (day) {
        case 1:{
            self.cell.depositLab.text = [NSString stringWithFormat:@"¥:%.2f",[model.three floatValue]/100];
            self.rent = [model.three floatValue]/100;
        }
            break;
        case 2:{
            self.cell.depositLab.text = [NSString stringWithFormat:@"¥:%.2f",[model.seven floatValue]/100];
            self.rent = [model.seven floatValue]/100;
        }
            break;
            
        case 3:{
            self.cell.depositLab.text= [NSString stringWithFormat:@"¥:%.2f",[model.fiften floatValue]/100];
            self.rent = [model.fiften floatValue]/100;

        }
            break;
            
        case 4:{
            self.cell.depositLab.text = [NSString stringWithFormat:@"¥:%.2f",[model.twentyFive floatValue]/100];
            self.rent = [model.twentyFive floatValue]/100;

        }
            break;
        default:
            break;
    }
    
    if (self.isRisk) {
        self.total.text = [NSString stringWithFormat:@"租金及其他:¥%.2f",self.rent + [model.risk floatValue]/100];
    }else{
        self.total.text = [NSString stringWithFormat:@"租金及其他:¥%.2f",self.rent ];
    }
    
    self.day = day;
}


-(void)returnRisk:(BOOL)certain
{
    BrandDetailModel *model = [BrandDetailModel modelFromDictionary:self.myDict];
    
    if (certain) {
        self.total.text = [NSString stringWithFormat:@"租金及其他:¥%.2f",self.rent + [model.risk floatValue]/100];
    }else{
        self.total.text = [NSString stringWithFormat:@"租金及其他:¥%.2f",self.rent ];
    }
    self.isRisk = certain;
    
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
