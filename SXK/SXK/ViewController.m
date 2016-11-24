//
//  ViewController.m
//  SXK
//
//  Created by 杨伟康 on 2016/11/11.
//  Copyright © 2016年 ywk. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()


@property (nonatomic, strong) UIImageView *image;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.image sd_setImageWithURL:[NSURL URLWithString:@""]];
    NSDictionary *dic = [[NSDictionary alloc] init];
    NSLog(@"%@",describe(dic));
    
    
    NSDictionary *dic1 = @{@"avlChannelId":@"",@"avlDeviceType":@"4",@"avlMachineId":@"1111",@"avlMachineName":@"iPhone",@"avlSystemName":@"1",@"avlVersions":@"1.2.0",@"carbrandId":@"",@"companyCity":@"115",@"companyCountry":@"",@"companyName":@"",@"companyProvince":@"",@"latitude":@"39.912954",@"locationDistrictId":@"115",@"longitude":@"116.402975",@"mainBusiness":@"",@"merchantId":@"",@"sessionCode":@"1479085708939"};
    
    
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/plain", @"text/javascript", @"text/json", @"text/html", nil];
    [manager.requestSerializer setValue:@"application/json;chartset=utf-8" forHTTPHeaderField:@"Content-Type"];

    [manager POST:@"http://www.arogo.cn/mobile/merchant_queryNearbyMerchantList.do" parameters:dic1 progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"成功 %@",describe(responseObject));
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"失败  %@",error);
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
