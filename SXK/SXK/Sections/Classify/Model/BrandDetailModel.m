//
//  BrandDetailModel.m
//  SXK
//
//  Created by 杨伟康 on 2016/12/28.
//  Copyright © 2016年 ywk. All rights reserved.
//

#import "BrandDetailModel.h"

@implementation BrandDetailModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"rentid"   :@"rentid",
             @"color"        :@"color",
             @"counterPrice"            :@"counterPrice",
             @"crowd":@"crowd",
             @"description1":@"description",
             @"attachList":@"attachList",
             @"keyword":@"keyword",
             @"commentList":@"commentList",
             @"imgList":@"imgList",
             @"sale":@"sale",
             @"sort":@"sort",
             @"name":@"name",
             @"categoryid":@"categoryid",
             @"brandid":@"brandid",
             @"condition":@"condition",
             @"userid":@"userid",
             @"three":@"three",
             @"twentyFive":@"twentyFive",
             @"fiften":@"fiften",
             @"seven":@"seven",
             @"marketPrice":@"marketPrice",
             @"rentPrice":@"rentPrice",
             @"brand":@"brand"
             
             };
}

@end
