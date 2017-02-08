//
//  QuestionListModel.m
//  SXK
//
//  Created by 杨伟康 on 2017/1/20.
//  Copyright © 2017年 ywk. All rights reserved.
//

#import "QuestionListModel.h"

@implementation QuestionListModel


+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"content"        :@"content",
             @"questionid"      :@"questionid",
             @"name"        :@"name"
             };
}

@end
