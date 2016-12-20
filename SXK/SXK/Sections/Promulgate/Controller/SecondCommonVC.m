//
//  SecondCommonVC.m
//  SXK
//
//  Created by 杨伟康 on 2016/11/23.
//  Copyright © 2016年 ywk. All rights reserved.
//

#import "SecondCommonVC.h"
#import "SelectCell.h"
#import "CategoryListModel.h"
@interface SecondCommonVC () <SelectCellDelegate>


@property (nonatomic, strong) NSArray *dataArr;
@property (nonatomic, strong) SelectCell *selectCell;


@end

@implementation SecondCommonVC


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if ([self.myDict[@"type"] isEqualToString:@"类别"]) {
        [self loadingRequest];
    }else{
        self.dataArr = self.myDict[@"data"];
        [self.tableView reloadData];
    }
    
    
}

-(void)loadingRequest
{
    _weekSelf(weakSelf);
    [BaseRequest GetCategoryListWithPageNo:0 PageSize:0 order:1 parentid:[self.myDict[@"categoryID"] integerValue] succesBlock:^(id data) {
        NSArray *models = [CategoryListModel modelsFromArray:data[@"categoryList"]];
        weakSelf.dataArr = models;
        [weakSelf.tableView reloadData];
    } failue:^(id data, NSError *error) {
    }];
}

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
    if (self.selectCell.name.length <= 0) {
        [ProgressHUDHandler showHudTipStr:@"请选择类型"];
        return;
    }
    
    if ([self.myDict[@"type"] isEqualToString:@"类别"]) {
        NSDictionary *dic = @{@"name":self.selectCell.name,@"class":self.myDict[@"className"],@"categoryid":self.myDict[@"categoryID"]};
        NSNotification *notification =[NSNotification notificationWithName:@"tongzhi" object:nil userInfo:dic];
        //通过通知中心发送通知
        [[NSNotificationCenter defaultCenter] postNotification:notification];
        [self PopToIndexViewController:1];
    }else{
        
        NSDictionary *dic = @{@"name":self.selectCell.name,@"class":self.myDict[@"title"]};

        NSNotification *notification =[NSNotification notificationWithName:@"huidiao" object:nil userInfo:dic];
        //通过通知中心发送通知
        [[NSNotificationCenter defaultCenter] postNotification:notification];
        [self popGoBack];

    }

    
}

-(void)initData
{
//    self.dataArr = [[NSMutableArray alloc] initWithObjects:@"腕表",@"台钟",@"怀表",@"其他",@"石英腕表",@"自动机械表", nil];
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
    

    if ([self.myDict[@"type"] isEqualToString:@"类别"]) {
        CategoryListModel *model = self.dataArr[indexPath.row];
        [cell setModel:model];
    }else{
        [cell fillTitle:self.dataArr[indexPath.row]];
    }

    
    
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
