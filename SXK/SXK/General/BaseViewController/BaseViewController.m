//
//  BaseViewController.m
//  SXK
//
//  Created by 杨伟康 on 2016/11/24.
//  Copyright © 2016年 ywk. All rights reserved.
//

#import "BaseViewController.h"
#import "AppDelegate.h"
#import "LoginVCViewController.h"
#import "LoginVC.h"
@interface BaseViewController ()<PushManagerDelegate>

@property (strong, nonatomic) UIView * failView;
@property (strong, nonatomic) UIView * waitView;
@property (strong, nonatomic) UIImageView *loading;

@end

@implementation BaseViewController{
    BOOL _canPush;
}

#pragma mark - View Controller Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _canPush = YES;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // TODO:
//    NSLog(@"出现");
    [PushManager sharedManager].delegate = self;
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    // TODO:这里做Aotulayout改变处理
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    // TODO:这里
//    NSLog(@"消失");
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self]; // 确保视图注销的时候移除所有通知
    NSLog(@"dealloc:%@",NSStringFromClass(self.class));
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark -- pushmanager delegate
- (void)pushToVCWithClassName:(NSString *)name info:(NSDictionary *)info{
    [self PushViewControllerByClassName:name info:info];
}

#pragma mark -- push跳转
- (void)PushViewControllerByClassName:(NSString *)className info:(NSDictionary *)info{
    //初步设计  防止多重跳转 待优化
    if (!_canPush) {
        return;
    }
    _canPush = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.75 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        _canPush = YES;
    });
    // 初始化传递进来的类
    Class class                = NSClassFromString( className );
    id pClass                  = [[class alloc] init];
    
    NSLog(@"class %@",[self class]);
    // 将需要传递的值放入notification中
    [pClass performSelector:@selector(setMyDict:) withObject:info];
    [self.navigationController pushViewController:pClass animated:YES];
}

/**
 *  跳转会指定界面后进入指定VC
 *
 *  @param index tabBar中的位置
 */
- (void)PopToRootViewControllerWithIndex:(NSInteger)index{
    [self PopToRootViewController];
    //[(UITabBarController *)[self.navigationController.navigationController.viewControllers firstObject] setSelectedIndex:index];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.20 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        CATransition *transition = [CATransition animation];
        [transition setDuration:0.2];
        [transition setType:@"moveIn"];
        
        UITabBarController *tabar = (UITabBarController *)((AppDelegate *)[[UIApplication sharedApplication] delegate]).window.rootViewController;
        [tabar.view.layer addAnimation:transition forKey:nil];
        [tabar setSelectedIndex:index];
    });
}


/**
 *  跳转回根视图
 */
- (void)PopToRootViewController{
    [self.navigationController popToRootViewControllerAnimated:YES];
}


#pragma mark -- present
- (void)PresentViewControllerByClassName:(NSString *)className info:(NSDictionary *)info{
    // 初始化传递进来的类
    Class class                = NSClassFromString( className );
    id pClass                  = [[class alloc] init];
    BaseNavigationVC *navi     = [[BaseNavigationVC alloc] initWithRootViewController:pClass];
    // 将需要传递的值放入notification中
    //navi.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    [pClass performSelector:@selector(setMyDict:) withObject:info];
    
    navi.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    //self.tabBarController.modalPresentationStyle = UIModalPresentationCurrentContext;

    [self.tabBarController presentViewController:navi animated:YES completion:nil];
}

/**
 *  push跳转  注意：所有需要用lcn导航栏的push跳转都必须使用此函数
 *
 *  @param viewController 跳转VC
 */
- (void)pushViewController:(UIViewController *)viewController{
 
    //关闭键盘
     //[[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    //跳转
    [self.navigationController pushViewController:viewController animated:YES];
    
}

-(void)PopToIndexViewController:(NSInteger)index{
    NSArray * ctrlArray = self.jt_navigationController.viewControllers;
    [self.jt_navigationController popToViewController:[ctrlArray objectAtIndex:index] animated:YES];
}

#pragma mark -- 设置按钮

/**
 *  设置导航栏右按钮
 *
 *  @param data title 或者 image
 *  @param sel  方法
 *
 *  @return 右按钮
 */
- (UIBarButtonItem *)setRightBarButtonWith:(id)data selector:(SEL)sel{
    if ([data isKindOfClass:[NSString class]]) {
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:data style:UIBarButtonItemStylePlain target:self action:sel];
        self.navigationItem.rightBarButtonItem = item;
        self.navigationItem.rightBarButtonItem.tintColor = APP_COLOR_GREEN;
        return item;
    }else if ([data isKindOfClass:[UIImage class]]){
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:data style:UIBarButtonItemStylePlain target:self action:sel];
        self.navigationItem.rightBarButtonItem = item;
        return item;
    }
    return nil;
}

/**
 *  设置自定义返回方法
 *
 *  @param sel 方法
 */
- (void)setLeftBackButtonWithSelector:(SEL)sel{
    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Left"] style:UIBarButtonItemStylePlain target:self action:sel];
    self.navigationItem.leftBarButtonItem = button;
}

#pragma mark -- 加载界面 和 加载失败界面

/**
 *  开始加载界面
 *
 *  @param frame 加载位置 空即为手机屏幕大小
 */
- (void)startLoadingView:(CGRect)frame{
    if (![self.waitView superview]) {
        [self.view addSubview:self.waitView];
        self.waitView.frame = frame;
    }
    [self.view bringSubviewToFront:self.waitView];
    [self.loading startAnimating];
}

/**
 *  结束加载界面
 */
- (void)stopLoadingView{
    [self.loading stopAnimating];
    [self.waitView removeFromSuperview];
    self.waitView = nil;
    self.loading  = nil;
    if (_failView) {
        [self.failView removeFromSuperview];
        self.failView = nil;
    }
}


/**
 *  进入加载界面时调用的请求，以便请求失败时，重新请求
 */
- (void)loadingRequest{}

/**
 *  请求失败时 出现的界面
 */
- (void)showFailView{
//    [self.loading stopAnimating];
    if ([self.failView superview]) {
        [self.view bringSubviewToFront:self.failView];
    }else{
        [self.view addSubview:self.failView];
        self.failView.frame = self.waitView.frame;
    }
}

- (void)presentLoginVC{
    LoginVC *vc = [[LoginVC alloc] init];
    BaseNavigationVC *navi = [[BaseNavigationVC alloc] initWithRootViewController:vc];
    [((AppDelegate *)[[UIApplication sharedApplication] delegate]).window.rootViewController presentViewController:navi animated:YES completion:nil];
//    [self presentViewController:navi  animated:YES completion:nil];
//    NSLog(@"11111");
    
}

#pragma mark - NavigationBarButton Event Response
- (void)popGoBack {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)dismissGoback {
    [self dismissViewControllerAnimated:YES completion:nil];
}



#pragma mark -- getters and setters

- (UIView *)waitView{
    if (!_waitView) {
        _waitView = [[UIView alloc] init];
        _waitView.backgroundColor = APP_COLOR_BASE_BACKGROUND;
        UILabel *label = [UILabel createLabelWithFrame:VIEWFRAME(0, 25, SCREEN_WIDTH, 25)
                                               andText:@"正在努力加载中..."
                                          andTextColor:APP_COLOR_GRAY_333333
                                            andBgColor:[UIColor clearColor]
                                               andFont:SYSTEMFONT(15)
                                      andTextAlignment:NSTextAlignmentCenter];
//        _waitView.alpha=0;
        [_waitView addSubview:self.loading];
        [_waitView addSubview:label];
        
        [self.loading mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(100, 100));
            make.centerX.equalTo(_waitView.mas_centerX);
            make.centerY.equalTo(_waitView.mas_centerY).offset(-75);
        }];
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_offset(20);
            make.top.equalTo(_loading.mas_bottom).offset(5);
            make.centerX.equalTo(_loading.mas_centerX);
        }];
        
    }
    return _waitView;
}

- (UIView *)failView{
    if (!_failView) {
        _failView = [[UIView alloc] init];
        _failView.backgroundColor = APP_COLOR_BASE_BACKGROUND;
        
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"BaseLogo"]];
        
        UILabel *label = [UILabel createLabelWithFrame:VIEWFRAME(0, 25, SCREEN_WIDTH, 25)
                                               andText:@"糟糕，加载失败了～"
                                          andTextColor:APP_COLOR_GRAY_333333
                                            andBgColor:[UIColor clearColor]
                                               andFont:SYSTEMFONT(15)
                                      andTextAlignment:NSTextAlignmentCenter];
        
        UIButton *request = [UIButton buttonWithType:UIButtonTypeCustom];
        request.titleLabel.font = SYSTEMFONT(15);
        [request setTitle:@"重新加载" forState:UIControlStateNormal];
        [request setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [request setBackgroundColor:APP_COLOR_GREEN];
        [request addTarget:self action:@selector(loadingRequest) forControlEvents:UIControlEventTouchUpInside];
        ViewRadius(request, 7);
        
        [_failView addSubview:imageView];
        [_failView addSubview:request];
        [_failView addSubview:label];
        
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(55, 65));
            make.centerX.equalTo(_failView.mas_centerX);
            make.centerY.equalTo(_failView.mas_centerY).offset(-100);
        }];

        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_offset(20);
            make.centerX.equalTo(_failView.mas_centerX);
            make.top.equalTo(imageView.mas_bottom).offset(25);
        }];
        
        [request mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(130, 35));
            make.centerX.equalTo(_failView.mas_centerX);
            make.top.equalTo(label.mas_bottom).offset(25);
        }];
        
    }
    return _failView;
}

- (UIImageView *)loading{
    if (!_loading) {
        _loading = [[UIImageView alloc] init];
        NSMutableArray *refreshingImages = [NSMutableArray array];
        for (NSUInteger i = 0; i<=7; i++) {
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"Sources4_0%zd", i]];
            [refreshingImages addObject:image];
        }
        _loading.animationImages = refreshingImages;
        _loading.animationDuration = 1;

    }
    return _loading;
}

- (id)preViewController{
    if (self.jt_navigationController.jt_viewControllers.count < 2) return nil;
    return self.jt_navigationController.jt_viewControllers[self.jt_navigationController.jt_viewControllers.count - 2];
}

/** 是否安装支付 否则弹出提示框c*/
- (BOOL)hasfixalipay  {
    if ( [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"alipay://"]])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您还没安装支付宝,请前往AppStore中下载安装" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        return NO;
    }else{
        return YES;
    }
}

@end
