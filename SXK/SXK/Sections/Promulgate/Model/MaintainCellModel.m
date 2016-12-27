//
//  MaintainCellModel.m
//  SXK
//
//  Created by 杨伟康 on 2016/12/22.
//  Copyright © 2016年 ywk. All rights reserved.
//

#import "MaintainCellModel.h"

@implementation MaintainCellModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"description1"   :@"description",
             @"classifyid"     :@"classifyid",
             @"name"           :@"name",
             @"img"            :@"img",
             @"maintainid"     :@"maintainid",
             @"keyword":@"keyword",
             @"price":@"price"
             };
}


@end
