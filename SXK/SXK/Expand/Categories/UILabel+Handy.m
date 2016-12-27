//
//  UILabel+Handy.m
//  SXK
//
//  Created by 杨伟康 on 2016/11/24.
//  Copyright © 2016年 ywk. All rights reserved.
//

#import "UILabel+Handy.h"

@implementation UILabel (Handy)

+ (UILabel *)createLabelWithFrame:(CGRect)frame
                          andText:(NSString *)text
                     andTextColor:(UIColor*)textColor
                       andBgColor:(UIColor*)bgColor
                 andTextAlignment:(NSTextAlignment)textAlignment {
    UILabel *label        = [[UILabel alloc] initWithFrame:frame];
    label.text            = text;
    label.frame           = frame;
    label.textColor       = textColor;
    label.backgroundColor = bgColor;
    label.textAlignment   = textAlignment;
    
    return label;
}

+ (UILabel *)createLabelWithFrame:(CGRect)frame
                          andText:(NSString *)text
                     andTextColor:(UIColor*)textColor
                       andBgColor:(UIColor*)bgColor
                          andFont:(UIFont *)font
                 andTextAlignment:(NSTextAlignment)textAlignment {
    UILabel *label        = [[UILabel alloc] initWithFrame:frame];
    label.text            = text;
    label.frame           = frame;
    label.font            = font;
    label.textColor       = textColor;
    label.backgroundColor = bgColor;
    label.textAlignment   = textAlignment;
    
    return label;
}

+ (CGFloat)getHeightByWidth:(CGFloat)width title:(NSString *)title font:(UIFont *)font
{
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, 0)];
    label.text = title;
    label.font = font;
    label.numberOfLines = 0;
    [label sizeToFit];
    CGFloat height = label.frame.size.height;
    return height;
}

+ (CGFloat)getWidthWithTitle:(NSString *)title font:(UIFont *)font {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 1000, 0)];
    label.text = title;
    label.font = font;
    [label sizeToFit];
    return label.frame.size.width;
}

- (void) textLeftTopAlign
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:12.f], NSParagraphStyleAttributeName:paragraphStyle.copy};
    
    CGSize labelSize = [self.text boundingRectWithSize:CGSizeMake(207, 999) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    
    CGRect dateFrame =CGRectMake(2, 140, CGRectGetWidth(self.frame)-5, labelSize.height);
    self.frame = dateFrame;
}

@end
