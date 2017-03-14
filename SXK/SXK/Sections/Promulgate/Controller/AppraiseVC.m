//
//  AppraiseVC.m
//  SXK
//
//  Created by 杨伟康 on 2016/11/29.
//  Copyright © 2016年 ywk. All rights reserved.
//

#import "AppraiseVC.h"
#import "TypeCell.h"
#import "ConsigneeCell.h"
#import "PayCell.h"
#import "AppraiseClassModel.h"
#import "AppraiseClassVC.h"
#import "BrandVC.h"
#import "AddressModel.h"
@interface AppraiseVC ()<SelectPayCellDelegate,AppraiseClassVCDelegate,BrandVCDelegate>

@property (strong, nonatomic) UIView   *headView;
@property (nonatomic, strong) NSArray *firstArr;
@property (nonatomic, strong) NSArray *payArr;
@property (nonatomic, strong) UIView *footView;
@property (nonatomic, strong) UIImageView *headImage;
@property (nonatomic, strong) PayCell *selectCell;
@property (nonatomic, strong) NSString *helpImage;
@property (nonatomic, strong) NSArray *dataArr;
@property (nonatomic, strong) NSMutableDictionary *cellDic;
@property (nonatomic, strong) UILabel *priceLab;

@property (nonatomic, assign) NSInteger brandid;
@property (nonatomic, assign) NSInteger genreid;
@property (nonatomic, assign) NSInteger receiverid;

@property (nonatomic, assign) NSInteger total;

@property (nonatomic, strong) AddressModel *model;
@property (nonatomic, strong) NSString *str;
@property (nonatomic, strong) NSString *type;


@end

@implementation AppraiseVC


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setRightBarButtonWith:[UIImage imageNamed:@"感叹号"] selector:@selector(barButtonAction)];
    self.navigationItem.title = @"中检鉴定";
    [self initData];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.footView];
    

}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    _weekSelf(weakSelf);
    [BaseRequest AppraiseWithSetupID:1 succesBlock:^(id data) {
        NSDictionary *dic = data[@"setup"];
        [weakSelf.headImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",APP_BASEIMG,dic[@"campaign"]]]];
        NSArray *models = [AppraiseClassModel modelsFromArray:data[@"genreList"]];
        weakSelf.helpImage = dic[@"help"];
        weakSelf.dataArr = models;
        //        NSLog(@"%@",describe(models));
        
        
        [BaseRequest GetAddressWithReceiverid:0 succesBlock:^(id data) {
            weakSelf.model = [AddressModel modelFromDictionary:data[@"receiver"]];
            weakSelf.str = @"";
            weakSelf.receiverid = [data[@"receiver"][@"receiverid"] integerValue];
            [weakSelf.tableView reloadData];
        } failue:^(id data, NSError *error) {
            
            weakSelf.str = data[@"message"];
            [weakSelf.tableView reloadData];
        }];
        
        
    } failue:^(id data, NSError *error) {
        
    }];

}

-(void)initData
{
    self.cellDic = [[NSMutableDictionary alloc] init];
    self.firstArr = @[@"类别",@"品牌"];
    self.payArr = @[@"微信支付",@"支付宝支付",@"银联支付"];
}

-(void)barButtonAction
{
    NSDictionary *dic =@{@"image":self.helpImage};
    [self PushViewControllerByClassName:@"HowToShootVC" info:dic];
}

#pragma mark -- UITabelViewDelegate And DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if (section == 1) {
        return 1;
    }
    if (section == 2) {
        return 3;
    }

    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    NSString *CellIdentifier = [NSString stringWithFormat:@"cell%ld%ld",indexPath.section,indexPath.row];//不使用复用

    if (indexPath.section == 1) {
        ConsigneeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ConsigneeCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (self.str.length > 0) {
            [cell fillWithTitle:self.str];
        }else{
            [cell fillWithModel:self.model str:self.str];
        }
        return cell;
    }
    if (indexPath.section == 2) {
        PayCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PayCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell fillWithTitle:self.payArr[indexPath.row]];
        cell.delegate = self;
        cell.type = indexPath.row;
        return cell;
    }
    
    TypeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TypeCell"];
    [cell fillWithTitle:self.firstArr[indexPath.row] andType:0];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSString *title = self.firstArr[indexPath.row];
    [self.cellDic setObject:cell forKey:title];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        return 64;
    }
    return 54;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 15;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor colorWithHexColorString:@"f7f7f7"];
    
    return view;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0 && indexPath.section == 0) {
        AppraiseClassVC *vc = [[AppraiseClassVC alloc] init];
        vc.dataArr = self.dataArr;
        vc.delegate = self;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    if (indexPath.row == 1 && indexPath.section == 0) {
        BrandVC *vc = [[BrandVC alloc] init];
        vc.delegate = self;
        vc.type =1;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    if (indexPath.section == 1) {
        
        [self PushViewControllerByClassName:@"AddressManagerVC" info:nil];
    }
    
    
    
}

#pragma mark -- getters and setters

- (UITableView *)tableView{
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:VIEWFRAME(0, 0, SCREEN_WIDTH, SCREEN_HIGHT-64-40) style:UITableViewStyleGrouped];
        _tableView.dataSource      = self;
        _tableView.delegate        = self;
        [_tableView registerClass:[TypeCell class] forCellReuseIdentifier:@"TypeCell"];
        [_tableView registerClass:[ConsigneeCell class] forCellReuseIdentifier:@"ConsigneeCell"];
        [_tableView registerClass:[PayCell class] forCellReuseIdentifier:@"PayCell"];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.backgroundColor = [UIColor colorWithHexColorString:@"f7f7f7"];
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.tableHeaderView = self.headView;
        _tableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
        _tableView.sectionHeaderHeight = 0.0;
        _tableView.sectionFooterHeight = 0.0;
        
    }
    return _tableView;
}

- (UIView *)headView{
    if (!_headView) {
        _headView = [[UIView alloc] initWithFrame:VIEWFRAME(0, 0, SCREEN_WIDTH, (200.0000/667*SCREEN_HIGHT))];
        _headView.backgroundColor = [UIColor whiteColor];
        
        UIImageView * headImage = [[UIImageView alloc] initWithFrame:VIEWFRAME(0, 0, SCREEN_WIDTH, CommonHight(210))];
        headImage.image = [UIImage imageNamed:@""];
        self.headImage = headImage;
        [_headView addSubview:headImage];
        
    }
    
    return _headView;
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
        [payBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel *totle = [UILabel createLabelWithFrame:VIEWFRAME(30, 0, 100, 44)                                                 andText:@"合计:¥ 0"
                                  andTextColor:[UIColor blackColor]
                                    andBgColor:[UIColor clearColor]
                                       andFont:SYSTEMFONT(15)
                              andTextAlignment:NSTextAlignmentLeft];
        
        self.priceLab = totle;
        [_footView addSubview:payBtn];
        [_footView addSubview:totle];
    }
    
    return _footView;
}


-(void)sendValue:(id)cell andType:(NSInteger)type;
{
    if (self.selectCell) {
        [self.selectCell isSelect];
        [(PayCell *)cell isSelect];
        self.selectCell = (PayCell *)cell;
    }else{
        [(PayCell *)cell isSelect];
        self.selectCell = (PayCell *)cell;
    }
    
    switch (type) {
        case 0:{
            self.type = @"wx";
        }
            break;
        case 1:{
            self.type = @"alipay";
        }
            break;

        case 2:{
            self.type = @"upacp";
        }
            break;
        
            
        default:
            break;
    }
    
    
//    NSLog(@"%ld",type);
}

-(void)returndata:(NSDictionary *)dic
{
    TypeCell *cell = [(TypeCell *)self.cellDic valueForKey:@"类别"];
    [cell changeTitle1:dic[@"name"]];
    self.priceLab.text = [NSString stringWithFormat:@"合计:¥ %.2f",[dic[@"price"] floatValue] / 100 ];
    self.total = [dic[@"price"] integerValue];
//    NSLog(@"这是中鉴1%@",describe(dic));
    self.genreid = [dic[@"genreid"] integerValue];
}

-(void)returnBrand:(NSDictionary *)dic
{
    TypeCell *cell = [(TypeCell *)self.cellDic valueForKey:@"品牌"];
    [cell changeTitle1:dic[@"name"]];
    self.brandid = [dic[@"brandid"] integerValue];

//    NSLog(@"这是中鉴2%@",describe(dic));
}


-(void)buttonClick:(UIButton *)sender
{
    [BaseRequest CreateAppraiseOrderWithReceiverid:self.receiverid brandid:self.brandid genreid:self.genreid total:self.total succesBlock:^(id data) {
        
        [BaseRequest PayWithChannel:self.type orderID:[data[@"orderid"] integerValue] type:3 succesBlock:^(id data) {
            
            //        NSLog(@"======%@====",data[@"info"]);
            _weekSelf(weakSelf);
            [Pingpp createPayment:data[@"info"] appURLScheme:@"wx4bfb2d22ce82d40d" withCompletion:^(NSString *result, PingppError *error) {
                NSLog(@"completion block: %@", result);
                if (error == nil) {
                    NSLog(@"PingppError is nil");
                    [ProgressHUDHandler showHudTipStr:@"付款成功"];
                    [weakSelf popGoBack];
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
