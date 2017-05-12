//
//  MyPromulgateModel.m
//  SXK
//
//  Created by 杨伟康 on 2016/12/27.
//  Copyright © 2016年 ywk. All rights reserved.
//

#import "MyPromulgateModel.h"

@implementation MyPromulgateModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"keyword"        :@"keyword",
             @"imgList"            :@"imgList",
             @"rentPrice"        :@"rentPrice",
             @"marketPrice"    :@"marketPrice",
             @"name":           @"name",
             @"rentid":@"rentid",
             @"oddNumber":@"oddNumber",
             @"condition":@"condition",
             @"orderid":@"orderid"
             };
}


@end
