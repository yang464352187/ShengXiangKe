//
//  ExchangeVC.m
//  SXK
//
//  Created by 杨伟康 on 2017/1/17.
//  Copyright © 2017年 ywk. All rights reserved.
//

#import "ExchangeVC.h"
#import "MQChatViewManager.h"
#import "MQChatDeviceUtil.h"
#import <MeiQiaSDK/MeiQiaSDK.h>
#import "NSArray+MQFunctional.h"
#import "MQBundleUtil.h"
#import "MQAssetUtil.h"
#import "MQImageUtil.h"
#import "MQToast.h"

@interface ExchangeVC ()

@end

@implementation ExchangeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"交换";
    [self initUI];
}

-(void)initUI
{
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"背景"]];
//    imageView.image = [UIImage imageNamed:@"背景"];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn setTitle:@"发起咨询" forState:UIControlStateNormal];
    [btn setTintColor:[UIColor colorWithHexColorString:@"2c2c2c"]];
    [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
//    ViewRadius(btn , 35/2);
    ViewBorderRadius(btn, 17.5, 0.5, [UIColor colorWithHexColorString:@"656565"]);
    
    [self.view addSubview:btn];
    [self.view addSubview:imageView];
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(CommonHight(527));
    }];
    
    
     [btn mas_makeConstraints:^(MASConstraintMaker *make) {
         make.centerX.equalTo(self.view).offset(0);
         make.top.equalTo(imageView.mas_bottom).offset(21);
         make.size.mas_equalTo(CGSizeMake(121, 35));
     }];
    
}

-(void)btnAction:(UIButton *)sender
{
    MQChatViewManager *chatViewManager = [[MQChatViewManager alloc] init];
    [chatViewManager.chatViewStyle setEnableRoundAvatar:YES];
    [chatViewManager setClientInfo:@{@"name":@"updated",@"avatar":@"http://pic1a.nipic.com/2008-10-27/2008102715429376_2.jpg"} override:YES];
    [chatViewManager pushMQChatViewControllerInViewController:self];

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