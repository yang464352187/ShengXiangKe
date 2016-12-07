//
//  DeleteView.m
//  SXK
//
//  Created by 杨伟康 on 2016/12/7.
//  Copyright © 2016年 ywk. All rights reserved.
//

#import "DeleteView.h"
#import "AppDelegate.h"

@interface DeleteView ()

@property (nonatomic, strong)UIView *backGroundView;

@property (nonatomic, strong)UIView *alertView;

@property (nonatomic, strong)UILabel *titleLab;

@end

@implementation DeleteView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.alpha = 0;
        self.frame = frame;
        [self loadSubView];
    }
    return self;
}

-(void)loadSubView
{
    self.backGroundView  = [[UIView alloc] initWithFrame:VIEWFRAME(0, 0, SCREEN_WIDTH, SCREEN_HIGHT)];
    self.backGroundView.backgroundColor = [UIColor colorWithHexColorString:@"3c3c3c"];
    self.backGroundView.alpha = 0;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self.backGroundView addGestureRecognizer:tap];
    
    
    self.alertView = [[UIView alloc] initWithFrame:VIEWFRAME(30, SCREEN_HIGHT, SCREEN_WIDTH - 60, 190)];
    self.alertView.backgroundColor = [UIColor whiteColor];
    
    
    self.titleLab = [UILabel createLabelWithFrame:VIEWFRAME(0, 50,self.alertView.frame.size.width, 16)                                                 andText:@"确定删除地址吗？"
                                     andTextColor:[UIColor blackColor]
                                       andBgColor:[UIColor clearColor]
                                          andFont:SYSTEMFONT(16)
                                 andTextAlignment:NSTextAlignmentCenter];

    UIButton *cancelBtn =[UIButton buttonWithType:UIButtonTypeSystem];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor colorWithHexColorString:@"aaaaaa"] forState:UIControlStateNormal];
    cancelBtn.frame = VIEWFRAME((self.alertView.bounds.size.width - 212)/2, 111, 81, 27);
    [cancelBtn addTarget:self action:@selector(cancelBtn:) forControlEvents:UIControlEventTouchUpInside];
    ViewBorderRadius(cancelBtn, 27/2, 0.5, [UIColor colorWithHexColorString:@"aaaaaa"]);
    
    UIButton *certainBtn =[UIButton buttonWithType:UIButtonTypeSystem];
    [certainBtn setTitle:@"确定" forState:UIControlStateNormal];
    [certainBtn setTitleColor:APP_COLOR_GREEN forState:UIControlStateNormal];
    [certainBtn addTarget:self action:@selector(certainBtn:) forControlEvents:UIControlEventTouchUpInside];
    certainBtn.frame = VIEWFRAME((self.alertView.bounds.size.width - 212)/2+131, 111, 81, 27);
    ViewBorderRadius(certainBtn, 27/2, 0.5, APP_COLOR_GREEN);
    
    [self.alertView addSubview:self.titleLab];
    [self.alertView addSubview:cancelBtn];
    [self.alertView addSubview:certainBtn];
}

-(void)show
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate.window addSubview:self.backGroundView];
    [appDelegate.window addSubview:self.alertView];
    self.backGroundView.alpha = 0.8;
    
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    
    dispatch_async(queue, ^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [UIView animateWithDuration:0.5 animations:^{
                
                self.alertView.frame = VIEWFRAME(30, CommonHight(220), SCREEN_WIDTH - 60, 180);
                
            } completion:^(BOOL finished) {
                
            }];
        });
    });
    
}

-(void)tapAction:(UITapGestureRecognizer *)tap
{
    [self disMiss];
}

-(void)disMiss
{
    
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    
    dispatch_async(queue, ^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [UIView animateWithDuration:0.5 animations:^{
                
                self.alertView.frame = VIEWFRAME(30, SCREEN_HIGHT,SCREEN_WIDTH - 60, CommonHight(180));
                
            } completion:^(BOOL finished) {
                
                [self.backGroundView removeFromSuperview];
                [self.alertView removeFromSuperview];
                
            }];
        });
    });
    
}

-(void)cancelBtn:(UIButton *)sender
{
    [self disMiss];
}

-(void)certainBtn:(UIButton *)sender
{
    [self disMiss];
    [_delegate deleteAddress];
}

@end
