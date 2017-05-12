//
//  OrderDetailVC.m
//  SXK
//
//  Created by 杨伟康 on 2017/4/20.
//  Copyright © 2017年 ywk. All rights reserved.
//

#import "OrderDetailVC.h"
#import "OrderDetailCell.h"
#import "OrderCell1.h"
#import "OrderCell2.h"
#import "BrandDetailModel.h"
#import "AddressModel.h"
#import "OrderDetailModel.h"
#import "OrderDetailCell1.h"
#import <RongIMKit/RongIMKit.h>
#import "RCConversationVC.h"
#import "MyRentModel.h"
#import "BusinessOrderCell2.h"
#import "BusinessOrderDetail3.h"
#import "MyBussinessBuyModel.h"

@interface OrderDetailVC ()<RCIMUserInfoDataSource,RCIMGroupInfoDataSource
>


@property (nonatomic, strong) UIView *footView;

@property (nonatomic, assign) NSInteger selectDay;

@property (nonatomic, strong) UILabel *total;

@property (nonatomic, strong) UILabel *deposit;

@property (nonatomic, assign) CGFloat rent;

@property (nonatomic, assign) BOOL isRisk;

@property (nonatomic, strong) OrderCell1 *cell;

@property (nonatomic, assign) NSInteger day;

@property (nonatomic, strong) AddressModel *model;

@property (nonatomic, strong) UILabel *addressTitle;

@property (nonatomic, strong) UILabel *nameLab;

@property (nonatomic, strong) UILabel *phoneLab;

@property (nonatomic, strong) UILabel *addressLab;

@property (nonatomic, strong) NSString *content;

@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) NSString *mobile;

@property (nonatomic, strong) NSString *address;

@property (nonatomic, assign) BOOL isSelect;

@property (nonatomic, strong) NSArray *dataArr;

@property (nonatomic, strong) OrderDetailModel *model1;
@end

@implementation OrderDetailVC


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSLog(@"%@",describe(self.myDict));
    
    if ([self.myDict[@"type"] isEqualToString:@"1"] || [self.myDict[@"type"] isEqualToString:@"7"] ) {
        
        [self loadingRequest];
        NSLog(@"------1");

    }else if ([self.myDict[@"type"] isEqualToString:@"rent"]) {
        NSLog(@"-------5");
        UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"返回"] style:UIBarButtonItemStylePlain target:self action:@selector(btnAction1:)];
        self.navigationItem.leftBarButtonItem = button;
         [self loadingRequest1];
        
    }else if ([self.myDict[@"type"] isEqualToString:@"business"]){
        UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"返回"] style:UIBarButtonItemStylePlain target:self action:@selector(btnAction1:)];
        self.navigationItem.leftBarButtonItem = button;

        [self loadingRequest2];        NSLog(@"------2");

    }else if([self.myDict[@"type"] isEqualToString:@"2"] || [self.myDict[@"type"] isEqualToString:@"8"]){
        NSLog(@"--------3");

        [self loadingRequest3];
    }
    
    
}

-(void)loadingRequest
{
    _weekSelf(weakSelf);
    
    [BaseRequest AppraiseOrderDetailWithOrderID:[self.myDict[@"orderid"] integerValue]succesBlock:^(id data) {
        OrderDetailModel *model = [OrderDetailModel modelFromDictionary:data[@"order"]];
        weakSelf.model1 = model;
        weakSelf.model = [AddressModel modelFromDictionary:data[@"order"][@"receiver"]];
        //        NSLog(@"%ld",[data[@"code"] integerValue]);
        weakSelf.nameLab.text = [NSString stringWithFormat:@"姓名:%@",weakSelf.model.name];
        weakSelf.phoneLab.text = [NSString stringWithFormat:@"电话:%@",weakSelf.model.mobile];
        weakSelf.addressLab.text = [NSString stringWithFormat:@"地址:%@%@%@%@",weakSelf.model.state,weakSelf.model.city,weakSelf.model.district,weakSelf.model.address];
        weakSelf.name = [NSString stringWithFormat:@"姓名:%@",weakSelf.model.name];
        weakSelf.mobile = [NSString stringWithFormat:@"电话:%@",weakSelf.model.mobile];
        weakSelf.address = [NSString stringWithFormat:@"地址:%@%@%@%@",weakSelf.model.state,weakSelf.model.city,weakSelf.model.district,weakSelf.model.address];
        weakSelf.addressTitle.text = @"";
        
        [weakSelf.tableView reloadData];
        
    } failue:^(id data, NSError *error) {
        
    }];
    

}



-(void)loadingRequest1
{
    _weekSelf(weakSelf);
    [BaseRequest GetRentorderListWithPageNo:0 PageSize:0 order:-1 status:2 succesBlock:^(id data) {
        
        NSArray *models = [MyRentModel modelsFromArray:data[@"orderList"]];
        MyRentModel *model = models[0];
        //        NSLog(@"%@",describe(models));
        
        
        [BaseRequest AppraiseOrderDetailWithOrderID:[model.orderid integerValue]succesBlock:^(id data) {
            OrderDetailModel *model = [OrderDetailModel modelFromDictionary:data[@"order"]];
            weakSelf.model1 = model;
            weakSelf.model = [AddressModel modelFromDictionary:data[@"order"][@"receiver"]];
            //        NSLog(@"%ld",[data[@"code"] integerValue]);
            weakSelf.nameLab.text = [NSString stringWithFormat:@"姓名:%@",weakSelf.model.name];
            weakSelf.phoneLab.text = [NSString stringWithFormat:@"电话:%@",weakSelf.model.mobile];
            weakSelf.addressLab.text = [NSString stringWithFormat:@"地址:%@%@%@%@",weakSelf.model.state,weakSelf.model.city,weakSelf.model.district,weakSelf.model.address];
            weakSelf.name = [NSString stringWithFormat:@"姓名:%@",weakSelf.model.name];
            weakSelf.mobile = [NSString stringWithFormat:@"电话:%@",weakSelf.model.mobile];
            weakSelf.address = [NSString stringWithFormat:@"地址:%@%@%@%@",weakSelf.model.state,weakSelf.model.city,weakSelf.model.district,weakSelf.model.address];
            weakSelf.addressTitle.text = @"";
            
            [weakSelf.tableView reloadData];
            
        } failue:^(id data, NSError *error) {
            
        }];

        
        
        
        
        
    } failue:^(id data, NSError *error) {
        
    }];
}

-(void)loadingRequest2
{
    _weekSelf(weakSelf);
    [BaseRequest GetPutchaseOrderListWithPageNo:0 PageSize:0 order:-1 status:2 succesBlock:^(id data) {
        NSArray *models = [MyBussinessBuyModel modelsFromArray:data[@"orderList"]];
        
        if (models.count > 0 ) {
            MyBussinessBuyModel *model = models[0];
            [BaseRequest BusinessOrderDetailWithOrderID:[model.orderid integerValue]  succesBlock:^(id data) {
                OrderDetailModel *model = [OrderDetailModel modelFromDictionary:data[@"order"]];
                weakSelf.model1 = model;
                weakSelf.model = [AddressModel modelFromDictionary:data[@"order"][@"receiver"]];
                //        NSLog(@"%ld",[data[@"code"] integerValue]);
                weakSelf.nameLab.text = [NSString stringWithFormat:@"姓名:%@",weakSelf.model.name];
                weakSelf.phoneLab.text = [NSString stringWithFormat:@"电话:%@",weakSelf.model.mobile];
                weakSelf.addressLab.text = [NSString stringWithFormat:@"地址:%@%@%@%@",weakSelf.model.state,weakSelf.model.city,weakSelf.model.district,weakSelf.model.address];
                weakSelf.name = [NSString stringWithFormat:@"姓名:%@",weakSelf.model.name];
                weakSelf.mobile = [NSString stringWithFormat:@"电话:%@",weakSelf.model.mobile];
                weakSelf.address = [NSString stringWithFormat:@"地址:%@%@%@%@",weakSelf.model.state,weakSelf.model.city,weakSelf.model.district,weakSelf.model.address];
                weakSelf.addressTitle.text = @"";
                
                [weakSelf.tableView reloadData];
                
            } failue:^(id data, NSError *error) {
                
            }];

        }
        
        
        
    } failue:^(id data, NSError *error) {
        
    }];
}

-(void)loadingRequest3
{
    _weekSelf(weakSelf);
    [BaseRequest BusinessOrderDetailWithOrderID:[self.myDict[@"orderid"] integerValue]  succesBlock:^(id data) {
        OrderDetailModel *model = [OrderDetailModel modelFromDictionary:data[@"order"]];
        weakSelf.model1 = model;
        weakSelf.model = [AddressModel modelFromDictionary:data[@"order"][@"receiver"]];
        //        NSLog(@"%ld",[data[@"code"] integerValue]);
        weakSelf.nameLab.text = [NSString stringWithFormat:@"姓名:%@",weakSelf.model.name];
        weakSelf.phoneLab.text = [NSString stringWithFormat:@"电话:%@",weakSelf.model.mobile];
        weakSelf.addressLab.text = [NSString stringWithFormat:@"地址:%@%@%@%@",weakSelf.model.state,weakSelf.model.city,weakSelf.model.district,weakSelf.model.address];
        weakSelf.name = [NSString stringWithFormat:@"姓名:%@",weakSelf.model.name];
        weakSelf.mobile = [NSString stringWithFormat:@"电话:%@",weakSelf.model.mobile];
        weakSelf.address = [NSString stringWithFormat:@"地址:%@%@%@%@",weakSelf.model.state,weakSelf.model.city,weakSelf.model.district,weakSelf.model.address];
        weakSelf.addressTitle.text = @"";
        
        [weakSelf.tableView reloadData];

    } failue:^(id data, NSError *error) {
        
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"订单详情";
    [self.view addSubview:self.tableView];

    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor whiteColor];
    
    UIButton *certainBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [certainBtn setTitle:@"联系对方" forState:UIControlStateNormal];
    certainBtn.backgroundColor = APP_COLOR_GREEN;
    [certainBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [certainBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    certainBtn.titleLabel.font = SYSTEMFONT(14);
    certainBtn.frame = VIEWFRAME(15, 20, CommonWidth(335), 40);
    ViewRadius(certainBtn, certainBtn.frame.size.height/2);
    
    UIView *line =[[UIView alloc] initWithFrame:VIEWFRAME(0, 0, SCREEN_WIDTH, 0.5)];
    line.backgroundColor = APP_COLOR_GRAY_Line;
    
    [view addSubview:certainBtn];
    [view addSubview:line];
    [self.view addSubview:view];
    
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.bottom.equalTo(self.view.mas_bottom).offset(0);
        make.height.mas_equalTo(80);
    }];
    

    
}

- (UITableView *)tableView{
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:VIEWFRAME(0, 0, SCREEN_WIDTH, SCREEN_HIGHT-64-44) style:UITableViewStyleGrouped];
        _tableView.dataSource      = self;
        _tableView.delegate        = self;
        [_tableView registerClass:[OrderDetailCell class] forCellReuseIdentifier:@"OrderDetailCell"];
        [_tableView registerClass:[OrderDetailCell1 class] forCellReuseIdentifier:@"OrderDetailCell1"];
        [_tableView registerClass:[BusinessOrderCell2 class] forCellReuseIdentifier:@"BusinessOrderCell2"];
        [_tableView registerClass:[BusinessOrderDetail3 class] forCellReuseIdentifier:@"BusinessOrderDetail3"];
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

#pragma mark -- UITabelViewDelegate And DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([self.myDict[@"type"] isEqualToString:@"1"] || [self.myDict[@"type"] isEqualToString:@"rent"] || [self.myDict[@"type"] isEqualToString:@"7"] ) {
        
        if (indexPath.section == 1) {
            OrderDetailCell1 *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderDetailCell1"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell setModel:self.model1];
            return cell;
        }
        
        
        OrderDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderDetailCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setModel:self.model1];
        
        return cell;

    }
    
    
    
    if (indexPath.section == 1) {
        BusinessOrderCell2 *cell = [tableView dequeueReusableCellWithIdentifier:@"BusinessOrderCell2"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setModel:self.model1];
        return cell;
    }

    
    BusinessOrderDetail3 *cell = [tableView dequeueReusableCellWithIdentifier:@"BusinessOrderDetail3"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setModel:self.model1];

    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        if ([self.myDict[@"type"] isEqualToString:@"1"] || [self.myDict[@"type"] isEqualToString:@"rent"]) {
            return 125;
        }
        return 50;
    }
//    if (indexPath.section == 2) {
//        
//        if ([self.myDict[@"type"] isEqualToString:@"1"] || [self.myDict[@"push"] isEqualToString:@"rent"]) {
//            return 125;
//        }
//
//        
//        return 50;
//    }
    return 148;
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


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = APP_COLOR_GRAY_Header;
//    UITapGestureRecognizer *singleTap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapAction1:)];
//    [view addGestureRecognizer:singleTap1];
    
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


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

-(void)btnAction:(UIButton *)sender
{
    if ([self.myDict[@"type"] isEqualToString:@"1"] || [self.myDict[@"type"] isEqualToString:@"rent"]) {
//                NSLog(@"222222222%@",describe(self.model1));
        UserModel *model =   [LoginModel curLoginUser];
        
        RCConversationVC *chat = [[RCConversationVC alloc] initWithConversationType:ConversationType_PRIVATE
                                                                           targetId:[NSString stringWithFormat:@"%@",model.userid]];
        
        [RCIM sharedRCIM].currentUserInfo = [[RCUserInfo alloc] initWithUserId:[NSString stringWithFormat:@"%@",model.userid] name:model.nickname portrait:model.headimgurl];
        
        [RCIM sharedRCIM].globalMessageAvatarStyle = RC_USER_AVATAR_CYCLE;
        
        [[RCIM sharedRCIM] setUserInfoDataSource:self];
        
        chat.conversationType = ConversationType_PRIVATE;
        
        chat.targetId = [NSString stringWithFormat:@"%ld",[self.model1.rent[@"userid"] integerValue]];
        
        chat.title = self.model1.rent[@"nickname"];
        
        [RCIM sharedRCIM].enablePersistentUserInfoCache = YES;
        [RCIM sharedRCIM].enableMessageAttachUserInfo = YES;
        
        
        RCUserInfo *user = [[RCUserInfo alloc] initWithUserId: [NSString stringWithFormat:@"%ld",[self.model1.rent[@"userid"] integerValue]]name:self.model1.rent[@"nickname"] portrait:self.model1.rent[@"headimgurl"]];
        [[RCIM sharedRCIM] refreshUserInfoCache:user withUserId:[NSString stringWithFormat:@"%ld",[self.model1.rent[@"userid"] integerValue]]];
        
        
        [self.navigationController pushViewController:chat animated:YES];

        }else if ([self.myDict[@"type"] isEqualToString:@"7"] ){
        NSLog(@"00000000%@",self.model1.nickname);
        UserModel *model =   [LoginModel curLoginUser];
        
        RCConversationVC *chat = [[RCConversationVC alloc] initWithConversationType:ConversationType_PRIVATE
                                                                           targetId:[NSString stringWithFormat:@"%@",model.userid]];
        [RCIM sharedRCIM].currentUserInfo = [[RCUserInfo alloc] initWithUserId:[NSString stringWithFormat:@"%@",model.userid] name:model.nickname portrait:model.headimgurl];
        
        [RCIM sharedRCIM].globalMessageAvatarStyle = RC_USER_AVATAR_CYCLE;
        
        [[RCIM sharedRCIM] setUserInfoDataSource:self];
        
        chat.conversationType = ConversationType_PRIVATE;
        
        chat.targetId = [NSString stringWithFormat:@"%ld",[self.model1.userid integerValue]];
        
        chat.title = self.model1.nickname;
        
        [RCIM sharedRCIM].enablePersistentUserInfoCache = YES;
        [RCIM sharedRCIM].enableMessageAttachUserInfo = YES;
        
        
        RCUserInfo *user = [[RCUserInfo alloc] initWithUserId: [NSString stringWithFormat:@"%ld",[self.model1.userid integerValue]]name:self.model1.nickname portrait:self.model1.headimgurl];
        [[RCIM sharedRCIM] refreshUserInfoCache:user withUserId:[NSString stringWithFormat:@"%ld",[self.model1.userid integerValue]]];
        
        
        [self.navigationController pushViewController:chat animated:YES];
            
        }else if ([self.myDict[@"type"] isEqualToString:@"8"]){
            
            UserModel *model =   [LoginModel curLoginUser];
            
            RCConversationVC *chat = [[RCConversationVC alloc] initWithConversationType:ConversationType_PRIVATE
                                                                               targetId:[NSString stringWithFormat:@"%@",model.userid]];
            [RCIM sharedRCIM].currentUserInfo = [[RCUserInfo alloc] initWithUserId:[NSString stringWithFormat:@"%@",model.userid] name:model.nickname portrait:model.headimgurl];
            
            [RCIM sharedRCIM].globalMessageAvatarStyle = RC_USER_AVATAR_CYCLE;
            
            [[RCIM sharedRCIM] setUserInfoDataSource:self];
            
            chat.conversationType = ConversationType_PRIVATE;
            
            chat.targetId = [NSString stringWithFormat:@"%ld",[self.model1.userid integerValue]];
            
            chat.title = self.model1.nickname;
            
            [RCIM sharedRCIM].enablePersistentUserInfoCache = YES;
            [RCIM sharedRCIM].enableMessageAttachUserInfo = YES;
            
            
            RCUserInfo *user = [[RCUserInfo alloc] initWithUserId: [NSString stringWithFormat:@"%ld",[self.model1.userid integerValue]]name:self.model1.nickname portrait:self.model1.headimgurl];
            [[RCIM sharedRCIM] refreshUserInfoCache:user withUserId:[NSString stringWithFormat:@"%ld",[self.model1.userid integerValue]]];
            
            
            [self.navigationController pushViewController:chat animated:YES];
            
        }
        else
        {
//                NSLog(@"2222222222%@",self.model1.headimgurl);
        UserModel *model =   [LoginModel curLoginUser];
        
        RCConversationVC *chat = [[RCConversationVC alloc] initWithConversationType:ConversationType_PRIVATE
                                                                           targetId:[NSString stringWithFormat:@"%@",model.userid]];
        [RCIM sharedRCIM].currentUserInfo = [[RCUserInfo alloc] initWithUserId:[NSString stringWithFormat:@"%@",model.userid] name:model.nickname portrait:model.headimgurl];
        
        [RCIM sharedRCIM].globalMessageAvatarStyle = RC_USER_AVATAR_CYCLE;
        
        [[RCIM sharedRCIM] setUserInfoDataSource:self];
        
        chat.conversationType = ConversationType_PRIVATE;
        
        chat.targetId = [NSString stringWithFormat:@"%ld",[self.model1.purchase[@"userid"] integerValue]];
        
        chat.title = self.model1.purchase[@"nickname"] ;
        
        [RCIM sharedRCIM].enablePersistentUserInfoCache = YES;
        [RCIM sharedRCIM].enableMessageAttachUserInfo = YES;
        
        
        RCUserInfo *user = [[RCUserInfo alloc] initWithUserId: [NSString stringWithFormat:@"%ld",[self.model1.purchase[@"userid"] integerValue]]name:self.model1.purchase[@"nickname"]  portrait:self.model1.purchase[@"headimgurl"]];
        [[RCIM sharedRCIM] refreshUserInfoCache:user withUserId:[NSString stringWithFormat:@"%ld",[self.model1.purchase[@"userid"] integerValue]]];
        
        
        [self.navigationController pushViewController:chat animated:YES];

    }

    
    
    
    
    

}

- (void)getUserInfoWithUserId:(NSString *)userId
                   completion:(void (^)(RCUserInfo *userInfo))completion
{
    UserModel *model =   [LoginModel curLoginUser];
    
    if ([userId isEqualToString:[NSString stringWithFormat:@"%@",model.userid]]) {
        return completion([[RCUserInfo alloc] initWithUserId:[NSString stringWithFormat:@"%@",model.userid] name:model.nickname portrait:model.headimgurl]);
    }else
    {
        //        根据存储联系人信息的模型，通过 userId 来取得对应的name和头像url，进行以下设置（此处因为项目接口尚未实现，所以就只能这样给大家说说，请见谅）
        return completion([[RCUserInfo alloc] initWithUserId:[NSString stringWithFormat:@"%ld",[self.model1.rent[@"userid"] integerValue]] name:self.model1.rent[@"nickname"]  portrait:self.model1.rent[@"headimgurl"]]);
    }
}

-(void)btnAction1:(UIButton *)sender
{
    [self PopToRootViewController];
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
