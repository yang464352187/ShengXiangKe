//
//  CustomHUD.h
//  瀑布流Demo
//
//  Created by yangqijia on 16/5/10.
//  Copyright © 2016年 yangqijia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomHUD : UIView

@property(nonatomic ,strong)UIActivityIndicatorView *activityView;
@property(nonatomic ,strong)UIView  *bgView;
@property(nonatomic ,strong)UILabel *contentlabel;

/**
 *  单例
 *
 *  @return 返回实例对象
 */
+(CustomHUD *)shareCustomHud;

/**
 *  停止并隐藏
 */
+(void)stopHidden;

/**
 *  设置显示内容以及等待时间
 *
 *  @param time    等待时间
 *  @param content 显示内容
 */
+(void)createHudCustomTime:(CGFloat)time showContent:(NSString *)content;

/**
 *  设置显示内容
 *
 *  @param content 显示内容
 */
+(void)createHudCustomShowContent:(NSString *)content;

/**
 *  仅显示提示语
 *
 *  @param content 提示语
 *  @param time    设置隐藏时间
 */
+(void)createShowContent:(NSString *)content hiddenTime:(CGFloat)time;

@end
