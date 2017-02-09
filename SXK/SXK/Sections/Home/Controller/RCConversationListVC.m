//
//  RCConversationListVC.m
//  SXK
//
//  Created by 杨伟康 on 2017/2/9.
//  Copyright © 2017年 ywk. All rights reserved.
//

#import "RCConversationListVC.h"
#import "RongYunListCell.h"

@interface RCConversationListVC ()

@property (nonatomic, strong)NSArray *iconArr;
@end

@implementation RCConversationListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setDisplayConversationTypes:@[@(ConversationType_PRIVATE)]];
    self.iconArr = @[@"占位-0"];
}

- (void)onSelectedTableRow:(RCConversationModelType)conversationModelType
         conversationModel:(RCConversationModel *)model
               atIndexPath:(NSIndexPath *)indexPath {
    RCConversationViewController *conversationVC = [[RCConversationViewController alloc]init];
    conversationVC.conversationType = model.conversationType;
    conversationVC.targetId = model.targetId;
    conversationVC.title = @"想显示的会话标题";
    [self.navigationController pushViewController:conversationVC animated:YES];
}

//- (void)willDisplayConversationTableCell:(RCConversationBaseCell *)cell atIndexPath:(NSIndexPath *)indexPath{
//    RCConversationModel *model = [self.conversationListDataSource objectAtIndex:indexPath.row];
//    if(model.conversationModelType != RC_CONVERSATION_MODEL_TYPE_CUSTOMIZATION){
//        RCConversationCell *RCcell = (RCConversationCell *)cell;
//        RCcell.conversationTitle.font = [UIFont fontWithName:@"PingFangSC-Light" size:18];
//        RCcell.messageContentLabel.font = [UIFont fontWithName:@"PingFangSC-Light" size:16];
//        RCcell.messageCreatedTimeLabel.font = [UIFont fontWithName:@"PingFangSC-Light" size:14];
//    }
//}

//- (RCConversationBaseCell *)rcConversationListTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    RongYunListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RongYunListCell"];
//    if (!cell) {
//        cell = [[[NSBundle mainBundle]loadNibNamed:@"RongYunListCell" owner:self options:nil] firstObject];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        cell.ListOneCount.hidden = YES;
//    }
//    NSInteger count = 0;
//    if(indexPath.row < _badgeValueArr.count){
//        count = [_badgeValueArr[indexPath.row] integerValue];
//    }
//    if(count>0){
//        cell.ListOneCount.hidden = NO;
//        cell.ListOneCount.text = [NSString stringWithFormat:@"%ld",count];
//    }else{
//        cell.ListOneCount.hidden = YES;
//    }
//    RCConversationModel *model = self.conversationListDataSource[indexPath.row];
//    [cell setRongYunListCellOneUIViewWithModel:model iconName:self.iconArr[indexPath.row]];
//    return cell;
//}

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
