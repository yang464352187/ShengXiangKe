//
//  MyBussinesModel.m
//  SXK
//
//  Created by 杨伟康 on 2017/4/5.
//  Copyright © 2017年 ywk. All rights reserved.
//

#import "MyBussinesModel.h"

@implementation MyBussinesModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"imgList":@"imgList",
             @"sellingPrice"        :@"sellingPrice",
             @"marketPrice"    :@"marketPrice",
             @"name":           @"name",
             @"description1":@"description",
             @"advancePrice":@"advancePrice",
             @"oddNumber":@"oddNumber",
             @"orderid":@"orderid"
             };
}

@end
