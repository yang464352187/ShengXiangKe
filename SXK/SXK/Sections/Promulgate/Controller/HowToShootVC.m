//
//  HowToShootVC.m
//  SXK
//
//  Created by 杨伟康 on 2016/12/19.
//  Copyright © 2016年 ywk. All rights reserved.
//

#import "HowToShootVC.h"

@interface HowToShootVC ()

@end

@implementation HowToShootVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"如何拍摄";
    
    
    UIImageView *image = [[UIImageView alloc] initWithFrame:VIEWFRAME(0, 0, SCREEN_WIDTH, SCREEN_HIGHT)];
    image.image = [UIImage imageNamed:@"如何拍摄"];
    [self.view addSubview:image];

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
