//
//  ProgressHUDHandler.h
//  YHFoundation
//
//  Created by Yhoon on 16/1/20.
//  Copyright © 2016年 yhoon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProgressHUDHandler : NSObject

+ (void)setSVProgressHUD;
+ (void)showHudTipStr:(NSString *)tipStr;
+ (void)showSuccessHudTipStr:(NSString *)tipStr;
+ (void)showInfoHudTipStr:(NSString *)tipStr;
+ (void)showProgressHUD ;
+ (void)dismissProgressHUD;

@end
