//
//  PersonalSummaryVC.m
//  SXK
//
//  Created by 杨伟康 on 2016/12/2.
//  Copyright © 2016年 ywk. All rights reserved.
//

#import "PersonalSummaryVC.h"
#import "FEPlaceHolderTextView.h"

@interface PersonalSummaryVC ()

@property (nonatomic, strong)FEPlaceHolderTextView *textView;

@end

@implementation PersonalSummaryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"个人简介";
    [self.view addSubview:self.textView];
    
    [self initUI];
}

-(void)initUI
{
    UIButton *certainBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [certainBtn setTitle:@"提交" forState:UIControlStateNormal];
    certainBtn.backgroundColor = APP_COLOR_GREEN;
    [certainBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    certainBtn.titleLabel.font = SYSTEMFONT(14);
    certainBtn.frame = VIEWFRAME(15, 15+CommonHight(220)+40, CommonWidth(335), 40);
    ViewRadius(certainBtn, certainBtn.frame.size.height/2);
    [self.view addSubview:certainBtn];
    
}

-(UITextView *)textView
{
    if (!_textView) {
        _textView = [[FEPlaceHolderTextView alloc] initWithFrame:VIEWFRAME(15, 15, CommonWidth(345), CommonHight(220))];
        _textView.backgroundColor = [UIColor colorWithHexColorString:@"eeeeee"];
        _textView.placeholder = @"请输入您的个人简介";
        _textView.placeholderColor = [UIColor colorWithHexColorString:@"a1a1a1"];
        [_textView setFont:SYSTEMFONT(14)];
    }
    return _textView;
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
