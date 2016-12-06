//
//  AddAddress.m
//  SXK
//
//  Created by 杨伟康 on 2016/12/6.
//  Copyright © 2016年 ywk. All rights reserved.
//

#import "AddAddress.h"
#import "AddAddressCell.h"
#import "FEPlaceHolderTextView.h"

@interface AddAddress ()

@property (nonatomic, strong)NSMutableArray *dataArray;
@property (nonatomic, strong) UIView *footerView;
@property (nonatomic, strong)FEPlaceHolderTextView *textView;

@end

@implementation AddAddress

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"地址详情";
    [self initDataArray];
    [self.view addSubview:self.tableView];
}

-(void)initDataArray
{
    self.dataArray = [[NSMutableArray alloc] initWithObjects:@"请输入收货人姓名",@"请输入联系电话",@"请选择地区街道", nil];
}
#pragma mark -- getters and setters
- (UITableView *)tableView{
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:VIEWFRAME(0, 0, SCREEN_WIDTH, SCREEN_HIGHT+44) style:UITableViewStyleGrouped];
        _tableView.dataSource      = self;
        _tableView.delegate        = self;
        [_tableView registerClass:[AddAddressCell class] forCellReuseIdentifier:@"AddAddressCell"];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.backgroundColor = [UIColor colorWithHexColorString:@"f7f7f7"];
        _tableView.tableFooterView = self.footerView;
        //        _tableView.tableHeaderView = [[UIView alloc] init];
        _tableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
        _tableView.sectionHeaderHeight = 0.0;
        _tableView.sectionFooterHeight = 0.0;
        
    }
    return _tableView;
}

-(UIView *)footerView
{
    if (!_footerView) {
        _footerView = [[UIView alloc] initWithFrame:VIEWFRAME(0, 0, SCREEN_WIDTH, 180)];
        _footerView.backgroundColor = [UIColor colorWithHexColorString:@"f7f7f7"];
        
        UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [addBtn setTitle:@"保存" forState:UIControlStateNormal];
        addBtn.backgroundColor = APP_COLOR_GREEN;
        [addBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [addBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        addBtn.tag = 101;
        addBtn.titleLabel.font = SYSTEMFONT(14);
        addBtn.frame = VIEWFRAME(20, 120, SCREEN_WIDTH - 40, 40);
        ViewRadius(addBtn, addBtn.frame.size.height/2);
        
        UIView *view = [[UIView alloc] initWithFrame:VIEWFRAME(0, 0, SCREEN_WIDTH, 96)];
        view.backgroundColor = [UIColor whiteColor];
        [view addSubview:self.textView];
        
        [_footerView addSubview:view];
        [_footerView addSubview:addBtn];

    }
    return _footerView;
}

-(UITextView *)textView
{
    if (!_textView) {
        _textView = [[FEPlaceHolderTextView alloc] initWithFrame:VIEWFRAME(15, 0, SCREEN_WIDTH-21-22, 96)];
        _textView.backgroundColor = [UIColor whiteColor];
        _textView.placeholder = @"请输入您的个人简介";
        _textView.placeholderColor = [UIColor colorWithRed:188.0f/255.0f green:188.0/255.0f blue:188.0/255.0f alpha:1];
        [_textView setFont:SYSTEMFONT(14)];
    }
    return _textView;
}

#pragma mark -- UITabelViewDelegate And DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AddAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AddAddressCell"];
    [cell fillWithPlaceholder:self.dataArray[indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 52;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 13;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor colorWithHexColorString:@"f7f7f7"];
    return view;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor colorWithHexColorString:@"f7f7f7"];
    return view;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 2) {
        
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
