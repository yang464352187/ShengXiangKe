//
//  NSString+StringAttribute.m
//  HYStringAttribute
//
//  Created by HEYANG on 15/11/22.
//  Copyright © 2015年 HEYANG. All rights reserved.
//

#import "NSString+StringAttribute.h"

@implementation NSString (StringAttribute)

- (NSMutableAttributedString *)mutableAttributedStringWithStringAttributes:(NSArray *)attributes {
    
    NSMutableAttributedString *attributedString = nil;
    
    if (self) {
        
        attributedString = [[NSMutableAttributedString alloc] initWithString:self];
        
        for (id <StringAttributeProtocol> attribute in attributes) {
            
            [attributedString addAttribute:[attribute attributeName]
                                     value:[attribute attributeValue]
                                     range:[attribute effectiveStringRange]];
        }
    }
    
    return attributedString;
}

- (NSAttributedString *)attributedStringWithStringAttributes:(NSArray *)attributes {
    
    NSAttributedString *attributedString = nil;
    
    if (self) {
        
        NSMutableDictionary *attributesDictionary = [NSMutableDictionary dictionary];
        
        for (id <StringAttributeProtocol> attribute in attributes) {
            
            [attributesDictionary setObject:[attribute attributeValue]
                                     forKey:[attribute attributeName]];
        }
        
        attributedString = [[NSAttributedString alloc] initWithString:self
                                                           attributes:attributesDictionary];
    }
    
    return attributedString;
}


@end
