//
//  ForegroundColorAttribute.m
//  HYStringAttribute
//
//  Created by HEYANG on 15/11/22.
//  Copyright © 2015年 HEYANG. All rights reserved.
//

#import "ForegroundColorAttribute.h"

@implementation ForegroundColorAttribute

- (NSString *)attributeName {
    
    return NSForegroundColorAttributeName;
}

- (id)attributeValue {
    
    if (self.color) {
        
        return self.color;
        
    } else {
        
        return [UIColor blackColor];
    }
}

@end
