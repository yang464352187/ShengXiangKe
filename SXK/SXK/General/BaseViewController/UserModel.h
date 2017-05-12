//
//  UserModel.h
//  SXK
//
//  Created by 杨伟康 on 2016/11/24.
//  Copyright © 2016年 ywk. All rights reserved.
//

#import "BaseModel.h"

@interface UserModel : BaseModel

@property (nonatomic, copy) NSString *profile;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, copy) NSString *headimgurl;
@property (nonatomic, copy) NSString *mobile;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *image;
@property (nonatomic, copy) NSString *invitationCode;
@property (nonatomic, strong) NSNumber *userid,*birthday,*role,*sex;


+ (UserModel *)readCurLoginUser;        // 读取当前登录用户信息
+ (void)writeUser:(UserModel *)user;    // 将用户数据写入系统本地数据库

@end
