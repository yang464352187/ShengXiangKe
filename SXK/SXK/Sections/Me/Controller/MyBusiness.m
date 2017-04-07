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
    
    UIImageView *image1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sendthe"]];
    image1.frame = VIEWFRAME(0, 0, SCREEN_WIDTH,CommonHight(220));
    image1.userInteractionEnabled = YES;
    [self.view addSubview:image1];
    
    
    UIImageView *image2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"takeonlease"]];
    image2.frame = VIEWFRAME(0, (SCREEN_HIGHT-64)/2, SCREEN_WIDTH,CommonHight(220));
    image2.userInteractionEnabled = YES;
    [self.view addSubview:image2];
    
    
    UIView *view1 = [[UIView alloc] init];
    view1.layer.shadowOpacity = 0.8f;
    view1.layer.shadowRadius = 4;
    view1.layer.shadowColor = [UIColor grayColor].CGColor;
    view1.backgroundColor = [UIColor whiteColor];
    
    UILabel *title11 = [UILabel createLabelWithFrame:VIEWFRAME(150, 60, 100, 50)                                                 andText:@"我的寄卖"
                                        andTextColor:[UIColor blackColor]
                                          andBgColor:[UIColor clearColor]
                                             andFont:SYSTEMFONT(12)
                                    andTextAlignment:NSTextAlignmentCenter];
    
    UILabel *title12 = [UILabel createLabelWithFrame:VIEWFRAME(150, 60, 100, 50)                                                 andText:@"My Sale"
                                        andTextColor:[UIColor blackColor]
                                          andBgColor:[UIColor clearColor]
                                             andFont:SYSTEMFONT(13)
                                    andTextAlignment:NSTextAlignmentCenter];
    
    
    [self.view addSubview:view1];
    [view1 addSubview:title11];
    [view1 addSubview:title12];
    
    
    UIView *view2 = [[UIView alloc] init];
    view2.layer.shadowOpacity = 0.8f;
    view2.layer.shadowRadius = 4;
    view2.layer.shadowColor = [UIColor grayColor].CGColor;
    view2.backgroundColor = [UIColor whiteColor];
    
    UILabel *title21 = [UILabel createLabelWithFrame:VIEWFRAME(150, 60, 100, 50)                                                 andText:@"我的买入"
                                        andTextColor:[UIColor blackColor]
                                          andBgColor:[UIColor clearColor]
                                             andFont:SYSTEMFONT(12)
                                    andTextAlignment:NSTextAlignmentCenter];
    
    UILabel *title22 = [UILabel createLabelWithFrame:VIEWFRAME(150, 60, 100, 50)                                                 andText:@"My Goods"
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
        make.size.mas_equalTo(CGSizeMake(100, 50));
    }];
    
    [view2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(image2.mas_bottom).offset(5);
        make.size.mas_equalTo(CGSizeMake(100, 50));
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

-(void)tap1:(UITapGestureRecognizer*)tap
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

-(void)tap2:(UITapGestureRecognizer *)tap
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
