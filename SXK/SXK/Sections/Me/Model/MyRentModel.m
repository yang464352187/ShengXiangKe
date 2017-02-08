//
//  MyRentModel.m
//  SXK
//
//  Created by 杨伟康 on 2017/1/23.
//  Copyright © 2017年 ywk. All rights reserved.
//

#import "MyRentModel.h"

@implementation MyRentModel


+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"oddNumber"        :@"oddNumber",
             @"backOddNumber"      :@"backOddNumber",
             @"rent":@"rent",
             @"rentid":@"rentid",
             @"orderid":@"orderid",
             };
}

@end
