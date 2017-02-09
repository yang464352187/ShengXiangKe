//
//  RongYunListCell.h
//  poseidon
//
//  Created by ZFJ on 16/5/16.
//  Copyright © 2016年 我要学. All rights reserved.
//

#import <RongIMKit/RongIMKit.h>

@interface RongYunListCell : RCConversationBaseCell

//系统消息 评论 点赞 访客
//ListOne
@property (weak, nonatomic) IBOutlet UIImageView *ListOneIcon;//图标
@property (weak, nonatomic) IBOutlet UILabel *ListOneTitle;//标题
@property (weak, nonatomic) IBOutlet UILabel *ListOneCount;//未读消息
- (void)setRongYunListCellOneUIViewWithModel:(RCConversationModel *)model iconName:(NSString *)iconName;


//会话列表 Listtwo
@property (weak, nonatomic) IBOutlet UIImageView *ListtwoIcon;//头像
@property (weak, nonatomic) IBOutlet UILabel *Listtwoname;//名称
@property (weak, nonatomic) IBOutlet UILabel *ListtwoTime;//时间
@property (weak, nonatomic) IBOutlet UILabel *ListtwoContent;//内容
- (void)setRongYunListCellTwoUIViewWithModel:(RCConversationModel *)model;


//评委老师 Listthree
@property (weak, nonatomic) IBOutlet UIImageView *ListthreeIcon;//头像
@property (weak, nonatomic) IBOutlet UILabel *ListthreeName;//名称
@property (weak, nonatomic) IBOutlet UILabel *ListthreeDescribe;//描述
- (void)setListthreeViewWithImgStr:(NSString *)ImgStr name:(NSString *)name describeStr:(NSString *)describeStr;





@end
