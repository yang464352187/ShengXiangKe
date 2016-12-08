//
//  PushManager.h
//  SXK
//
//  Created by 杨伟康 on 2016/11/24.
//  Copyright © 2016年 ywk. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PushManagerDelegate <NSObject>

@optional
- (void)pushToVCWithClassName:(NSString *)name info:(NSDictionary *)info;
- (void)presentLoginVC;

@end

@interface PushManager : NSObject

+ (instancetype)sharedManager;

@property (weak,   nonatomic) id<PushManagerDelegate> delegate;

/**
 *  万能跳转－－指定当前界面 跳转
 *
 *  @param name 跳转界面类名
 *  @param info 跳转传递参数
 */
- (void)pushToVCWithClassName:(NSString *)name info:(NSDictionary *)info;

/** 推出登录界面*/
- (void)presentLoginVC;

@end
