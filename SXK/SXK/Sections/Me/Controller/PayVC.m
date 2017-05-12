//
//  PayVC.m
//  SXK
//
//  Created by 杨伟康 on 2016/12/28.
//  Copyright © 2016年 ywk. All rights reserved.
//

#import "PayVC.h"
#import "PayCell.h"
#import "AppDelegate.h"
#import "BrandDetailModel.h"
@interface PayVC ()<SelectPayCellDelegate>

@property (nonatomic, strong) NSArray *payArr;

@property (nonatomic, strong) PayCell *selectCell;

@property (nonatomic, strong) NSString *type;

@property (nonatomic, strong)UIView *backGroundView;

@property (nonatomic, strong)UIView *alertView;

@end

@implementation PayVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"支付";
    
    [self initData];
    [self.view addSubview:self.tableView];
//    NSLog(@"--------%@----------",self.myDict[@"orderid"]);
}

-(void)initData
{
    
    BrandDetailModel *model = [BrandDetailModel modelFromDictionary:self.myDict[@"data"]];
    
    
    self.payArr = @[@"微信支付",@"支付宝支付",@"银联支付"];

    
    self.backGroundView  = [[UIView alloc] initWithFrame:VIEWFRAME(0, 0, SCREEN_WIDTH, SCREEN_HIGHT)];
    self.backGroundView.backgroundColor = [UIColor colorWithHexColorString:@"3c3c3c"];
    self.backGroundView.alpha = 0.5;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self.backGroundView addGestureRecognizer:tap];

    self.alertView = [[UIView alloc] initWithFrame:VIEWFRAME(30, SCREEN_HIGHT, CommonWidth(315), 430)];
    self.alertView.backgroundColor = [UIColor whiteColor];
    
    
    UIImageView *image = [[UIImageView alloc] init];
    image.image = [UIImage imageNamed:@"订单背景"];
    
    UIImageView *image1 = [[UIImageView alloc] init];
    [image1 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",APP_BASEIMG,model.imgList[0]]]];
    
    UILabel *title = [UILabel createLabelWithFrame:VIEWFRAME(30, 0, 200, 44)                                                 andText:model.name
                                        andTextColor:[UIColor blackColor]
                                          andBgColor:[UIColor clearColor]
                                             andFont:SYSTEMFONT(13)
                                    andTextAlignment:NSTextAlignmentLeft];
    
    UILabel *content = [UILabel createLabelWithFrame:VIEWFRAME(30, 0, 200, 44)                                                 andText:@""
                                        andTextColor:[UIColor blackColor]
                                          andBgColor:[UIColor clearColor]
                                             andFont:SYSTEMFONT(13)
                                    andTextAlignment:NSTextAlignmentLeft];
    
    
    UILabel *price = [UILabel createLabelWithFrame:VIEWFRAME(30, 0, 200, 44)                                                 andText:@""

                                        andTextColor:APP_COLOR_GREEN
                                          andBgColor:[UIColor clearColor]
                                             andFont:SYSTEMFONT(13)
                                    andTextAlignment:NSTextAlignmentLeft];
    
    UIButton *cancelBtn =[UIButton buttonWithType:UIButtonTypeSystem];
    [cancelBtn setTitle:@"取消订单" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor colorWithHexColorString:@"aaaaaa"] forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(cancelBtn:) forControlEvents:UIControlEventTouchUpInside];
    cancelBtn.frame = VIEWFRAME(CommonWidth(57), 360, 81, 27);
    ViewBorderRadius(cancelBtn, 27/2, 0.5, [UIColor colorWithHexColorString:@"aaaaaa"]);
    
    UIButton *certainBtn =[UIButton buttonWithType:UIButtonTypeSystem];
    [certainBtn setTitle:@"去付款" forState:UIControlStateNormal];
    [certainBtn setTitleColor:APP_COLOR_GREEN forState:UIControlStateNormal];
    [certainBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    certainBtn.frame = VIEWFRAME(CommonWidth(178), 360, 81, 27);
    ViewBorderRadius(certainBtn, 27/2, 0.5, APP_COLOR_GREEN);
    
    [self.alertView addSubview:image];
    [self.alertView addSubview:image1];
    [self.alertView addSubview:title];
    [self.alertView addSubview:content];
    [self.alertView addSubview:price];
    [self.alertView addSubview:cancelBtn];
    [self.alertView addSubview:certainBtn];
    
    [image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.alertView.mas_top).offset(0);
        make.left.equalTo(self.alertView.mas_left).offset(0);
        make.right.equalTo(self.alertView.mas_right).offset(0);
        make.bottom.equalTo(self.alertView.mas_bottom).offset(0);
    }];
    
    [image1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.alertView.mas_top).offset(15);
        make.left.equalTo(self.alertView.mas_left).offset(15);
        make.right.equalTo(self.alertView.mas_right).offset(-15);
        make.height.mas_equalTo(@(250));
    }];
    
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(image1.mas_bottom).offset(10);
        make.left.equalTo(self.alertView.mas_left).offset(15);
        make.right.equalTo(self.alertView.mas_right).offset(-15);
        make.height.mas_equalTo(@(15));
    }];
    
    [content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(title.mas_bottom).offset(10);
        make.left.equalTo(self.alertView.mas_left).offset(15);
        make.right.equalTo(self.alertView.mas_right).offset(-15);
        make.height.mas_equalTo(@(15));
    }];

    [price mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(content.mas_bottom).offset(10);
        make.left.equalTo(self.alertView.mas_left).offset(15);
        make.right.equalTo(self.alertView.mas_right).offset(-15);
        make.height.mas_equalTo(@(15));
    }];
    
    if ( [self.myDict[@"index"] isEqualToString:@"a"] ) {
        price.text = [NSString stringWithFormat:@"售价:%.2f元/天",[model.sellingPrice floatValue]/100];
        content.text = model.description1;
    }else{
        price.text = [NSString stringWithFormat:@"租价:%.2f元/天",[model.rentPrice floatValue]/100];
        content.text = model.description1;
    }

}

-(void)cancelBtn:(UIButton *)sender
{
    [self disMiss];
}

-(void)buttonAction:(UIButton *)sender
{
    [self pay];
}

#pragma mark -- UITabelViewDelegate And DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
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
    [certainBtn setTitle:@"租呗" forState:UIControlStateNormal];
    certainBtn.backgroundColor = APP_COLOR_GREEN;
    [certainBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    certainBtn.titleLabel.font = SYSTEMFONT(14);
    certainBtn.frame = VIEWFRAME(15, 20, CommonWidth(335), 40);
    [certainBtn addTarget:self action:@selector(payAction:) forControlEvents:UIControlEventTouchUpInside];
    ViewRadius(certainBtn, certainBtn.frame.size.height/2);
    
    [view addSubview:certainBtn];

    return view;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


- (UITableView *)tableView{
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:VIEWFRAME(0, 0, SCREEN_WIDTH, SCREEN_HIGHT-64) style:UITableViewStyleGrouped];
        _tableView.dataSource      = self;
        _tableView.delegate        = self;
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
    [self pay];
}

-(void)pay
{
    [BaseRequest PayWithChannel:self.type orderID:[self.myDict[@"orderid"] integerValue] type:[self.myDict[@"type"] integerValue]  succesBlock:^(id data) {
        
        //        NSLog(@"======%@====",data[@"info"]);
        _weekSelf(weakSelf);
        [Pingpp createPayment:data[@"info"] appURLScheme:@"wx4bfb2d22ce82d40d" withCompletion:^(NSString *result, PingppError *error) {
            NSLog(@"completion block: %@", result);
            if (error == nil) {
                NSLog(@"PingppError is nil");
                [ProgressHUDHandler showHudTipStr:@"付款成功"];
    
                NSDictionary *dic = @{@"type":self.myDict[@"push"]};
                [weakSelf PushViewControllerByClassName:@"OrderDetailVC" info:dic];
                [weakSelf.backGroundView removeFromSuperview];
                [weakSelf.alertView removeFromSuperview];
//                [weakSelf PopToRootViewController];
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
                
                if (error.code == 5) {
                    //                    NSLog(@"傻逼");
                    [self loadingView];
                }
            }
        }];
        
        
    } failue:^(id data, NSError *error) {
        
    }];

}

-(void)loadingView
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate.window addSubview:self.backGroundView];
    [appDelegate.window addSubview:self.alertView];
//    
//    UserModel *model = [LoginModel curLoginUser];
//    
//    self.name.text = model.nickname;
//    self.text.text = model.mobile;
    
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    
    dispatch_async(queue, ^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [UIView animateWithDuration:0.5 animations:^{
                
                self.alertView.frame = VIEWFRAME(CommonWidth(30), CommonHight(100), CommonWidth(315), 430);
                
            } completion:^(BOOL finished) {
                
            }];
        });
    });
    
}



-(void)tapAction:(UITapGestureRecognizer *)tap
{
    [self disMiss];
}
-(void)disMiss
{
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    
    dispatch_async(queue, ^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [UIView animateWithDuration:0.5 animations:^{
                
                self.alertView.frame = VIEWFRAME(30, SCREEN_HIGHT,CommonWidth(315), CommonHight(390));
                
            } completion:^(BOOL finished) {
                
                [self.backGroundView removeFromSuperview];
                [self.alertView removeFromSuperview];
                
            }];
        });
    });
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    
    
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
