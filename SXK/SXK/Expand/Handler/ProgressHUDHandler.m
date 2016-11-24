//
//  ProgressHUDHandler.m
//  YHFoundation
//
//  Created by Yhoon on 16/1/20.
//  Copyright © 2016年 yhoon. All rights reserved.
//

#import "ProgressHUDHandler.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import <SVProgressHUD/SVProgressHUD.h>

@implementation ProgressHUDHandler

+ (void)setSVProgressHUD{
    [SVProgressHUD setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.6] ];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor] ];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
    [SVProgressHUD setMinimumDismissTimeInterval:1.5];
    [SVProgressHUD  setRingNoTextRadius:5];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
}

// MBProgressHUD
+ (void)showHudTipStr:(NSString *)tipStr{
    if (tipStr && tipStr.length > 0) {
        MBProgressHUD *hud            = [MBProgressHUD showHUDAddedTo:KEY_WINDOW animated:YES];
        hud.mode                      = MBProgressHUDModeText;
        hud.detailsLabelFont          = [UIFont boldSystemFontOfSize:15.0];
        hud.detailsLabelText          = tipStr;
        hud.margin                    = 10.f;
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:1.5];
    }
}

+ (void)showSuccessHudTipStr:(NSString *)tipStr {
    [SVProgressHUD showSuccessWithStatus:tipStr];
}

+ (void)showInfoHudTipStr:(NSString *)tipStr {
    
    [SVProgressHUD showInfoWithStatus:tipStr];
}

+ (void)showProgressHUD {
    [SVProgressHUD show];
    
}

+ (void)dismissProgressHUD{
    [SVProgressHUD dismiss];
}

@end
