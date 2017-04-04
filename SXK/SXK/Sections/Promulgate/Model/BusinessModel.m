//
//  BusinessModel.m
//  SXK
//
//  Created by 杨伟康 on 2017/3/17.
//  Copyright © 2017年 ywk. All rights reserved.
//

#import "BusinessModel.h"

@implementation BusinessModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"category"        :@"category",
             @"name"            :@"name",
             @"advancePrice"    :@"advancePrice",
             @"condition"       :@"condition"
             };
}


@end
