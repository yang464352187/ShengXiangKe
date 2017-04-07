//
//  BaseRequest.m
//  SXK
//
//  Created by 杨伟康 on 2016/11/11.
//  Copyright © 2016年 ywk. All rights reserved.
//

#import "BaseRequest.h"
#import "UserModel.h"
#import <RongIMKit/RongIMKit.h>

@implementation BaseRequest
+ (instancetype)sharedInstance {
    static BaseRequest *sharedInstance = nil;
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        sharedInstance = [[self alloc] init];
        [NetworkClient sharedInstance];
    });
    return sharedInstance;
}

#pragma mark -- 网络状态
- (AFNetworkReachabilityStatus)status{
    return [[NetworkClient sharedInstance] getStatus];
}


#pragma mark - Common Request
+ (void)requestGetCommonWithPath:(NSString *)aPath Params:(id)params succesBlock:(SuccessBlock)successBlock failue:(FailureBlock)failueBlock {
    
    [self requestCommonWithPath:aPath Params:params withMethodType:NetworkType_Post succesBlock:successBlock failue:failueBlock];
}

+ (void)requestPostCommonWithPath:(NSString *)aPath Params:(id)params succesBlock:(SuccessBlock)successBlock failue:(FailureBlock)failueBlock {
    //NSLog(@"b");
    [self requestCommonWithPath:aPath Params:params withMethodType:NetworkType_Post succesBlock:successBlock failue:failueBlock];
}

+ (void)requestCommonWithPath:(NSString *)aPath Params:(id)params withMethodType:(NetworkType)type succesBlock:(SuccessBlock)successBlock failue:(FailureBlock)failueBlock {
    //NSLog(@"a");
    [[NetworkClient sharedInstance] requestJsonDataWithPath:aPath withParams:params withMethodType:type autoShowError:YES success:^(id data) {
        if (successBlock) {
            successBlock(data);
        }
    } failure:^(id data, NSError *error) {
        if (failueBlock) {
            failueBlock(data,error);
        }
        
    }];
}




/**
 *  注册
 *
 *  @param userName     账号
 *  @param psw          密码
 *  @param verify       验证码
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)registerWithUserName:(NSString *)userName
                    password:(NSString *)psw
                      verify:(NSString *)verify
                 succesBlock:(SuccessBlock)successBlock
                      failue:(FailureBlock)failueBlock{
    NSDictionary *params = @{@"mobile"   : userName,
                             @"password" : psw,
                             @"code"   : verify};
    
    [self requestPostCommonWithPath:APPINTERFACE_Register Params:params succesBlock:^(id data) {
        
        [self loginWithUserName:userName password:psw succesBlock:^(id data) {
            
            if (successBlock) {
                successBlock(data);
            }

        } failue:^(id data, NSError *error) {
            
        }];
        
    } failue:failueBlock];
}


/**
 *  登陆
 *
 *  @param userName     账号
 *  @param psw          密码
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)loginWithUserName:(NSString *)userName
                 password:(NSString *)psw
              succesBlock:(SuccessBlock)successBlock
                   failue:(FailureBlock)failueBlock{
    NSMutableDictionary *params = [@{@"mobile"   : userName,
                                     @"password" : psw,
                                     } mutableCopy];
    
    [self requestPostCommonWithPath:APPINTERFACE_Login Params:params succesBlock:^(id data) {
        //        //登录成功
        NSLog(@"%@",describe(data));
        [LoginModel doLogin:data];

        if (successBlock) {
            successBlock(data);
        }
    } failue:failueBlock];
}

/**
 *  添加收货地址
 *
 *  @param name         姓名
 *  @param phone        电话
 *  @param address      地址
 *  @param state        省份
 *  @param city         城市
 *  @param district      区
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */

+ (void)addAddressWithname:(NSString *)name
                     phone:(NSString *)phone
                     state:(NSString *)state
                      city:(NSString *)city
                  district:(NSString *)district
                   address:(NSString *)address
               succesBlock:(SuccessBlock)successBlock
                    failue:(FailureBlock)failueBlock{
    NSMutableDictionary *params = [@{@"name":name,@"mobile":phone,@"state":state,@"city":city,@"district":district,@"address":address} mutableCopy];
    
    
    [self requestPostCommonWithPath:APPINTERFACE__AddAddress Params:params succesBlock:^(id data) {
        //        //登录成功
                
        if (successBlock) {
            successBlock(data);
        }
    } failue:failueBlock];
    
}

/**
 *  发送验证码
 *
 *  @param mobile       手机号
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */

+ (void)sendSmsWithmobile:(NSString *)mobile
              succesBlock:(SuccessBlock)successBlock
                   failue:(FailureBlock)failueBlock{
    NSDictionary *params = @{@"mobile" : mobile};
    [self requestPostCommonWithPath:APPINTERFACE_SendMob Params:params succesBlock:successBlock failue:failueBlock];
}

/**
 *  忘记密码
 *
 *  @param mobile       手机号
 *  @param psw          密码
 *  @param verify       验证码
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)resetPassWordWithmobile:(NSString *)mobile
                       password:(NSString *)psw
                         verify:(NSString *)verify
                    succesBlock:(SuccessBlock)successBlock
                         failue:(FailureBlock)failueBlock{
    NSDictionary *params = @{@"mobile"      : mobile,
                             @"password"    : psw,
                             @"code"      : verify};
    [self requestPostCommonWithPath:APPINTERFACE_ForgetUserPwd Params:params succesBlock:successBlock failue:failueBlock];
}

/**
 *  获取收获地址
 *  @param pageNo       页码
 *  @param pageSize     页数
 *  @param order        订单
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)getAddressWithPageNo:(NSInteger)pageNo
                    PageSize:(NSInteger)pageSize
                       order:(NSDictionary *)order
                 succesBlock:(SuccessBlock)successBlock
                      failue:(FailureBlock)failueBlock;{
    
    NSDictionary *dic = @{@"receiverid":@-1};
    NSDictionary *params = @{@"pageNo":@(pageNo),
                             @"pageSize":@(pageSize),
                             @"order":dic};
    
    [self requestPostCommonWithPath:APPINTERFACE__GetAddressList Params:params succesBlock:^(id data) {
        //        //登录成功
        
        if (successBlock) {
            successBlock(data);
        }
    } failue:failueBlock];
}

/**
 *  删除收货地址
 *
 *  @param index        位置
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)deleteAddressWithindex:(NSNumber *)index
                   succesBlock:(SuccessBlock)successBlock
                        failue:(FailureBlock)failueBlock{
    NSDictionary *params = @{@"receiverid":index};
    [self requestPostCommonWithPath:APPINTERFACE__DelAddress Params:params succesBlock:^(id data) {
//        [self getAddressWithsuccesBlock:successBlock failue:failueBlock];
        if (successBlock) {
            successBlock(data);
        }

    } failue:failueBlock];
}

/**
 *  添加收货地址
 *
 *  @param name         姓名
 *  @param phone        电话
 *  @param address      地址
 *  @param state        省份
 *  @param city         城市
 *  @param district      区
 *  @param index        地址标示
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */

+ (void)ChangeAddressWithname:(NSString *)name
                        phone:(NSString *)phone
                        state:(NSString *)state
                         city:(NSString *)city
                     district:(NSString *)district
                      address:(NSString *)address
                        index:(NSNumber *)index
                  succesBlock:(SuccessBlock)successBlock
                       failue:(FailureBlock)failueBlock{
    
    NSMutableDictionary *params = [@{@"name":name,
                                     @"mobile":phone,
                                     @"state":state,
                                     @"city":city,
                                     @"district":district,
                                     @"address":address,
                                     @"receiverid":index}
                                     mutableCopy];
    
    [self requestPostCommonWithPath:APPINTERFACE__ChangeAddress Params:params succesBlock:^(id data) {
        
        if (successBlock) {
            successBlock(data);
        }
        
    } failue:failueBlock];
    
}

/**
 *  添加收货地址
 *
 *  @param params       params
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */

+(void)ChangeAddressWithParams:(NSDictionary *)params
                   succesBlock:(SuccessBlock)successBlock
                        failue:(FailureBlock)failueBlock
{
    [self requestPostCommonWithPath:APPINTERFACE__ChangeAddress Params:params succesBlock:^(id data) {
        
        if (successBlock) {
            successBlock(data);
        }
        
    } failue:failueBlock];

}


/**
 *  获取全部品牌
 *  @param pageNo       页码
 *  @param pageSize     页数
 *  @param order        订单
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)GetBrandListWithPageNo:(NSInteger)pageNo
                      PageSize:(NSInteger)pageSize
                         order:(NSInteger)order
                   succesBlock:(SuccessBlock)successBlock
                        failue:(FailureBlock)failueBlock
{
    
    NSDictionary *dic = @{
                          @"name":@(order)
                        };
    NSDictionary *params = @{@"pageNo":@(pageNo),
                             @"pageSize":@(pageSize),
                             @"order":dic};
    
    [self requestPostCommonWithPath:APPINTERFACE__GetBrandlist Params:params succesBlock:^(id data) {
        //        //登录成功
        
        if (successBlock) {
            successBlock(data);
        }
    } failue:failueBlock];
}

/**
 *  获取热门品牌
 *  @param pageNo       页码
 *  @param pageSize     页数
 *  @param order        订单
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)GetBrandHotListWithPageNo:(NSInteger)pageNo
                         PageSize:(NSInteger)pageSize
                            order:(NSInteger)order
                      succesBlock:(SuccessBlock)successBlock
                           failue:(FailureBlock)failueBlock;
{
    NSDictionary *dic = @{
                          @"sort":@(order)
                          };
    NSDictionary *params = @{@"pageNo":@(pageNo),
                             @"pageSize":@(pageSize),
                             @"order":dic};
    
    [self requestPostCommonWithPath:APPINTERFACE__GetBrandHotlist Params:params succesBlock:^(id data) {
        //        //登录成功
        
        if (successBlock) {
            successBlock(data);
        }
    } failue:failueBlock];
}

/**
 *  获取活动列表
 *  @param pageNo       页码
 *  @param pageSize     页数
 *  @param order        订单
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)GetActivityListWithPageNo:(NSInteger)pageNo
                         PageSize:(NSInteger)pageSize
                            order:(NSInteger)order
                      succesBlock:(SuccessBlock)successBlock
                           failue:(FailureBlock)failueBlock;
{
    NSDictionary *dic = @{
                          @"sort":@(order)
                          };
    NSDictionary *params = @{@"pageNo":@(pageNo),
                             @"pageSize":@(pageSize),
                             @"order":dic};
    
    [self requestPostCommonWithPath:APPINTERFACE__GetActivityList Params:params succesBlock:^(id data) {
        //        //登录成功
        
        if (successBlock) {
            successBlock(data);
        }
    } failue:failueBlock];

}

/**
 *  获取活动详情
 *  @param activityid    活动ID
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)GetActivityDetailWithActivityID:(NSInteger)activityid
                            succesBlock:(SuccessBlock)successBlock
                                 failue:(FailureBlock)failueBlock;
{
    NSDictionary *params = @{@"activityid":@(activityid)};
    [self requestPostCommonWithPath:APPINTERFACE__GetActivityDetail Params:params succesBlock:^(id data) {
        //        //登录成功
        
        if (successBlock) {
            successBlock(data);
        }
    } failue:failueBlock];
}

/**
 *  获取分类
 *  @param pageNo       页码
 *  @param pageSize     页数
 *  @param order        订单
 *  @param parentid     分类ID
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)GetCategoryListWithPageNo:(NSInteger)pageNo
                         PageSize:(NSInteger)pageSize
                            order:(NSInteger)order
                         parentid:(NSInteger)parentid
                      succesBlock:(SuccessBlock)successBlock
                           failue:(FailureBlock)failueBlock;
{
    NSDictionary *dic = @{
                          @"sort":@(order)
                          };
    NSDictionary *params = @{@"pageNo":@(pageNo),
                             @"pageSize":@(pageSize),
                             @"order":dic,
                             @"parentid":@(parentid)
                             };
    
    [self requestPostCommonWithPath:APPINTERFACE__GetCategoryList Params:params succesBlock:^(id data) {
        //        //登录成功
        
        if (successBlock) {
            successBlock(data);
        }
    } failue:failueBlock];
    
}

/**
 *  获取社区宣传图片
 *  @param setupid      ID
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)GetCommunityHeadImageWithSetupID:(NSInteger)setupid
                         succesBlock:(SuccessBlock)successBlock
                              failue:(FailureBlock)failueBlock;
{
    NSDictionary *params = @{@"setupid":@(setupid)};
    [self requestPostCommonWithPath:APPINTERFACE__GetCommunityHead Params:params succesBlock:^(id data) {
        //        //登录成功
        
        if (successBlock) {
            successBlock(data);
        }
    } failue:failueBlock];

}

/**
 *  获取活动列表
 *  @param pageNo       页码
 *  @param pageSize     页数
 *  @param order        订单
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)GetCommunityModuleWithPageNo:(NSInteger)pageNo
                            PageSize:(NSInteger)pageSize
                               order:(NSInteger)order
                         succesBlock:(SuccessBlock)successBlock
                              failue:(FailureBlock)failueBlock;
{
    NSDictionary *dic = @{
                          @"sort":@(order)
                          };
    NSDictionary *params = @{@"pageNo":@(pageNo),
                             @"pageSize":@(pageSize),
                             @"order":dic};
    
    [self requestPostCommonWithPath:APPINTERFACE__GetCommunityModule Params:params succesBlock:^(id data) {
        //        //登录成功
        
        if (successBlock) {
            successBlock(data);
        }
    } failue:failueBlock];
    
}

/**
 *  获取话题列表
 *  @param pageNo       页码
 *  @param pageSize     页数
 *  @param topicid      订单
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)GetCommunityTopicListWithPageNo:(NSInteger)pageNo
                               PageSize:(NSInteger)pageSize
                                topicid:(NSInteger)topicid
                               moduleid:(NSInteger)moduleid
                            succesBlock:(SuccessBlock)successBlock
                                 failue:(FailureBlock)failueBlock;
{
    NSDictionary *dic = @{
                          @"topicid":@(topicid)
                          };
    NSDictionary *params = @{@"pageNo":@(pageNo),
                             @"pageSize":@(pageSize),
                             @"order":dic,
                             @"moduleid":@(moduleid)
                             };
    
    [self requestPostCommonWithPath:APPINTERFACE__GetCommunityTopicList Params:params succesBlock:^(id data) {
        //        //登录成功
        
        if (successBlock) {
            successBlock(data);
        }
    } failue:failueBlock];
}


/**
 *  评论
 *  @param topicid      ID
 *  @param comment      评论内容
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)SetCommunityTopicWithTopicID:(NSInteger)topicid
                             comment:(NSString *)comment
                         succesBlock:(SuccessBlock)successBlock
                              failue:(FailureBlock)failueBlock;
{
    NSDictionary *params = @{
                             @"topicid":@(topicid),
                             @"comment":comment
                             };
    
    [self requestPostCommonWithPath:APPINTERFACE__SetCommunityTopic Params:params succesBlock:^(id data) {
        //        //登录成功
        
        if (successBlock) {
            successBlock(data);
        }
    } failue:failueBlock];

}

/**
 *  点赞
 *  @param topicid      ID
 *  @param like         赞
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)SetCommunityTopicWithTopicID:(NSInteger)topicid
                                like:(NSInteger )like
                         succesBlock:(SuccessBlock)successBlock
                              failue:(FailureBlock)failueBlock;
{
    NSDictionary *params = @{
                             @"topicid":@(topicid),
                             @"like":@(like)
                             };
    
    [self requestPostCommonWithPath:APPINTERFACE__SetCommunityTopic Params:params succesBlock:^(id data) {
        //        //登录成功
        if (successBlock) {
            successBlock(data);
        }
        
    } failue:failueBlock];
    

}

/**
 *  发布商品
 *  @param content      内容
 *  @param imgList      图片
 *  @param moduleid     ID
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)AddCommunityTopicWithContent:(NSString *)content
                             imgList:(NSArray *)imgList
                            moduleid:(NSInteger)moduleid
                         succesBlock:(SuccessBlock)successBlock
                              failue:(FailureBlock)failueBlock;
{
    


    
    NSMutableArray *imgArr = [[NSMutableArray alloc] init];
    for (int i = 0; i < imgList.count; i++) {
        NSString *str = imgList[i];

//        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
//        [dic setValue:str forKey:@"image"];
        [imgArr addObject:str];
    }
    
    NSDictionary *params = @{
                             @"content" :content,
                             @"imgList" :imgArr,
                             @"moduleid":@(moduleid)
                             };
    
    
    [self requestPostCommonWithPath:APPINTERFACE__AddCommunityTopic Params:params succesBlock:^(id data) {
        //        //登录成功
        
        if (successBlock) {
            successBlock(data);
        }
        
    } failue:failueBlock];

}


/**
 *  意见反馈
 *  @param content      内容
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)SubmitOpinion:(NSString *)content
          succesBlock:(SuccessBlock)successBlock
               failue:(FailureBlock)failueBlock;
{
    NSDictionary *params = @{
                             @"content" :content
                             };
    [self requestPostCommonWithPath:APPINTERFACE__SubmitOpinion Params:params succesBlock:^(id data) {
        //        //登录成功
        
        if (successBlock) {
            successBlock(data);
        }
        
    } failue:failueBlock];
}
/**
 *  用户协议
 *  @param setupid      ID
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)UserProtocolWithSetupID:(NSInteger)setupid
                    succesBlock:(SuccessBlock)successBlock
                         failue:(FailureBlock)failueBlock;
{
    NSDictionary *params = @{@"setupid":@(1)};
    [self requestPostCommonWithPath:APPINTERFACE__UserProtocol Params:params succesBlock:^(id data) {
        //        //登录成功
        
        if (successBlock) {
            successBlock(data);
        }
    } failue:failueBlock];
}

/**
 *  修改个人信息
 *
 *  @param params       params
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */

+(void)SetPersonalInfoWithParams:(NSDictionary *)params
                     succesBlock:(SuccessBlock)successBlock
                          failue:(FailureBlock)failueBlock;
{
    [self requestPostCommonWithPath:APPINTERFACE__SetPersonalInfo Params:params succesBlock:^(id data) {
        
        UserModel *user = [LoginModel curLoginUser];

        [params enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            if ([key isEqualToString:@"nickname"]) {
                user.nickname = params[@"nickname"];
            }
            if ([key isEqualToString:@"sex"]) {
                user.sex = params[@"sex"];
            }
            
            if ([key isEqualToString:@"headimgurl"]) {
                user.headimgurl = params[@"headimgurl"];
            }
            if ([key isEqualToString:@"birthday"]) {
                user.birthday = params[@"birthday"];
            }
            if ([key isEqualToString:@"profile"]) {
                user.profile = params[@"profile"];
            }

            [UserModel writeUser:user];
//            NSLog(@"--------%@-------",[LoginModel curLoginUser]);

        }];
        
        if (successBlock) {
            successBlock(data);
        }
        
    } failue:failueBlock];

}


/**
 *  获取个人信息
 *
 *  @param params       params
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */

+(void)GetPersonalInfoWithParams:(NSDictionary *)params
                     succesBlock:(SuccessBlock)successBlock
                          failue:(FailureBlock)failueBlock;
{
    
    [self requestPostCommonWithPath:APPINTERFACE__GetPersonalInfo Params:params succesBlock:^(id data) {
        
        UserModel *user = [UserModel modelFromDictionary:data[@"user"]];
        
        [UserModel writeUser:user];
        
        DEFAULTS_SET_OBJ(user.userid, @"userid");
        [BaseRequest ChatWithUserID:[user.userid integerValue] succesBlock:^(id data) {
            
            NSString *str = data[@"token"];
            DEFAULTS_SET_OBJ(str, @"RongYunToken");
            
            
            
            [[RCIM sharedRCIM] connectWithToken:str success:^(NSString *userId) {
                NSLog(@"登陆成功。当前登录的用户ID：%@", userId);
                
            } error:^(RCConnectErrorCode status) {
                NSLog(@"登陆的错误码为:%d", status);
            } tokenIncorrect:^{
                //token过期或者不正确。
                //如果设置了token有效期并且token过期，请重新请求您的服务器获取新的token
                //如果没有设置token有效期却提示token错误，请检查您客户端和服务器的appkey是否匹配，还有检查您获取token的流程。
                NSLog(@"token错误");
            }];
    
        
            
            
            
            
        } failue:^(id data, NSError *error) {
            
        }];
        


        if (successBlock) {
            successBlock(data);
        }
    } failue:failueBlock];

}


/**
 *  发布商品
 *
 *  @param params       params
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */

+(void)ReleaseProductWithParams:(NSDictionary *)params
                    succesBlock:(SuccessBlock)successBlock
                         failue:(FailureBlock)failueBlock;
{
    [self requestPostCommonWithPath:APPINTERFACE__ReleaseProduct Params:params succesBlock:^(id data) {
        
        if (successBlock) {
            successBlock(data);
        }
    } failue:failueBlock];

}


/**
 *  关于啵呗
 *  @param setupid      ID
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)AboutBoobelWithSetupID:(NSInteger)setupid
                   succesBlock:(SuccessBlock)successBlock
                        failue:(FailureBlock)failueBlock;
{
    NSDictionary *params = @{@"setupid":@(1)};
    [self requestPostCommonWithPath:APPINTERFACE__AboutSetup Params:params succesBlock:^(id data) {
        //        //登录成功
        
        if (successBlock) {
            successBlock(data);
        }
    } failue:failueBlock];

}

/**
 *  获取养护列表
 *  @param pageNo       页码
 *  @param pageSize     页数
 *  @param order        订单
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)GetMaintainListWithPageNo:(NSInteger)pageNo
                        PageSize:(NSInteger)pageSize
                           order:(NSInteger)order
                     succesBlock:(SuccessBlock)successBlock
                          failue:(FailureBlock)failueBlock;
{
    NSDictionary *dic = @{
                          @"sort":@(order)
                          };
    NSDictionary *params = @{@"pageNo":@(pageNo),
                             @"pageSize":@(pageSize),
                             @"order":dic};
    
    [self requestPostCommonWithPath:APPINTERFACE__GetMaintainList Params:params succesBlock:^(id data) {
        //        //登录成功
        
        if (successBlock) {
            successBlock(data);
        }
    } failue:failueBlock];
}

/**
 *  获取养护
 *  @param maintainid      ID
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)GetMaintainWithMaintainid:(NSInteger)maintainid
                      succesBlock:(SuccessBlock)successBlock
                           failue:(FailureBlock)failueBlock;
{
    NSDictionary *params = @{@"maintainid":@(maintainid)};
    [self requestPostCommonWithPath:APPINTERFACE__GetMaintain Params:params succesBlock:^(id data) {
        //        //登录成功
        
        if (successBlock) {
            successBlock(data);
        }
    } failue:failueBlock];
}


/**
 *  获取养护二级分类列表
 *  @param pageNo       页码
 *  @param pageSize     页数
 *  @param order        订单
 *  @param classifyid   分类ID
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)GetMaintainListWithPageNo:(NSInteger)pageNo
                         PageSize:(NSInteger)pageSize
                            order:(NSInteger)order
                       classifyid:(NSInteger)classifyid
                      succesBlock:(SuccessBlock)successBlock
                           failue:(FailureBlock)failueBlock;
{
    NSDictionary *dic = @{
                          @"sort":@(order)
                          };
    NSDictionary *params = @{@"pageNo":@(pageNo),
                             @"pageSize":@(pageSize),
                             @"order":dic,
                             @"classifyid":@(classifyid)
                             };
    
    [self requestPostCommonWithPath:APPINTERFACE__GetMaintainList Params:params succesBlock:^(id data) {
        //        //登录成功
        
        if (successBlock) {
            successBlock(data);
        }
    } failue:failueBlock];
}

/**
 *  中检鉴定
 *  @param setupid      ID
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)AppraiseWithSetupID:(NSInteger)setupid
                succesBlock:(SuccessBlock)successBlock
                     failue:(FailureBlock)failueBlock;
{
    NSDictionary *params = @{@"setupid":@(1)};
    [self requestPostCommonWithPath:APPINTERFACE__GetAppraise Params:params succesBlock:^(id data) {
        //        //登录成功
        
        if (successBlock) {
            successBlock(data);
        }
    } failue:failueBlock];
}

/**
 *  获取我的发布列表
 *  @param pageNo       页码
 *  @param pageSize     页数
 *  @param order        订单
 *  @param status       状态
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)GetTenancyListWithPageNo:(NSInteger)pageNo
                        PageSize:(NSInteger)pageSize
                           order:(NSInteger)order
                          status:(NSInteger)status
                     succesBlock:(SuccessBlock)successBlock
                          failue:(FailureBlock)failueBlock;
{
    NSDictionary *dic = @{
                          @"rentid":@(order)
                          };
    NSDictionary *params = @{@"pageNo":@(pageNo),
                             @"pageSize":@(pageSize),
                             @"order":dic,
                             @"own":@(1),
                             @"status":@(status)
                             };
    
    [self requestPostCommonWithPath:APPINTERFACE__GetTenancyList Params:params succesBlock:^(id data) {
        //        //登录成功
        if (successBlock) {
            successBlock(data);
        }
    } failue:failueBlock];

}

/**
 *  获取我的养护列表
 *  @param pageNo       页码
 *  @param pageSize     页数
 *  @param order        订单
 *  @param status       状态
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)GetRentorderListWithPageNo:(NSInteger)pageNo
                        PageSize:(NSInteger)pageSize
                           order:(NSInteger)order
                          status:(NSInteger)status
                     succesBlock:(SuccessBlock)successBlock
                          failue:(FailureBlock)failueBlock;
{
    NSDictionary *dic = @{
                          @"orderid":@(order)
                          };
    NSDictionary *params = @{@"pageNo":@(pageNo),
                             @"pageSize":@(pageSize),
                             @"order":dic,
                             @"own":@(1),
                             @"status":@(status)
                             };
    
    [self requestPostCommonWithPath:APPINTERFACE__GetRentorderList Params:params succesBlock:^(id data) {
        //        //登录成功
        if (successBlock) {
            successBlock(data);
        }
    } failue:failueBlock];
    
}





/**
 *  产品详情
 *  @param rentID       ID
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)GetProductlWithRentID:(NSInteger)rentID
                  succesBlock:(SuccessBlock)successBlock
                       failue:(FailureBlock)failueBlock;
{
    NSDictionary *params = @{@"rentid":@(rentID)};
    [self requestPostCommonWithPath:APPINTERFACE__ProductDeta Params:params succesBlock:^(id data) {
        //        //登录成功
        
        if (successBlock) {
            successBlock(data);
        }
    } failue:failueBlock];

}

/**
 *  产品详情
 *  @param purchaseid       ID
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)GetProductlWithPurchaseid:(NSInteger)purchaseid
                  succesBlock:(SuccessBlock)successBlock
                       failue:(FailureBlock)failueBlock;
{
    NSDictionary *params = @{@"purchaseid":@(purchaseid)};
    [self requestPostCommonWithPath:APPINTERFACE__PurchaseProductDetail Params:params succesBlock:^(id data) {
        //        //登录成功
        
        if (successBlock) {
            successBlock(data);
        }
    } failue:failueBlock];
    
}



/**
 *  创建订单
 *
 *  @param params       params
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */

+(void)CreatOrderWithParams:(NSDictionary *)params
                succesBlock:(SuccessBlock)successBlock
                     failue:(FailureBlock)failueBlock;
{
    [self requestPostCommonWithPath:APPINTERFACE__CreateOrder Params:params succesBlock:^(id data) {
        
        if (successBlock) {
            successBlock(data);
        }
        
    } failue:failueBlock];

}



/**
 *  设置默认地址
 *  @param isDefault     BOOL
 *  @param receiverid    地址ID
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)SetPretermitAddressWithRentID:(NSInteger)isDefault
                           ReceiverID:(NSInteger)receiverid
                          succesBlock:(SuccessBlock)successBlock
                               failue:(FailureBlock)failueBlock;
{
    NSDictionary *params = @{
                            @"isdefault":@(isDefault),
                            @"receiverid":@(receiverid)
                            };
    
    [self requestPostCommonWithPath:APPINTERFACE__ChangeAddress Params:params succesBlock:^(id data) {
        //        //登录成功
        
        if (successBlock) {
            successBlock(data);
        }
    } failue:failueBlock];

}


/**
 *  支付
 *  @param channel        支付类型
 *  @param orderid     订单ID
 *  @param type        类型
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)PayWithChannel:(NSString *)channel
               orderID:(NSInteger)orderid
                  type:(NSInteger)type
           succesBlock:(SuccessBlock)successBlock
                failue:(FailureBlock)failueBlock;
{
    NSDictionary *params = @{
                             @"channel":channel,
                             @"orderid":@(orderid),
                             @"type":@(type)
                             };
    [self requestPostCommonWithPath:APPINTERFACE__Pay Params:params succesBlock:^(id data) {
        //        //登录成功
        
        if (successBlock) {
            successBlock(data);
        }
    } failue:failueBlock];

}


/**
 *  获取用户
 *  @param userID       ID
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)GetUserWithuserID:(NSInteger)userID
              succesBlock:(SuccessBlock)successBlock
                   failue:(FailureBlock)failueBlock;
{
    NSDictionary *params = @{@"userid":@(userID)};
    [self requestPostCommonWithPath:APPINTERFACE__GetUser Params:params succesBlock:^(id data) {
        //        //登录成功
        
        if (successBlock) {
            successBlock(data);
        }
    } failue:failueBlock];

}

/**
 *  获取首页轮播图
 *  @param setupid       ID
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)GetAdvertisesetupWithSetupID:(NSInteger)setupid
                         succesBlock:(SuccessBlock)successBlock
                              failue:(FailureBlock)failueBlock;
{
    NSDictionary *params = @{@"setupid":@(setupid)};
    [self requestPostCommonWithPath:APPINTERFACE__Advertisesetup Params:params succesBlock:^(id data) {
        //        //登录成功
        
        if (successBlock) {
            successBlock(data);
        }
    } failue:failueBlock];

}


/**
 *  获取左侧轮播图
 *  @param setupid       ID
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)GetLeftSetupWithSetupID:(NSInteger)setupid
                    succesBlock:(SuccessBlock)successBlock
                         failue:(FailureBlock)failueBlock;
{
    NSDictionary *params = @{@"setupid":@(setupid)};
    [self requestPostCommonWithPath:APPINTERFACE__HomeLeftSetup Params:params succesBlock:^(id data) {
        //        //登录成功
        
        if (successBlock) {
            successBlock(data);
        }
    } failue:failueBlock];

}

/**
 *  获取右上轮播图
 *  @param setupid       ID
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)GetRightUpSetupWithSetupID:(NSInteger)setupid
                       succesBlock:(SuccessBlock)successBlock
                            failue:(FailureBlock)failueBlock;
{
    NSDictionary *params = @{@"setupid":@(setupid)};
    [self requestPostCommonWithPath:APPINTERFACE__HomeRightUpSetup Params:params succesBlock:^(id data) {
        //        //登录成功
        
        if (successBlock) {
            successBlock(data);
        }
    } failue:failueBlock];

}
/**
 *  获取右下轮播图
 *  @param setupid       ID
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)GetRightDownSetupWithSetupID:(NSInteger)setupid
                         succesBlock:(SuccessBlock)successBlock
                              failue:(FailureBlock)failueBlock;
{
    NSDictionary *params = @{@"setupid":@(setupid)};
    [self requestPostCommonWithPath:APPINTERFACE__HomeRightDownSetup Params:params succesBlock:^(id data) {
        //        //登录成功
        
        if (successBlock) {
            successBlock(data);
        }
    } failue:failueBlock];

}


/**
 *  获取首页精选列表
 *  @param pageNo       页码
 *  @param pageSize     页数
 *  @param order        订单
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)GetHomeClassListWithPageNo:(NSInteger)pageNo
                          PageSize:(NSInteger)pageSize
                             order:(NSInteger)order
                       succesBlock:(SuccessBlock)successBlock
                            failue:(FailureBlock)failueBlock;
{
    NSDictionary *dic = @{
                          @"sort":@(order)
                          };
    NSDictionary *params = @{@"pageNo":@(pageNo),
                             @"pageSize":@(pageSize),
                             @"order":dic};
    
    [self requestPostCommonWithPath:APPINTERFACE__HomeClassList Params:params succesBlock:^(id data) {
        
        if (successBlock) {
            successBlock(data);
        }
    } failue:failueBlock];
}


/**
 *  获取精选分类
 *  @param classid       ID
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)GetHomeClassWithSetupID:(NSInteger)classid
                    succesBlock:(SuccessBlock)successBlock
                         failue:(FailureBlock)failueBlock;
{
    NSDictionary *params = @{@"classid":@(classid)};
    [self requestPostCommonWithPath:APPINTERFACE__HomeClass Params:params succesBlock:^(id data) {
        
        if (successBlock) {
            successBlock(data);
        }
    } failue:failueBlock];

}


/**
 *  获取首页热门列表
 *  @param pageNo       页码
 *  @param pageSize     页数
 *  @param order        订单
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)GetHomeTopicListWithPageNo:(NSInteger)pageNo
                          PageSize:(NSInteger)pageSize
                             order:(NSInteger)order
                       succesBlock:(SuccessBlock)successBlock
                            failue:(FailureBlock)failueBlock;{
    NSDictionary *dic = @{
                          @"sort":@(order)
                          };
    NSDictionary *params = @{@"pageNo":@(pageNo),
                             @"pageSize":@(pageSize),
                             @"order":dic};
    
    [self requestPostCommonWithPath:APPINTERFACE__HomeTopicList Params:params succesBlock:^(id data) {
        
        if (successBlock) {
            successBlock(data);
        }
    } failue:failueBlock];
}

/**
 *  获取话题
 *  @param topicid       ID
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)GetHomeTopicWithSetupID:(NSInteger)topicid
                    succesBlock:(SuccessBlock)successBlock
                         failue:(FailureBlock)failueBlock;{
    NSDictionary *params = @{@"topicid":@(topicid)};
    [self requestPostCommonWithPath:APPINTERFACE__HomeTopic Params:params succesBlock:^(id data) {
        
        if (successBlock) {
            successBlock(data);
        }
    } failue:failueBlock];

}


/**
 *  第三方登录
 *  @param openid       ID
 *  @param nickname     昵称
 *  @param headimgurl   头像地址
 *  @param pf           类型
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)ThirdLoginWithOpenID:(NSString *)openid
                    nickname:(NSString *)nickname
                  headimgurl:(NSString *)headimgurl
                          pf:(NSInteger)pf
                 succesBlock:(SuccessBlock)successBlock
                      failue:(FailureBlock)failueBlock;
{
    NSDictionary *params = @{@"openid":openid,
                             @"nickname":nickname,
                             @"headimgurl":headimgurl,
                             @"pf":@(pf)
                             };
    
    [self requestPostCommonWithPath:APPINTERFACE__ThirdLogin Params:params succesBlock:^(id data) {
        [LoginModel doLogin:data];

        if (successBlock) {
            successBlock(data);
        }
    } failue:failueBlock];

}

/**
 *  获取默认地址
 *  @param receiverid       ID
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)GetAddressWithReceiverid:(NSInteger)receiverid
                     succesBlock:(SuccessBlock)successBlock
                          failue:(FailureBlock)failueBlock;
{
    NSDictionary *params = @{};
    [self requestPostCommonWithPath:APPINTERFACE__GetAddress Params:params succesBlock:^(id data) {
        
        if (successBlock) {
            successBlock(data);
        }
    } failue:failueBlock];

}

/**
 *  获取问答列表
 *  @param pageNo       页码
 *  @param pageSize     页数
 *  @param order        订单
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)GetQuestionListWithPageNo:(NSInteger)pageNo
                         PageSize:(NSInteger)pageSize
                            order:(NSInteger)order
                      succesBlock:(SuccessBlock)successBlock
                           failue:(FailureBlock)failueBlock;
{
    NSDictionary *dic = @{
                          @"sort":@(order)
                          };
    NSDictionary *params = @{@"pageNo":@(pageNo),
                             @"pageSize":@(pageSize),
                             @"order":dic};
    
    [self requestPostCommonWithPath:APPINTERFACE__GetQuestionList Params:params succesBlock:^(id data) {
        
        if (successBlock) {
            successBlock(data);
        }
    } failue:failueBlock];
}

/**
 *  获取服务中心详情
 *  @param setupid       ID
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)GetServiceDetailWithSetupID:(NSInteger)setupid
                                url:(NSString *)url
                        succesBlock:(SuccessBlock)successBlock
                             failue:(FailureBlock)failueBlock;
{
    NSDictionary *params = @{@"setupid":@(setupid)};
    [self requestPostCommonWithPath:url Params:params succesBlock:^(id data) {
        
        if (successBlock) {
            successBlock(data);
        }
    } failue:failueBlock];
    
}


/**
 *  添加关注
 *  @param userid       ID
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)AddFollowWithUserID:(NSInteger)userid
                succesBlock:(SuccessBlock)successBlock
                     failue:(FailureBlock)failueBlock;
{
    NSDictionary *params = @{@"userid":@(userid)};
    [self requestPostCommonWithPath:APPINTERFACE__AddFollow Params:params succesBlock:^(id data) {
        
        if (successBlock) {
            successBlock(data);
        }
    } failue:failueBlock];

}


/**
 *  关注列表
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)GetFollowListsuccesBlock:(SuccessBlock)successBlock
                          failue:(FailureBlock)failueBlock;
{
    NSDictionary *params = @{};
    [self requestPostCommonWithPath:APPINTERFACE__GetFollowList Params:params succesBlock:^(id data) {
        
        if (successBlock) {
            successBlock(data);
        }
    } failue:failueBlock];

}

/**
 *  添加关注
 *  @param userid       ID
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)DeleteFollowWithUserID:(NSInteger)userid
                   succesBlock:(SuccessBlock)successBlock
                        failue:(FailureBlock)failueBlock;
{
    NSDictionary *params = @{@"userid":@(userid)};
    [self requestPostCommonWithPath:APPINTERFACE__DeleteFollow Params:params succesBlock:^(id data) {
        
        if (successBlock) {
            successBlock(data);
        }
    } failue:failueBlock];
}


/**
 *  收藏
 *  @param rentid       ID
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)AddKeepWithRentID:(NSInteger)rentid
              succesBlock:(SuccessBlock)successBlock
                   failue:(FailureBlock)failueBlock;
{
    NSDictionary *params = @{@"rentid":@(rentid)};
    [self requestPostCommonWithPath:APPINTERFACE__AddKeep Params:params succesBlock:^(id data) {
        
        if (successBlock) {
            successBlock(data);
        }
    } failue:failueBlock];
}


/**
 *  收藏列表
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)GetKeepListsuccesBlock:(SuccessBlock)successBlock
                        failue:(FailureBlock)failueBlock;
{
    NSDictionary *params = @{};
    [self requestPostCommonWithPath:APPINTERFACE__GetKeepList Params:params succesBlock:^(id data) {
        
        if (successBlock) {
            successBlock(data);
        }
    } failue:failueBlock];

}

/**
 *  取消关注
 *  @param rentid       ID
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)CancelKeepWithRentID:(NSInteger)rentid
                 succesBlock:(SuccessBlock)successBlock
                      failue:(FailureBlock)failueBlock;
{
    NSDictionary *params = @{@"rentid":@(rentid)};
    [self requestPostCommonWithPath:APPINTERFACE__CancelKeep Params:params succesBlock:^(id data) {
        
        if (successBlock) {
            successBlock(data);
        }
    } failue:failueBlock];

}


/**
 *  创建养护订单
 *  @param maintainid   养护ID
 *  @param receiverid   地址ID
 *  @param price        价格
 *  @param message      留言
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)CreateMaintainWithMaintainid:(NSInteger)maintainid
                          receiverid:(NSInteger)receiverid
                               price:(NSInteger)price
                             message:(NSString *)message
                         succesBlock:(SuccessBlock)successBlock
                              failue:(FailureBlock)failueBlock;
{
    NSDictionary *params = @{@"maintainid":@(maintainid),
                             @"receiverid":@(receiverid),
                             @"total":@(price),
                             @"message":message
                             };
    [self requestPostCommonWithPath:APPINTERFACE__CreateMaintainOrder Params:params succesBlock:^(id data) {
        
        if (successBlock) {
            successBlock(data);
        }
    } failue:failueBlock];

}


/**
 *  身份认证
 *
 *  @param params       params
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */

+(void)VerifyIdetityWithParams:(NSDictionary *)params
                   succesBlock:(SuccessBlock)successBlock
                        failue:(FailureBlock)failueBlock;
{
    [self requestPostCommonWithPath:APPINTERFACE__SetPersonalInfo Params:params succesBlock:^(id data) {
        if (successBlock) {
            successBlock(data);
        }

    } failue:failueBlock];

}

/**
 *  删除租赁订单
 *  @param rentid       ID
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)DeleteRentOrderWithRentID:(NSInteger)rentid
                      succesBlock:(SuccessBlock)successBlock
                           failue:(FailureBlock)failueBlock;
{
    NSDictionary *params = @{@"rentid":@(rentid)};
    [self requestPostCommonWithPath:APPINTERFACE__DeleteRentOrder Params:params succesBlock:^(id data) {
        
        if (successBlock) {
            successBlock(data);
        }
    } failue:failueBlock];

}


/**
 *  下架租赁订单
 *  @param rentid       ID
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)UnderCarriageOrderWithRentID:(NSInteger)rentid
                         succesBlock:(SuccessBlock)successBlock
                              failue:(FailureBlock)failueBlock;
{
    
    NSDictionary *params = @{
                             @"rentid":@(rentid),
                             @"status":@(4)
                             };
    [self requestPostCommonWithPath:APPINTERFACE__ChangeRentOrder Params:params succesBlock:^(id data) {
        
        if (successBlock) {
            successBlock(data);
        }
    } failue:failueBlock];

}

/**
 *  确认回收订单
 *  @param rentid       ID
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)RecoverOrderWithRentID:(NSInteger)rentid
                     oddNumber:(NSString *)oddNumber
                   succesBlock:(SuccessBlock)successBlock
                        failue:(FailureBlock)failueBlock;
{
    NSDictionary *params;
    if (oddNumber.length == 0 ) {
        params = @{
                    @"rentid":@(rentid),
                    @"status":@(2),
                };
    }else{
        params = @{
                    @"rentid":@(rentid),
                    @"status":@(2),
                    @"oddNumber":oddNumber,
                };
    }
    
    [self requestPostCommonWithPath:APPINTERFACE__ChangeRentOrder Params:params succesBlock:^(id data) {
        
        if (successBlock) {
            successBlock(data);
        }
    } failue:failueBlock];

}


/**
 *  获取我的养护列表
 *  @param pageNo       页码
 *  @param pageSize     页数
 *  @param order        订单
 *  @param status       状态
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)GetMyMaintainListWithPageNo:(NSInteger)pageNo
                           PageSize:(NSInteger)pageSize
                              order:(NSInteger)order
                             status:(NSInteger)status
                        succesBlock:(SuccessBlock)successBlock
                             failue:(FailureBlock)failueBlock;
{
    NSDictionary *dic = @{
                          @"orderid":@(order)
                          };
    NSDictionary *params = @{@"pageNo":@(pageNo),
                             @"pageSize":@(pageSize),
                             @"order":dic,
                             @"own":@(1),
                             @"status":@(status)
                             };
    
    [self requestPostCommonWithPath:APPINTERFACE__GetMyMaintainList Params:params succesBlock:^(id data) {
        //        //登录成功
        if (successBlock) {
            successBlock(data);
        }
    } failue:failueBlock];

}


/**
 *  确认养护订单
 *  @param orderid      ID
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)ConfirmMyMaintainOrderWithOrderID:(NSInteger)orderid
                              succesBlock:(SuccessBlock)successBlock
                                   failue:(FailureBlock)failueBlock;
{
    NSDictionary *params = @{
                             @"orderid":@(orderid),
                             @"status":@(3),
                             };
    [self requestPostCommonWithPath:APPINTERFACE__ConfirmMyMaintainOrder Params:params succesBlock:^(id data) {
        
        if (successBlock) {
            successBlock(data);
        }
    } failue:failueBlock];
}


/**
 *  获取我的鉴定列表
 *  @param pageNo       页码
 *  @param pageSize     页数
 *  @param order        订单
 *  @param status       状态
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)GetMyAppraiseListWithPageNo:(NSInteger)pageNo
                           PageSize:(NSInteger)pageSize
                              order:(NSInteger)order
                             status:(NSInteger)status
                        succesBlock:(SuccessBlock)successBlock
                             failue:(FailureBlock)failueBlock;
{
    NSDictionary *dic = @{
                          @"orderid":@(order)
                          };
    NSDictionary *params = @{@"pageNo":@(pageNo),
                             @"pageSize":@(pageSize),
                             @"order":dic,
                             @"status":@(status)
                             };
    
    [self requestPostCommonWithPath:APPINTERFACE__GetMyAppraiseList Params:params succesBlock:^(id data) {
        //        //登录成功
        if (successBlock) {
            successBlock(data);
        }
    } failue:failueBlock];

}

/**
 *  创建鉴定订单
 *  @param receiverid   地址id
 *  @param brandid      品牌id
 *  @param genreid      类别id
 *  @param total        价格
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)CreateAppraiseOrderWithReceiverid:(NSInteger)receiverid
                                  brandid:(NSInteger)brandid
                                  genreid:(NSInteger)genreid
                                    total:(NSInteger)total
                              succesBlock:(SuccessBlock)successBlock
                                   failue:(FailureBlock)failueBlock;
{
    NSDictionary *params = @{
                             @"receiverid":@(receiverid),
                             @"brandid":@(brandid),
                             @"genreid":@(genreid),
                             @"total":@(total),
                             @"setupid":@(1)
                             };
    [self requestPostCommonWithPath:APPINTERFACE__CreateAppraiseOrder Params:params succesBlock:^(id data) {
        
        if (successBlock) {
            successBlock(data);
        }
    } failue:failueBlock];
    
}

/**
 *  获取啵呗秀列表
 *  @param setupid       ID
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)GetShowSetupListWithSetupID:(NSInteger)setupid
                        succesBlock:(SuccessBlock)successBlock
                             failue:(FailureBlock)failueBlock;
{
    NSDictionary *params = @{@"setupid":@(setupid)};
    [self requestPostCommonWithPath:APPINTERFACE__HomeShowSetupList Params:params succesBlock:^(id data) {
        
        if (successBlock) {
            successBlock(data);
        }
    } failue:failueBlock];

}


/**
 *  获取来换包列表
 *  @param setupid       ID
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)GetSwapSetupListWithSetupID:(NSInteger)setupid
                        succesBlock:(SuccessBlock)successBlock
                             failue:(FailureBlock)failueBlock;
{
    NSDictionary *params = @{@"setupid":@(setupid)};
    [self requestPostCommonWithPath:APPINTERFACE__HomeSwapSetupList Params:params succesBlock:^(id data) {
        
        if (successBlock) {
            successBlock(data);
        }
    } failue:failueBlock];

}


/**
 *  确认收货
 *  @param rentid       ID
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)ConfirmOrderWithRentID:(NSInteger)rentid
                   succesBlock:(SuccessBlock)successBlock
                        failue:(FailureBlock)failueBlock;
{
       NSDictionary * params = @{
                   @"orderid":@(rentid),
                   @"status":@(3),
                                };
    
    [self requestPostCommonWithPath:APPINTERFACE__ConfirmMyRentOrder Params:params succesBlock:^(id data) {
        
        if (successBlock) {
            successBlock(data);
        }
    } failue:failueBlock];
    
}

/**
 *  退回
 *  @param rentid       ID
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)ConfirmOrderWithRentID:(NSInteger)rentid
                 backOddNumber:(NSString *)backOddNumber
                   succesBlock:(SuccessBlock)successBlock
                        failue:(FailureBlock)failueBlock;
{
    NSDictionary * params = @{
                              @"orderid":@(rentid),
//                              @"status":@(3),
                              @"backOddNumber":backOddNumber,
                              };
    
    [self requestPostCommonWithPath:APPINTERFACE__ConfirmMyRentOrder Params:params succesBlock:^(id data) {
        
        if (successBlock) {
            successBlock(data);
        }
    } failue:failueBlock];
}

/**
 *  发布评论
 *  @param content      内容
 *  @param imgList      图片
 *  @param orderid     ID
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)AddRentCommentWithContent:(NSString *)content
                          imgList:(NSArray *)imgList
                          orderid:(NSInteger)orderid
                      succesBlock:(SuccessBlock)successBlock
                           failue:(FailureBlock)failueBlock;
{
    
    NSMutableArray *imgArr = [[NSMutableArray alloc] init];
    for (int i = 0; i < imgList.count; i++) {
        NSString *str = imgList[i];
        
        //        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        //        [dic setValue:str forKey:@"image"];
        [imgArr addObject:str];
    }
    
    NSDictionary *params = @{
                             @"content" :content,
                             @"imgList" :imgArr,
                             @"orderid":@(orderid)
                             };
    
    
    [self requestPostCommonWithPath:APPINTERFAXE__RentComment Params:params succesBlock:^(id data) {
        //        //登录成功
        
        if (successBlock) {
            successBlock(data);
        }
        
    } failue:failueBlock];

}

/**
 *  融云聊天
 *  @param userid       ID
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)ChatWithUserID:(NSInteger)userid
           succesBlock:(SuccessBlock)successBlock
                failue:(FailureBlock)failueBlock;
{
    NSDictionary *params = @{@"userid":@(userid)};
    [self requestPostCommonWithPath:APPINTERFACE__ChatWithUser Params:params succesBlock:^(id data) {
        
        if (successBlock) {
            successBlock(data);
        }
    } failue:failueBlock];

}


/**
 *  获取热门品牌
 *  @param pageNo       页码
 *  @param pageSize     页数
 *  @param order        订单
 *  @param categoryid   类别id
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)GetCategoryHotListWithPageNo:(NSInteger)pageNo
                           PageSize:(NSInteger)pageSize
                              order:(NSInteger)order
                         categoryid:(NSInteger)categoryid
                        succesBlock:(SuccessBlock)successBlock
                             failue:(FailureBlock)failueBlock;
{
    NSDictionary *dic = @{
                          @"sort":@(order)
                          };
    NSDictionary *params = @{
                             @"pageNo":@(pageNo),
                             @"pageSize":@(pageSize),
                             @"order":dic,
                             @"categoryid":@(categoryid)
                             };
    
    [self requestPostCommonWithPath:APPINTERFACE__GetCategoryHotList Params:params succesBlock:^(id data) {
        //        //登录成功
        
        
        if (successBlock) {
            successBlock(data);
        }
    } failue:failueBlock];
}



/**
 *  获取租赁列表
 *  @param pageNo       页码
 *  @param pageSize     页数
 *  @param order        订单
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)GetRentListWithPageNo:(NSInteger)pageNo
                     PageSize:(NSInteger)pageSize
                        order:(NSInteger)order
                       brandid:(NSInteger)brandid
                  succesBlock:(SuccessBlock)successBlock
                       failue:(FailureBlock)failueBlock;
{
    NSDictionary *dic = @{
                          @"rentid":@(order)
                          };
    NSDictionary *params = @{@"pageNo":@(pageNo),
                             @"pageSize":@(pageSize),
                             @"order":dic,
                             @"brandid":@(brandid)
                             };
    
    [self requestPostCommonWithPath:APPINTERFACE__GetTenancyList Params:params succesBlock:^(id data) {
        //        //登录成功
        
        if (successBlock) {
            successBlock(data);
        }
    } failue:failueBlock];
    
}

/**
 *  获取租赁列表
 *  @param pageNo       页码
 *  @param pageSize     页数
 *  @param order        订单
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)GetRentList1WithPageNo:(NSInteger)pageNo
                     PageSize:(NSInteger)pageSize
                        order:(NSInteger)order
                   categoryid:(NSInteger)categoryid
                  succesBlock:(SuccessBlock)successBlock
                       failue:(FailureBlock)failueBlock;
{
    NSDictionary *dic = @{
                          @"rentid":@(order)
                          };
    NSDictionary *params = @{@"pageNo":@(pageNo),
                             @"pageSize":@(pageSize),
                             @"order":dic,
                             @"categoryid":@(categoryid)
                             };
    
    [self requestPostCommonWithPath:APPINTERFACE__GetTenancyList Params:params succesBlock:^(id data) {
        //        //登录成功
        
        if (successBlock) {
            successBlock(data);
        }
    } failue:failueBlock];
    
}
/**
 *  充值
 *  @param amount       金额
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)SetRechargeorderWithAmount:(NSInteger)amount
                       succesBlock:(SuccessBlock)successBlock
                            failue:(FailureBlock)failueBlock;
{
    NSDictionary *params = @{@"amount":@(amount)};
    [self requestPostCommonWithPath:APPINTERFACE__RechargeOrder Params:params succesBlock:^(id data) {
        
        if (successBlock) {
            successBlock(data);
        }
    } failue:failueBlock];

}

/**
 *  用户协议
 *  @param setupid      ID
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)RewardSetupWithSetupID:(NSInteger)setupid
                   succesBlock:(SuccessBlock)successBlock
                        failue:(FailureBlock)failueBlock;
{
    
    NSDictionary *params = @{@"setupid":@(1)};
    [self requestPostCommonWithPath:APPINTERFACE__RewardSetup Params:params succesBlock:^(id data) {
        //        //登录成功
        
        if (successBlock) {
            successBlock(data);
        }
    } failue:failueBlock];
}


/**
 *  绑定手机号码
 *
 *  @param params       params
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */

+(void)SetMobileWithParams:(NSDictionary *)params
               succesBlock:(SuccessBlock)successBlock
                    failue:(FailureBlock)failueBlock;
{
    [self requestPostCommonWithPath:APPINTERFACE__SetPersonalInfo Params:params succesBlock:^(id data) {
        
        UserModel *user = [LoginModel curLoginUser];
        
        [params enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            if ([key isEqualToString:@"nickname"]) {
                user.nickname = params[@"nickname"];
            }
            if ([key isEqualToString:@"sex"]) {
                user.sex = params[@"sex"];
            }
            
            if ([key isEqualToString:@"headimgurl"]) {
                user.headimgurl = params[@"headimgurl"];
            }
            if ([key isEqualToString:@"birthday"]) {
                user.birthday = params[@"birthday"];
            }
            if ([key isEqualToString:@"profile"]) {
                user.profile = params[@"profile"];
            }
            if ([key isEqualToString:@"mobile"]) {
                user.mobile = params[@"mobile"];
            }
            
            if ([key isEqualToString:@"password"]) {
                user.password = params[@"password"];
            }

            
            [UserModel writeUser:user];
            //            NSLog(@"--------%@-------",[LoginModel curLoginUser]);
            
        }];
        
        if (successBlock) {
            successBlock(data);
        }
        
    } failue:failueBlock];
    
}


/**
 *  确认鉴定订单
 *  @param orderid      ID
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)ConfirmMyAppraiseWithOrderID:(NSInteger)orderid
                         succesBlock:(SuccessBlock)successBlock
                              failue:(FailureBlock)failueBlock;
{
    NSDictionary *params = @{
                             @"orderid":@(orderid),
                             @"status":@(3),
                             };
    [self requestPostCommonWithPath:APPINTERFACE__ConfirmMyAppraise Params:params succesBlock:^(id data) {
        
        if (successBlock) {
            successBlock(data);
        }
    } failue:failueBlock];
}



/**
 *  养护收藏
 *  @param maintainid       ID
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)AddKeepWithMaintainid:(NSInteger)maintainid
              succesBlock:(SuccessBlock)successBlock
                   failue:(FailureBlock)failueBlock;
{
    NSDictionary *params = @{@"maintainid":@(maintainid)};
    [self requestPostCommonWithPath:APPINTERFACE__AddMaintainKeep Params:params succesBlock:^(id data) {
        
        if (successBlock) {
            successBlock(data);
        }
    } failue:failueBlock];
}

/**
 *  提现
 *  @param amount       提现金额
 *  @param cardNumber   卡号
 *  @param bank         银行
 *  @param branch       支行
 *  @param name         姓名
 *  @param code         验证码
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)WithdrawalsWithAmount:(NSInteger)amount
                   cardNumber:(NSString *)cardNumber
                         bank:(NSString *)bank
                       branch:(NSString *)branch
                         name:(NSString *)name
                         code:(NSString *)code
                  succesBlock:(SuccessBlock)successBlock
                       failue:(FailureBlock)failueBlock;{
    
    NSDictionary *params = @{
                             @"amount":@(amount),
                             @"cardNumber":cardNumber,
                             @"bank":bank,
                             @"branch":branch,
                             @"name":name,
                             @"code":code,
                             };
    [self requestPostCommonWithPath:APPINTERFACE__Withdrawals Params:params succesBlock:^(id data) {
        
        if (successBlock) {
            successBlock(data);
        }
    } failue:failueBlock];

    
}

/**
 *  获取积分列表
 *  @param pageNo       页码
 *  @param pageSize     页数
 *  @param order        订单
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */

+ (void)GetRecordListWithPageNo:(NSInteger)pageNo
                      PageSize:(NSInteger)pageSize
                         order:(NSInteger)order
                   succesBlock:(SuccessBlock)successBlock
                        failue:(FailureBlock)failueBlock;
{
    
    NSDictionary *dic = @{
                          @"recordid":@(order)
                          };
    
    NSDictionary *params = @{
                             @"pageNo":@(pageNo),
                             @"pageSize":@(pageSize),
                             @"order":dic
                             };
    
    
    [self requestPostCommonWithPath:APPINTERFACE__RecordList Params:params succesBlock:^(id data) {
        
        if (successBlock) {
            successBlock(data);
        }
    } failue:failueBlock];
    
    
}


/**
 *  获取评论列表
 *  @param pageNo       页码
 *  @param pageSize     页数
 *  @param order        订单
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)GetCommentListWithPageNo:(NSInteger)pageNo
                        PageSize:(NSInteger)pageSize
                           order:(NSInteger)order
                          rentid:(NSInteger)rentid
                     succesBlock:(SuccessBlock)successBlock
                          failue:(FailureBlock)failueBlock;
{
    

    
    NSDictionary *dic = @{
                          @"commentid":@(order)
                         };
    
    
    NSDictionary *params = @{
                             @"pageNo":@(pageNo),
                             @"pageSize":@(pageSize),
                             @"order":dic,
                             @"rentid":@(rentid)
                            };
    
    [self requestPostCommonWithPath:APPINTERFACE__CommontList Params:params succesBlock:^(id data) {
        //        //登录成功
        if (successBlock) {
            successBlock(data);
        }
    } failue:failueBlock];
    
}

/**
 *  获取搜索列表
 *  @param pageNo       页码
 *  @param pageSize     页数
 *  @param order        订单
 *  @param word         关键词
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)GetSearchListWithPageNo:(NSInteger)pageNo
                       PageSize:(NSInteger)pageSize
                          order:(NSInteger)order
                           word:(NSString *)word
                  succesBlock:(SuccessBlock)successBlock
                       failue:(FailureBlock)failueBlock;
{
    NSDictionary *dic = @{
                          @"rentid":@(order)
                          };
    NSDictionary *params = @{@"pageNo":@(pageNo),
                             @"pageSize":@(pageSize),
                             @"order":dic,
                             @"name":word
                             };
    
    [self requestPostCommonWithPath:APPINTERFACE__GetTenancyList Params:params succesBlock:^(id data) {
        //        //登录成功
        
        if (successBlock) {
            successBlock(data);
        }
    } failue:failueBlock];
    
}


/**
 *  获取钱包记录列表
 *  @param pageNo       页码
 *  @param pageSize     页数
 *  @param order        订单
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */

+ (void)GetWalletListWithPageNo:(NSInteger)pageNo
                       PageSize:(NSInteger)pageSize
                          order:(NSInteger)order
                    succesBlock:(SuccessBlock)successBlock
                         failue:(FailureBlock)failueBlock;
{
    
    NSDictionary *dic = @{
                          @"walletid":@(order)
                          };
    
    NSDictionary *params = @{
                             @"pageNo":@(pageNo),
                             @"pageSize":@(pageSize),
                             @"order":dic
                             };
    
    
    [self requestPostCommonWithPath:APPINTERFACE__WalletList Params:params succesBlock:^(id data) {
        
        if (successBlock) {
            successBlock(data);
        }
    } failue:failueBlock];
    
    
}


/**
 *  发布寄卖
 *
 *  @param params       params
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */

+(void)SetPurchaseWithParams:(NSDictionary *)params
                 succesBlock:(SuccessBlock)successBlock
                      failue:(FailureBlock)failueBlock;
{
    [self requestPostCommonWithPath:APPINTERFACE__AddPurchase Params:params succesBlock:^(id data) {
        
        if (successBlock) {
            successBlock(data);
        }
    } failue:failueBlock];
    
}


/**
 *  获取寄卖列表
 *  @param pageNo       页码
 *  @param pageSize     页数
 *  @param order        订单
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */

+ (void)GetPurchaseListWithPageNo:(NSInteger)pageNo
                         PageSize:(NSInteger)pageSize
                            order:(NSInteger)order
                      succesBlock:(SuccessBlock)successBlock
                           failue:(FailureBlock)failueBlock;
{
    
    NSDictionary *dic = @{
                          @"purchaseid":@(order)
                          };
    
    NSDictionary *params = @{
                             @"pageNo":@(pageNo),
                             @"pageSize":@(pageSize),
                             @"status":@(1),
                             @"own":@(1),
                             @"order":dic
                             };
    
    
    [self requestPostCommonWithPath:APPINTERFACE__PurchaseList Params:params succesBlock:^(id data) {
        
        if (successBlock) {
            successBlock(data);
        }
    } failue:failueBlock];
    
    
}



/**
 *  获取我的寄卖列表
 *  @param pageNo       页码
 *  @param pageSize     页数
 *  @param order        订单
 *  @param status       状态
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)GetPutchaseOrderListWithPageNo:(NSInteger)pageNo
                        PageSize:(NSInteger)pageSize
                           order:(NSInteger)order
                          status:(NSInteger)status
                     succesBlock:(SuccessBlock)successBlock
                          failue:(FailureBlock)failueBlock;
{
    NSDictionary *dic = @{
                          @"orderid":@(order)
                          };
    NSDictionary *params = @{@"pageNo":@(pageNo),
                             @"pageSize":@(pageSize),
                             @"order":dic,
                             @"own":@(1),
                             @"status":@(status)
                             };
    
    [self requestPostCommonWithPath:APPINTERFACE__PutchaseOrderList Params:params succesBlock:^(id data) {
        //        //登录成功
        if (successBlock) {
            successBlock(data);
        }
    } failue:failueBlock];
    
}

/**
 *  获取寄卖列表
 *  @param pageNo       页码
 *  @param pageSize     页数
 *  @param order        订单
 *  @param status       状态
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)GetPurchaseListWithPageNo:(NSInteger)pageNo
                         PageSize:(NSInteger)pageSize
                            order:(NSInteger)order
                           status:(NSInteger)status
                      succesBlock:(SuccessBlock)successBlock
                           failue:(FailureBlock)failueBlock;
{
    NSDictionary *dic = @{
                          @"purchaseid":@(order)
                          };
    NSDictionary *params = @{@"pageNo":@(pageNo),
                             @"pageSize":@(pageSize),
                             @"order":dic,
                             @"own":@(1),
                             @"status":@(status)
                             };
    
    [self requestPostCommonWithPath:APPINTERFACE__PurchaseList Params:params succesBlock:^(id data) {
        //        //登录成功
        if (successBlock) {
            successBlock(data);
        }
    } failue:failueBlock];
    
}

/**
 *  删除寄卖订单
 *  @param orderid       ID
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)DeletePurchaseOrderWithOrderID:(NSInteger)orderid
                      succesBlock:(SuccessBlock)successBlock
                           failue:(FailureBlock)failueBlock;
{
    NSDictionary *params = @{@"orderid":@(orderid)};
    [self requestPostCommonWithPath:APPINTERFACE__DeletePurchaseOrder Params:params succesBlock:^(id data) {
        
        if (successBlock) {
            successBlock(data);
        }
    } failue:failueBlock];
    
}


/**
 *  确认收货
 *  @param rentid       ID
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)ConfirmPurchaseOrderWithRentID:(NSInteger)rentid
                   succesBlock:(SuccessBlock)successBlock
                        failue:(FailureBlock)failueBlock;
{
    NSDictionary * params = @{
                              @"orderid":@(rentid),
                              @"status":@(4),
                              };
    
    [self requestPostCommonWithPath:APPINTERFACE__ConfirmPurchaseOrder Params:params succesBlock:^(id data) {
        
        if (successBlock) {
            successBlock(data);
        }
    } failue:failueBlock];
    
}

/**
 *  获取寄卖列表
 *  @param pageNo       页码
 *  @param pageSize     页数
 *  @param order        订单
 *  @param status       状态
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)GetPurchaseList1WithPageNo:(NSInteger)pageNo
                         PageSize:(NSInteger)pageSize
                            order:(NSInteger)order
                           status:(NSInteger)status
                      succesBlock:(SuccessBlock)successBlock
                           failue:(FailureBlock)failueBlock;
{
    NSDictionary *dic = @{
                          @"purchaseid":@(order)
                          };
    NSDictionary *params = @{@"pageNo":@(pageNo),
                             @"pageSize":@(pageSize),
                             @"order":dic,
                             @"status":@(status)
                             };
    
    [self requestPostCommonWithPath:APPINTERFACE__PurchaseList Params:params succesBlock:^(id data) {
        //        //登录成功
        if (successBlock) {
            successBlock(data);
        }
    } failue:failueBlock];
    
}


/**
 *  获取寄租列表
 *  @param pageNo       页码
 *  @param pageSize     页数
 *  @param order        订单
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)GetRentList1WithPageNo:(NSInteger)pageNo
                      PageSize:(NSInteger)pageSize
                         order:(NSInteger)order
                   succesBlock:(SuccessBlock)successBlock
                        failue:(FailureBlock)failueBlock;
{
    NSDictionary *dic = @{
                          @"rentid":@(order)
                          };
    NSDictionary *params = @{@"pageNo":@(pageNo),
                             @"pageSize":@(pageSize),
                             @"order":dic,
                             };
    
    [self requestPostCommonWithPath:APPINTERFACE__GetTenancyList Params:params succesBlock:^(id data) {
        //        //登录成功
        if (successBlock) {
            successBlock(data);
        }
    } failue:failueBlock];
    
}

+ (void)SetPurchaseWithPurchaseidList:(NSArray *)purchaseidList
                           receiverid:(NSInteger)receiverid
                          succesBlock:(SuccessBlock)successBlock
                               failue:(FailureBlock)failueBlock;
{
    NSDictionary *params = @{@"purchaseidList":purchaseidList,
                             @"status":@(2),
                             @"receiverid":@(receiverid),
                             };
    
    [self requestPostCommonWithPath:APPINTERFACE__PurchaseSetPost Params:params succesBlock:^(id data) {
        //登录成功
        if (successBlock) {
            successBlock(data);
        }
    } failue:failueBlock];

}


/**
 *  寄卖协议
 *  @param setupid      ID
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)BussinessProtocolWithSetupID:(NSInteger)setupid
                         succesBlock:(SuccessBlock)successBlock
                              failue:(FailureBlock)failueBlock;
{
    NSDictionary *params = @{@"setupid":@(1)};
    [self requestPostCommonWithPath:APPINTERFACE__BussinessProtocol Params:params succesBlock:^(id data) {
        //        //登录成功
        
        if (successBlock) {
            successBlock(data);
        }
    } failue:failueBlock];
    
}


/**
 *  创建购买订单
 *
 *  @param params       params
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */

+(void)CreatPurchaseOrderWithParams:(NSDictionary *)params
                        succesBlock:(SuccessBlock)successBlock
                             failue:(FailureBlock)failueBlock;
{
    [self requestPostCommonWithPath:APPINTERFACE__SetBussinessOrder Params:params succesBlock:^(id data) {
        
        if (successBlock) {
            successBlock(data);
        }
        
    } failue:failueBlock];
    
}

/**
 *  积分支付
 *  @param orderid      ID
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)PayWithWalletWithOrderid:(NSInteger)orderid
                     succesBlock:(SuccessBlock)successBlock
                          failue:(FailureBlock)failueBlock;
{
    NSDictionary *params = @{
                             @"orderid":@(orderid),
                             @"type":@(2)
                             };
    [self requestPostCommonWithPath:APPINTERFACE__PayByWallet Params:params succesBlock:^(id data) {
        //        //登录成功
        
        if (successBlock) {
            successBlock(data);
        }
    } failue:failueBlock];
    
}

/**
 *  活动报名
 *  @param activityid      ID
 *  @param nickname      昵称
 *  @param mobile        手机
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)EnterActivityWithActivityid:(NSInteger)activityid
                           nickname:(NSString *)nickname
                             mobile:(NSString *)mobile
                     succesBlock:(SuccessBlock)successBlock
                          failue:(FailureBlock)failueBlock;
{
    NSDictionary *params = @{
                             @"activityid":@(activityid),
                             @"nickname":nickname,
                             @"mobile":mobile
                             };
    [self requestPostCommonWithPath:APPINTERFACE__EnterActivity Params:params succesBlock:^(id data) {
        //        //登录成功
        
        if (successBlock) {
            successBlock(data);
        }
    } failue:failueBlock];
    
}



@end
