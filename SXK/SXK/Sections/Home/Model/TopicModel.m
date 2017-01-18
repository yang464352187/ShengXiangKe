//
//  TopicModel.m
//  SXK
//
//  Created by 杨伟康 on 2017/1/17.
//  Copyright © 2017年 ywk. All rights reserved.
//

#import "TopicModel.h"

@implementation TopicModel


+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"img"   :@"img",
             @"topicid"       :@"topicid",
             @"name"       :@"name"
             };
}

@end
