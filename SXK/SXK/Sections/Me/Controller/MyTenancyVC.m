//
//  MyTenancyVC.m
//  SXK
//
//  Created by 杨伟康 on 2016/12/26.
//  Copyright © 2016年 ywk. All rights reserved.
//

#import "MyTenancyVC.h"
#import "MyTenancyCell.h"
#import "MyTenancyCell1.h"
#import "MyTenancyCell2.h"
#import "MyDistributeVC.h"
#import "MyRentVC.h"
@interface MyTenancyVC ()
@property (nonatomic, assign)NSInteger index;

@end

@implementation MyTenancyVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"我的租赁";
//    NSArray *array = @[@"待收货",@"已收货",@"已完成",@"已退回"];
//    [self setupTitlesView:array];
//    [self.view addSubview:self.tableView];
    [self initUI];
}

-(void)initUI
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn setTitle:@"我的发布" forState:UIControlStateNormal];
    btn.frame = VIEWFRAME(0, 0, 100, 100);
    [btn addTarget:self action:@selector(btn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn1 setTitle:@"我的租赁" forState:UIControlStateNormal];
    btn1.frame = VIEWFRAME(0, 100, 100, 100);
    [btn1 addTarget:self action:@selector(btn1:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
}

-(void)btn:(UIButton *)sender
{
    NSMutableArray *vcArr1 = [NSMutableArray array];
    for (int i =0; i<5; i++) {
        UIViewController *vc = [[UIViewController alloc] init];
        vc.view.backgroundColor = [UIColor whiteColor];
        [vcArr1 addObject:vc];
    }
    NSArray *array = @[@"待审核",@"发布中",@"租赁中",@"已下架",@"未通过"];
    MyDistributeVC *vc = [[MyDistributeVC alloc] initWithControllers:vcArr1 titles:array type:1];
    
    [self pushViewController:vc];

}


-(void)btn1:(UIButton *)sender
{
    NSMutableArray *vcArr = [NSMutableArray array];
    for (int i =0; i<4; i++) {
        UIViewController *vc = [[UIViewController alloc] init];
        vc.view.backgroundColor = [UIColor whiteColor];
        [vcArr addObject:vc];
    }
    NSArray *array = @[@"啵客待收",@"进行中",@"啵主确认",@"已完成"];
    MyRentVC *vc = [[MyRentVC alloc] initWithControllers:vcArr titles:array type:1];
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
