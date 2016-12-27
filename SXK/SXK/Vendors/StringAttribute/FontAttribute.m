//
//  FontAttribute.m
//  HYStringAttribute
//
//  Created by HEYANG on 15/11/22.
//  Copyright © 2015年 HEYANG. All rights reserved.
//

#import "FontAttribute.h"

@implementation FontAttribute

- (NSString *)attributeName {
    
    return NSFontAttributeName;
}

//因为不确定返回的类型，可能是self.font也可能是UIFont，所以用id
- (id)attributeValue {
    
    if (self.font) {
        
        return self.font;
        
    } else {
        
        return [UIFont systemFontOfSize:12.f];
    }
}
@end
