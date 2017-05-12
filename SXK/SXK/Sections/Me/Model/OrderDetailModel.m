//
//  OrderDetailModel.m
//  SXK
//
//  Created by 杨伟康 on 2017/4/20.
//  Copyright © 2017年 ywk. All rights reserved.
//

#import "OrderDetailModel.h"

@implementation OrderDetailModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"keyword"        :@"keyword",
//             @"imgList"            :@"imgList",
             @"rentPrice"        :@"rentPrice",
             @"marketPrice"    :@"marketPrice",
             @"name":           @"name",
             @"rentid":@"rentid",
             @"oddNumber":@"oddNumber",
             @"condition":@"condition",
             @"orderid":@"orderid",
             @"rent":@"rent",
             @"tenancy":@"tenancy",
             @"purchase":@"purchase",
             @"nickname":@"nickname",
             @"headimgurl":@"headimgurl"
             };
}



@end
