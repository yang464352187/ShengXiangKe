//
//  CategoryListModel.m
//  SXK
//
//  Created by 杨伟康 on 2016/12/10.
//  Copyright © 2016年 ywk. All rights reserved.
//

#import "CategoryListModel.h"

@implementation CategoryListModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"categoryid"   :@"categoryid",
             @"name"        :@"name",
             @"img"            :@"img"
             };
}


@end
