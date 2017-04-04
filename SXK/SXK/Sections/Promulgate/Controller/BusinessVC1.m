//
//  BusinessVC1.m
//  SXK
//
//  Created by 杨伟康 on 2017/3/15.
//  Copyright © 2017年 ywk. All rights reserved.
//

#import "BusinessVC1.h"
#import "BusinessCell.h"
#import "BusinessCell1.h"
#import "BusinessCell2.h"
#import "BusinessModel.h"
@interface BusinessVC1 ()

@property (nonatomic, strong) NSArray *imagesArr;

@property (nonatomic, strong) NSArray *titleArr;

@property (nonatomic, strong) NSArray *contentArr;

@property (nonatomic, strong) NSArray *models;

@end

@implementation BusinessVC1

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    _weekSelf(weakSelf);
    [BaseRequest GetPurchaseListWithPageNo:0 PageSize:0 order:1 succesBlock:^(id data) {
        weakSelf.models = [BusinessModel modelsFromArray:data[@"purchaseList"]];
        NSLog(@"%@",describe(weakSelf.models));
        NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndex:0];
        [weakSelf.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
    } failue:^(id data, NSError *error) {
        
    }];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"预约啵呗寄卖";
    
    self.imagesArr = @[@"图层-51",@"cdfdv"];
    self.titleArr = @[@"填写寄卖商品信息",@"选择商品回寄地址"];
    self.contentArr = @[@"平台签收以实物为准,售价以鉴定师实际估价为准,一般为专柜购入价的3-5折",@"如商品不符合平台标准或售卖价不能达成一致,会将商品顺丰到付回寄给您"];
    
    [self.view addSubview:self.tableView];
    
    
    
}


- (UITableView *)tableView{
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:VIEWFRAME(0, 0, SCREEN_WIDTH, SCREEN_HIGHT-64) style:UITableViewStyleGrouped];
        _tableView.dataSource      = self;
        _tableView.delegate        = self;
        _tableView.showsVerticalScrollIndicator = NO;
        [_tableView registerClass:[BusinessCell class] forCellReuseIdentifier:@"cell"];
        [_tableView registerClass:[BusinessCell1 class] forCellReuseIdentifier:@"cell1"];
        [_tableView registerClass:[BusinessCell2 class] forCellReuseIdentifier:@"cell2"];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.tableFooterView = [[UIView alloc] init];
//        _tableView.tableHeaderView = self.headView;
        _tableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
        _tableView.sectionHeaderHeight = 0.0;
        _tableView.sectionFooterHeight = 0.0;
        
    }
    return _tableView;
}



#pragma mark -- UITabelViewDelegate And DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return self.models.count + 1;
    }
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        
        if (indexPath.row == self.models.count) {
            BusinessCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else{
            BusinessCell2 *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2"];
            cell.selectionStyle = UITableViewCellAccessoryNone;
            BusinessModel *model = self.models[indexPath.row];
            [cell setModel:model];
            return cell;

        }

    }

    
    
    
    BusinessCell1 *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 1) {
        return 160;
    }
    
    if (self.models.count > 0) {
        if (indexPath.section == 0 && indexPath.row == self.models.count) {
            return 74;
        }
    }
    
    return 90;
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",self.imagesArr[section]]]];
    
    UILabel *label = [UILabel createLabelWithFrame:VIEWFRAME(15, 0, 100, 53)                                                 andText:self.titleArr[section]
                              andTextColor:[UIColor blackColor]
                                andBgColor:[UIColor clearColor]
                                   andFont:[UIFont fontWithName:@"Helvetica-Bold" size:14]
                          andTextAlignment:NSTextAlignmentLeft];
    
    UILabel *label1 = [UILabel createLabelWithFrame:VIEWFRAME(15, 0, 100, 53)                                                 andText:self.contentArr[section]
                                       andTextColor:[UIColor colorWithHexColorString:@"a1a1a1"]
                                         andBgColor:[UIColor clearColor]
                                            andFont:SYSTEMFONT(14)
                                   andTextAlignment:NSTextAlignmentLeft];
    label1.numberOfLines = 0;
    
    [view addSubview:image];
    [view addSubview:label];
    [view addSubview:label1];
    
    CGFloat height = [UILabel getHeightByWidth:SCREEN_WIDTH - 30 title:self.contentArr[section] font:SYSTEMFONT(14)];
    
    [image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view.mas_top).offset(30);
        make.left.equalTo(view.mas_left).offset(15);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(image);
        make.left.equalTo(image.mas_right).offset(10);
        make.size.mas_equalTo(CGSizeMake(200, 30));
    }];
    
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view.mas_left).offset(15);
        make.top.equalTo(image.mas_bottom).offset(10);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 30, height));
    }];
    
    
    return view;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor whiteColor];
    if (section == 0) {
        return view;
    }
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    UIImage *image = [UIImage imageNamed:@"椭圆-21"];
    [btn setImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    
    UILabel *label = [UILabel createLabelWithFrame:VIEWFRAME(15, 0, 150, 53)                                                 andText:@"我已阅读并同意BOOBE"
                                      andTextColor:[UIColor blackColor]
                                        andBgColor:[UIColor clearColor]
                                           andFont:SYSTEMFONT(14)
                                  andTextAlignment:NSTextAlignmentCenter];
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn1 setTitle:@"《寄卖协议》" forState:UIControlStateNormal];
    [btn1 setTitleColor:APP_COLOR_GREEN forState:UIControlStateNormal];
    btn1.titleLabel.textAlignment = NSTextAlignmentLeft;
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeSystem];
    btn2.backgroundColor = APP_COLOR_GREEN;
    [btn2 setTitle:@"确认寄卖" forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn2.titleLabel.font = SYSTEMFONT(14);
    
    [view addSubview:btn];
    [view addSubview:label];
    [view addSubview:btn1];
    [view addSubview:btn2];
    
    CGFloat width = [UILabel getWidthWithTitle:@"我已阅读并同意BOOBE" font:SYSTEMFONT(14)];
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
         make.top.equalTo(view.mas_top).offset(15);
         make.left.equalTo(view.mas_left).offset(15);
         make.size.mas_equalTo(CGSizeMake(16, 16));
    }];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(btn);
        make.left.equalTo(btn.mas_right).offset(3);
        make.size.mas_equalTo(CGSizeMake(width, 16));
    }];
    
    [btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(btn);
        make.left.equalTo(label.mas_right).offset(-5);
        make.size.mas_equalTo(CGSizeMake(100, 16));
    }];
    
    [btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view.mas_left).offset(15);
        make.right.equalTo(view.mas_right).offset(-15);
        make.top.equalTo(btn.mas_bottom).offset(15);
        make.height.mas_equalTo(45);
    }];

    
    
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 1) {
        return 110;
    }
    
    return 0.000001;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 100;
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
