//
//  UserModel.h
//  YuanChenKeeper
//
//  Created by Yhoon on 16/2/1.
//  Copyright © 2016年 com.Qingye.YuanChenKeeper. All rights reserved.
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
