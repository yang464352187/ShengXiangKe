
//
//  DepositeVC.m
//  SXK
//
//  Created by 杨伟康 on 2017/2/21.
//  Copyright © 2017年 ywk. All rights reserved.
//

#import "DepositeVC.h"
#import "PayCell.h"
#import "DepositeCell.h"
@interface DepositeVC ()<SelectPayCellDelegate,DepositeCellDelegate>


@property (nonatomic, strong) NSArray *payArr;

@property (nonatomic, strong) PayCell *selectCell;

@property (nonatomic, strong) NSString *type;

@property (nonatomic, strong) NSString *money;

@end

@implementation DepositeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"充值";
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];//设置电池条颜色为黑色
    
    [self initData];
    [self.view addSubview:self.tableView];

}
-(void)initData
{
    self.payArr = @[@"微信支付",@"支付宝支付",@"银联支付"];
}

#pragma mark -- UITabelViewDelegate And DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 3) {
        DepositeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DepositeCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
        return cell;
    }
    
    PayCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PayCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell fillWithTitle:self.payArr[indexPath.row]];
    cell.delegate = self;
    cell.type = indexPath.row;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 54;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.00000001;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 50;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = APP_COLOR_GRAY_Header;
    
    UIButton *certainBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [certainBtn setTitle:@"立即充值" forState:UIControlStateNormal];
    certainBtn.backgroundColor = APP_COLOR_GREEN;
    [certainBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    certainBtn.titleLabel.font = SYSTEMFONT(14);
    certainBtn.frame = VIEWFRAME(15, 20, CommonWidth(335), 40);
    [certainBtn addTarget:self action:@selector(payAction:) forControlEvents:UIControlEventTouchUpInside];
    ViewRadius(certainBtn, certainBtn.frame.size.height/2);
    
    
    [view addSubview:certainBtn];
    
    return view;
}

- (UITableView *)tableView{
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:VIEWFRAME(0, 0, SCREEN_WIDTH, SCREEN_HIGHT-64) style:UITableViewStyleGrouped];
        _tableView.dataSource      = self;
        _tableView.delegate        = self;
        [_tableView registerClass:[PayCell class] forCellReuseIdentifier:@"PayCell"];
        [_tableView registerClass:[DepositeCell class] forCellReuseIdentifier:@"DepositeCell"];

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

-(void)sendValue:(id)cell andType:(NSInteger)type
{
    switch (type) {
        case 0:
            self.type = @"wx";
            break;
        case 1:
            self.type = @"alipay";
            break;
            
        case 2:
            self.type = @"upacp";
            break;

        
        
        default:
            break;
    }
    
    if (self.selectCell) {
        [self.selectCell isSelect];
        [(PayCell *)cell isSelect];
        self.selectCell = (PayCell *)cell;
    }else{
        [(PayCell *)cell isSelect];
        self.selectCell = (PayCell *)cell;
        
    }
    
    
}

-(void)payAction:(UIButton *)sender
{
    _weekSelf(weakSelf);
    [BaseRequest SetRechargeorderWithAmount:[self.money floatValue] * 100 succesBlock:^(id data) {
        
        [weakSelf payWithOrderId:[data[@"orderid"] integerValue]];
        
    } failue:^(id data, NSError *error) {
        
    }];
    
}
-(void)payWithOrderId:(NSInteger)order
{
    [BaseRequest PayWithChannel:self.type orderID:order type:5 succesBlock:^(id data) {
        
        //        NSLog(@"======%@====",data[@"info"]);
        _weekSelf(weakSelf);
        [Pingpp createPayment:data[@"info"] appURLScheme:@"wx4bfb2d22ce82d40d" withCompletion:^(NSString *result, PingppError *error) {
            NSLog(@"completion block: %@", result);
            if (error == nil) {
                NSLog(@"PingppError is nil");
                [ProgressHUDHandler showHudTipStr:@"付款成功"];
                [weakSelf PopToRootViewController];
            } else {
                NSLog(@"PingppError: code=%lu msg=%@", (unsigned  long)error.code, [error getMsg]);
                if (error.code == 3) {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                                    message:@"您还没安装微信,请前往AppStore中下载安装"
                                                                   delegate:nil
                                                          cancelButtonTitle:@"确定"
                                                          otherButtonTitles:nil];
                    [alert show];
                }
            }
        }];
        
        
    } failue:^(id data, NSError *error) {
        
    }];

}

-(void)returnText:(NSString *)text
{
    self.money = text;
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
