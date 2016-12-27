//
//  NSMutableAttributedString+StringAttribute.m
//  HYStringAttribute
//
//  Created by HEYANG on 15/11/22.
//  Copyright © 2015年 HEYANG. All rights reserved.
//

#import "NSMutableAttributedString+StringAttribute.h"

@implementation NSMutableAttributedString (StringAttribute)

- (void)addStringAttribute:(id <StringAttributeProtocol>)stringAttribute {
    
    [self addAttribute:[stringAttribute attributeName]
                 value:[stringAttribute attributeValue]
                 range:[stringAttribute effectiveStringRange]];
}

- (void)removeStringAttribute:(id <StringAttributeProtocol>)stringAttribute {
    
    [self removeAttribute:[stringAttribute attributeName]
                    range:[stringAttribute effectiveStringRange]];
}

@end
