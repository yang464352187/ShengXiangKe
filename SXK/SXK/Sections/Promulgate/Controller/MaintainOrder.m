//
//  MaintainOrder.m
//  SXK
//
//  Created by 杨伟康 on 2017/1/20.
//  Copyright © 2017年 ywk. All rights reserved.
//

#import "MaintainOrder.h"
#import "MaintainCell.h"
#import "MaintainCellModel.h"
#import "AddressModel.h"
#import "MaintainOrderCell1.h"
#import "OrderCell2.h"
#import "PayCell.h"
@interface MaintainOrder ()<OrderCell2Delegate,SelectPayCellDelegate>

@property (nonatomic, strong) UIView *footView;

@property (nonatomic, strong) NSMutableArray *dataArr;

@property (nonatomic, strong) AddressModel *model;

@property (nonatomic, strong) UILabel *addressTitle;

@property (nonatomic, strong) UILabel *nameLab;

@property (nonatomic, strong) UILabel *phoneLab;

@property (nonatomic, strong) UILabel *addressLab;

@property (nonatomic, strong) NSString *content;

@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) NSString *mobile;

@property (nonatomic, strong) NSString *address;

@property (nonatomic, strong) NSArray *payArr;

@property (nonatomic, strong) PayCell *selectCell;

@property (nonatomic, strong) NSString *type;

@property (nonatomic, strong) MaintainCellModel *MaintainModel;

@end

@implementation MaintainOrder
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    _weekSelf(weakSelf);
    [BaseRequest GetAddressWithReceiverid:0 succesBlock:^(id data) {
        
        weakSelf.model = [AddressModel modelFromDictionary:data[@"receiver"]];
        //        NSLog(@"%ld",[data[@"code"] integerValue]);
        weakSelf.nameLab.text = [NSString stringWithFormat:@"姓名:%@",weakSelf.model.name];
        weakSelf.phoneLab.text = [NSString stringWithFormat:@"电话:%@",weakSelf.model.mobile];
        weakSelf.addressLab.text = [NSString stringWithFormat:@"地址:%@%@%@%@",weakSelf.model.state,weakSelf.model.city,weakSelf.model.district,weakSelf.model.address];
        
        weakSelf.name = [NSString stringWithFormat:@"姓名:%@",weakSelf.model.name];
        weakSelf.mobile = [NSString stringWithFormat:@"电话:%@",weakSelf.model.mobile];
        weakSelf.address = [NSString stringWithFormat:@"地址:%@%@%@%@",weakSelf.model.state,weakSelf.model.city,weakSelf.model.district,weakSelf.model.address];
        weakSelf.addressTitle.text = @"";
    } failue:^(id data, NSError *error) {
        weakSelf.addressTitle.text = data[@"message"];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"账单";
    self.dataArr = [[NSMutableArray alloc] init];
    MaintainCellModel *model = [MaintainCellModel modelFromDictionary:self.myDict];
    [self.dataArr addObject:model];
    self.MaintainModel = model;
    self.payArr = @[@"微信支付",@"支付宝支付",@"余额支付"];
    
    [self initUI];
}




-(void)initUI
{
    [self.view addSubview:self.footView];
    [self.view addSubview:self.tableView];
    
}


#pragma mark -- UITabelViewDelegate And DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.dataArr.count > 0) {
        
        return self.dataArr.count+3;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 3) {
        return 3;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MaintainCellModel *model = self.dataArr[0];
    if (indexPath.section == 0) {
        MaintainCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MaintainCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setModel:model];
        return cell;
    }
    if (indexPath.section == 2) {
        OrderCell2 *cell2 = [tableView dequeueReusableCellWithIdentifier:@"OrderCell2"];
        cell2.selectionStyle = UITableViewCellSelectionStyleNone;
        cell2.delegate =self;
        return cell2;
    }
    if (indexPath.section == 3) {
        PayCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PayCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell fillWithTitle:self.payArr[indexPath.row]];
        cell.delegate = self;
        cell.type = indexPath.row;
        return cell;
    }

    
    MaintainOrderCell1 *cell = [tableView dequeueReusableCellWithIdentifier:@"MaintainOrderCell1"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setModel:model];
    return cell;
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
    return 0.000000001;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        return 85;
    }
    if (indexPath.section == 2) {
        return 125;
    }
    if (indexPath.section == 3) {
        return 54;
    }
    return 138;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = APP_COLOR_GRAY_Header;
    UITapGestureRecognizer *singleTap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapAction1:)];
    [view addGestureRecognizer:singleTap1];
    
    if (section == 0) {
        UILabel *address = [UILabel createLabelWithFrame:VIEWFRAME(30, 0, 200, 44)                                                 andText:@""
                                            andTextColor:[UIColor blackColor]
                                              andBgColor:[UIColor clearColor]
                                                 andFont:SYSTEMFONT(13)
                                        andTextAlignment:NSTextAlignmentLeft];
        
        UILabel *nameLab = [UILabel createLabelWithFrame:VIEWFRAME(30, 0, 200, 44)                                                 andText:@""
                                            andTextColor:[UIColor blackColor]
                                              andBgColor:[UIColor clearColor]
                                                 andFont:SYSTEMFONT(13)
                                        andTextAlignment:NSTextAlignmentLeft];
        
        UILabel *phoneLab = [UILabel createLabelWithFrame:VIEWFRAME(30, 0, 200, 44)                                                 andText:@""
                                             andTextColor:[UIColor blackColor]
                                               andBgColor:[UIColor clearColor]
                                                  andFont:SYSTEMFONT(13)
                                         andTextAlignment:NSTextAlignmentLeft];
        
        UILabel *addressLab = [UILabel createLabelWithFrame:VIEWFRAME(30, 0, 200, 44)                                                 andText:@""
                                               andTextColor:[UIColor blackColor]
                                                 andBgColor:[UIColor clearColor]
                                                    andFont:SYSTEMFONT(13)
                                           andTextAlignment:NSTextAlignmentLeft];
        
        
        
        [view addSubview:address];
        [view addSubview:nameLab];
        [view addSubview:phoneLab];
        [view addSubview:addressLab];
        
        self.addressTitle = address;
        self.nameLab = nameLab;
        self.phoneLab = phoneLab;
        self.addressLab = addressLab;
        
        self.nameLab.text = self.name;
        self.phoneLab.text = self.mobile;
        self.addressLab.text = self.address;
        
        [address mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(view);
            make.left.equalTo(view.mas_left).offset(23.5);
            make.size.mas_equalTo(CGSizeMake(150, 14));
        }];
        
        [nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(view.mas_top).offset(11);
            make.left.equalTo(view.mas_left).offset(23.5);
            make.size.mas_equalTo(CGSizeMake(80, 15));
        }];
        
        [phoneLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(nameLab);
            make.left.equalTo(nameLab.mas_right).offset(30);
            make.size.mas_equalTo(CGSizeMake(200, 14));
        }];
        
        [addressLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(nameLab.mas_bottom).offset(11);
            make.left.equalTo(view.mas_left).offset(23.5);
            make.size.mas_equalTo(CGSizeMake(300, 14));
        }];
        
        
        
    }
    
    
    return view;
}


- (UITableView *)tableView{
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:VIEWFRAME(0, 0, SCREEN_WIDTH, SCREEN_HIGHT-64-44) style:UITableViewStyleGrouped];
        _tableView.dataSource      = self;
        _tableView.delegate        = self;
        [_tableView registerClass:[MaintainCell class] forCellReuseIdentifier:@"MaintainCell"];
        [_tableView registerClass:[MaintainOrderCell1 class] forCellReuseIdentifier:@"MaintainOrderCell1"];
        [_tableView registerClass:[OrderCell2 class] forCellReuseIdentifier:@"OrderCell2"];
        [_tableView registerClass:[PayCell class] forCellReuseIdentifier:@"PayCell"];

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
        
        UILabel *first = [UILabel createLabelWithFrame:VIEWFRAME(30, 0, 100, 44)                                                 andText:@"价格:¥ 450000"
                                          andTextColor:[UIColor blackColor]
                                            andBgColor:[UIColor clearColor]
                                               andFont:SYSTEMFONT(13)
                                      andTextAlignment:NSTextAlignmentLeft];
        
        [_footView addSubview:payBtn];
        [_footView addSubview:first];
        
        [first mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_footView.mas_left).offset(30);
            make.centerY.equalTo(_footView);
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH-CommonWidth(154) - 30, 15));
        }];
        
        first.text = [NSString stringWithFormat:@"价格:¥ %.2f",[self.MaintainModel.price floatValue] / 100];

    }
    
    return _footView;
}

-(void)btnClick:(UIButton *)sender
{
    if (self.content.length < 1) {
        [ProgressHUDHandler showHudTipStr:@"请输入留言"];
        return;
    }
    if (self.type.length < 1) {
        [ProgressHUDHandler showHudTipStr:@"请选择支付方式"];
        return;
    }
    
    [BaseRequest CreateMaintainWithMaintainid:[self.MaintainModel.maintainid integerValue] receiverid:[self.model.receiverid integerValue] price:[self.MaintainModel.price integerValue] message:self.content succesBlock:^(id data) {
//        NSLog(@"%@",describe(data));
        
        if ([self.type isEqualToString:@"upacp"]) {
            
            [BaseRequest PayWithWalletWithOrderid:[data[@"orderid"] integerValue] type:2 succesBlock:^(id data) {
                if ([data[@"code"] integerValue] == 1) {
                    [ProgressHUDHandler showHudTipStr:@"付款成功"];
                    [self PopToRootViewController];
                    
                }
            } failue:^(id data, NSError *error) {
                
            }];

        }else{
            [BaseRequest PayWithChannel:self.type orderID:[data[@"orderid"] integerValue] type:2 succesBlock:^(id data) {
                
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
        
        
 
        
        


        
    } failue:^(id data, NSError *error) {
        
    }];
}



-(void)singleTapAction1:(UITapGestureRecognizer *)tap
{
    NSDictionary *dic = @{@"type":@"1"};
    [self PushViewControllerByClassName:@"AddressManagerVC" info:dic];
}

-(void)SendTextValue:(NSString *)content {
    self.content = content;
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
