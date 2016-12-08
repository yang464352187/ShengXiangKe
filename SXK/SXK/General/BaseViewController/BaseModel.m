//
//  BaseModel.m
//  SXK
//
//  Created by 杨伟康 on 2016/11/24.
//  Copyright © 2016年 ywk. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return nil;
}

// 字典转模型
+ (id)modelFromDictionary:(NSDictionary *)data {
    NSError *error;
    id model = [MTLJSONAdapter modelOfClass:self.class fromJSONDictionary:data error:&error];
    
    if (error) {
        NSLog(@"模型转换失败:%@",error);
        return nil;
    }
    return model;
}

/**
 *  数组转模型数组
 *
 *  @param array 数组
 *
 *  @return 模型数组
 */
+ (id)modelsFromArray:(NSArray *)array{
    NSError *error;
    id models = [MTLJSONAdapter modelsOfClass:self.class fromJSONArray:array error:&error];
    
    if (error) {
        NSLog(@"模型转换失败:%@",error);
        return nil;
    }
    return models;
}

// 模型转字典
- (NSDictionary *)transformToDictionary {
    NSError *error;
    NSDictionary *dictionary = [MTLJSONAdapter JSONDictionaryFromModel:self error:&error];
    
    if (error) {
        NSLog(@"数据转换失败:%@",error);
        return nil;
    }
    return dictionary;
}

@end
