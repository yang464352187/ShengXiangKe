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
    
    UIImageView *image1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sendthe"]];
    image1.frame = VIEWFRAME(0, 0, SCREEN_WIDTH,CommonHight(220));
    image1.userInteractionEnabled = YES;
    [self.view addSubview:image1];
    
    UIImageView *image2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"takeonlease"]];
    image2.frame = VIEWFRAME(0, (SCREEN_HIGHT-64)/2, SCREEN_WIDTH,CommonHight(220));
    image2.userInteractionEnabled = YES;
    [self.view addSubview:image2];

    UIView *view1 = [[UIView alloc] init];
//    view1.layer.shadowOpacity = 0.8f;
//    view1.layer.shadowRadius = 4;
//    view1.layer.shadowColor = [UIColor grayColor].CGColor;
    view1.backgroundColor = [UIColor whiteColor];
    ViewBorder(view1, 0.5, [UIColor blackColor]);
//
    UILabel *title11 = [UILabel createLabelWithFrame:VIEWFRAME(150, 60, 100, 50)                                                 andText:@"我的发布"
                                 andTextColor:[UIColor blackColor]
                                   andBgColor:[UIColor clearColor]
                                      andFont:SYSTEMFONT(12)
                             andTextAlignment:NSTextAlignmentCenter];
    
    UILabel *title12 = [UILabel createLabelWithFrame:VIEWFRAME(150, 60, 100, 50)                                                 andText:@"My Release"
                                        andTextColor:[UIColor blackColor]
                                          andBgColor:[UIColor clearColor]
                                             andFont:SYSTEMFONT(13)
                                    andTextAlignment:NSTextAlignmentCenter];

    
    [self.view addSubview:view1];
    [view1 addSubview:title11];
    [view1 addSubview:title12];
    
    
    UIView *view2 = [[UIView alloc] init];
//    view2.layer.shadowOpacity = 0.8f;
//    view2.layer.shadowRadius = 4;
//    view2.layer.shadowColor = [UIColor grayColor].CGColor;
    view2.backgroundColor = [UIColor whiteColor];
    ViewBorder(view2, 0.5, [UIColor blackColor]);
    
    UILabel *title21 = [UILabel createLabelWithFrame:VIEWFRAME(150, 60, 100, 50)                                                 andText:@"我的租赁"
                                        andTextColor:[UIColor blackColor]
                                          andBgColor:[UIColor clearColor]
                                             andFont:SYSTEMFONT(12)
                                    andTextAlignment:NSTextAlignmentCenter];
    
    UILabel *title22 = [UILabel createLabelWithFrame:VIEWFRAME(150, 60, 100, 50)                                                 andText:@"My Lease"
                                        andTextColor:[UIColor blackColor]
                                          andBgColor:[UIColor clearColor]
                                             andFont:SYSTEMFONT(13)
                                    andTextAlignment:NSTextAlignmentCenter];
    
    [self.view addSubview:view2];
    [view2 addSubview:title21];
    [view2 addSubview:title22];
    
    [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(image1.mas_bottom).offset(5);
        make.size.mas_equalTo(CGSizeMake(125, 50));
    }];
    
    [view2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(image2.mas_bottom).offset(5);
        make.size.mas_equalTo(CGSizeMake(125, 50));
    }];
    
    [title11 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@(12));
        make.left.equalTo(view1.mas_left).offset(0);
        make.right.equalTo(view1.mas_right).offset(0);
        make.centerY.equalTo(view1).offset(-8);
    }];

    [title12 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@(12));
        make.left.equalTo(view1.mas_left).offset(0);
        make.right.equalTo(view1.mas_right).offset(0);
        make.centerY.equalTo(view1).offset(8);
    }];
    
    [title21 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@(12));
        make.left.equalTo(view2.mas_left).offset(0);
        make.right.equalTo(view2.mas_right).offset(0);
        make.centerY.equalTo(view2).offset(-8);
    }];
    
    [title22 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@(12));
        make.left.equalTo(view2.mas_left).offset(0);
        make.right.equalTo(view2.mas_right).offset(0);
        make.centerY.equalTo(view2).offset(8);
    }];

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap1:)];
    [view1 addGestureRecognizer:tap];
    
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap1:)];
    [image1 addGestureRecognizer:tap1];

    
    UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap2:)];
    [view2 addGestureRecognizer:tap3];
    
    UITapGestureRecognizer *tap4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap2:)];
    [image2 addGestureRecognizer:tap4];

}



-(void)tap1:(UITapGestureRecognizer*)tap
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

-(void)tap2:(UITapGestureRecognizer *)tap
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
