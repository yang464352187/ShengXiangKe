//
//  AddressModel.m
//  SXK
//
//  Created by 杨伟康 on 2016/12/6.
//  Copyright © 2016年 ywk. All rights reserved.
//

#import "AddressModel.h"

@implementation AddressModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"address"        :@"address",
             @"city"            :@"city",
             @"district"        :@"district",
             @"mobile"    :@"mobile",
             @"name":           @"name",
             @"receiverid":@"receiverid",
             @"state":@"state",
             @"userid":@"userid"
             };
}

@end
