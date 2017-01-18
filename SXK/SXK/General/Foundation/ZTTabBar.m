//
//  ZTTabBar.m
//  SinaWeibo
//
//  Created by user on 15/10/16.
//  Copyright © 2015年 ZT. All rights reserved.
//
#define  kContentFrame  CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-kTabbarHeight)
#define  kDockFrame CGRectMake(0, self.view.frame.size.height-kTabbarHeight, self.view.frame.size.width, kTabbarHeight)

#define kCameraViewWidth 49
#define kCameraViewHeight 60
#define kCameraBtnWidth kCameraViewWidth
#define kCameraBtnHeight 50


#import "ZTTabBar.h"

@interface ZTTabBar ()

@property (nonatomic, weak) UIView *plusBtn;

@end

@implementation ZTTabBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        _cameraView =[[UIView alloc]init];
        _cameraView.center = CGPointMake(SCREEN_WIDTH*0.5, SCREEN_HIGHT-(kCameraViewHeight*0.5));
        _cameraView.bounds = CGRectMake(0, 0, kCameraViewWidth, kCameraViewHeight+10);
        _cameraView.backgroundColor = [UIColor blackColor];
 
        _cameraView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tab_摄影机图标背景"]];
//        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:_cameraView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(20, 20)];
//        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
//        maskLayer.frame = _cameraView.bounds;
//        maskLayer.path = maskPath.CGPath;
//        _cameraView.layer.mask = maskLayer;
        
        if (SCREEN_HIGHT > 667) {
            UIView *line = [[UIView alloc] initWithFrame:VIEWFRAME(0, 0, kCameraViewWidth, 0.05)];
            line.backgroundColor = [UIColor whiteColor];
            [_cameraView addSubview:line];
        }
        _cameraBtn = [[UIButton alloc]init];
        [_cameraBtn setBackgroundImage:[UIImage imageNamed:@"+"] forState:UIControlStateNormal];
        [_cameraBtn setBackgroundImage:[UIImage imageNamed:@"+"] forState:UIControlStateHighlighted];
        _cameraBtn.frame = CGRectMake(3.5, 8.5, kCameraBtnWidth-7, kCameraBtnHeight-7);
        _cameraBtn.tag = 2;
        [_cameraBtn addTarget:self action:@selector(plusBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [_cameraView addSubview:_cameraBtn];
        [self addSubview: _cameraView];
        self.plusBtn = _cameraView;

    }
    return self;
}

/**
 *  加号按钮点击
 */
- (void)plusBtnClick
{
    // 通知代理
    if ([self.delegate respondsToSelector:@selector(tabBarDidClickPlusButton:)]) {
        [self.delegate tabBarDidClickPlusButton:self];
    }
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 1.设置加号按钮的位置
    self.plusBtn.centerX = self.width*0.5;
    self.plusBtn.centerY = self.height*0.5;

    [self bringSubviewToFront:self.plusBtn];
    
    // 2.设置其他tabbarButton的frame
    CGFloat tabBarButtonW = self.width / 5;
    CGFloat tabBarButtonIndex = 0;
    for (UIView *child in self.subviews) {
        Class class = NSClassFromString(@"UITabBarButton");
        if ([child isKindOfClass:class]) {
            // 设置x
            child.x = tabBarButtonIndex * tabBarButtonW;
            // 设置宽度
            child.width = tabBarButtonW;
            
            
            // 增加索引
            tabBarButtonIndex++;
            if (tabBarButtonIndex == 2) {
                tabBarButtonIndex++;
            }
        }
    }
}


/**
 *  想要重新排布系统控件subview的布局，推荐重写layoutSubviews，在调用父类布局后重新排布。
 */



@end
