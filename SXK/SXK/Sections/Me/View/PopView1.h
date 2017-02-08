//
//  PopView1.h
//  SXK
//
//  Created by 杨伟康 on 2017/1/23.
//  Copyright © 2017年 ywk. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PopView1Delegate <NSObject>

-(void)success;

@end

@interface PopView1 : UIView

@property (nonatomic, weak)id<PopView1Delegate>delegate;
-(void)changeTitle:(NSString *)title andIdex:(NSInteger)index;
-(void)show;
@property (nonatomic, strong) NSString *oddNumber;

@end
