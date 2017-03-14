
//
//  WalletModel.m
//  SXK
//
//  Created by 杨伟康 on 2017/3/6.
//  Copyright © 2017年 ywk. All rights reserved.
//

#import "WalletModel.h"

@implementation WalletModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"amount"        :@"amount",
             @"balance"         :@"balance",
             @"createtime"    :@"createtime"
             
             };
}


@end
