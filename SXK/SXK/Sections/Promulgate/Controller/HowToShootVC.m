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
    NSString *headImage = self.myDict[@"image"];
    UIImageView *image = [[UIImageView alloc] initWithFrame:VIEWFRAME(0, 0, SCREEN_WIDTH, SCREEN_HIGHT)];
    if (SCREEN_WIDTH > 320) {
        image.frame = VIEWFRAME(0, -40, SCREEN_WIDTH, SCREEN_HIGHT);
    }
    if (headImage.length > 0 ) {
        [image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",APP_BASEIMG,headImage]]];
    }else{
        image.image = [UIImage imageNamed:@"如何拍摄"];
    }
    image.contentMode = UIViewContentModeScaleAspectFit;
//    image.clipsToBounds =YES;
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
