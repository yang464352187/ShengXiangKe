//
//  SecondCommonVC.m
//  SXK
//
//  Created by 杨伟康 on 2016/11/23.
//  Copyright © 2016年 ywk. All rights reserved.
//

#import "SecondCommonVC.h"
#import "SelectCell.h"

@interface SecondCommonVC () <SelectCellDelegate>


@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, strong) SelectCell *selectCell;

@end

@implementation SecondCommonVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = self.myDict[@"title"];

      [self setRightBarButtonWith:[NSString stringWithFormat:@"完成"] selector:@selector(barButtonAction)];
    [self initData];
    [self.view addSubview:self.tableView];
}
-(void)barButtonAction
{
//    NSArray * ctrlArray = self.jt_navigationController.viewControllers;
//    [self.jt_navigationController popToViewController:[ctrlArray objectAtIndex:1] animated:YES];
    
    if (self.selectCell.name.length <= 0) {
        return;
    }
    NSDictionary *dic = @{@"name":self.selectCell.name,@"class":self.myDict[@"className"]};
    NSLog(@"%@",describe(dic));
    NSNotification *notification =[NSNotification notificationWithName:@"tongzhi" object:nil userInfo:dic];
    //通过通知中心发送通知
    [[NSNotificationCenter defaultCenter] postNotification:notification];
    [self PopToIndexViewController:1];
}

-(void)initData
{
    self.dataArr = [[NSMutableArray alloc] initWithObjects:@"腕表",@"台钟",@"怀表",@"其他",@"石英腕表",@"自动机械表", nil];
}
- (UITableView *)tableView{
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:VIEWFRAME(0, 0, SCREEN_WIDTH, SCREEN_HIGHT) style:UITableViewStyleGrouped];
        _tableView.dataSource      = self;
        _tableView.delegate        = self;
        [_tableView registerClass:[SelectCell class] forCellReuseIdentifier:@"cell"];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.tableFooterView = [[UIView alloc] init];
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
    
    
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SelectCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.delegate = self;
    [cell fillTitle:self.dataArr[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 52;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.0001;
}

-(void)sendValue:(id)cell
{
    if (self.selectCell) {
        [self.selectCell isSelect];
        [(SelectCell *)cell isSelect];
        self.selectCell = (SelectCell *)cell;
    }else{
        [(SelectCell *)cell isSelect];
        self.selectCell = (SelectCell *)cell;
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
