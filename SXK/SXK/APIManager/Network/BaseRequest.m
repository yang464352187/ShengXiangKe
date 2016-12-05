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





@end
