//
//  RongYunListCell.m
//  poseidon
//
//  Created by ZFJ on 16/5/16.
//  Copyright © 2016年 我要学. All rights reserved.
//

#import "RongYunListCell.h"

@implementation RongYunListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.ListOneCount.layer.masksToBounds = YES;
    self.ListOneCount.layer.cornerRadius = 10;
    
    self.ListthreeIcon.layer.masksToBounds = YES;
    self.ListthreeIcon.layer.cornerRadius = 50/2;
}

//系统消息 评论 点赞 访客
- (void)setRongYunListCellOneUIViewWithModel:(RCConversationModel *)model iconName:(NSString *)iconName{
    self.ListOneTitle.font = [UIFont fontWithName:@"PingFangSC-Light" size:18];
    self.ListOneIcon.image = [UIImage imageNamed:iconName];
    self.ListOneTitle.text = model.conversationTitle;
}

//会话列表
- (void)setRongYunListCellTwoUIViewWithModel:(RCConversationModel *)model{
    
}

//评委老师
- (void)setListthreeViewWithImgStr:(NSString *)ImgStr name:(NSString *)name describeStr:(NSString *)describeStr{
    [self.ListthreeIcon sd_setImageWithURL:[NSURL URLWithString:ImgStr] placeholderImage:[UIImage imageNamed:@"PlacelorHeadImage"]];
    UIFont *font = [UIFont fontWithName:@"PingFangSC-Regular" size:18];
    if(font==nil){
        font = [UIFont fontWithName:@"PingFang-SC-Regular" size:18];
    }
    self.ListthreeName.text = name;
    self.ListthreeName.font = font;
    self.ListthreeName.textColor = [UIColor colorWithRed:0.204 green:0.204 blue:0.204 alpha:1.00];
    
    font = [UIFont fontWithName:@"PingFangSC-Light" size:14];
    if([describeStr isEqual:[NSNull null]]){
        describeStr = @"";
    }
    describeStr = [NSString stringWithFormat:@"%@",describeStr];
    
    self.ListthreeDescribe.text = describeStr;
    self.ListthreeDescribe.font = font;
    self.ListthreeDescribe.textColor = [UIColor colorWithRed:0.592 green:0.592 blue:0.592 alpha:1.00];
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
