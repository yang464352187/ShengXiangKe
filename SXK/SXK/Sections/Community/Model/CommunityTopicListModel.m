//
//  CommunityTopicListModel.m
//  SXK
//
//  Created by 杨伟康 on 2016/12/12.
//  Copyright © 2016年 ywk. All rights reserved.
//

#import "CommunityTopicListModel.h"

@implementation CommunityTopicListModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
   
             @"commentList":@"commentList",
             @"content":@"content",
             @"headimgurl":@"headimgurl",
             @"imgList":@"imgList",
             @"likeList":@"likeList",
             @"nickname":@"nickname",
             @"topicid":@"topicid",
             @"userid":@"userid",
             @"createtime":@"createtime"
             };
}


@end
