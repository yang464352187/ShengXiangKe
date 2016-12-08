//
//  UserModel.h
//  SXK
//
//  Created by 杨伟康 on 2016/11/24.
//  Copyright © 2016年 ywk. All rights reserved.
//

#import "BaseModel.h"

@interface UserModel : BaseModel

@property (nonatomic, copy) NSString *mobile;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *image;
@property (nonatomic, copy) NSString *province;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *county;
@property (nonatomic, copy) NSString *headimgurl;
@property (nonatomic, strong) NSNumber *fu,*money,*status,*userid,*updatetime;


+ (UserModel *)readCurLoginUser;        // 读取当前登录用户信息
+ (void)writeUser:(UserModel *)user;    // 将用户数据写入系统本地数据库

@end
