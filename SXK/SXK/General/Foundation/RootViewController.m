//
//  RootViewController.m
//  SXK
//
//  Created by 杨伟康 on 2016/11/16.
//  Copyright © 2016年 ywk. All rights reserved.
//

#import "RootViewController.h"
#import "AppDelegate.h"
#import "UMessage.h"
@interface RootViewController ()


@end

@implementation RootViewController

//预留动画活动页
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    
    // Do any additional setup after loading the view.
}

#pragma mark -- UI
- (void)initUI{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.window.rootViewController = self.tabbarVC;
//    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
//    [UMessage addLaunchMessageWithWindow:self.view.window finishViewController:self];


    
}

#pragma mark -- getters and setters

- (SXKViewController *)tabbarVC{
    if (!_tabbarVC) {
        _tabbarVC = [[SXKViewController alloc] init];
    }
    return _tabbarVC;
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
