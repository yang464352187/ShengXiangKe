//
//  StringAttribute.h
//  HYStringAttribute
//
//  Created by HEYANG on 15/11/22.
//  Copyright © 2015年 HEYANG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "StringAttributeProtocol.h"

@interface StringAttribute : NSObject <StringAttributeProtocol>

/**
 *  富文本设置的生效范围
 */
@property (nonatomic) NSRange  effectRange;

@end
