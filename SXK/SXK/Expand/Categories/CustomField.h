//
//  CustomField.h
//  YunTShop
//
//  Created by sfgod on 16/4/4.
//  Copyright © 2016年 sufan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    validateTypeDefualt,
    validateTypeMobile,
    validateTypeEmail,
    validateTypePassWord,
} validateType;


@interface CustomField : UITextField

@property (assign, nonatomic) validateType validatetype;

- (instancetype)initWithValidateType:(validateType)type;
- (instancetype)initWithFrame:(CGRect)frame AndValidateType:(validateType)type;

- (instancetype)initWithFrame:(CGRect)frame
               andPlaceholder:(NSString*)placeholder
             andLeftViewImage:(UIImage *)image
              AndValidateType:(validateType)type;
- (BOOL)validate;
- (BOOL)validatePassWord;

@end
