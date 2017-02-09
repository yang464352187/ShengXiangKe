//
//  LoginModel.m
//  YunTShop
//
//  Created by Yhoon on 16/2/1.
//  Copyright © 2016年 com.Qingye.YunTShop. All rights reserved.
//

#import "LoginModel.h"
#import "UserModel.h"

static UserModel *curLoginUser;

@implementation LoginModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"globalKey":@"globalKey",
             @"userName" :@"username",
             @"password" :@"password"
             };
}

// 登录状态方法
+ (BOOL)isLogin {
    BOOL loginState = [[NSUserDefaults standardUserDefaults] boolForKey:kLoginState];
    
    if (loginState) {
        return YES;
    }else {
        return NO;
    }
}

// 用户登录操作,登录成功保存用户数据
+ (void)doLogin:(NSDictionary *)loginUserDict {
    if (loginUserDict) {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setBool:YES forKey:kLoginState];
        [userDefaults setObject:loginUserDict forKey:kLoginUserData];
        [userDefaults synchronize];
    }else {
//        [LoginModel doLoginOut];
    }
}

// 退出登录
//+ (void)doLoginOut {
//    [BaseRequest loginOutWithsuccesBlock:^(id data) {
//        
//    } failue:nil];
//    curLoginUser = nil;
//    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//    [userDefaults setBool:NO forKey:kLoginState];
//    [userDefaults removeObjectForKey:kLoginUserData];
//    [userDefaults synchronize];
//}


// 更新用户数据
+ (void)doUpdateCurrentUser:(NSDictionary *)user{
    if (user) {
//        if (![user[@"updatetime"] isEqualToNumber:curLoginUser.updatetime]) {
//            
//        }
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:user forKey:kLoginUserData];
        [userDefaults synchronize];
        curLoginUser = [UserModel modelFromDictionary:user];
    }
    
}

+ (UserModel *)curLoginUser {
//    if ([curLoginUser.userid stringValue].length > 0) {
        NSDictionary *loginData = [[NSUserDefaults standardUserDefaults] objectForKey:kLoginUserData];
        curLoginUser = loginData ? [UserModel modelFromDictionary:loginData] : nil;
//    }
    return curLoginUser;
}

+ (NSString *)curUserToken{
    if (!curLoginUser) {
        NSDictionary *loginData = [[NSUserDefaults standardUserDefaults] objectForKey:kLoginUserData];
        curLoginUser = loginData ? [UserModel modelFromDictionary:loginData] : nil;
    }
    return curLoginUser.PHPSESSID;
}

// 本地保存登录用户名
+ (void)setPreUserName:(NSString *)userName {
    if (userName.length <= 0) {
        return;
    }
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:userName forKey:kLoginPreUserName];
    [defaults synchronize];
}

// 取出本地保存的用户名
+ (NSString *)preUserName {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:kLoginPreUserName];
}


@end
