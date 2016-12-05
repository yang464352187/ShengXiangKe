//
//  PopView.h
//  SXK
//
//  Created by 杨伟康 on 2016/12/1.
//  Copyright © 2016年 ywk. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PopViewDelegate <NSObject>
// 代理传值方法
- (void)sexual:(NSInteger) tag;

@end


@interface PopView : UIView


@property (weak, nonatomic) id<PopViewDelegate> delegate;


-(instancetype)initWithFrame:(CGRect)fram;
-(void)fillWithTitle:(NSString *)title;

-(void)show;
-(void)show1;
-(void)show2;

@end

