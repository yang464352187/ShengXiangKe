//
//  AboutBoobe.m
//  SXK
//
//  Created by 杨伟康 on 2016/12/20.
//  Copyright © 2016年 ywk. All rights reserved.
//

#import "AboutBoobe.h"

@interface AboutBoobe ()

@property (nonatomic, strong)UIWebView *webView;

@property (nonatomic, strong)NSString *html;

@end

@implementation AboutBoobe


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadingRequest];
}


-(void)loadingRequest
{
    [BaseRequest AboutBoobelWithSetupID:1 succesBlock:^(id data) {
        NSLog(@"%@",data);
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
