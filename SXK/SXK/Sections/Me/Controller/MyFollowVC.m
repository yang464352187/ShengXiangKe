//
//  MyFollowVC.m
//  SXK
//
//  Created by 杨伟康 on 2017/1/20.
//  Copyright © 2017年 ywk. All rights reserved.
//

#import "MyFollowVC.h"
#import "FollowListModel.h"
#import "FollowListCell.h"
#import <RongIMKit/RongIMKit.h>
#import "RCConversationVC.h"
@interface MyFollowVC ()<RCIMUserInfoDataSource,RCIMGroupInfoDataSource
>
@property (nonatomic, strong) FollowListModel *model;

@end

@implementation MyFollowVC

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    _weekSelf(weakSelf);
    [BaseRequest GetFollowListsuccesBlock:^(id data) {
        NSArray *models = [FollowListModel modelsFromArray:data[@"follow"][@"userList"]];
        NSLog(@"%@",describe(models));
        [weakSelf handleModels:models total:models.count];
    } failue:^(id data, NSError *error) {
        
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"我的关注";
    [self.view addSubview:self.tableView];
    self.isUseNoDataView = YES;
    [self.noDataView setTitle:@"暂无订单~"];

}

#pragma mark -- getters and setters
- (UITableView *)tableView{
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:VIEWFRAME(0, 0, SCREEN_WIDTH, SCREEN_HIGHT-64) style:UITableViewStyleGrouped];
        _tableView.dataSource      = self;
        _tableView.delegate        = self;
        [_tableView registerClass:[FollowListCell class] forCellReuseIdentifier:@"FollowListCell"];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.backgroundColor = [UIColor colorWithHexColorString:@"f7f7f7"];
        _tableView.separatorStyle  = UITableViewCellSeparatorStyleSingleLine;
        _tableView.sectionHeaderHeight = 0.0;
        _tableView.sectionFooterHeight = 0.0;

    }
    return _tableView;
}


#pragma mark -- UITabelViewDelegate And DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.listData.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    FollowListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FollowListCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setModel:self.listData[indexPath.section]];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.0000001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.0000001;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    FollowListModel *model = self.listData[indexPath.section];
    _weekSelf(weakSelf);
    [BaseRequest DeleteFollowWithUserID:[model.userid integerValue] succesBlock:^(id data) {
        [self.listData removeObjectAtIndex:indexPath.section];
//        NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:indexPath.section];
//        [self.tableView deleteSections:indexSet withRowAnimation:UITableViewRowAnimationFade];
        [weakSelf.tableView reloadData];
    } failue:^(id data, NSError *error) {
        
    }];
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    FollowListModel *follow = self.listData[indexPath.section];
    
    self.model = follow;
    
    UserModel *model =   [LoginModel curLoginUser];
    
    RCConversationVC *chat = [[RCConversationVC alloc] initWithConversationType:ConversationType_PRIVATE
                                                                       targetId:[NSString stringWithFormat:@"%@",model.userid]];
    [RCIM sharedRCIM].currentUserInfo = [[RCUserInfo alloc] initWithUserId:[NSString stringWithFormat:@"%@",model.userid] name:model.nickname portrait:model.headimgurl];
    
    [RCIM sharedRCIM].globalMessageAvatarStyle = RC_USER_AVATAR_CYCLE;
    
    [[RCIM sharedRCIM] setUserInfoDataSource:self];
    
    chat.conversationType = ConversationType_PRIVATE;
    
    chat.targetId = [NSString stringWithFormat:@"%ld",[follow.userid integerValue]];
    
    chat.title = follow.nickname;
    
    [RCIM sharedRCIM].enablePersistentUserInfoCache = YES;
    [RCIM sharedRCIM].enableMessageAttachUserInfo = YES;
    
    
    RCUserInfo *user = [[RCUserInfo alloc] initWithUserId: [NSString stringWithFormat:@"%ld",[follow.userid integerValue]] name:follow.nickname portrait:follow.headimgurl];
    [[RCIM sharedRCIM] refreshUserInfoCache:user withUserId:[NSString stringWithFormat:@"%ld",[follow.userid integerValue]]];
    

    [self.navigationController pushViewController:chat animated:YES];
}

//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return YES;
//}
//
//- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//    return UITableViewCellEditingStyleDelete;
//}
//
////设置编辑状态下cell删除按钮的名字
//- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//    return @"删除";
//}


//-(void)push
//{
//    
//    UserModel *model =   [LoginModel curLoginUser];
//    
//    RCConversationVC *chat = [[RCConversationVC alloc] initWithConversationType:ConversationType_PRIVATE
//                                                                       targetId:[NSString stringWithFormat:@"%@",model.userid]];
//    [RCIM sharedRCIM].currentUserInfo = [[RCUserInfo alloc] initWithUserId:[NSString stringWithFormat:@"%@",model.userid] name:model.nickname portrait:model.headimgurl];
//    
//    [RCIM sharedRCIM].globalMessageAvatarStyle = RC_USER_AVATAR_CYCLE;
//    
//    [[RCIM sharedRCIM] setUserInfoDataSource:self];
//    
//    chat.conversationType = ConversationType_PRIVATE;
//    
//    chat.targetId = [NSString stringWithFormat:@"%ld",_userid];
//    
//    chat.title = _title;
//    
//    [RCIM sharedRCIM].enablePersistentUserInfoCache = YES;
//    [RCIM sharedRCIM].enableMessageAttachUserInfo = YES;
//    
//    
//    RCUserInfo *user = [[RCUserInfo alloc] initWithUserId: [NSString stringWithFormat:@"%ld",_userid] name:_title portrait:_image1];
//    [[RCIM sharedRCIM] refreshUserInfoCache:user withUserId:[NSString stringWithFormat:@"%ld",_userid]];
//    
//    
//    [self.vc.navigationController pushViewController:chat animated:YES];
//    
//    
//    //    NSLog(@"-----%ld-----",_userid);
//}
//
- (void)getUserInfoWithUserId:(NSString *)userId
                   completion:(void (^)(RCUserInfo *userInfo))completion
{
    UserModel *model =   [LoginModel curLoginUser];
    
    if ([userId isEqualToString:[NSString stringWithFormat:@"%@",model.userid]]) {
        return completion([[RCUserInfo alloc] initWithUserId:[NSString stringWithFormat:@"%@",model.userid] name:model.nickname portrait:model.headimgurl]);
    }else
    {
        //        根据存储联系人信息的模型，通过 userId 来取得对应的name和头像url，进行以下设置（此处因为项目接口尚未实现，所以就只能这样给大家说说，请见谅）
        return completion([[RCUserInfo alloc] initWithUserId:[NSString stringWithFormat:@"%ld",[self.model.userid integerValue]] name:self.model.nickname portrait:self.model.headimgurl]);
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
