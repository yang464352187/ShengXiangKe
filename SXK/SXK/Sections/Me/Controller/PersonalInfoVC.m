//
//  PersonalInfoVC.m
//  SXK
//
//  Created by 杨伟康 on 2016/11/30.
//  Copyright © 2016年 ywk. All rights reserved.
//

#import "PersonalInfoVC.h"
#import "CategoryCell.h"
#import "PopView.h"
#import "AppDelegate.h"

@interface PersonalInfoVC ()

@property (strong, nonatomic) UIView  *headView;
@property (strong, nonatomic) NSArray *firstArr;
@property (strong, nonatomic) NSArray *secondArr;
@property (strong, nonatomic) PopView *popView;

@end

@implementation PersonalInfoVC

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];//设置电池条颜色为黑色

}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"个人资料";
    [self initData];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.popView];
}

-(void)initData
{
    self.firstArr = [[NSArray alloc] initWithObjects:@"昵称",@"性别",@"生日",@"个人简介" ,nil];
    self.secondArr = [[NSArray alloc] initWithObjects:@"手机号码",@"修改密码", nil];
}
#pragma mark -- getters and setters
- (UITableView *)tableView{
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:VIEWFRAME(0, 0, SCREEN_WIDTH, SCREEN_HIGHT-44) style:UITableViewStyleGrouped];
        _tableView.dataSource      = self;
        _tableView.delegate        = self;
        [_tableView registerClass:[CategoryCell class] forCellReuseIdentifier:@"CategoryCell"];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.tableHeaderView = self.headView;
        _tableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
        _tableView.sectionHeaderHeight = 0.0;
        _tableView.sectionFooterHeight = 0.0;
        
    }
    return _tableView;
}

- (UIView *)headView{
    if (!_headView) {
        _headView = [[UIView alloc] initWithFrame:VIEWFRAME(0, 0, SCREEN_WIDTH, (203.0000/667*SCREEN_HIGHT))];
        _headView.backgroundColor = [UIColor whiteColor];
        
        UIImageView *headImage = [[UIImageView alloc] initWithFrame:VIEWFRAME( (SCREEN_WIDTH - CommonHight(94))/2, CommonHight(18), CommonHight(94), CommonHight(94))];
        headImage.image = [UIImage imageNamed:@"头像"];
        ViewRadius(headImage, CommonHight(94)/2);
        
        UIButton *shootBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        UIImage *shootImage = [UIImage imageNamed:@"相机"];
        [shootBtn setImage:[shootImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        shootBtn.frame = VIEWFRAME(CommonWidth(200), CommonHight(90), CommonHight(25), CommonHight(25));
        
        UILabel *siteLab = [UILabel createLabelWithFrame:CommonVIEWFRAME(24, 137.5, 262, 32)                                                 andText:@"http://www.baidu.com"
                                  andTextColor:[UIColor blackColor]
                                    andBgColor:[UIColor clearColor]
                                       andFont:SYSTEMFONT(13)
                              andTextAlignment:NSTextAlignmentCenter];
        ViewBorder(siteLab, 0.5, [UIColor colorWithHexColorString:@"a0a0a0"]);
        
        UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        shareBtn.frame = CommonVIEWFRAME(296, 137.5, 60.5, 32);
        [shareBtn setTitle:@"分享" forState:UIControlStateNormal];
        [shareBtn setBackgroundColor:APP_COLOR_GREEN];
        [shareBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [_headView addSubview:headImage];
        [_headView addSubview:shootBtn];
        [_headView addSubview:siteLab];
        [_headView addSubview:shareBtn];
    }
    return _headView;
}

#pragma mark -- UITabelViewDelegate And DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return self.firstArr.count;
    }
    return self.secondArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    CategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CategoryCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section == 0) {
        [cell fillTitle:self.firstArr[indexPath.row]];
    }else{
        [cell fillTitle:self.secondArr[indexPath.row]];
    }
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return 52;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor colorWithHexColorString:@"f7f7f7"];
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.section == 0 && indexPath.row == 0) {
        [self.popView fillWithTitle:@"修改昵称"];
        [self.popView show];
    }
    
    if (indexPath.section == 0 && indexPath.row == 1) {
        [self.popView fillWithTitle:@"修改性别"];
        [self.popView show1];
    }
    
    if (indexPath.section == 0 && indexPath.row == 2) {
        [self.popView fillWithTitle:@"出生年月"];
        [self.popView show2];
    }

    
    if (indexPath.section == 1 && indexPath.row == 0) {
        [self.popView fillWithTitle:@"手机号码"];
        [self.popView show];
    }

}

-(PopView *)popView
{
    if (!_popView) {
        _popView =  [[PopView alloc] initWithFrame:VIEWFRAME(0, 0, SCREEN_WIDTH, SCREEN_HIGHT)];
    }
    return _popView;
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
