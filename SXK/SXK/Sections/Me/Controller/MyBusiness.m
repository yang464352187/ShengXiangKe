//
//  MyBusiness.m
//  SXK
//
//  Created by 杨伟康 on 2017/4/5.
//  Copyright © 2017年 ywk. All rights reserved.
//

#import "MyBusiness.h"
#import "MyBussinessReleaseVC.h"
#import "MyBusinessBuy.h"
@interface MyBusiness ()

@end

@implementation MyBusiness

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"我的买卖";
    [self initUI];
}


-(void)initUI
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn setTitle:@"我的寄卖" forState:UIControlStateNormal];
    btn.frame = VIEWFRAME(0, 0, 100, 100);
    [btn addTarget:self action:@selector(btn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn1 setTitle:@"我的买入" forState:UIControlStateNormal];
    btn1.frame = VIEWFRAME(0, 100, 100, 100);
    [btn1 addTarget:self action:@selector(btn1:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
}

-(void)btn:(UIButton *)sender
{
    NSMutableArray *vcArr1 = [NSMutableArray array];
    for (int i =0; i<3; i++) {
        UIViewController *vc = [[UIViewController alloc] init];
        vc.view.backgroundColor = [UIColor whiteColor];
        [vcArr1 addObject:vc];
    }
    NSArray *array = @[@"发布中",@"寄送中",@"已收货"];
    MyBussinessReleaseVC *vc = [[MyBussinessReleaseVC alloc] initWithControllers:vcArr1 titles:array type:1];
    
    [self pushViewController:vc];
    
}


-(void)btn1:(UIButton *)sender
{
    NSMutableArray *vcArr1 = [NSMutableArray array];
    for (int i =0; i<3; i++) {
        UIViewController *vc = [[UIViewController alloc] init];
        vc.view.backgroundColor = [UIColor whiteColor];
        [vcArr1 addObject:vc];
    }
    NSArray *array = @[@"待发货",@"待收货",@"已收货"];
    MyBusinessBuy *vc = [[MyBusinessBuy alloc] initWithControllers:vcArr1 titles:array type:1];
    
    [self pushViewController:vc];
    
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
