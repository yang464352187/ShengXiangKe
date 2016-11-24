//
//  SXKViewController.m
//  SXK
//
//  Created by 杨伟康 on 2016/11/16.
//  Copyright © 2016年 ywk. All rights reserved.
//

#import "SXKViewController.h"
#import "HomeVC.h"
#import "ClassifyVC.h"
#import "PromulgateVC.h"
#import "CommunityVC.h"
#import "MeVC.h"
#import "AppDelegate.h"
#import "ZTTabBar.h"
#import "VTingSeaPopView.h"


@interface SXKViewController ()<ZTTabBarDelegate,VTingPopItemSelectDelegate>
{
    NSMutableArray *images;
    NSMutableArray *titles;
    VTingSeaPopView *pop;
}


@end

@implementation SXKViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initVCS];
      images = [NSMutableArray array];
    titles = [NSMutableArray arrayWithObjects:@"发布",@"养护",@"鉴定", nil];
    
    for (int i = 0; i<3; i++) {
        if (i<3) {
            [images addObject:[UIImage imageNamed:[NSString stringWithFormat:@"%d",i+1]]];
        }else{
            [images addObject:[UIImage imageNamed:[NSString stringWithFormat:@"remind"]]];
        }
    }
    
}


- (void)initVCS{
    
    HomeVC *vc = [[HomeVC alloc] init];
    BaseNavigationVC * nav1 = [[BaseNavigationVC alloc] initWithRootViewController:vc];
    BaseNavigationVC * nav2 = [[BaseNavigationVC alloc] initWithRootViewController:[[ClassifyVC alloc] init]];
    BaseNavigationVC * nav4 = [[BaseNavigationVC alloc] initWithRootViewController:[[CommunityVC alloc] init]];
    BaseNavigationVC * nav5 = [[BaseNavigationVC alloc] initWithRootViewController:[[MeVC alloc] init]];
    
    [nav1.tabBarItem setTitlePositionAdjustment:UIOffsetMake(2, -3)];
    [nav2.tabBarItem setTitlePositionAdjustment:UIOffsetMake(2, -3)];
    [nav4.tabBarItem setTitlePositionAdjustment:UIOffsetMake(2, -3)];
    [nav5.tabBarItem setTitlePositionAdjustment:UIOffsetMake(2, -3)];

    
    [self addOneChildViewController:nav1
                          WithTitle:@"首页"
                    normalImageName:@"TabBar1"
                  selectedImageName:@"TabBar1Sel"];
    [self addOneChildViewController:nav2
                          WithTitle:@"分类"
                    normalImageName:@"TabBar2"
                  selectedImageName:@"TabBar2Sel"];
//    [self addOneChildViewController:nav3
//                          WithTitle:@"发布"
//                    normalImageName:@"Lottery"
//                  selectedImageName:@"Lottery_Sel"];
    [self addOneChildViewController:nav4
                          WithTitle:@"社区"
                    normalImageName:@"TabBar4"
                  selectedImageName:@"TabBar4Sel"];
    [self addOneChildViewController:nav5
                          WithTitle:@"我的"
                    normalImageName:@"TabBar5"
                  selectedImageName:@"TabBar5Sel"];
    
    //加载自定义TabBar
    ZTTabBar *tabBar = [[ZTTabBar alloc] init];
    tabBar.delegate = self;
    [self setValue:tabBar forKey:@"tabBar"];
    
    //设置tabbar颜色，防止渲染
    [[UITabBar appearance] setBarTintColor:[UIColor blackColor]];
    [[UITabBar appearance] setBackgroundColor:[UIColor blackColor]];

    //设置tabbar Title 字体颜色
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:APP_COLOR_GRAY_333333, NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
  
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    
//    if (!DEFAULTS_GET_BOOL(@"kAppFirstInstall")) {
//        _firstpageVC = [[FirstPageViewController alloc] init];
//        [self.view addSubview:_firstpageVC.view];
//        _firstpageVC.scrollView.delegate = self;
//        DEFAULTS_SET_BOOL(YES, @"kAppFirstInstall");
//    }
    
}

/**
 *  添加一个子控制器
 *
 *  @param viewController    控制器
 *  @param title             标题
 *  @param normalImageName   图片
 *  @param selectedImageName 选中图片
 */
- (void)addOneChildViewController:(UIViewController *)viewController
                        WithTitle:(NSString *)title
                  normalImageName:(NSString *)normalImageName
                selectedImageName:(NSString *)selectedImageName {
    
    viewController.tabBarItem.title         = title;
    UIImage *normalImage = [UIImage imageNamed:normalImageName];
    normalImage = [normalImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    viewController.tabBarItem.image         = normalImage;
    UIImage *selectedImage = [UIImage imageNamed:selectedImageName];
    selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    viewController.tabBarItem.selectedImage = selectedImage;
    
    [self addChildViewController:viewController];
    
}

#pragma ZTTabBarDelegate
- (void)tabBarDidClickPlusButton:(ZTTabBar *)tabBar
{
    pop = [[VTingSeaPopView alloc] initWithButtonBGImageArr:images andButtonBGT:titles];
    [self.view addSubview:pop];
    pop.delegate = self;
    [pop show];
}

#pragma mark delegate
-(void)itemDidSelected:(NSInteger)index {
//        NSLog(@"点击了%d:item",index);
    if (index == 0) {
        [[PushManager sharedManager] pushToVCWithClassName:@"PromulgateVC" info:nil];
    }
    [pop disMiss];
    
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
