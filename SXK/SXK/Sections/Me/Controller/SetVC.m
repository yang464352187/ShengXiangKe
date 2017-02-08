//
//  SetVC.m
//  SXK
//
//  Created by 杨伟康 on 2016/11/30.
//  Copyright © 2016年 ywk. All rights reserved.
//

#import "SetVC.h"
#import "CommonCell.h"

@interface SetVC ()

@property (nonatomic, strong)NSArray *dataArr;

@end

@implementation SetVC


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"设置";
    [self initData];
    [self.view addSubview:self.tableView];
}

-(void)initData
{
    self.dataArr = [[NSMutableArray alloc] initWithObjects:@"常用地址",@"分享APP",@"清除缓存",@"检查更新",@"意见反馈",@"用户协议",@"关于啵呗", nil];
}


#pragma mark -- getters and setters
- (UITableView *)tableView{
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:VIEWFRAME(0, 0, SCREEN_WIDTH, SCREEN_HIGHT+44) style:UITableViewStyleGrouped];
        _tableView.dataSource      = self;
        _tableView.delegate        = self;
        [_tableView registerClass:[CommonCell class] forCellReuseIdentifier:@"CommonCell"];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.tableFooterView = [[UIView alloc] init];
//        _tableView.tableHeaderView = [[UIView alloc] init];
        _tableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
        _tableView.sectionHeaderHeight = 0.0;
        _tableView.sectionFooterHeight = 0.0;

    }
    return _tableView;
}

#pragma mark -- UITabelViewDelegate And DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CommonCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommonCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell fillWithTitle:self.dataArr[indexPath.row]];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 54;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.0000001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.0000001;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
            [self PushViewControllerByClassName:@"AddressManagerVC" info:nil];
            break;
        case 4:{
            NSDictionary *dic = @{@"title":@"意见反馈",
                                  @"opinion":@"请输入您的宝贵意见"};
            [self PushViewControllerByClassName:@"PersonalSummaryVC" info:dic];
            break;
        }
            
        case 5:{
            NSDictionary *dic = @{@"title":@"用户协议"};
            [self PushViewControllerByClassName:@"UserProtocolVC" info:dic];
            break;
        }
            
        case 6:{
            NSDictionary *dic = @{@"title":@"关于啵呗"};
            [self PushViewControllerByClassName:@"AboutBoobe" info:dic];
            break;
        }
            
        default:
            break;
    }
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
