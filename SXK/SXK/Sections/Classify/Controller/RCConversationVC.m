//
//  RCConversationVC.m
//  SXK
//
//  Created by 杨伟康 on 2017/2/9.
//  Copyright © 2017年 ywk. All rights reserved.
//

#import "RCConversationVC.h"

@interface RCConversationVC ()

@end

@implementation RCConversationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)willDisplayMessageCell:(RCMessageBaseCell *)cell
                   atIndexPath:(NSIndexPath *)indexPath;{
    
    RCMessageCell *cell1 = (RCMessageCell *)cell;
    cell1.messageContentView.backgroundColor = [UIColor greenColor];
    NSInteger i = 0;
    
    for (UIView *view in cell1.messageContentView.subviews) {
        
    }
//    NSLog(@"%ld",i);
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
