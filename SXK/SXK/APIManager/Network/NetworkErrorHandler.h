//
//  NetworkErrorHandler.h
//  YHFoundation
//
//  Created by Yhoon on 16/1/18.
//  Copyright © 2016年 yhoon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkErrorHandler : NSObject

+ (void)showError:(NSError *)error;

+ (id)handleResponse:(id)responseJSON;
+ (id)handleResponse:(id)responseJSON autoShowError:(BOOL)autoShowError;

@end
