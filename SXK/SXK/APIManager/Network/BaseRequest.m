//
//  BaseRequest.m
//  SXK
//
//  Created by 杨伟康 on 2016/11/11.
//  Copyright © 2016年 ywk. All rights reserved.
//

#import "BaseRequest.h"

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
 *  @param topicid        订单
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)GetCommunityTopicListWithPageNo:(NSInteger)pageNo
                               PageSize:(NSInteger)pageSize
                                topicid:(NSInteger)topicid
                            succesBlock:(SuccessBlock)successBlock
                                 failue:(FailureBlock)failueBlock;
{
    NSDictionary *dic = @{
                          @"topicid":@(topicid)
                          };
    NSDictionary *params = @{@"pageNo":@(pageNo),
                             @"pageSize":@(pageSize),
                             @"order":dic};
    
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
        NSLog(@"%@",str);
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setValue:str forKey:@"image"];
        [imgArr addObject:dic];
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


@end
