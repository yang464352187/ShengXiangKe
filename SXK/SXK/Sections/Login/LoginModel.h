//
//  LoginModel.h
//  YunTShop
//
//  Created by Yhoon on 16/2/1.
//  Copyright © 2016年 com.Qingye.YunTShop. All rights reserved.
//

#import "BaseModel.h"

@interface LoginModel : BaseModel

@property (nonatomic, copy) NSString *userName; // 用户名
@property (nonatomic, copy) NSString *password; // 密码

/**
 *  获取用户登录状态
 *
 *  @return 用户登录状态(YES为已登录,NO为未登录)
 */
+ (BOOL)isLogin;

/**
 *  用户登录
 *
 *  @param loginUserDict 用户信息字典
 */
+ (void)doLogin:(NSDictionary *)loginUserDict;

/** 退出登录*/
//+ (void)doLoginOut;

/** 更新用户数据*/
+ (void)doUpdateCurrentUser:(NSDictionary *)user;

/** 当前用户模型*/
+ (UserModel *)curLoginUser;

/** 当前用户模型*/
+ (NSString *)curUserToken;

/**
 *  本地保存登录用户名
 *
 *  @param userName 输入的用户名
 */
+ (void)setPreUserName:(NSString *)userName;

/**
 *  取出本地保存的用户名
 *
 *  @return 用户名
 */
+ (NSString *)preUserName;

@end
