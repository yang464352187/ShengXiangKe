//
//  BrandHotModel.m
//  SXK
//
//  Created by 杨伟康 on 2016/12/8.
//  Copyright © 2016年 ywk. All rights reserved.
//

#import "BrandHotModel.h"

@implementation BrandHotModel


+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"description1"   :@"description",
             @"img"            :@"img",
             @"name"        :@"name",
             @"brandid"    :@"brandid",
             @"hotid"       :@"hotid"
             };
}

@end
