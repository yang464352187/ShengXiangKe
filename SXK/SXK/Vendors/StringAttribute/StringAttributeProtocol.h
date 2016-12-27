//
//  StringAttributeProtocol.h
//  HYStringAttribute
//
//  Created by HEYANG on 15/11/22.
//  Copyright © 2015年 HEYANG. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol StringAttributeProtocol <NSObject>

#pragma mark - 必须实现
@required

/**
 *  属性名字
 *
 *  @return 属性名字
 */
- (NSString *)attributeName;

/**
 *  属性对应的值
 *
 *  @return 对应的值
 */
- (id)attributeValue;


#pragma mark - 可选实现
@optional
/**
 *  属性设置生效范围
 *
 *  @return 生效的范围
 */
- (NSRange)effectiveStringRange;

@end


/*
 *  HY ：
 *  1、多种属性类可以抽象出一个抽象类，然后多种属性类继承这个抽象类。
 *     因为 Font是一种属性，ForegroundColor是一种属性，存在着显而易见的 is a 关系
 *  2、因为具体的子类属性模型中的attributeName是不需要"用一个变量"存储的，可以直接用方法return value
 *     每一个具体的子类attributeName是具体不变的字面量，相对而言attributeValue却是变化的value，所以需要property对应声明
 *     由于具体的子类对应的attributeValue的值不一样，又考虑协议提供统一的接口，所以用attributeValue取代各自属性值的get方法
 *
 */