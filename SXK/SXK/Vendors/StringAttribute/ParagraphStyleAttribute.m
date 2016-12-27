//
//  ParagraphStyleAttribute.m
//  HYStringAttribute
//
//  Created by HEYANG on 15/11/22.
//  Copyright © 2015年 HEYANG. All rights reserved.
//

#import "ParagraphStyleAttribute.h"

@implementation ParagraphStyleAttribute

- (NSString *)attributeName {
    
    return NSParagraphStyleAttributeName;
}

//因为不确定返回的类型，可能是self.font也可能是UIFont，所以用id
- (id)attributeValue {
    
    if (self.style) {
        
        return self.style;
        
    } else {
        
        return [[NSMutableParagraphStyle alloc] init];
    }
}

@end
