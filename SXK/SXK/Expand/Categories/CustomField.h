//
//  CustomField.h
//  SXK
//
//  Created by 杨伟康 on 2016/11/24.
//  Copyright © 2016年 ywk. All rights reserved.
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
