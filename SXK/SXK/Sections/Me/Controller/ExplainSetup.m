//
//  ExplainSetup.m
//  SXK
//
//  Created by 杨伟康 on 2017/4/10.
//  Copyright © 2017年 ywk. All rights reserved.
//

#import "ExplainSetup.h"

@interface ExplainSetup ()

@property (nonatomic, strong)UIWebView *webView;

@property (nonatomic, strong)NSString *html;

@end

@implementation ExplainSetup
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadingRequest];
}


-(void)loadingRequest
{
    //    [BaseRequest UserProtocolWithSetupID:1 succesBlock:^(id data) {
    //        NSLog(@"%@",data);
    //        self.html = data[@"setup"][@"content"];
    //        [self.webView loadHTMLString:self.html baseURL:nil];
    //
    //    } failue:^(id data, NSError *error) {
    //
    //    }];
    
    [BaseRequest DamagesMoneyWithSetupID:1 succesBlock:^(id data) {
        self.html = data[@"setup"][@"content"];
        [self.webView loadHTMLString:self.html baseURL:nil];
        
    } failue:^(id data, NSError *error) {
        
    }];
    
    [BaseRequest ExplainSetupWithSetupID:1 succesBlock:^(id data) {
        self.html = data[@"setup"][@"content"];
        [self.webView loadHTMLString:self.html baseURL:nil];
    } failue:^(id data, NSError *error) {
        
    }];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = self.myDict[@"title"];
    [self.view addSubview:self.webView];
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
