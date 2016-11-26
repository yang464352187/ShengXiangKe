//
//  BrandVC.m
//  SXK
//
//  Created by 杨伟康 on 2016/11/23.
//  Copyright © 2016年 ywk. All rights reserved.
//

#import "BrandVC.h"
#import "BATableView.h"
#import "BrandCell.h"

@interface BrandVC ()<BATableViewDelegate>

@property (nonatomic, strong) BATableView *contactTableView;
@property (nonatomic, strong)NSMutableArray *dataArray;

@end

@implementation BrandVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"品牌";
    self.dataArray = [NSMutableArray array];
    for (int i = 0; i < 26; i++) {
        //         循环段数据
        NSMutableArray *sectionArr = [NSMutableArray array];
        for (int j = 0; j < 5; j++) {
            //            循环行数据
            NSString *rowStr = [NSString stringWithFormat:@"第%d段，%d行", i, j];
            [sectionArr addObject:rowStr];
        }
        [self.dataArray addObject:sectionArr];
    }

//    [self.view addSubview:self.tableView];
    self.jt_navigationController.line.backgroundColor = [UIColor colorWithHexColorString:@"dcdcdc"];
    [self initUI];
    NSLog(@"%@",self.myDict);
}

#pragma mark -- getters and setters
-(void)initUI
{
    self.contactTableView = [[BATableView alloc] initWithFrame:VIEWFRAME(0, 0, SCREEN_WIDTH, SCREEN_HIGHT-44)];
    self.contactTableView.delegate = self;
    [self.contactTableView.tableView registerClass:[BrandCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.contactTableView];

}

#pragma mark - UITableViewDataSource
//多少段
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArray.count;
}

//多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *sectionArr = self.dataArray[section];
    return sectionArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BrandCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    NSArray *sectionArr = self.dataArray[indexPath.section];
    [cell fillWithTitle:sectionArr[indexPath.row]];
    
    
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
    view.backgroundColor = [UIColor whiteColor];
    
    UILabel *title = [UILabel createLabelWithFrame:VIEWFRAME(15,25 , 105, 14)
                                           andText:[NSString stringWithFormat:@"%c", (int)(section + 65)]
                                      andTextColor:[UIColor blackColor]
                                        andBgColor:[UIColor clearColor]
                                           andFont:SYSTEMFONT(14)
                                  andTextAlignment:NSTextAlignmentLeft];
    UIView *line = [[UIView alloc] initWithFrame:VIEWFRAME(15, 49.5, SCREEN_WIDTH, 0.5)];
    line.backgroundColor = [UIColor colorWithHexColorString:@"dcdcdc"];
    
    [view addSubview:title];
    [view addSubview:line];
    
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 52;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *sectionArr = self.dataArray[indexPath.section];
    NSLog(@"%@",sectionArr[indexPath.row]);
    NSDictionary *dic = @{@"name":sectionArr[indexPath.row],@"class":self.myDict[@"className"]};
    NSNotification *notification =[NSNotification notificationWithName:@"tongzhi" object:nil userInfo:dic];
    //通过通知中心发送通知
    [[NSNotificationCenter defaultCenter] postNotification:notification];
    [self PopToIndexViewController:1];

    
}


- (NSArray *) sectionIndexTitlesForABELTableView:(BATableView *)tableView {
        NSMutableArray *titles = [NSMutableArray array];
        for (int i = 0; i < 26; i++) {
            
            [titles addObject:[NSString stringWithFormat:@"%c", 65+i]];
        }
//    [titles addObject:UITableViewIndexSearch];
    
        return titles;
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
