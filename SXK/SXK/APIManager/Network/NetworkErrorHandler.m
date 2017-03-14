//
//  NetworkErrorHandler.m
//  YHFoundation
//
//  Created by Yhoon on 16/1/18.
//  Copyright © 2016年 yhoon. All rights reserved.
//

#import "NetworkErrorHandler.h"
#import "ProgressHUDHandler.h"

@implementation NetworkErrorHandler

// 错误提示内容
+ (NSString *)tipFromError:(NSError *)error{
    if (error && error.userInfo) {
        NSMutableString *tipStr = [[NSMutableString alloc] init];
        if (error.userInfo[@"codeInfo"]) {
            [tipStr appendString:error.userInfo[@"codeInfo"]];
        }else{
            if ([error.userInfo objectForKey:@"NSLocalizedDescription"]) {
                tipStr = [error.userInfo objectForKey:@"NSLocalizedDescription"];
            }else{
                [tipStr appendFormat:@"ErrorCode = %ld", (long)error.code];
            }
        }
        return tipStr;
    }
    return nil;
}

#pragma mark - NetError
+ (void)showError:(NSError *)error{
    NSString *tipStr = [NetworkErrorHandler tipFromError:error];
    [ProgressHUDHandler showHudTipStr:tipStr];
}


+ (id)handleResponse:(id)responseJSON {
    return [self handleResponse:responseJSON autoShowError:YES];
}

// 处理错误提示信息
+ (id)handleResponse:(id)responseJSON autoShowError:(BOOL)autoShowError {
    NSError *error = nil;
    NSNumber *resultCode = [responseJSON valueForKeyPath:@"code"];
    
    // TODO:code为非0值时，表示请求出错,可根据后台定义的错误类型进行分类处理
    if (resultCode.integerValue != 1) {
        if (resultCode.integerValue == 0) {
            //参数值非法或者参数格式错误
            
            
    
        }else if (resultCode.intValue == 911) {
            // TODO:用户未登录或者登陆超时
//            [LoginModel doLoginOut];
            [ProgressHUDHandler showHudTipStr:@"登录超时,请重新登录"];
            [[PushManager sharedManager] presentLoginVC];
            
        }else  if (resultCode.intValue == 2003){
            if (autoShowError) {
                // TODO:其他错误提示
                
                NSString * msg = responseJSON[@"message"];
                [ProgressHUDHandler showHudTipStr:msg];
            }
        }
        error = [NSError errorWithDomain:@"" code:resultCode.integerValue userInfo:responseJSON];
    }
    return error;
}

@end
