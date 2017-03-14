//
//  RentCommentModel.m
//  SXK
//
//  Created by 杨伟康 on 2017/3/2.
//  Copyright © 2017年 ywk. All rights reserved.
//

#import "RentCommentModel.h"

@implementation RentCommentModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             
             @"imgList"   :@"imgList",
             @"nickname"  :@"nickname",
             @"createtime":@"createtime",
             @"headimgurl":@"headimgurl",
             @"content"   :@"content",
             @"commentid" :@"commentid",
             @"userid":@"userid"
             };
}

@end
