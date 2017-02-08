//
//  FollowListModel.m
//  SXK
//
//  Created by 杨伟康 on 2017/1/20.
//  Copyright © 2017年 ywk. All rights reserved.
//

#import "FollowListModel.h"

@implementation FollowListModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"nickname"        :@"nickname",
             @"createtime"      :@"createtime",
             @"headimgurl"        :@"headimgurl",
             @"userid":@"userid",
             };
}


@end
