//
//  BrandDetailCell3.h
//  SXK
//
//  Created by 杨伟康 on 2017/3/1.
//  Copyright © 2017年 ywk. All rights reserved.
//

#import "BaseCell.h"
#import "DFLineLikeItem.h"
#import "DFLineCommentItem.h"
#import "DFBaseLineItem.h"
#import "CommunityCollectionCell.h"
#import "DFLineCellManager.h"
#import "DFLineCommentItem.h"
#import "DFLineLikeItem.h"
#import "CommentInputView.h"
#import "DFBaseLineCell.h"
#import "ModuleModel.h"
#import "CommunityTopicListModel.h"


@interface BrandDetailCell3 : BaseCell

-(void) addItem:(DFBaseLineItem *) item;

//添加到头部
-(void) addItemTop:(DFBaseLineItem *) item;

//根据ID删除
-(void) deleteItem:(long long) itemId;

//赞
-(void) addLikeItem:(DFLineLikeItem *) likeItem itemId:(long long) itemId;

//评论
-(void) addCommentItem:(DFLineCommentItem *) commentItem itemId:(long long) itemId replyCommentId:(long long) replyComment;

@property (nonatomic, strong) NSNumber *rentid;


-(void)setWithArray:(NSArray *)array;
@end
