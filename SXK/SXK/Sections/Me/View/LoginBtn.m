//
//  LoginBtn.m
//  SXK
//
//  Created by 杨伟康 on 2016/11/17.
//  Copyright © 2016年 ywk. All rights reserved.
//

#import "LoginBtn.h"

@interface LoginBtn()

@property (nonatomic,weak) id target;
@property (nonatomic, assign) SEL action;

@end


@implementation LoginBtn

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithFrame:(CGRect)frame andImage:(UIImage *)image andTitle:(NSString *)title{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = APP_COLOR_GRAY_333333;
        self.frame = frame;
        [self loadSubViewWithImage:image andTitle:title];
    }
    return self;
}

-(void)loadSubViewWithImage:(UIImage *)image andTitle:(NSString *)title
{

    
    UIImageView *image1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    image1.image = image;
    [self addSubview:image1];
    
    UILabel *title1 = [[UILabel alloc] init];
    title1.text = title;
    title1.textColor = [UIColor whiteColor];
    title1.textAlignment = NSTextAlignmentLeft;
    title1.adjustsFontSizeToFitWidth = YES;
    [self addSubview:title1];
    
    if ([title isEqualToString:@"用BOOBE登录"]) {
        [image1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).offset(18.0000/667*SCREEN_HIGHT);
            make.bottom.equalTo(self.mas_bottom).offset(-15.0000/667*SCREEN_HIGHT);
            make.left.equalTo(self.mas_left).offset(15.0000/375*SCREEN_WIDTH);
            make.width.equalTo(@(45.0000/375*SCREEN_WIDTH));
        }];
    }else if ([title isEqualToString:@"用QQ账号登录"]){
        [image1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).offset(11.0000/667*SCREEN_HIGHT);
            make.bottom.equalTo(self.mas_bottom).offset(-11.0000/667*SCREEN_HIGHT);
            make.left.equalTo(self.mas_left).offset(25.0000/375*SCREEN_WIDTH);
            make.width.equalTo(@(22.0000/375*SCREEN_WIDTH));
        }];
    }
    else{
        [image1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).offset(10.0000/667*SCREEN_HIGHT);
            make.bottom.equalTo(self.mas_bottom).offset(-10.0000/667*SCREEN_HIGHT);
            make.left.equalTo(self.mas_left).offset(25.0000/375*SCREEN_WIDTH);
            make.width.equalTo(@(25.0000/375*SCREEN_WIDTH));
        }];
    }

    
    [title1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(16.0000/667*SCREEN_HIGHT);
        make.bottom.equalTo(self.mas_bottom).offset(-16.0000/667*SCREEN_HIGHT);
        make.left.equalTo(self.mas_left).offset(75.0000/375*SCREEN_WIDTH);
        make.width.equalTo(@(160.0000/375*SCREEN_WIDTH));
    }];
    
}

-(void)addTarget:(id)target action:(SEL)action
{
        self.target = target;
        self.action = action;
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
         //获取触摸对象
         UITouch *touche = [touches anyObject];
         //获取touche的位置
         CGPoint point = [touche locationInView:self];
    
         //判断点是否在button中
         if (CGRectContainsPoint(self.bounds, point))
             {
                     //执行action
                 [self.target performSelector:self.action withObject:self afterDelay:0.0];
             }
}


@end
