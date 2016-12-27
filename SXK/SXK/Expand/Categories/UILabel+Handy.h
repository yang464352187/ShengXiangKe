//
//  UILabel+Handy.h
//  SXK
//
//  Created by 杨伟康 on 2016/11/24.
//  Copyright © 2016年 ywk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Handy)

//创建UILabel的快捷方法
+ (UILabel *)createLabelWithFrame:(CGRect)frame
                          andText:(NSString *)text
                     andTextColor:(UIColor*)textColor
                       andBgColor:(UIColor*)bgColor
                          andFont:(UIFont *)font
                 andTextAlignment:(NSTextAlignment)textAlignment;

+ (UILabel *)createLabelWithFrame:(CGRect)frame
                          andText:(NSString *)text
                     andTextColor:(UIColor*)textColor
                       andBgColor:(UIColor*)bgColor
                 andTextAlignment:(NSTextAlignment)textAlignment;

//自适应高度

+ (CGFloat)getHeightByWidth:(CGFloat)width title:(NSString *)title font:(UIFont*)font;

+ (CGFloat)getWidthWithTitle:(NSString *)title font:(UIFont *)font;

- (void) textLeftTopAlign; 

@end
