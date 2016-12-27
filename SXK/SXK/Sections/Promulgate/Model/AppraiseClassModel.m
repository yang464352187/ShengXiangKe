//
//  AppraiseClassModel.m
//  SXK
//
//  Created by 杨伟康 on 2016/12/24.
//  Copyright © 2016年 ywk. All rights reserved.
//

#import "AppraiseClassModel.h"

@implementation AppraiseClassModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"description1"   :@"description",
             @"price"            :@"price",
             @"name"        :@"name",
             @"genreid" : @"genreid"
             };
}

@end
