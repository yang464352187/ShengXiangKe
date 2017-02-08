//
//  ServiceCenter1.m
//  SXK
//
//  Created by 杨伟康 on 2017/1/20.
//  Copyright © 2017年 ywk. All rights reserved.
//

#import "ServiceCenter1.h"

@interface ServiceCenter1 ()

@property (nonatomic, strong)UIWebView *webView;

@end

@implementation ServiceCenter1


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if ([self.myDict[@"type"] isEqualToString:@"1"]) {
        NSString *jsString = [NSString stringWithFormat:@"<html> \n"
                              "<head> \n"
                              "<style type=\"text/css\"> \n"
                              "body {font-size: %f; font-family: \"%@\"; color: %@;}\n"
                              "</style> \n"
                              "</head> \n"
                              "<body>%@</body> \n"
                              "</html>", 13.0f, @"Times New Roman", @"black", self.myDict[@"content"] ];

        [self.webView loadHTMLString:jsString baseURL:nil];
//        NSLog(@"%@",self.myDict[@"content"]);
    }else{
    _weekSelf(weakSelf);
    [BaseRequest GetServiceDetailWithSetupID:1 url:self.myDict[@"url"] succesBlock:^(id data) {
        NSString *htmls = [NSString stringWithFormat:@"<html> \n"
                           "<head> \n"
                           "<style type=\"text/css\"> \n"
                           "body {font-size:13px}\n"
                           "</style> \n"
                           "</head> \n"
                           "<body>"
                           "<script type='text/javascript'>"
                           "window.onload = function(){\n"
                           "var $img = document.getElementsByTagName('img');\n"
                           "for(var p in  $img){\n"
                           "$img[p].style.width = '100%%';\n"
                           "$img[p].style.height ='auto'\n"
                           "}\n"
                           "}"
                           "</script>%@"
                           "</body>"
                           "</html>",data[@"setup"][@"content"]];
            [weakSelf.webView loadHTMLString:htmls  baseURL:nil];
//        NSLog(@"%@",data[@"setup"][@"content"]);
    } failue:^(id data, NSError *error) {
        
    }];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = self.myDict[@"title"];
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HIGHT)];
    [self.view addSubview:self.webView];
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
