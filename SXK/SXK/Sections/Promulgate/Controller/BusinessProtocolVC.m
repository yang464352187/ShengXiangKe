//
//  BusinessProtocolVC.m
//  SXK
//
//  Created by 杨伟康 on 2017/4/5.
//  Copyright © 2017年 ywk. All rights reserved.
//

#import "BusinessProtocolVC.h"

@interface BusinessProtocolVC ()

@property (nonatomic, strong)UIWebView *webView;

@property (nonatomic, strong)NSString *html;

@end

@implementation BusinessProtocolVC
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadingRequest];
}


-(void)loadingRequest
{
//    [BaseRequest AboutBoobelWithSetupID:1 succesBlock:^(id data) {
//        NSLog(@"%@",data);
//    } failue:^(id data, NSError *error) {
//        
//    }];
    
    
    [BaseRequest BussinessProtocolWithSetupID:1 succesBlock:^(id data) {
        self.html = data[@"setup"][@"content"];
        [self.webView loadHTMLString:self.html baseURL:nil];

    } failue:^(id data, NSError *error) {
        
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"寄卖协议";
    [self.view addSubview:self.webView];

    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.top.equalTo(self.view.mas_top).offset(0);
        make.bottom.equalTo(self.view.mas_bottom).offset(0);
    }];
}


- (UIWebView *)webView
{
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
        _webView.dataDetectorTypes = UIDataDetectorTypeAll;
        _webView.scrollView.bounces = NO;
    }
    return _webView;
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
