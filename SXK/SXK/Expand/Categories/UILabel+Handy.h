//
//  UILabel+Handy.h
//  PaperSource
//
//  Created by Yhoon on 15/10/21.
//  Copyright © 2015年 yhoon. All rights reserved.
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

@end
