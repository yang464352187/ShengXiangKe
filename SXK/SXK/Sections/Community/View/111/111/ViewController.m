//
//  ViewController.m
//  111
//
//  Created by 杨伟康 on 2016/12/2.
//  Copyright © 2016年 ywk. All rights reserved.
//

#import "ViewController.h"
#import "HZWSelectTime.h"

@interface ViewController ()<HZWPickerDelegate>
@property(nonatomic,strong)HZWSelectTime *picker;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _picker = [[HZWSelectTime alloc] initWithFrame:CGRectMake(0, 200, 200, 50) andDelegate:self];
    
    //    [_picker show];
    
    [self.view addSubview:_picker];

}
- (void)changeTime:(NSString *)time
{
    NSLog(@"返回的时间:%@",time);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
