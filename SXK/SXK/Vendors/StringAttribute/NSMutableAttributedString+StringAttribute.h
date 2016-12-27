//
//  NSMutableAttributedString+StringAttribute.h
//  HYStringAttribute
//
//  Created by HEYANG on 15/11/22.
//  Copyright © 2015年 HEYANG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StringAttribute.h"

@interface NSMutableAttributedString (StringAttribute)

/**
 *  添加富文本对象
 *
 *  @param stringAttribute 实现了StringAttributeProtocol协议的对象
 */
- (void)addStringAttribute:(id <StringAttributeProtocol>)stringAttribute;

/**
 *  消除指定的富文本对象
 *
 *  @param stringAttribute 实现了StringAttributeProtocol协议的对象
 */
- (void)removeStringAttribute:(id <StringAttributeProtocol>)stringAttribute;


@end
