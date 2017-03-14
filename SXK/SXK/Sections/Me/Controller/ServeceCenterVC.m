//
//  ServeceCenterVC.m
//  SXK
//
//  Created by 杨伟康 on 2017/1/19.
//  Copyright © 2017年 ywk. All rights reserved.
//

#import "ServeceCenterVC.h"
#import "ServeveCenterCell.h"
#import "QuestionListModel.h"
#import "MQChatViewManager.h"
#import "MQChatDeviceUtil.h"
#import <MeiQiaSDK/MeiQiaSDK.h>
#import "NSArray+MQFunctional.h"
#import "MQBundleUtil.h"
#import "MQAssetUtil.h"
#import "MQImageUtil.h"
#import "MQToast.h"

@interface ServeceCenterVC ()

@property (nonatomic, assign)NSInteger index;

@property (nonatomic, strong)UIView *master;

@property (nonatomic, strong)UIView *guest;

@property (nonatomic, strong)UIView *headView;

@property (nonatomic, strong)UIView *headView1;

@property (nonatomic, strong)NSArray *dataArr;

@property (nonatomic, strong)UITableView *tableView1;

@property (nonatomic, strong)UITableView *tableView2;

@property (nonatomic, strong)NSArray *urlArr;

@property (nonatomic, strong)NSArray *titleArr;

@property (nonatomic, assign)NSInteger type;

@end

@implementation ServeceCenterVC

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadingRequest];
}

-(void)loadingRequest
{
    _weekSelf(weakSelf);
    [BaseRequest GetQuestionListWithPageNo:0 PageSize:0 order:-1 succesBlock:^(id data) {
        NSArray *models = [QuestionListModel modelsFromArray:data[@"questionList"]];
//        NSLog(@"-------%@",describe(models));
        [weakSelf handleModels:models total:[data[@"total"] integerValue]];
    } failue:^(id data, NSError *error) {
        
    }];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"服务中心";
    self.urlArr = @[@"/app/processsetup/getpost",@"/app/profitsetup/getpost",@"/app/guaranteesetup/getpost",@"/app/damagesetup/getpost",@"/app/chargesetup/getpost",@"/app/longtermsetup/getpost"];
    self.titleArr = @[@"租用流程",@"租赁费用",@"注册审核",@"破损处理",@"APP指导",@"平台保障"];

    [self initUI];
}

-(void)initUI
{
    
    
    for (int i = 0; i < self.ViewArr.count; i++) {
        if (i == 0) {
            self.master = self.ViewArr[i];
        }else{
            self.guest = self.ViewArr[i];
        }
        UITableView *tableView = [[UITableView alloc]initWithFrame:self.master.frame style:UITableViewStyleGrouped];
        tableView.dataSource      = self;
        tableView.delegate        = self;
        tableView.showsVerticalScrollIndicator = NO;
        [tableView registerClass:[ServeveCenterCell class] forCellReuseIdentifier:@"ServeceCenter"];
        tableView.backgroundColor = [UIColor whiteColor];
        tableView.tableFooterView = [[UIView alloc] init];
        tableView.separatorStyle  = UITableViewCellSeparatorStyleSingleLine;
        tableView.sectionHeaderHeight = 0.0;
        tableView.sectionFooterHeight = 0.0;
        
        if (i == 0) {
            tableView.tableHeaderView = self.headView;
            [self.master addSubview:tableView];
            self.tableView = tableView;
            self.tableView1 = tableView;
        }else{
            tableView.tableHeaderView = self.headView1;
            [self.guest addSubview:tableView];
            self.tableView2 = tableView;
        }
        
    }
    
    
}

#pragma mark -- UITabelViewDelegate And DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.listData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ServeveCenterCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ServeceCenter"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setModel:self.listData[indexPath.row]];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 52;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView == self.tableView2) {
        return 0;
    }
    return 40;
}


-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 40;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = APP_COLOR_GRAY_Header;
    
    if (tableView == self.tableView1) {
        UILabel *title = [UILabel createLabelWithFrame:VIEWFRAME((SCREEN_WIDTH -  CommonWidth(148)*2)/3, 0, 150, 40)                                                 andText:@"常见问题"
                                          andTextColor:[UIColor blackColor]
                                            andBgColor:[UIColor clearColor]
                                               andFont:SYSTEMFONT(14)
                                      andTextAlignment:NSTextAlignmentLeft];
        
        [view addSubview:title];

    }
    return view;

}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor whiteColor];
    
    UIButton *certainBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [certainBtn setTitle:@"联系客服" forState:UIControlStateNormal];
    certainBtn.backgroundColor = APP_COLOR_GREEN;
    [certainBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    certainBtn.titleLabel.font = SYSTEMFONT(14);
    certainBtn.frame = VIEWFRAME(15, 20, CommonWidth(335), 40);
    [certainBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    ViewRadius(certainBtn, certainBtn.frame.size.height/2);
    
    [view addSubview:certainBtn];
    return view;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    QuestionListModel *model = self.listData[indexPath.row];
    NSDictionary *dic = @{@"title":model.name,@"content":model.content,@"type":@"1"};
    [self PushViewControllerByClassName:@"ServiceCenter1" info:dic];
    

}

-(void)setAnimationWithOrigin:(CGFloat)x{
    [super setAnimationWithOrigin:x];
    self.type = x/SCREEN_WIDTH;
}


- (UIView *)headView{
    if (!_headView) {
        _headView = [[UIView alloc] initWithFrame:VIEWFRAME(0, 0, SCREEN_WIDTH, CommonHight(78)*3+18/667.000000*SCREEN_HIGHT)];
        _headView.backgroundColor = [UIColor whiteColor];
        NSArray *contentArr = @[@"这是个小标题1",@"这是个小标题2",@"这是个小标题3",@"这是个小标题4",@"这是个小标题5",@"这是个小标题6"];
        int k = 0;
        for (int i = 0 ; i < 3; i++) {
            for (int j = 0; j < 2; j++) {
                UIView *view = [[UIView alloc] initWithFrame:VIEWFRAME((SCREEN_WIDTH -  CommonWidth(148)*2)/3 + (CommonWidth(148)+(SCREEN_WIDTH -  CommonWidth(148)*2)/3)*j, 18 + i * CommonHight(78), CommonWidth(148), CommonHight(60))];
                view.backgroundColor =[UIColor whiteColor];
                ViewBorderRadius(view, 8, 0.5, APP_COLOR_GRAY_Line);
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
                [view addGestureRecognizer:tap];
                view.tag = k+1;
                UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"服务中心-%d",k+1]]];
                
                UILabel *title = [UILabel createLabelWithFrame:VIEWFRAME(15, 0, 150, 53)                                                 andText:self.titleArr[k]
                                          andTextColor:[UIColor blackColor]
                                            andBgColor:[UIColor clearColor]
                                               andFont:SYSTEMFONT(11)
                                      andTextAlignment:NSTextAlignmentLeft];
                UILabel *content = [UILabel createLabelWithFrame:VIEWFRAME(15, 0, 150, 53)                                                 andText:contentArr[k]
                                                  andTextColor:[UIColor blackColor]
                                                    andBgColor:[UIColor clearColor]
                                                       andFont:SYSTEMFONT(11)
                                              andTextAlignment:NSTextAlignmentLeft];

                
                [view addSubview:image];
                [view addSubview:title];
                [view addSubview:content];
                
                [_headView addSubview:view];
                k++;
                
                [image mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.size.mas_equalTo(CGSizeMake(CommonWidth(36), CommonWidth(36)));
                    make.centerY.equalTo(view);
                    make.left.equalTo(view.mas_left).offset(10);
                }];
                
                [title mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(image.mas_right).offset(5);
                    make.centerY.equalTo(view).offset(-6.5);
                    make.right.equalTo(view.mas_right).offset(0);
                    make.height.mas_equalTo(12);
                }];
                
                [content mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(image.mas_right).offset(5);
                    make.centerY.equalTo(view).offset(6.5);
                    make.right.equalTo(view.mas_right).offset(0);
                    make.height.mas_equalTo(12);
                }];

            }
            
        }
        
    }
    return _headView;
}

- (UIView *)headView1{
    if (!_headView1) {
        _headView1 = [[UIView alloc] initWithFrame:VIEWFRAME(0, 0, SCREEN_WIDTH, CommonHight(78)*3+18/667.000000*SCREEN_HIGHT)];
        _headView1.backgroundColor = [UIColor whiteColor];
        NSArray *titleArr = @[@"租用流程",@"出租收益",@"平台保障",@"破损处理",@"平台服务费",@"长租"];
        NSArray *contentArr = @[@"这是个小标题1",@"这是个小标题2",@"这是个小标题3",@"这是个小标题4",@"这是个小标题5",@"这是个小标题6"];
        int k = 0;
        for (int i = 0 ; i < 3; i++) {
            for (int j = 0; j < 2; j++) {
                UIView *view = [[UIView alloc] initWithFrame:VIEWFRAME((SCREEN_WIDTH -  CommonWidth(148)*2)/3 + (CommonWidth(148)+(SCREEN_WIDTH -  CommonWidth(148)*2)/3)*j, 18 + i * CommonHight(78), CommonWidth(148), CommonHight(60))];
                view.backgroundColor =[UIColor whiteColor];
                ViewBorderRadius(view, 8, 0.5, APP_COLOR_GRAY_Line);
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
                [view addGestureRecognizer:tap];
                view.tag = k+1;

                UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"服务中心-%d",k+1]]];
                
                UILabel *title = [UILabel createLabelWithFrame:VIEWFRAME(15, 0, 150, 53)                                                 andText:titleArr[k]
                                                  andTextColor:[UIColor blackColor]
                                                    andBgColor:[UIColor clearColor]
                                                       andFont:SYSTEMFONT(11)
                                              andTextAlignment:NSTextAlignmentLeft];
                
                UILabel *content = [UILabel createLabelWithFrame:VIEWFRAME(15, 0, 150, 53)                                                 andText:contentArr[k]
                                                    andTextColor:[UIColor blackColor]
                                                      andBgColor:[UIColor clearColor]
                                                         andFont:SYSTEMFONT(11)
                                                andTextAlignment:NSTextAlignmentLeft];
                
                
                [view addSubview:image];
                [view addSubview:title];
                [view addSubview:content];
                
                [_headView1 addSubview:view];
                k++;
                
                [image mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.size.mas_equalTo(CGSizeMake(CommonWidth(36), CommonWidth(36)));
                    make.centerY.equalTo(view);
                    make.left.equalTo(view.mas_left).offset(10);
                }];
                
                [title mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(image.mas_right).offset(5);
                    make.centerY.equalTo(view).offset(-6.5);
                    make.right.equalTo(view.mas_right).offset(0);
                    make.height.mas_equalTo(12);
                }];
                
                [content mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(image.mas_right).offset(5);
                    make.centerY.equalTo(view).offset(6.5);
                    make.right.equalTo(view.mas_right).offset(0);
                    make.height.mas_equalTo(12);
                }];
                
                
                
            }
            
        }
        
    }
    
    return _headView1;
}

-(void)buttonClick:(UIButton *)sender
{
    MQChatViewManager *chatViewManager = [[MQChatViewManager alloc] init];
    [chatViewManager.chatViewStyle setEnableRoundAvatar:YES];
    [chatViewManager setClientInfo:@{@"name":@"updated",@"avatar":@"http://pic1a.nipic.com/2008-10-27/2008102715429376_2.jpg"} override:YES];
    [chatViewManager pushMQChatViewControllerInViewController:self];

    
}

-(void)tapAction:(UITapGestureRecognizer *)tap
{
    
    if (self.type == 1) {
        
        NSInteger tag = tap.view.tag;
        NSDictionary *dic = @{@"title":self.titleArr[tag-1],@"url":self.urlArr[tag-1],@"type":@"2"};
        [self PushViewControllerByClassName:@"ServiceCenter1" info:dic];
        
    }else{
        
        
        
        
        NSArray *array = @[@"租用流程",@"租赁费用",@"注册审核",@"破损处理",@"APP指导",@"平台保障"];
        NSArray *url = @[@"/app/processsetup/getpost",@"/app/costsetup/getpost",@"/app/guaranteesetup/getpost",@"/app/damagesetup/getpost",@"/app/guidesetup/getpost",@"/app/guaranteesetup/getpost"];
        NSInteger tag = tap.view.tag;
        
        if ((tag - 1) == 2) {
            
            [self PushViewControllerByClassName:@"RegisteExamineVC" info:nil];
            
        }else{
            NSDictionary *dic = @{@"title":array[tag-1],@"url":url[tag-1],@"type":@"2"};
            [self PushViewControllerByClassName:@"ServiceCenter1" info:dic];

        }

        
        
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
