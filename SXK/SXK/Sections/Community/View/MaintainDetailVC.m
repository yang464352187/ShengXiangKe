//
//  MaintainDetailVC.m
//  SXK
//
//  Created by 杨伟康 on 2016/12/22.
//  Copyright © 2016年 ywk. All rights reserved.
//

#import "MaintainDetailVC.h"
#import "MaintainCellModel.h"
#import "MaintainCell.h"
#import "ProductDetailCell.h"
#import "TradeCell.h"
//#import <RongIMKit/RongIMKit.h>
//#import "RCConversationVC.h"
#import "MQChatViewManager.h"
#import "MQChatDeviceUtil.h"
#import <MeiQiaSDK/MeiQiaSDK.h>
#import "NSArray+MQFunctional.h"
#import "MQBundleUtil.h"
#import "MQAssetUtil.h"
#import "MQImageUtil.h"
#import "MQToast.h"

@interface MaintainDetailVC ()<ProductDetailCellDelegate>


@property(nonatomic, strong)NSMutableArray *dataArr;

@property(nonatomic, assign)CGFloat cellHeight;

@property(nonatomic, strong)MaintainCellModel *model;
@end

@implementation MaintainDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"养护";
    self.dataArr = [[NSMutableArray alloc] init];
    _weekSelf(weakSelf);
    [BaseRequest GetMaintainWithMaintainid:[self.myDict[@"maintainid"] integerValue] succesBlock:^(id data) {
        
        MaintainCellModel *model = [MaintainCellModel modelFromDictionary:data[@"maintain"]];
        weakSelf.model = model;
        [self.dataArr addObject:model];
//        NSLog(@"%@",describe(model));
        [weakSelf.tableView reloadData];
    } failue:^(id data, NSError *error) {
        
    }];
    
    [self.view addSubview:self.tableView];
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor whiteColor];
    UIButton *certainBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [certainBtn setTitle:@"立即购买" forState:UIControlStateNormal];
    certainBtn.backgroundColor = APP_COLOR_GREEN;
    [certainBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    certainBtn.titleLabel.font = SYSTEMFONT(14);
    certainBtn.frame = VIEWFRAME(15, 20, CommonWidth(335), 40);
    [certainBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    ViewRadius(certainBtn, certainBtn.frame.size.height/2);
    
    [view addSubview:certainBtn];
    [self.view addSubview:view];
    
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.bottom.equalTo(self.view.mas_bottom).offset(0);
        make.height.mas_equalTo(80);
    }];

}

#pragma mark -- UITabelViewDelegate And DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if (self.dataArr.count > 0) {
        
        return self.dataArr.count+3;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MaintainCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MaintainCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    MaintainCellModel *model = self.dataArr[0];
    [cell setModel:model];
    
    if (indexPath.section == 1) {
        ProductDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProductDetailCell"];
        cell.delegate = self;
        cell.backgroundColor = [UIColor greenColor];
        [cell setModel:self.dataArr[0]];
        return cell;
    }
    
    if (indexPath.section == 3) {
        TradeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TradeCell"];
        return cell;
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        NSLog(@"cellHeight %lf",self.cellHeight);
        return self.cellHeight;
    }
    if (indexPath.section == 3) {
        if (SCREEN_WIDTH < 375) {
            return 350;
        }
        
        return 440;
    }
    return 138;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 66;
    }
    return 50;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{

    UIView *view;
    
    switch (section) {
        case 0:{
            view = [self loadHeadView];
            break;
        }
        case 1:{
            view = [self sectionViewWithTitle:@"商品细节" andContent:@"Product details"];
            break;
        }
        case 2:{
            view = [self sectionViewWithTitle:@"评论" andContent:@"Comments"];
            break;
        }
        case 3:{
            view = [self sectionViewWithTitle:@"交易流程" andContent:@"production infomation"];
            break;
        }
        default:
            break;
    }
    
    
    
    return view;
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
//    MaintainCellModel *model = self.listData[indexPath.row];
//    NSDictionary *dic = @{@"maintainid":model.maintainid};
//    [self PushViewControllerByClassName:@"MaintainDetailVC" info:dic];
}




#pragma mark -- getters and setters

- (UITableView *)tableView{
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:VIEWFRAME(0, 0, SCREEN_WIDTH, SCREEN_HIGHT-64-80) style:UITableViewStyleGrouped];
        _tableView.dataSource      = self;
        _tableView.delegate        = self;
        [_tableView registerClass:[MaintainCell class] forCellReuseIdentifier:@"MaintainCell"];
        [_tableView registerClass:[ProductDetailCell class] forCellReuseIdentifier:@"ProductDetailCell"];
        [_tableView registerClass:[TradeCell class] forCellReuseIdentifier:@"TradeCell"];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.backgroundColor = APP_COLOR_BASE_BACKGROUND;
        _tableView.tableFooterView = [[UIView alloc] init];
        //        _tableView.tableHeaderView = self.headView;
        _tableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
        _tableView.sectionHeaderHeight = 0.0;
        _tableView.sectionFooterHeight = 0.0;
        
    }
    return _tableView;
}

-(UIView *)loadHeadView
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 66)];
    view.backgroundColor = APP_COLOR_GRAY_Header;
    
    UIImageView *image = [[UIImageView alloc] init];
    image.image = [UIImage imageNamed:@"touxiangk"];
    
    UILabel *title = [UILabel createLabelWithFrame:VIEWFRAME(15, 0, 150, 53)                                                 andText:@"啵呗养护管家"
                                      andTextColor:[UIColor blackColor]
                                        andBgColor:[UIColor clearColor]
                                           andFont:SYSTEMFONT(13)
                                  andTextAlignment:NSTextAlignmentLeft];
    
    
    UIImage *talkImage = [UIImage imageNamed:@"对话"];
    UIButton *talkBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [talkBtn setTitle:@"聊呗" forState:UIControlStateNormal];
    [talkBtn addTarget:self action:@selector(talkBtn:) forControlEvents:UIControlEventTouchUpInside];
    [talkBtn setImage:[talkImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    talkBtn.frame = VIEWFRAME(SCREEN_WIDTH - 130, 11, 60, 15);
    talkBtn.titleLabel.font = SYSTEMFONT(12);
    talkBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 8, 0, 0);
    //    [talkBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [talkBtn setTintColor:[UIColor blackColor]];
    
    UIImage *likeImage = [UIImage imageNamed:@"嘴型@2x"];
    UIButton *likeBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [likeBtn setTitle:@"啵一个" forState:UIControlStateNormal];
    [likeBtn setImage:[likeImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    likeBtn.frame = VIEWFRAME(SCREEN_WIDTH - 130, 11, 50, 15);
    likeBtn.titleLabel.font = SYSTEMFONT(12);
    likeBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 8, 0, 0);
    [likeBtn addTarget:self action:@selector(likeAction:) forControlEvents:UIControlEventTouchUpInside];
    //    [talkBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [likeBtn setTintColor:[UIColor blackColor]];
    
    [view addSubview:image];
    [view addSubview:title];
    [view addSubview:talkBtn];
    [view addSubview:likeBtn];
    
    [image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(view);
        make.left.equalTo(view.mas_left).offset(20);
        make.size.mas_equalTo(CGSizeMake(37, 37));
    }];
    
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(view);
        make.left.equalTo(image.mas_right).offset(10);
        make.size.mas_equalTo(CGSizeMake(100, 66));
    }];
    
    [talkBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(view);
        make.right.equalTo(view.mas_right).offset(-15);
        make.size.mas_equalTo(CGSizeMake(60, 25));
    }];
    
    [likeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(view);
        make.right.equalTo(talkBtn.mas_left).offset(0);
        make.size.mas_equalTo(CGSizeMake(70, 25));
    }];

    return view;
}

-(UIView *)sectionViewWithTitle:(NSString *)title andContent:(NSString *)content
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 66)];
    view.backgroundColor =  [UIColor whiteColor];
    UILabel *title2 = [UILabel createLabelWithFrame:CommonVIEWFRAME(18, 13.5, 50, 12)
                                            andText:title
                                       andTextColor:[UIColor blackColor]
                                         andBgColor:[UIColor clearColor]
                                            andFont:SYSTEMFONT(13)
                                   andTextAlignment:NSTextAlignmentLeft];
    title2.adjustsFontSizeToFitWidth =YES;
    
    UIView * line =[[UIView alloc] initWithFrame:CommonVIEWFRAME(77, 13.5, 0.5, 12)];
    line.backgroundColor = [UIColor colorWithHexColorString:@"a0a0a0"];
    
    UILabel *title1 = [UILabel createLabelWithFrame:CommonVIEWFRAME(86, 8.5, 150, 22)
                                            andText:content
                                       andTextColor:[UIColor colorWithHexColorString:@"a1a1a1"]                                                andBgColor:[UIColor clearColor]
                                            andFont:SYSTEMFONT(12)
                                   andTextAlignment:NSTextAlignmentLeft];
    title1.adjustsFontSizeToFitWidth =YES;
    
    
    
    
    if ([title isEqualToString:@"评论"]) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        [btn setTitle:@"更多>>" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.titleLabel.font = SYSTEMFONT(11);
        [view addSubview:btn];
        
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(view);
            make.right.equalTo(view.mas_right).offset(0);
            make.size.mas_equalTo(CGSizeMake(60, 20));
        }];
    }
    
    [view addSubview:title2];
    [view addSubview:line];
    [view addSubview:title1];
    
    CGFloat width = [UILabel getWidthWithTitle:title font:SYSTEMFONT(13)];
    
    [title2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(view);
        make.left.equalTo(view.mas_left).offset(20);
        make.size.mas_equalTo(CGSizeMake(width, 20));
    }];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(view);
        make.left.equalTo(title2.mas_right).offset(12);
        make.size.mas_equalTo(CGSizeMake(0.5, 20));
    }];
    
    [title1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(view);
        make.left.equalTo(line.mas_right).offset(12);
        make.size.mas_equalTo(CGSizeMake(150, 20));
    }];

    
    
    
    return view;
}

-(void)buttonClick:(UIButton *)sender
{
    if (![LoginModel isLogin]) {
        [ProgressHUDHandler showHudTipStr:@"请先登录"];
        [[PushManager sharedManager] presentLoginVC];
        return;
    }

    NSDictionary *dic = [self.model transformToDictionary];
    [self PushViewControllerByClassName:@"MaintainOrder" info:dic];
}


-(void)getHeight:(CGFloat)height
{
    if (self.cellHeight != height) {
        self.cellHeight = height;
        [self.tableView reloadData];
    }
    
}

-(void)likeAction:(UIButton *)sender
{
    if (![LoginModel isLogin]) {
        [ProgressHUDHandler showHudTipStr:@"请先登录"];
        [[PushManager sharedManager] presentLoginVC];
        return;
    }

    [BaseRequest AddKeepWithMaintainid:[self.model.maintainid integerValue] succesBlock:^(id data) {
        if ([data[@"code"] integerValue] == 1) {
            [ProgressHUDHandler showHudTipStr:@"收藏成功"];
        }

    } failue:^(id data, NSError *error) {
        
    }];
}


-(void)talkBtn:(UIButton *)sender
{

    if (![LoginModel isLogin]) {
        [ProgressHUDHandler showHudTipStr:@"请先登录"];
        [[PushManager sharedManager] presentLoginVC];
        return;
    }

    MQChatViewManager *chatViewManager = [[MQChatViewManager alloc] init];
    [chatViewManager.chatViewStyle setEnableRoundAvatar:YES];
    [chatViewManager setClientInfo:@{@"name":@"updated",@"avatar":@"http://pic1a.nipic.com/2008-10-27/2008102715429376_2.jpg"} override:YES];
    [chatViewManager pushMQChatViewControllerInViewController:self];


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
