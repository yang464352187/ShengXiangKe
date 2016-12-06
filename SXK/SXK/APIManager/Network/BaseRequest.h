//
//  BaseRequest.h
//  SXK
//
//  Created by 杨伟康 on 2016/11/11.
//  Copyright © 2016年 ywk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetworkClient.h"

@interface BaseRequest : NSObject

@property (nonatomic, strong) NSString *baseUrl;
@property (nonatomic, assign) NSTimeInterval *requestTimeoutInterval;
@property (nonatomic, readonly) AFNetworkReachabilityStatus status;

+ (instancetype)sharedInstance;


+ (void)requestGetCommonWithPath:(NSString *)aPath Params:(id)params succesBlock:(SuccessBlock)successBlock failue:(FailureBlock)failueBlock;

+ (void)requestPostCommonWithPath:(NSString *)aPath Params:(id)params succesBlock:(SuccessBlock)successBlock failue:(FailureBlock)failueBlock;

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
                      failue:(FailureBlock)failueBlock;



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
                   failue:(FailureBlock)failueBlock;

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
                    failue:(FailureBlock)failueBlock;

/**
 *  发送验证码
 *
 *  @param mobile       手机号
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */

+ (void)sendSmsWithmobile:(NSString *)mobile
              succesBlock:(SuccessBlock)successBlock
                   failue:(FailureBlock)failueBlock;


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
                         failue:(FailureBlock)failueBlock;


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
                      failue:(FailureBlock)failueBlock;


@end
