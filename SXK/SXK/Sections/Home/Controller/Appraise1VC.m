//
//  Appraise1VC.m
//  SXK
//
//  Created by 杨伟康 on 2017/1/17.
//  Copyright © 2017年 ywk. All rights reserved.
//

#import "Appraise1VC.h"

@interface Appraise1VC ()


@end

@implementation Appraise1VC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"鉴定";
    [self initUI];
}

-(void)initUI
{
    UIView *line1 = [[UIView alloc] init];
    UIView *line2 = [[UIView alloc] init];
    line1.backgroundColor = [UIColor grayColor];
    line2.backgroundColor = [UIColor grayColor];

    UILabel *title = [UILabel createLabelWithFrame:VIEWFRAME(90,18, SCREEN_WIDTH - 120, 14)
                                      andText:@"AUTHENTICATE"
                                 andTextColor:[UIColor blackColor]
                                   andBgColor:[UIColor clearColor]
                                      andFont:SYSTEMFONT(14)
                             andTextAlignment:NSTextAlignmentCenter];
    UILabel *title1 = [UILabel createLabelWithFrame:VIEWFRAME(90,18, SCREEN_WIDTH - 120, 14)
                                           andText:@"鉴定"
                                      andTextColor:[UIColor blackColor]
                                        andBgColor:[UIColor clearColor]
                                           andFont:SYSTEMFONT(14)
                                  andTextAlignment:NSTextAlignmentCenter];

    UIImageView *imageView1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mianfeijianding"]];
    UIImageView *imageView2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"zhongjian"]];
    imageView1.userInteractionEnabled = YES;
    imageView2.userInteractionEnabled = YES;
    [imageView1 setUserInteractionEnabled:YES];
    [imageView2 setUserInteractionEnabled:YES];
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapAction:)];
    UITapGestureRecognizer *singleTap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapAction1:)];
    [imageView1 addGestureRecognizer:singleTap];
    [imageView2 addGestureRecognizer:singleTap1];

    
    [self.view addSubview:title];
    [self.view addSubview:title1];
    [self.view addSubview:line1];
    [self.view addSubview:line2];
    [self.view addSubview:imageView1];
    [self.view addSubview:imageView2];

    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view).offset(0);
        make.top.equalTo(self.view.mas_top).offset(28);
        make.size.mas_equalTo(CGSizeMake(108, 15));
    }];
    
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(title).offset(0);
        make.right.equalTo(title.mas_left).offset(-5);
        make.size.mas_equalTo(CGSizeMake(20, 0.5));
    }];

    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(title).offset(0);
        make.left.equalTo(title.mas_right).offset(5);
        make.size.mas_equalTo(CGSizeMake(20, 0.5));
    }];
    
    [title1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view).offset(0);
        make.top.equalTo(title.mas_bottom).offset(10);
        make.size.mas_equalTo(CGSizeMake(108, 15));
    }];
    
    [imageView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(title1.mas_bottom).offset(29);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(CommonHight(220));
    }];
    
    [imageView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imageView1.mas_bottom).offset(29);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(CommonHight(220));
    }];


}


-(void)singleTapAction:(UITapGestureRecognizer *)tap
{
    [self PushViewControllerByClassName:@"FreeAppraiseVC" info:nil];
}
-(void)singleTapAction1:(UITapGestureRecognizer *)tap
{
    [self PushViewControllerByClassName:@"AppraiseVC" info:nil];
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
