//
//  NetworkClient.h
//  YHFoundation
//
//  Created by Yhoon on 16/1/18.
//  Copyright © 2016年 yhoon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

typedef NS_OPTIONS(NSInteger, NetworkType) {
    NetworkType_Get = 0,    // GET请求
    NetworkType_Post,       // POST请求
};

typedef void(^SuccessBlock)(id data);               //成功回调的block
typedef void(^FailureBlock)(id data,NSError *error);//失败回调的block

@interface NetworkClient : NSObject

@property (nonatomic, strong) NSString *baseUrl;
@property (nonatomic, assign) NSTimeInterval *requestTimeoutInterval;

+ (NetworkClient *)sharedInstance;
- (AFNetworkReachabilityStatus)getStatus;

/**
 *  网络请求接口
 *
 *  @param aPath         请求路径
 *  @param params        入参字典
 *  @param networkType   请求类型
 *  @param autoShowError 是否自动弹窗提示error
 *  @param successBlock  成功回调
 *  @param failureBlock  失败回调
 */
- (void)requestJsonDataWithPath:(NSString *)aPath
                     withParams:(id)params
                 withMethodType:(NetworkType)networkType
                  autoShowError:(BOOL)autoShowError
                        success:(SuccessBlock)successBlock
                        failure:(FailureBlock)failureBlock;



@end
