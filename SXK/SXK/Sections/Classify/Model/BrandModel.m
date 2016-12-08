//
//  BrandModel.m
//  SXK
//
//  Created by 杨伟康 on 2016/12/8.
//  Copyright © 2016年 ywk. All rights reserved.
//

#import "BrandModel.h"

@implementation BrandModel


+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"description1"   :@"description",
             @"img"            :@"img",
             @"name"        :@"name",
             @"brandid"    :@"brandid"
             };
}

@end
