//
//  StringAttribute.m
//  HYStringAttribute
//
//  Created by HEYANG on 15/11/22.
//  Copyright © 2015年 HEYANG. All rights reserved.
//

#import "StringAttribute.h"

@implementation StringAttribute

- (NSString *)attributeName {
    
    return nil;
}

- (id)attributeValue {
    
    return nil;
}

//因为这个方法是在协议里是可实现可不实现的，作为子类可以直接不实现
- (NSRange)effectiveStringRange {
    
    return self.effectRange;
}

@end
