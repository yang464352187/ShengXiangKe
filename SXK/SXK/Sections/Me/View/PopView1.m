//
//  PopView1.m
//  SXK
//
//  Created by 杨伟康 on 2017/1/23.
//  Copyright © 2017年 ywk. All rights reserved.
//

#import "PopView1.h"
#import "AppDelegate.h"

@interface PopView1()

@property (nonatomic, strong)UIView *alterView;

@property (nonatomic, strong)UILabel *title;

@property (nonatomic, strong)UILabel *titleLab;

@property (nonatomic, strong)UIView *backGroundView;

@property (nonatomic, assign)NSInteger index;

@property (nonatomic, strong)NSString *title1;

@property (nonatomic, strong)NSString *title2;

@property (nonatomic, assign)NSInteger type;
@end


@implementation PopView1

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

    self.alterView = [[UIView alloc] initWithFrame:VIEWFRAME((SCREEN_WIDTH - CommonWidth(315))/2, SCREEN_HIGHT, CommonWidth(315), 165)];
    self.alterView.backgroundColor = [UIColor whiteColor];
    
    self.titleLab = [UILabel createLabelWithFrame:VIEWFRAME(0, 50,  CommonWidth(315), 14)                                                 andText:@"是否删除订单"
                                      andTextColor:[UIColor blackColor]
                                        andBgColor:[UIColor clearColor]
                                           andFont:SYSTEMFONT(14)
                                  andTextAlignment:NSTextAlignmentCenter];
    
    UIButton *cancelBtn =[UIButton buttonWithType:UIButtonTypeSystem];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor colorWithHexColorString:@"aaaaaa"] forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
    cancelBtn.frame = VIEWFRAME(CommonWidth(57), 100, 81, 27);
    ViewBorderRadius(cancelBtn, 27/2, 0.5, [UIColor colorWithHexColorString:@"aaaaaa"]);
    
    UIButton *certainBtn =[UIButton buttonWithType:UIButtonTypeSystem];
    [certainBtn setTitle:@"确定" forState:UIControlStateNormal];
    [certainBtn setTitleColor:APP_COLOR_GREEN forState:UIControlStateNormal];
    [certainBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    certainBtn.frame = VIEWFRAME(CommonWidth(178), 100, 81, 27);
    ViewBorderRadius(certainBtn, 27/2, 0.5, APP_COLOR_GREEN);

    [self.alterView addSubview:self.titleLab];
    [self.alterView addSubview:cancelBtn];
    [self.alterView addSubview:certainBtn];
    
}

-(void)show
{
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate.window addSubview:self.backGroundView];
    [appDelegate.window addSubview:self.alterView];
    self.backGroundView.alpha = 0.5;
    
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    
    dispatch_async(queue, ^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [UIView animateWithDuration:0.5 animations:^{
                
                self.alterView.frame = VIEWFRAME((SCREEN_WIDTH - CommonWidth(315))/2, CommonHight(240), CommonWidth(315), 165);
                
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
                
                self.alterView.frame = VIEWFRAME((SCREEN_WIDTH - CommonWidth(315))/2, SCREEN_HIGHT,CommonWidth(315), 165);
                
            } completion:^(BOOL finished) {
                
                [self.backGroundView removeFromSuperview];
                [self.alterView removeFromSuperview];
                
            }];
        });
    });
    
}

-(void)cancelAction:(UIButton *)sender
{
    [self disMiss];

}

-(void)buttonAction:(UIButton *)sender
{
    if ([self.title2 isEqualToString:@"是否删除订单?"]) {
        
        
        if (self.type == 2) {
            [BaseRequest DeletePurchaseOrderWithOrderID:self.index succesBlock:^(id data) {
                if ([self.delegate respondsToSelector:@selector(success)]) {
                    [self.delegate success];
                }
                [ProgressHUDHandler showHudTipStr:@"删除成功"];
                [self disMiss];
                
            } failue:^(id data, NSError *error) {
                
            }];
        
            return;
        }
        
        
        
        
        return;
        
    }
    if ([self.title2 isEqualToString:@"是否确认收货?"]) {
        [BaseRequest ConfirmPurchaseOrderWithRentID:self.index succesBlock:^(id data) {
            if ([self.delegate respondsToSelector:@selector(success)]) {
                [self.delegate success];
            }
            [ProgressHUDHandler showHudTipStr:@"确认完成"];
            [self disMiss];
            
        } failue:^(id data, NSError *error) {
            
        }];
        return;
    }
    
    
    
    
    
    if ([self.title1 isEqualToString:@"是否删除订单?"]) {
        [BaseRequest DeleteRentOrderWithRentID:self.index succesBlock:^(id data) {
            if ([self.delegate respondsToSelector:@selector(success)]) {
                [self.delegate success];
            }
            [ProgressHUDHandler showHudTipStr:@"删除成功"];
            [self disMiss];
        } failue:^(id data, NSError *error) {
            
        }];

    }else if([self.title1 isEqualToString:@"是否下架商品?"]){
        [BaseRequest UnderCarriageOrderWithRentID:self.index succesBlock:^(id data) {
            if ([self.delegate respondsToSelector:@selector(success)]) {
                [self.delegate success];
            }
            [ProgressHUDHandler showHudTipStr:@"下架成功"];
            [self disMiss];
        } failue:^(id data, NSError *error) {
            
        }];
    }else if ([self.title1 isEqualToString:@"是否确认完成?"]){
        
        [BaseRequest ConfirmMyMaintainOrderWithOrderID:self.index succesBlock:^(id data) {
            if ([self.delegate respondsToSelector:@selector(success)]) {
                [self.delegate success];
            }
            [ProgressHUDHandler showHudTipStr:@"确认完成"];
            [self disMiss];
            
        } failue:^(id data, NSError *error) {
            
        }];
        
    }else if ([self.title1 isEqualToString:@"是否确认收货?"])
    {
//        NSLog(@"22222");
        [BaseRequest ConfirmOrderWithRentID:self.index succesBlock:^(id data) {
            if ([self.delegate respondsToSelector:@selector(success)]) {
                [self.delegate success];
            }
            [ProgressHUDHandler showHudTipStr:@"确认完成"];
            [self disMiss];
        } failue:^(id data, NSError *error) {
            
        }];
    }else if ([self.title1 isEqualToString:@"是否确认删除?"]){
        
        [BaseRequest DeleteRentOrderWithRentID:self.index succesBlock:^(id data) {
            if ([self.delegate respondsToSelector:@selector(success)]) {
                [self.delegate success];
            }
            [ProgressHUDHandler showHudTipStr:@"删除成功"];
            [self disMiss];
        } failue:^(id data, NSError *error) {
            
        }];
    }else if ([self.title1 isEqualToString:@"确认完成鉴定?"]){
        
        [BaseRequest ConfirmMyAppraiseWithOrderID:self.index succesBlock:^(id data) {
            
            if ([self.delegate respondsToSelector:@selector(success)]) {
                [self.delegate success];
            }
            [ProgressHUDHandler showHudTipStr:@"确认完成"];
            [self disMiss];

        } failue:^(id data, NSError *error) {
            
        }];
        
    }
    
    else{
        
        [BaseRequest RecoverOrderWithRentID:self.index oddNumber:@"" succesBlock:^(id data) {
            if ([self.delegate respondsToSelector:@selector(success)]) {
                [self.delegate success];
            }
            [ProgressHUDHandler showHudTipStr:@"回收成功"];
            [self disMiss];

        } failue:^(id data, NSError *error) {
            
        }];
    }
    
    self.title1 = @"";
    self.title2 = @"";
    

}

-(void)changeTitle:(NSString *)title andIdex:(NSInteger)index
{
    self.titleLab.text = title;
    self.index = index;
    self.title1 = title;
    self.title2 =@"";
}

-(void)changeTitle2:(NSString *)title andIdex:(NSInteger)index type:(NSInteger)type
{
    self.titleLab.text = title;
    self.index = index;
    self.title2 = title;
    self.title1 = @"";
    self.type = type;
}


@end
