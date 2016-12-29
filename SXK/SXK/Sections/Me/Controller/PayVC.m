//
//  PayVC.m
//  SXK
//
//  Created by 杨伟康 on 2016/12/28.
//  Copyright © 2016年 ywk. All rights reserved.
//

#import "PayVC.h"

@interface PayVC ()

@end

@implementation PayVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"支付";
    NSLog(@"--------%@----------",self.myDict[@"orderid"]);
    [BaseRequest PayWithChannel:@"alipay" orderID:[self.myDict[@"orderid"] integerValue] type:1 succesBlock:^(id data) {
        
        _weekSelf(weakSelf);
        [Pingpp createPayment:data[@"info"] appURLScheme:@"wx4bfb2d22ce82d40d" withCompletion:^(NSString *result, PingppError *error) {
            NSLog(@"completion block: %@", result);
            if (error == nil) {
                NSLog(@"PingppError is nil");
                [ProgressHUDHandler showHudTipStr:@"付款成功"];
                [weakSelf popGoBack];
            } else {
                NSLog(@"PingppError: code=%lu msg=%@", (unsigned  long)error.code, [error getMsg]);
                if (error.code == 3) {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                                    message:@"您还没安装微信,请前往AppStore中下载安装"
                                                                   delegate:nil
                                                          cancelButtonTitle:@"确定"
                                                          otherButtonTitles:nil];
                    [alert show];
                }
            }
        }];
        
    } failue:^(id data, NSError *error) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
