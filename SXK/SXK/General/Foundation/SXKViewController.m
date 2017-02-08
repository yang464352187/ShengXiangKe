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


@interface SXKViewController ()<ZTTabBarDelegate,VTingPopItemSelectDelegate,UIScrollViewDelegate,UITabBarDelegate>
{
    NSMutableArray *images;
    NSMutableArray *titles;
    VTingSeaPopView *pop;
}
@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIPageControl *pageControl;


@property (nonatomic, strong) UIButton *beginButton;

@property (nonatomic, strong) HomeVC *vc;

@property (nonatomic, strong) NSString *title1;

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
    
    [self setupData];

        if (DEFAULTS_GET_INTEGER(@"launchInteger") == 0) {
            NSInteger currentInt = DEFAULTS_GET_INTEGER(@"launchInteger");
            currentInt += 1;
            DEFAULTS_SET_INTEGER(currentInt, @"launchInteger");
            [self.view addSubview:self.scrollView];
            [self.view addSubview:self.pageControl];
        }

    self.title1 = @"首页";
}
- (void)setupData{
    NSArray *imageNames = @[@"背景", @"背景", @"背景"];
    for (int i = 0; i < imageNames.count; i++) {
        UIImage *image = [UIImage imageNamed:imageNames[i]];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * ViewWidth(self.scrollView), 0, ViewWidth(self.scrollView), ViewHeight(self.scrollView))];
        imageView.image = image;
        [self.scrollView addSubview:imageView];
    }
    self.scrollView.contentSize = CGSizeMake(imageNames.count * ViewWidth(self.scrollView), ViewHeight(self.scrollView));
    
}


- (void)initVCS{
    self.vc = [[HomeVC alloc] init];
    BaseNavigationVC * nav1 = [[BaseNavigationVC alloc] initWithRootViewController:self.vc];
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
    tabBar.backgroundColor = [UIColor colorWithHexColorString:@"000000"];
    [self setValue:tabBar forKey:@"tabBar"];
    
    //设置tabbar颜色，防止渲染
    [[UITabBar appearance] setBarTintColor:[UIColor colorWithHexColorString:@"000000"]];
    [[UITabBar appearance] setBackgroundColor:[UIColor colorWithHexColorString:@"000000"]];

    //设置tabbar Title 字体颜色
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:APP_COLOR_GRAY_333333, NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
  
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor colorWithHexColorString:@"000000"];
    view.frame = self.tabBar.bounds;
    [[UITabBar appearance] insertSubview:view atIndex:0];
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
    
    if ([self.title1 isEqualToString:@"首页"]) {
//        [self.vc PushViewControllerByClassName:@"PromulgateVC" info:nil];
        if (index == 0) {
            DEFAULTS_SET_OBJ(@"2", @"promulgateType");
            [self.vc PushViewControllerByClassName:@"PromulgateVC" info:nil];
        }
        if (index == 1) {
//            [[PushManager sharedManager] pushToVCWithClassName:@"MaintainVC" info:nil];
            [self.vc PushViewControllerByClassName:@"MaintainVC" info:nil];

        }
        if (index == 2) {
            
//            [[PushManager sharedManager] pushToVCWithClassName:@"AppraiseVC" info:nil];
            [self.vc PushViewControllerByClassName:@"AppraiseVC" info:nil];

        }

    }else{
        if (index == 0) {
            DEFAULTS_SET_OBJ(@"2", @"promulgateType");
            [[PushManager sharedManager] pushToVCWithClassName:@"PromulgateVC" info:nil];
        }
        if (index == 1) {
            [[PushManager sharedManager] pushToVCWithClassName:@"MaintainVC" info:nil];
        }
        if (index == 2) {
            [[PushManager sharedManager] pushToVCWithClassName:@"AppraiseVC" info:nil];
        }

    }
    
    [pop disMiss];
    
}


#pragma mark -- UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    int itemIndex = (scrollView.contentOffset.x + ViewWidth(scrollView) * 0.5) / ViewWidth(scrollView);
    self.pageControl.currentPage = itemIndex;
    if (itemIndex == 2) {
        [self initButton];
        
        
    }else{
        [self.view bringSubviewToFront:self.scrollView];
        [self.view bringSubviewToFront:self.pageControl];
        
        [_beginButton removeFromSuperview];
    }
}

#pragma mark -- Setter & Getter
- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
    }
    return _scrollView;
}

- (UIPageControl *)pageControl{
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc]initWithFrame:CGRectZero];
        _pageControl.numberOfPages = 3;
        //        _pageControl.currentPageIndicatorTintColor = App_COLOR_PAGECONTROL_CUREENTCOLOR;
        //        _pageControl.pageIndicatorTintColor = App_COLOR_PAGECONTROL_PAGECOLOR;
    }
    return _pageControl;
}


- (void)initButton{
    _beginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_beginButton setTitle:@"立即体验" forState:UIControlStateNormal];
    _beginButton.titleLabel.font = SYSTEMFONT(13);
    //    [_beginButton setBackgroundColor:App_COLOR_PAGECONTROL_PAGECOLOR];
    //    [_beginButton setTitleColor:APP_COLOR_BASE_Text_DarkGray forState:UIControlStateNormal];
    [_beginButton addTarget:self action:@selector(buttonCliked:) forControlEvents:UIControlEventTouchUpInside];
//    ViewRadius(_beginButton, 3.0);
    ViewBorderRadius(_beginButton, 15, 1, [UIColor whiteColor]);
    [self.scrollView addSubview:_beginButton];
    
    [_beginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(-(SCREEN_WIDTH - 60)/2);
        make.bottom.equalTo(self.view).offset(-100);
        make.width.equalTo(@60);
        make.height.equalTo(@30);
    }];
    
}

- (void)viewWillLayoutSubviews{
    _pageControl.frame = CGRectMake(0, ViewHeight(self.scrollView) -50, ViewWidth(self.scrollView), 40);
}

- (void)buttonCliked:(UIButton *)sender{
    
    

    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    
    dispatch_async(queue, ^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            
            [UIView animateWithDuration:1.0 animations:^{
                self.scrollView.alpha = 0 ;
                
            } completion:^(BOOL finished) {
                [self.scrollView removeFromSuperview];
                [self.pageControl removeFromSuperview];
            }];
            
            
            
            
        });
    });
    
    
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
//    LJLog(@"item name = %@", item.title);
//    NSLog(@"%@",item.title);
    self.title1 = item.title;
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
