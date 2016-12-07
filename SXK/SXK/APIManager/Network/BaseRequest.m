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
    
    NSNumber *i = [NSNumber numberWithInteger:pageNo];
    NSNumber *j = [NSNumber numberWithInteger:pageSize];
    NSDictionary *dic = @{@"receiverid":@1};
    NSDictionary *params = @{@"pageNo":i,
                             @"pageSize":j,
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



@end
