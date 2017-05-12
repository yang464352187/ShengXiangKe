//
//  UserModel.m
//  SXK
//
//  Created by 杨伟康 on 2016/11/24.
//  Copyright © 2016年 ywk. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"PHPSESSID"       :@"PHPSESSID",
             @"userid"          :@"userid",
             @"profile"           :@"profile",
             @"password"        :@"password",
             @"headimgurl"            :@"headimgurl",
             @"mobile"          :@"mobile",
             @"birthday"            :@"birthday",
             @"role"              :@"role",
             @"sex"           :@"sex",
             @"nickname"          :@"nickname",
             @"invitationCode":@"invitationCode"
             };
}

// 读取用户数据模型
+ (UserModel *)readCurLoginUser {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *userDict       = [userDefaults objectForKey:kLoginUserData];
    UserModel *user              = userDict ? [UserModel modelFromDictionary:userDict] : nil;
    return user;
}

// 将用户数据写入系统本地数据库
+ (void)writeUser:(UserModel *)user {
    NSMutableDictionary *userDict       = [[user transformToDictionary] mutableCopy];
//    if (userDict[@"headimgurl"] && userDict[@"headimgurl"] == [NSNull null] ) {
//        [userDict removeObjectForKey:@"headimgurl"];
//    }
    [userDict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if (obj && obj == [NSNull null]) {
            [userDict removeObjectForKey:key];
        }
    }];

    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:userDict forKey:kLoginUserData];
    [userDefaults synchronize];
        NSLog(@"++++%@++++",userDict);
}

- (NSString *)image{
    if (_image && _image.length > 0) {
        return _image;
    }else if (_headimgurl && _headimgurl.length > 0){
        return _headimgurl;
    }else{
        return @"";
    }
    
}

@end
