//
//  ActivityListModel.m
//  SXK
//
//  Created by 杨伟康 on 2016/12/9.
//  Copyright © 2016年 ywk. All rights reserved.
//

#import "ActivityListModel.h"

@implementation ActivityListModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"img"   :@"img",
             @"content"       :@"content",
             @"time"        :@"time",
             @"place"    :@"place",
             @"name"       :@"name",
             @"activityid":@"activityid"
             };
}


@end
