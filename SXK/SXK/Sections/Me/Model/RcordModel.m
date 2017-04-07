//
//  RcordModel.m
//  SXK
//
//  Created by 杨伟康 on 2017/2/28.
//  Copyright © 2017年 ywk. All rights reserved.
//

#import "RcordModel.h"

@implementation RcordModel


+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"amount"        :@"amount",
             @"point"         :@"point",
             @"createtime"    :@"createtime",
             @"type"          :@"type"
             
             };
}

@end
