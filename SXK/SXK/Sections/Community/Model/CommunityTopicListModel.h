//
//  CommunityTopicListModel.h
//  SXK
//
//  Created by 杨伟康 on 2016/12/12.
//  Copyright © 2016年 ywk. All rights reserved.
//

#import "BaseModel.h"

@interface CommunityTopicListModel : BaseModel

@property (nonatomic, strong)NSArray *commentList, *imgList, *likeList;

@property (nonatomic, strong)NSString *content, *headimgurl, *nickname;

@property (nonatomic, strong)NSNumber *topicid, *userid, *createtime;

@end
