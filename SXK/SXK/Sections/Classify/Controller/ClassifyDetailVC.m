//
//  ClassifyDetailVC.m
//  SXK
//
//  Created by 杨伟康 on 2016/12/21.
//  Copyright © 2016年 ywk. All rights reserved.
//

#import "ClassifyDetailVC.h"
#import "MaintainCell.h"
#import "BrandDetailModel.h"
#import "MyBussinesModel.h"
#import "HomeBuyCell.h"
@interface ClassifyDetailVC ()

@property (nonatomic, assign)NSInteger index;

@property (nonatomic, strong) UIView *view1;

@property (nonatomic, strong) UIView *view2;

@property (nonatomic, strong) UIImageView *image1;

@property (nonatomic, strong) UIImageView *image2;

@property (nonatomic, strong) UILabel *label1;

@property (nonatomic, strong) UILabel *label2;

@property (nonatomic, strong) UIButton *button1;

@property (nonatomic, strong) UIView *view3;

@property (nonatomic, assign) BOOL type;

@end

@implementation ClassifyDetailVC

-(void)loadingRequest
{
    _weekSelf(weakSelf)
    
    
//    [BaseRequest GetRentListWithPageNo:0 PageSize:0 order:-1 succesBlock:^(id data) {
//        NSArray *models = [BrandDetailModel modelsFromArray:data[@"rentList"]];
//        [weakSelf handleModels:models total:[data[@"total"] integerValue]];
//
////        NSLog(@"------%@------",describe(models));
//        
//    } failue:^(id data, NSError *error) {
//        
//    }];
    
    
    if ([self.myDict[@"type"] isEqualToString:@"1"]) {
        
        if (self.type) {
            
            [BaseRequest GetPurchaseList1WithPageNo:0 PageSize:0 order:-1 status:3 brandid:[self.myDict[@"brandid"] integerValue] type:1 succesBlock:^(id data) {
                NSArray *models = [MyBussinesModel modelsFromArray:data[@"purchaseList"]];
                [weakSelf handleModels:models total:[data[@"total"] integerValue]];
            } failue:^(id data, NSError *error) {
                
            }];


        }else{
            [BaseRequest GetRentListWithPageNo:0 PageSize:0 order:-1 brandid:[self.myDict[@"brandid"] integerValue] type:1 succesBlock:^(id data) {
                
                NSArray *models = [BrandDetailModel modelsFromArray:data[@"rentList"]];
                [weakSelf handleModels:models total:[data[@"total"] integerValue]];
                
            } failue:^(id data, NSError *error) {
                
            }];

        }


    }else if ([self.myDict[@"type"] isEqualToString:@"6"]){
        
        
        [BaseRequest GetSearchListWithPageNo:0 PageSize:0 order:-1 word:self.myDict[@"content"] succesBlock:^(id data) {
            NSLog(@"%@",self.myDict[@"content"]);
            NSArray *models = [BrandDetailModel modelsFromArray:data[@"rentList"]];
            [weakSelf handleModels:models total:[data[@"total"] integerValue]];

        } failue:^(id data, NSError *error) {
            
        }];

        
    }
    
    
    else{
        
        
        if (self.type) {
            [BaseRequest GetPurchaseList1WithPageNo:0 PageSize:0 order:-1 status:3 categoryid:[self.myDict[@"categoryid"] integerValue] type:1 succesBlock:^(id data) {
                NSArray *models = [MyBussinesModel modelsFromArray:data[@"purchaseList"]];
                [weakSelf handleModels:models total:[data[@"total"] integerValue]];
                
            } failue:^(id data, NSError *error) {
                
            }];

        }else{
            [BaseRequest GetRentList1WithPageNo:0 PageSize:0 order:-1 categoryid:[self.myDict[@"categoryid"] integerValue] type:1 succesBlock:^(id data) {
                NSArray *models = [BrandDetailModel modelsFromArray:data[@"rentList"]];
                [weakSelf handleModels:models total:[data[@"total"] integerValue]];
                
                
            } failue:^(id data, NSError *error) {
                
            }];

        }
        
        
    }
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadingRequest];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = self.myDict[@"title"];
    [self setupTitlesView];
    [self.view addSubview:self.tableView];
    [self initUI];
    self.type = 1;
    self.isUseNoDataView = YES;
    [self.noDataView setTitle:@"暂无寄卖商品~"];

}

-(void)initUI
{
    self.view1 = [[UIView alloc] init];
    self.view1.backgroundColor = [UIColor whiteColor];
    
    UIImage *image1 = [UIImage imageNamed:@"textjimaiuicon"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image1];
    
    UILabel *label = [UILabel createLabelWithFrame:VIEWFRAME(15, 0, 150, 53)                                                    andText:@""
                              andTextColor:[UIColor grayColor]
                                andBgColor:[UIColor clearColor]
                                   andFont:SYSTEMFONT(14)
                          andTextAlignment:NSTextAlignmentLeft];
    
//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    
//    [btn setImage:[image1 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = APP_COLOR_GRAY_Line;
    [self.view1 addSubview:imageView];
    [self.view1 addSubview:label];
    [self.view1 addSubview:line];
//    [self.view1 addSubview:btn];
    
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view1.mas_left).offset(30);
        make.centerY.equalTo(self.view1);
        make.size.mas_equalTo(CGSizeMake(22, 22));
    }];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imageView.mas_right).offset(5);
        make.centerY.equalTo(self.view1);
        make.size.mas_equalTo(CGSizeMake(80, 15));
    }];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view1.mas_left).offset(30);
        make.bottom.equalTo(self.view1.mas_bottom).offset(0);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 0.5));
    }];

    self.view2 = [[UIView alloc] init];
    self.view2.backgroundColor = [UIColor whiteColor];
    
    UIImage *image2 = [UIImage imageNamed:@""];
    UIImageView *imageView1 = [[UIImageView alloc] initWithImage:image2];
    
    UILabel *label1 = [UILabel createLabelWithFrame:VIEWFRAME(15, 0, 150, 53)                                                    andText:@""
                                      andTextColor:[UIColor grayColor]
                                        andBgColor:[UIColor clearColor]
                                           andFont:SYSTEMFONT(14)
                                  andTextAlignment:NSTextAlignmentLeft];
    
    [self.view2 addSubview:imageView1];
    [self.view2 addSubview:label1];
    
    [imageView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view2.mas_left).offset(30);
        make.centerY.equalTo(self.view2);
        make.size.mas_equalTo(CGSizeMake(22, 22));
    }];
    
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imageView1.mas_right).offset(5);
        make.centerY.equalTo(self.view2);
        make.size.mas_equalTo(CGSizeMake(80, 15));
    }];

    
    
    self.image1 = imageView;
    self.image2 = imageView1;
    self.label1 = label;
    self.label2 = label1;
//    self.button1 = btn;
    
    self.view3 = [[UIView alloc] init];
    self.view3.frame = VIEWFRAME(0, 36, SCREEN_WIDTH, 0);
    self.view3.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:self.view3];

    
    self.view1.frame = VIEWFRAME(0, 0, SCREEN_WIDTH, 40);
    self.view2.frame = VIEWFRAME(0, 40, SCREEN_WIDTH, 40);
    
    [self.view3 addSubview:self.view1];
    [self.view3 addSubview:self.view2];
    
    
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap1:)];
    [self.view1 addGestureRecognizer:tap1];
    
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap2:)];
    [self.view2 addGestureRecognizer:tap2];


}


#pragma mark -- UITabelViewDelegate And DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.listData.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.type) {
        MyBussinesModel *model = self.listData[indexPath.section];
        HomeBuyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeBuyCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setModel:model];
        return cell;

    }else{
        MaintainCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MaintainCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        BrandDetailModel *model = self.listData[indexPath.section];
        [cell setModel1:model];

    }
    MyBussinesModel *model = self.listData[indexPath.section];
    HomeBuyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeBuyCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setModel:model];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 138;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.0000001;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 15;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = APP_COLOR_GRAY_Header;
    return view;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (self.type) {
        MyBussinesModel *model = self.listData[indexPath.section];
        NSDictionary *dic = @{@"purchaseid":model.purchaseid};
        [self PushViewControllerByClassName:@"BrandDetailVC1" info:dic];
        
    }else{
        BrandDetailModel *model = self.listData[indexPath.section];
        NSDictionary *dic = @{@"rentid":model.rentid};
        [self PushViewControllerByClassName:@"BrandDetailVC" info:dic];

    }
    
}

- (UITableView *)tableView{
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:VIEWFRAME(0, 35, SCREEN_WIDTH, SCREEN_HIGHT-64-35) style:UITableViewStyleGrouped];
        _tableView.dataSource      = self;
        _tableView.delegate        = self;
        [_tableView registerClass:[MaintainCell class] forCellReuseIdentifier:@"MaintainCell"];
        [_tableView registerClass:[HomeBuyCell class] forCellReuseIdentifier:@"HomeBuyCell"];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.backgroundColor = APP_COLOR_BASE_BACKGROUND;
        _tableView.tableFooterView = [[UIView alloc] init];
        //        _tableView.tableHeaderView = self.headView;
        _tableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
        _tableView.sectionHeaderHeight = 0.0;
        _tableView.sectionFooterHeight = 0.0;
        
        
    }
    return _tableView;
}


/**
 * 设置顶部的标签栏
 */
- (void)setupTitlesView
{
    // 标签栏整体
    UIView *titlesView = [[UIView alloc] init];
    titlesView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1];
    titlesView.width = self.view.width;
    titlesView.height = 40;
    titlesView.y = 0;
    [self.view addSubview:titlesView];
    self.titlesView = titlesView;
    
    // 底部的红色指示器
    UIView *indicatorView = [[UIView alloc] init];
    indicatorView.backgroundColor = APP_COLOR_GRAY_333333;
    indicatorView.height = 2;
    indicatorView.tag = -1;
    indicatorView.y = titlesView.height - indicatorView.height-5;
    self.indicatorView = indicatorView;
    NSArray *array = [NSArray arrayWithObjects:@"寄卖",@"时间",@"价格",@"人气", nil];

    // 内部的子标签
    CGFloat width = titlesView.width / 4;
    CGFloat height = titlesView.height;
    for (NSInteger i = 0; i<4; i++) {
        UIButton *button = [[UIButton alloc] init];
        button.tag = i;
        button.height = height;
        button.width = width;
        button.x = i * width;
        NSString *title = array[i];
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button setTitleColor:APP_COLOR_GREEN forState:UIControlStateDisabled];

        UIImage *image = [UIImage imageNamed:@"未选择"];
        UIImage *image1 = [UIImage imageNamed:@"下"];
        [button setImage:[image1 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateSelected];
        [button setImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        [button setImage:[image1 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateHighlighted];
        [button setHighlighted:NO];
        [button setAdjustsImageWhenHighlighted:NO];
        button.titleEdgeInsets = UIEdgeInsetsMake(0, -8, 0, 0);
        button.imageEdgeInsets = UIEdgeInsetsMake(0, button.titleLabel.x+button.titleLabel.width+13, 0, 0);
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        [titlesView addSubview:button];
        
        // 默认点击了第一个按钮
        if (i == 0) {
            [button setSelected:YES];
            self.selectedButton = button;
            self.index =2;
            // 让按钮内部的label根据文字内容来计算尺寸
            [button.titleLabel sizeToFit];
            self.indicatorView.width = button.titleLabel.width+13;
            self.indicatorView.centerX = button.centerX+5;
        }
    }
    
    [titlesView addSubview:indicatorView];
}


- (void)titleClick:(UIButton *)button
{
    [self buttonStateChange:button];
    // 滚动
//    [self setShowingIndex:button.tag animate:YES];
}
- (void)buttonStateChange:(UIButton *)button
{
    
    switch (button.tag) {
        case 0:{
            self.image1.image = [UIImage imageNamed:@"textjimaiuicon"];
            self.image2.image = [UIImage imageNamed:@"textjizuicon"];
            self.label1.text = @"寄卖";
            self.label2.text = @"寄租";
            break;
        }
        case 1:{
            self.image1.image = [UIImage imageNamed:@"textzuiixn"];
            self.image2.image = [UIImage imageNamed:@"时间"];
            self.label1.text = @"最新发布";
            self.label2.text = @"最早发布";
            break;
        }

        case 2:{
            self.image1.image = [UIImage imageNamed:@"排序"];
            self.image2.image = [UIImage imageNamed:@"图层-2"];
            self.label1.text = @"从高到低";
            self.label2.text = @"从低到高";
            break;
        }

        case 3:{
            self.image1.image = [UIImage imageNamed:@"排序"];
            self.image2.image = [UIImage imageNamed:@"图层-2"];
            self.label1.text = @"从高到低";
            self.label2.text = @"从低到高";
            break;
        }

            
        default:
            break;
}
    
    
    
    
    
    
    
    // 修改按钮状态
    if (self.selectedButton == button) {
        
        if (self.index == 1) {
            self.index =2;
            
//            UIImage *image = [UIImage imageNamed:@"上"];
//            [button setImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateSelected];
//            [button setImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateHighlighted];
            
            [self hideView];
      

        }else{
            
//            UIImage *image = [UIImage imageNamed:@"下"];
//            [button setImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateSelected];
//            [button setImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateHighlighted];
            
            self.index =1;
            [self showView];
            
        }
        
        
    }else{
        
        [self.selectedButton setSelected:NO];
        UIImage *image = [UIImage imageNamed:@"下"];
        [button setImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateSelected];
        [button setImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateHighlighted];
        self.index =1;
        [button setSelected:YES];
        [self showView];
        
    }
    
    
    self.selectedButton = button;
    [UIView animateWithDuration:0.25 animations:^{
        self.indicatorView.width = button.titleLabel.width+13;
        self.indicatorView.centerX = button.centerX+5;
    }];
    
}

-(void)showView
{
    [self.view addSubview:self.view3];

    self.view1.alpha = 0;
    self.view2.alpha = 0;
    
    
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    
    dispatch_async(queue, ^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [UIView animateWithDuration:0.5 animations:^{
                
                self.view3.frame = VIEWFRAME(0, 36, SCREEN_WIDTH, 80);
                
            } completion:^(BOOL finished) {
                
                self.view1.alpha = 1;
                self.view2.alpha = 1;
                
            }];
        });
    });

}

-(void)hideView
{
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    
    dispatch_async(queue, ^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [UIView animateWithDuration:0.5 animations:^{
                
                self.view3.frame = VIEWFRAME(0, 36, SCREEN_WIDTH, 0);
                self.view1.alpha = 0;
                self.view2.alpha = 0;

            } completion:^(BOOL finished) {
                
                [self.view3 removeFromSuperview];
            }];
        });
    });
}

-(void)tap1:(UITapGestureRecognizer *)tap
{

    
    if (self.selectedButton.tag == 0) {
        self.type = 1;
        [self.selectedButton setTitle:@"寄卖" forState:UIControlStateNormal];
        [self.noDataView setTitle:@"暂无寄卖商品~"];

        [self loadingRequest];
        [self hideView];
    }
    if (self.selectedButton.tag == 1) {
        
    
    
        if (self.type) {
            
            
            if ([self.myDict[@"type"] isEqualToString:@"1"]) {
                
                [self loadingBussinessWithType:1 order:-1];
            }else{
                
                [self loadingBussiness1WithType:1 order:-1];
            }
        
        }else{
            if ([self.myDict[@"type"] isEqualToString:@"1"]) {
                
                [self loadingRentWithType:1 order:-1];
            }else{
                
                [self loadingRent1WithType:1 order:-1];
            }

        }
        [self hideView];


    }
    if (self.selectedButton.tag == 2) {
        
        
        
        if (self.type) {
            
            
            if ([self.myDict[@"type"] isEqualToString:@"1"]) {
                
                [self loadingBussinessWithType:3 order:-1];
            }else{
                
                [self loadingBussiness1WithType:3 order:-1];
            }
            
        }else{
            if ([self.myDict[@"type"] isEqualToString:@"1"]) {
                
                [self loadingRentWithType:3 order:-1];
            }else{
                
                [self loadingRent1WithType:3 order:-1];
            }
            
        }
        [self hideView];

    }

    if (self.selectedButton.tag == 3) {
        
        
        
        if (self.type) {
            
            
            if ([self.myDict[@"type"] isEqualToString:@"1"]) {
                
                [self loadingBussinessWithType:2 order:-1];
            }else{
                
                [self loadingBussiness1WithType:2 order:-1];
            }
            
        }else{
            if ([self.myDict[@"type"] isEqualToString:@"1"]) {
                
                [self loadingRentWithType:2 order:-1];
            }else{
                
                [self loadingRent1WithType:2 order:-1];
            }
            
        }
        [self hideView];

    }

    
    
}

-(void)tap2:(UITapGestureRecognizer *)tap
{
    
    
    if (self.selectedButton.tag == 0) {
        self.type = 0;
        [self.selectedButton setTitle:@"寄租" forState:UIControlStateNormal];
        [self.noDataView setTitle:@"暂无寄租商品~"];

        [self loadingRequest];
        [self hideView];
    }
    
    if (self.selectedButton.tag == 1) {
        
        
        
        if (self.type) {
            
            
            if ([self.myDict[@"type"] isEqualToString:@"1"]) {
                
                [self loadingBussinessWithType:1 order:1];
            }else{
                
                [self loadingBussiness1WithType:1 order:1];
            }
            
        }else{
            if ([self.myDict[@"type"] isEqualToString:@"1"]) {
                
                [self loadingRentWithType:1 order:1];
            }else{
                
                [self loadingRent1WithType:1 order:1];
            }
            
        }
        [self hideView];

        
    }
    if (self.selectedButton.tag == 2) {
        
        
        
        if (self.type) {
            
            
            if ([self.myDict[@"type"] isEqualToString:@"1"]) {
                
                [self loadingBussinessWithType:3 order:1];
            }else{
                
                [self loadingBussiness1WithType:3 order:1];
            }
            
        }else{
            if ([self.myDict[@"type"] isEqualToString:@"1"]) {
                
                [self loadingRentWithType:3 order:1];
            }else{
                
                [self loadingRent1WithType:3 order:1];
            }
            
        }
        [self hideView];

        
    }
    
    if (self.selectedButton.tag == 3) {
        
        
        
        if (self.type) {
            
            
            if ([self.myDict[@"type"] isEqualToString:@"1"]) {
                
                [self loadingBussinessWithType:2 order:1];
            }else{
                
                [self loadingBussiness1WithType:2 order:1];
            }
            
        }else{
            if ([self.myDict[@"type"] isEqualToString:@"1"]) {
                
                [self loadingRentWithType:2 order:1];
            }else{
                
                [self loadingRent1WithType:2 order:1];
            }
            
        }
        [self hideView];

        
    }
    
    
    
}

-(void)loadingBussinessWithType:(NSInteger)type order:(NSInteger)order
{
    _weekSelf(weakSelf);
    [BaseRequest GetPurchaseList1WithPageNo:0 PageSize:0 order:order status:3 brandid:[self.myDict[@"brandid"] integerValue] type:type succesBlock:^(id data) {
        NSArray *models = [MyBussinesModel modelsFromArray:data[@"purchaseList"]];
        [weakSelf handleModels:models total:[data[@"total"] integerValue]];
    } failue:^(id data, NSError *error) {
        
    }];
    [self hideView];
}

-(void)loadingBussiness1WithType:(NSInteger)type order:(NSInteger)order
{
    _weekSelf(weakSelf);
    [BaseRequest GetPurchaseList1WithPageNo:0 PageSize:0 order:order status:3 categoryid:[self.myDict[@"categoryid"] integerValue] type:type succesBlock:^(id data) {
        NSArray *models = [MyBussinesModel modelsFromArray:data[@"purchaseList"]];
        [weakSelf handleModels:models total:[data[@"total"] integerValue]];
        
    } failue:^(id data, NSError *error) {
        
    }];
}

-(void)loadingRentWithType:(NSInteger)type order:(NSInteger)order
{
    _weekSelf(weakSelf);
    [BaseRequest GetRentListWithPageNo:0 PageSize:0 order:order brandid:[self.myDict[@"brandid"] integerValue] type:type succesBlock:^(id data) {
        NSArray *models = [BrandDetailModel modelsFromArray:data[@"rentList"]];
        [weakSelf handleModels:models total:[data[@"total"] integerValue]];
        
    } failue:^(id data, NSError *error) {
        
    }];
}

-(void)loadingRent1WithType:(NSInteger)type order:(NSInteger)order
{
    _weekSelf(weakSelf);
    [BaseRequest GetRentList1WithPageNo:0 PageSize:0 order:order categoryid:[self.myDict[@"categoryid"] integerValue] type:type succesBlock:^(id data) {
        NSArray *models = [BrandDetailModel modelsFromArray:data[@"rentList"]];
        [weakSelf handleModels:models total:[data[@"total"] integerValue]];
    } failue:^(id data, NSError *error) {
        
    }];
    

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
