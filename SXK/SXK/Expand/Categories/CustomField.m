//
//  CustomField.m
//  SXK
//
//  Created by 杨伟康 on 2016/11/24.
//  Copyright © 2016年 ywk. All rights reserved.
//

#import "CustomField.h"

static NSString * const NumAndLetter = @"0123456789qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM";

@interface CustomField ()<UITextFieldDelegate>

@property (strong, nonatomic) NSString *validator;
@property (strong, nonatomic) NSString *showText;

@end

@implementation CustomField

- (instancetype)initWithValidateType:(validateType)type{
    if (self = [super init]) {
        self.validatetype = type;
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame AndValidateType:(validateType)type{
    if (self = [super initWithFrame:frame]) {
        self.validatetype = type;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
               andPlaceholder:(NSString*)placeholder
             andLeftViewImage:(UIImage *)image
              AndValidateType:(validateType)type{
    if ((self = [super initWithFrame:frame]) ) {
        self.validatetype = type;
        self.placeholder              = placeholder;
        self.font                     = SYSTEMFONT(16);
        self.textColor                = APP_COLOR_GRAY_333333;
        //[self setValue:APP_COLOR_GRAY_666666 forKeyPath:@"_placeholderLabel.textColor"];
        UIView *paddingView         = [[UIView alloc] initWithFrame:VIEWFRAME(0, 0, frame.size.height, frame.size.height)];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:VIEWFRAME((frame.size.height-image.size.width)/2, (frame.size.height-image.size.height)/2, image.size.width, image.size.height)];
        imageView.image = image;
        [paddingView addSubview:imageView];
        
        
        self.leftView                 = paddingView;
        self.leftViewMode             = UITextFieldViewModeAlways;
        self.backgroundColor          = [UIColor whiteColor];
        
    }
    return self;
}

- (void)setValidatetype:(validateType)validatetype{
    _validatetype = validatetype;
    [self fieldInit];
}

- (void)fieldInit{
    
    self.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.delegate = self;
    self.showText = @"请输入用户名";
    switch (self.validatetype) {
        case validateTypeDefualt:{
            
            break;
        }
        case validateTypeEmail:{
            self.validator = @"^(\\w)+(\\.\\w+)*@(\\w)+((\\.\\w+)+)$";
            break;
        }
        case validateTypeMobile:{
            self.validator = @"^(1)\\d{10}$";
            self.keyboardType = UIKeyboardTypeNumberPad;
            
            break;
        }
        case validateTypePassWord:{
            self.secureTextEntry = YES;
            self.showText = @"请输入密码";
            break;
        }
        default:
            break;
    }
    
}

#pragma mark -- 验证账号
- (BOOL)validate{
    //判断长度
    if (self.text.length == 0) {
        //[MBProgressHUD showHudTipStr:self.showText];
        
//        POPSpringAnimation *springA = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
//        //springA
//        springA.fromValue = [NSValue valueWithCGPoint:self.center];
//        springA.toValue = [NSValue valueWithCGPoint:CGPointMake(self.center.x+3, self.center.y)];
//
//        springA.springBounciness = 20;
//        springA.springSpeed = 20;
//        [self pop_addAnimation:springA forKey:@"spring"];
        
        CABasicAnimation*animation=[CABasicAnimation
                                    
                                    animationWithKeyPath:@"position.x"];
        animation.duration=0.10;
        animation.repeatCount = 3;
        animation.autoreverses=YES;
        animation.fromValue = @(self.center.x-6);
        animation.toValue = @(self.center.x+6);
        animation.timingFunction = [CAMediaTimingFunction
                                    
                                    functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        [self.layer addAnimation:animation forKey:@"wiggle"];

        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.001 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self becomeFirstResponder];
        });
        return NO;
    }else{
        if (self.validatetype == validateTypePassWord ) {
            if (self.text.length < 6) {
                [ProgressHUDHandler showHudTipStr:@"密码不能少于6位"];
                return NO;
            }else{
                return YES;
            }
        }else if (self.validatetype == validateTypeDefualt){
            return YES;
        }
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", self.validator];
        if ([predicate evaluateWithObject:self.text]) {
            return YES;
        }else{
            switch (self.validatetype) {
                case validateTypeEmail:
                    [ProgressHUDHandler showHudTipStr:@"请输入正确的邮箱"];
                    break;
                case validateTypeMobile:
                    [ProgressHUDHandler showHudTipStr:@"请输入正确的手机号"];
                    break;
                default:
                    break;
            }
            
            return NO;
        }
    }
}


#pragma mark -- 验证密码
- (BOOL)validatePassWord{
    return YES;
}

#pragma mark -- text field delegate

- (void)textFieldDidChange:(UITextField *)textField
{
    if (self.validatetype == validateTypeMobile) {
        if (textField.text.length > 11) {
            textField.text = [textField.text substringToIndex:11];
        }
    }
}

#pragma mark -- field delegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (self.validatetype == validateTypePassWord) {
        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:NumAndLetter] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        return [string isEqualToString:filtered];
    }else{
        return YES;
    }
}



@end
