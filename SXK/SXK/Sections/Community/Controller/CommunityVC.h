//
//  CommunityVC.h
//  SXK
//
//  Created by 杨伟康 on 2016/11/11.
//  Copyright © 2016年 ywk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DFLineLikeItem.h"
#import "DFLineCommentItem.h"
#import "DFBaseLineItem.h"

@interface CommunityVC : YTBaseTableVC

//添加到末尾
-(void) addItem:(DFBaseLineItem *) item;

//添加到头部
-(void) addItemTop:(DFBaseLineItem *) item;

//根据ID删除
-(void) deleteItem:(long long) itemId;

//赞
-(void) addLikeItem:(DFLineLikeItem *) likeItem itemId:(long long) itemId;

//评论
-(void) addCommentItem:(DFLineCommentItem *) commentItem itemId:(long long) itemId replyCommentId:(long long) replyComment;

@end
