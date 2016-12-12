//
//  ModuleModel.m
//  SXK
//
//  Created by 杨伟康 on 2016/12/12.
//  Copyright © 2016年 ywk. All rights reserved.
//

#import "ModuleModel.h"

@implementation ModuleModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"description1"   :@"description",
             @"img"            :@"img",
             @"name"        :@"name",
             @"moduleid" : @"moduleid"
             };
}
@end
