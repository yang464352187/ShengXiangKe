//
//  NetworkClient.m
//  YHFoundation
//
//  Created by Yhoon on 16/1/18.
//  Copyright © 2016年 yhoon. All rights reserved.
//

#import "NetworkClient.h"

#import "NetworkErrorHandler.h"
//#import "ProgressHUDHandler.h"

#define mNetworkTypeNames @[@"Get", @"Post"]

static const NSTimeInterval kRequestTimeoutInterval = 15; // 网络请求超时时间

@interface NetworkClient ()

@property (nonatomic, strong) AFHTTPSessionManager *netManager;
@property (nonatomic, assign) AFNetworkReachabilityStatus status;

@end

@implementation NetworkClient

+ (NetworkClient *)sharedInstance {
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] initWithBaseURL:[NSURL URLWithString:APP_BASEURL] ];
        [sharedInstance MonitoringNetWorking];
    });
    return sharedInstance;
}

- (instancetype)initWithBaseURL:(NSURL *)baseUrl {
    self = [super init];
    if (self) {
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        _netManager = [[AFHTTPSessionManager alloc] initWithBaseURL:baseUrl
                                               sessionConfiguration:configuration];
        _netManager.requestSerializer = [AFJSONRequestSerializer serializer];
        _netManager.responseSerializer = [AFJSONResponseSerializer serializer];
        _netManager.requestSerializer.timeoutInterval = kRequestTimeoutInterval;
        _netManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/plain", @"text/javascript", @"text/json", @"text/html", nil];
        [_netManager.requestSerializer setValue:@"application/json;chartset=utf-8" forHTTPHeaderField:@"Content-Type"];
        [_netManager.requestSerializer setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
        
    }
    return self;
}

- (void)requestJsonDataWithPath:(NSString *)aPath
                     withParams:(id)params
                 withMethodType:(NetworkType)networkType
                  autoShowError:(BOOL)autoShowError
                        success:(SuccessBlock)successBlock
                        failure:(FailureBlock)failureBlock {
    if (!aPath || aPath.length <= 0) {
        return;
    }
    if ([LoginModel isLogin]) {
        [_netManager.requestSerializer setValue:[LoginModel curUserToken] forHTTPHeaderField:@"PHPSESSID"];
        //NSLog(@"已登录的请求头 %@",_netManager.requestSerializer.HTTPRequestHeaders);
    }
    
    //打印请求数据
    DebugLog(@"\nDescribe:\n==============Request===============\n%@\n%@:\n%@\n\n\n", mNetworkTypeNames[networkType], aPath, describe(params));
    aPath = [aPath stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    switch (networkType) {
        case NetworkType_Get: {
            [_netManager GET:aPath parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                DebugLog(@"\nDescribe\n==============Response==============\n%@:\n%@\n\n\n", aPath, responseObject);

                id error = [NetworkErrorHandler handleResponse:responseObject autoShowError:autoShowError];
                
                if (error) {
                    failureBlock(nil,error);
                }else {
                    successBlock(responseObject);
                }
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                DebugLog(@"\nDescribe:\n==============Response==============\n%@:\n%@\n\n\n", aPath, error);
                
                [NetworkErrorHandler showError:error];
                failureBlock(nil,error);
            }];
            break;
        }
        case NetworkType_Post: {
            [_netManager POST:aPath parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                DebugLog(@"\nDescribe:\n==============Response Success==============\n%@:\n%@\n\n\n", aPath, describe(responseObject));

                id error = [NetworkErrorHandler handleResponse:responseObject autoShowError:autoShowError];
                
                if (error) {
                    failureBlock(responseObject,error);
                }else {
                    successBlock(responseObject);
                }
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                DebugLog(@"\nDescribe:\n==============Response Failure==============\n%@:\n%@\n\n\n", aPath, error);
                
                [NetworkErrorHandler showError:error];
                failureBlock(nil,error);
            }];
            break;
        }
    }
}


#pragma mark -- 网络监测
- (void)MonitoringNetWorking{
    //创建网络监听管理者对象
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    //设置监听
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        static NSInteger num = 0;
        _status = status;
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                NSLog(@"未识别的网络");
                break;
                
            case AFNetworkReachabilityStatusNotReachable:
                if (num > 0) {
                    //[MBProgressHUD showSuccessHudTipStr:@"网络已断开"];
                }else{
                    num ++;
                }
                NSLog(@"不可达的网络(未连接)");
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN:
                if (num > 0) {
                    //[MBProgressHUD showSuccessHudTipStr:@"当前为运营商网络"];
                }else{
                    num ++;
                }
                break;
                
            case AFNetworkReachabilityStatusReachableViaWiFi:
                if (num > 0) {
                    //[MBProgressHUD showSuccessHudTipStr:@"已连接到WIFI"];
                }else{
                    num ++;
                }
                break;
                
            default:
                break;
        }
    }];
    //开始监听
    [manager startMonitoring];
}



- (AFNetworkReachabilityStatus)getStatus{
    return self.status;
}



@end
