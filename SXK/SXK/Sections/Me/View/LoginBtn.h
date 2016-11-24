//
//  LoginBtn.h
//  SXK
//
//  Created by 杨伟康 on 2016/11/17.
//  Copyright © 2016年 ywk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginBtn : UIView

@property(nonatomic, assign)NSInteger LoginTag;

-(instancetype)initWithFrame:(CGRect)frame andImage:(UIImage *)image andTitle:(NSString *)title;

-(void)addTarget:target action:(SEL)action;

@end
