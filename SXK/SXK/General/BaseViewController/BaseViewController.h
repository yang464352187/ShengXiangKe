//
//  BaseViewController.h
//  SXK
//
//  Created by 杨伟康 on 2016/11/24.
//  Copyright © 2016年 ywk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

// 用来页面传值
@property (nonatomic, strong) NSDictionary *myDict;
//用来反向传值
@property (nonatomic, strong) NSDictionary *data;


/**
 *  push跳转
 *
 *  @param className 跳转的VC名称
 *  @param info      跳转需要传递的值
 */
- (void)PushViewControllerByClassName:(NSString *)className info:(NSDictionary *)info;

/**
 *  跳转会指定界面后进入指定VC
 *
 *  @param index tabBar中的位置
 */
- (void)PopToRootViewControllerWithIndex:(NSInteger)index;

/**
 *  跳转回根视图
 */
- (void)PopToRootViewController;

/**
 *  present跳转
 *
 *  @param className 跳转的VC名称
 *  @param info      跳转需要传递的值
 */
- (void)PresentViewControllerByClassName:(NSString *)className info:(NSDictionary *)info;

/**
 *  设置导航栏右按钮
 *
 *  @param data title 或者 image
 *  @param sel  方法
 *
 *  @return 右按钮
 */
- (UIBarButtonItem *)setRightBarButtonWith:(id)data selector:(SEL)sel;

/**
 *  设置自定义返回方法
 *
 *  @param sel 方法
 */
- (void)setLeftBackButtonWithSelector:(SEL)sel;

/**
 *  push跳转  注意：所有需要用lcn导航栏的push跳转都必须使用此函数
 *
 *  @param viewController 跳转VC
 */
- (void)pushViewController:(UIViewController *)viewController;

/**
 *  开始加载界面
 *
 *  @param frame 加载位置 空即为手机屏幕大小
 */
- (void)startLoadingView:(CGRect)frame;

/**
 *  结束加载界面
 */
- (void)stopLoadingView;

/**
 *  进入加载界面时调用的请求，以便请求失败时，重新请求
 */
- (void)loadingRequest;

/**
 *  请求失败时 出现的界面
 */
- (void)showFailView;


/** 弹出登录界面的方法*/
- (void)presentLoginVC;

/** pop返回上级页面方法*/
- (void)popGoBack;
/** dismiss返回页面方法*/
- (void)dismissGoback;

/** 获取push出该页面的vc*/
- (id)preViewController;

/** 是否安装支付 否则弹出提示框c*/
- (BOOL)hasfixalipay;

-(void)PopToIndexViewController:(NSInteger)index;


@end
