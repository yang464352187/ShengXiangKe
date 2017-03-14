//
//  RegisteExamineVC.m
//  SXK
//
//  Created by 杨伟康 on 2017/2/27.
//  Copyright © 2017年 ywk. All rights reserved.
//

#import "RegisteExamineVC.h"

@interface RegisteExamineVC ()

@property (strong, nonatomic) UIView *headView;

@end

@implementation RegisteExamineVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"注册审核";
    [self.view addSubview:self.tableView];
}







- (UITableView *)tableView{
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:VIEWFRAME(0, 0, SCREEN_WIDTH, SCREEN_HIGHT-64) style:UITableViewStyleGrouped];
        _tableView.dataSource      = self;
        _tableView.delegate        = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.backgroundColor = [UIColor colorWithHexColorString:@"f7f7f7"];
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.tableHeaderView = self.headView;
        _tableView.separatorStyle  = UITableViewCellSeparatorStyleSingleLine;
        _tableView.sectionHeaderHeight = 0.0;
        _tableView.sectionFooterHeight = 0.0;
        
    }
    return _tableView;
}

- (UIView *)headView{
    if (!_headView) {
        _headView = [[UIView alloc] initWithFrame:VIEWFRAME(0, 0, SCREEN_WIDTH, 600)];
        _headView.backgroundColor = [UIColor whiteColor];
        
        UITextField *text1 = [[UITextField alloc] init];
        text1.placeholder = @"请输入您的姓名";
        text1.font = SYSTEMFONT(14);
        
        UIView *line1 = [[UIView alloc] init];
        line1.backgroundColor = APP_COLOR_GRAY_Line;
        
        UITextField *text2 = [[UITextField alloc] init];
        text2.placeholder = @"请输入您的身份证号码";
        text2.font = SYSTEMFONT(14);
        
        UIView *line2 = [[UIView alloc] init];
        line2.backgroundColor = APP_COLOR_GRAY_Line;
        
        UILabel *title1 = [UILabel createLabelWithFrame:VIEWFRAME(15, 0, 150, 53)                                                 andText:@"请上传手持身份证正面，手持身份证反面的照片，并保证证件号码清晰"
                                  andTextColor:[UIColor blackColor]
                                    andBgColor:[UIColor clearColor]
                                       andFont:SYSTEMFONT(13)
                              andTextAlignment:NSTextAlignmentLeft];
        title1.numberOfLines = 0;
        
        UIImage *image = [UIImage imageNamed:@"相机-(2)"];
        
        UIButton *firstBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [firstBtn setImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        [firstBtn addTarget:self  action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        firstBtn.tag = 100;
        
        UIButton *secondBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [secondBtn setImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        [secondBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        secondBtn.tag = 200;
        
        UIView *line3 = [[UIView alloc] init];
        line3.backgroundColor = APP_COLOR_GRAY_Line;

        UILabel *title2 = [UILabel createLabelWithFrame:VIEWFRAME(15, 0, 150, 53)                                                 andText:@"感谢您对啵呗的关注,我们将在3-5个工作日内对您的资料进行审核,请耐心等待"
                                           andTextColor:[UIColor blackColor]
                                             andBgColor:[UIColor clearColor]
                                                andFont:SYSTEMFONT(13)
                                       andTextAlignment:NSTextAlignmentLeft];
        title2.numberOfLines = 0;
        
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = APP_COLOR_GRAY_Header;
        
        UILabel *title3 = [UILabel createLabelWithFrame:VIEWFRAME(15, 0, 150, 53)                                                 andText:@"缴纳保证金"
                                           andTextColor:[UIColor blackColor]
                                             andBgColor:[UIColor clearColor]
                                                andFont:SYSTEMFONT(13)
                                       andTextAlignment:NSTextAlignmentLeft];

        
        UITextField *text3 = [[UITextField alloc] init];
        text3.placeholder = @"请输入保证金(不低于300)";
        text3.font = SYSTEMFONT(14);

        UIButton *certainBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [certainBtn setTitle:@"提交" forState:UIControlStateNormal];
        certainBtn.backgroundColor = APP_COLOR_GREEN;
        [certainBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        certainBtn.titleLabel.font = SYSTEMFONT(14);
        certainBtn.frame = VIEWFRAME(15, 20, CommonWidth(335), 40);
        ViewRadius(certainBtn, certainBtn.frame.size.height/2);
        certainBtn.tag = 300;
        [certainBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];

        [_headView addSubview:text1];
        [_headView addSubview:text2];
        [_headView addSubview:text3];
        [_headView addSubview:line1];
        [_headView addSubview:line2];
        [_headView addSubview:line3];
        [_headView addSubview:title1];
        [_headView addSubview:title2];
        [_headView addSubview:firstBtn];
        [_headView addSubview:secondBtn];
        [_headView addSubview:certainBtn];
        [_headView addSubview:view];
        [view addSubview:title3];
        
        [text1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_headView.mas_left).offset(15);
            make.top.equalTo(_headView.mas_top).offset(10);
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 15, 30));
        }];
        
        [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_headView.mas_left).offset(10);
            make.top.equalTo(text1.mas_bottom).offset(5);
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 10, 0.5));

        }];
        
        [text2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_headView.mas_left).offset(15);
            make.top.equalTo(line1.mas_bottom).offset(5);
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 15, 30));
        }];
        
        [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_headView.mas_left).offset(10);
            make.top.equalTo(text2.mas_bottom).offset(5);
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 10, 0.5));
        }];
        
        CGFloat height = [UILabel getHeightByWidth:SCREEN_WIDTH - 10 title:@"感谢您对啵呗的关注,我们将在3-5个工作日内对您的资料进行审核,请耐心等待" font:SYSTEMFONT(13)];
        
        [title1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_headView.mas_left).offset(10);
            make.top.equalTo(text2.mas_bottom).offset(30);
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 10, height));
        }];
        
        [firstBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(title1.mas_bottom).offset(20);
            make.left.equalTo(_headView.mas_left).offset(23);
            make.size.mas_equalTo(CGSizeMake((SCREEN_WIDTH - 70)/2,  CommonHight(105)));
        }];
        
        [secondBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(title1.mas_bottom).offset(20);
            make.left.equalTo(firstBtn.mas_right).offset(23);
            make.size.mas_equalTo(CGSizeMake((SCREEN_WIDTH - 70)/2, CommonHight(105)));
        }];
        
        [line3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_headView);
            make.top.equalTo(firstBtn.mas_bottom).offset(25);
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 20, 0.5));
        }];
        
        CGFloat height1 = [UILabel getHeightByWidth:SCREEN_WIDTH - 10 title:@"请上传手持身份证正面，手持身份证反面的照片，并保证证件号码清晰" font:SYSTEMFONT(13)];
        
        [title2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_headView.mas_left).offset(10);
            make.top.equalTo(line3.mas_bottom).offset(25);
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 10, height1));
        }];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_headView.mas_left).offset(0);
            make.top.equalTo(title2.mas_bottom).offset(25);
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH , 30));
        }];
        
        [title3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(view.mas_left).offset(10);
            make.centerY.equalTo(view);
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 10, 30));
        }];
        
        [text3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_headView.mas_left).offset(15);
            make.top.equalTo(view.mas_bottom).offset(15);
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 15, 30));
        }];
        
        [certainBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(text3.mas_bottom).offset(30);
            make.left.equalTo(_headView.mas_left).offset(15);
            make.right.equalTo(_headView.mas_right).offset(-15);
            make.height.mas_equalTo(40);
        }];
        
        
        
    }
    return _headView;
}



#pragma mark -- UITabelViewDelegate And DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    return nil;
}

-(void)btnAction:(UIButton *)sender
{
    
    
}

- (BOOL)isCorrect:(NSString *)IDNumber
{
    NSMutableArray *IDArray = [NSMutableArray array];
    // 遍历身份证字符串,存入数组中
    for (int i = 0; i < 18; i++) {
        NSRange range = NSMakeRange(i, 1);
        NSString *subString = [IDNumber substringWithRange:range];
        [IDArray addObject:subString];
    }
    // 系数数组
    NSArray *coefficientArray = [NSArray arrayWithObjects:@"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2", nil];
    // 余数数组
    NSArray *remainderArray = [NSArray arrayWithObjects:@"1", @"0", @"X", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2", nil];
    // 每一位身份证号码和对应系数相乘之后相加所得的和
    int sum = 0;
    for (int i = 0; i < 17; i++) {
        int coefficient = [coefficientArray[i] intValue];
        int ID = [IDArray[i] intValue];
        sum += coefficient * ID;
    }
    // 这个和除以11的余数对应的数
    NSString *str = remainderArray[(sum % 11)];
    // 身份证号码最后一位
    NSString *string = [IDNumber substringFromIndex:17];
    // 如果这个数字和身份证最后一位相同,则符合国家标准,返回YES
    if ([str isEqualToString:string]) {
        return YES;
    } else {
        return NO;
    }
}

- (BOOL)judgeIdentityStringValid:(NSString *)identityString {
    
    if (identityString.length != 18) return NO;
    // 正则表达式判断基本 身份证号是否满足格式
    NSString *regex2 = @"^(^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$)|(^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])((\\d{4})|\\d{3}[Xx])$)$";
    NSPredicate *identityStringPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    //如果通过该验证，说明身份证格式正确，但准确性还需计算
    if(![identityStringPredicate evaluateWithObject:identityString]) return NO;
    
    //** 开始进行校验 *//
    
    //将前17位加权因子保存在数组里
    NSArray *idCardWiArray = @[@"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2"];
    
    //这是除以11后，可能产生的11位余数、验证码，也保存成数组
    NSArray *idCardYArray = @[@"1", @"0", @"10", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2"];
    
    //用来保存前17位各自乖以加权因子后的总和
    NSInteger idCardWiSum = 0;
    for(int i = 0;i < 17;i++) {
        NSInteger subStrIndex = [[identityString substringWithRange:NSMakeRange(i, 1)] integerValue];
        NSInteger idCardWiIndex = [[idCardWiArray objectAtIndex:i] integerValue];
        idCardWiSum+= subStrIndex * idCardWiIndex;
    }
    
    //计算出校验码所在数组的位置
    NSInteger idCardMod=idCardWiSum%11;
    //得到最后一位身份证号码
    NSString *idCardLast= [identityString substringWithRange:NSMakeRange(17, 1)];
    //如果等于2，则说明校验码是10，身份证号码最后一位应该是X
    if(idCardMod==2) {
        if(![idCardLast isEqualToString:@"X"]||[idCardLast isEqualToString:@"x"]) {
            return NO;
        }
    }
    else{
        //用计算出的验证码与最后一位身份证号码匹配，如果一致，说明通过，否则是无效的身份证号码
        if(![idCardLast isEqualToString: [idCardYArray objectAtIndex:idCardMod]]) {
            return NO;
        }
    }
    return YES;
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
