//
//  SearchVC.m
//  SXK
//
//  Created by 杨伟康 on 2017/3/2.
//  Copyright © 2017年 ywk. All rights reserved.
//

#import "SearchVC.h"
#import "SearchCell.h"
#import "SearchCell1.h"
#import "BrandHotModel.h"
#import "LXWSearchHotView.h"
#import "Search1VC.h"
@interface SearchVC ()
@property (nonatomic, strong) UIView *headView;
@property (nonatomic, strong) SearchCell *cell;

@property (nonatomic, strong) NSArray *array;
@property (nonatomic, strong) UITextField *text;

@property (nonatomic, strong) NSMutableArray *dataArr;
@end

@implementation SearchVC



-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
    
    _weekSelf(weakSelf);
    [BaseRequest GetBrandHotListWithPageNo:0 PageSize:0 order:1 succesBlock:^(id data) {
        weakSelf.array = [BrandHotModel modelsFromArray:data[@"hotList"]];
        NSMutableDictionary *searchDic = DEFAULTS_GET_OBJ(@"search");
        [weakSelf.dataArr removeAllObjects];
        for (NSInteger i = searchDic.count ; i>0; i--) {
            NSString *str = [searchDic valueForKey:[NSString stringWithFormat:@"%ld",i]];
            [weakSelf.dataArr addObject:str];
        }

        [weakSelf.tableView reloadData];
        
    } failue:^(id data, NSError *error) {
    }];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = YES;
    self.dataArr = [[NSMutableArray alloc] init];
    
    
    

    
    
//    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"返回"] style:UIBarButtonItemStylePlain target:self action:@selector(dismissGoback)];
//    self.navigationItem.leftBarButtonItem = button;
    [self.view addSubview:self.tableView];
}


#pragma mark -- getters and setters


- (UITableView *)tableView{
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:VIEWFRAME(0, -20, SCREEN_WIDTH, SCREEN_HIGHT+40) style:UITableViewStyleGrouped];
        _tableView.dataSource      = self;
        _tableView.delegate        = self;
        [_tableView registerClass:[SearchCell class] forCellReuseIdentifier:@"SearchCell"];
        [_tableView registerClass:[SearchCell1 class] forCellReuseIdentifier:@"SearchCell1"];

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
        
        _headView = [[UIView alloc] initWithFrame:VIEWFRAME(0, 0, SCREEN_WIDTH, 64)];
        _headView.backgroundColor = [UIColor whiteColor];
        
        UIImage *image = [UIImage imageNamed:@"返回"];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        [button setImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
        
        UITextField *text = [[UITextField alloc] init];
        text.backgroundColor = APP_COLOR_GRAY_Header;
        text.placeholder = @"搜索 香奈儿/爱马仕";
        text.font = SYSTEMFONT(14);
        self.text = text;
        
        UIButton *button1 = [UIButton buttonWithType:UIButtonTypeSystem];
        [button1 setTitle:@"搜索" forState:UIControlStateNormal];
        [button1 setTitleColor:APP_COLOR_GREEN forState:UIControlStateNormal];
        button1.titleLabel.font = SYSTEMFONT(14);
        [button1 addTarget:self action:@selector(searchAvtion:) forControlEvents:UIControlEventTouchUpInside];
        
        [_headView addSubview:button];
        [_headView addSubview:text];
        [_headView addSubview:button1];

        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_headView.mas_top).offset(20);
            make.left.equalTo(_headView.mas_left).offset(5);
            make.size.mas_equalTo(CGSizeMake(40, 40));
        }];
        
        [button1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(button);
            make.right.equalTo(_headView.mas_right).offset(-10);
            make.size.mas_equalTo(CGSizeMake(40, 40));

        }];
        
        [text mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(button.mas_right).offset(5);
            make.right.equalTo(button1.mas_left).offset(-5);
            make.centerY.equalTo(button);
            make.height.mas_equalTo(30);
        }];
        
        
    }
    return _headView;
}

#pragma mark -- UITabelViewDelegate And DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if (section == 1) {
        return self.dataArr.count;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 1) {
        SearchCell1 *cell = [tableView dequeueReusableCellWithIdentifier:@"SearchCell1"];
        cell.index = indexPath.row+1;
        [cell fillTitleWithStr:self.dataArr[indexPath.row]];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    SearchCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SearchCell"];
    [cell fillWithArray:self.array];
    cell.vc = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return [self setContents:self.array];
    }
    
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor whiteColor];
    
    if (section == 1) {
        UILabel *label = [UILabel createLabelWithFrame:VIEWFRAME(15, 0, 150, 53)                                                 andText:@"历史搜索"
                                     andTextColor:APP_COLOR_GRAY_Font
                                       andBgColor:[UIColor clearColor]
                                          andFont:SYSTEMFONT(14)
                                 andTextAlignment:NSTextAlignmentLeft];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        [btn setTitle:@"清空记录" forState:UIControlStateNormal];
        [btn setTitleColor:APP_COLOR_GREEN forState:UIControlStateNormal];
        btn.titleLabel.font = SYSTEMFONT(14);
        [btn addTarget:self action:@selector(clearBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        
        [view addSubview:label];
        [view addSubview:btn];
        
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(view);
            make.left.equalTo(view.mas_left).offset(15);
            make.size.mas_equalTo(CGSizeMake(100, 20));
        }];
        
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(view);
            make.right.equalTo(view.mas_right).offset(-15);
            make.size.mas_equalTo(CGSizeMake(60, 30));
        }];
        
        
        return view;
    }
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    if (section == 0) {
        return 0.000000000001;
    }
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.00000000001;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor whiteColor];
    
    return view;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"1");
    
    NSMutableArray *vcArr2 = [NSMutableArray array];
    for (int i =0; i<2; i++) {
        UIViewController *vc = [[UIViewController alloc] init];
        vc.view.backgroundColor = [UIColor whiteColor];
        [vcArr2 addObject:vc];
    }
    NSArray *array = @[@"寄卖商品",@"寄租商品"];
    NSDictionary *dic = @{@"title":@"搜索列表",@"content":self.dataArr[indexPath.row],@"type":@"6"};
    
    Search1VC *vc = [[Search1VC alloc] initWithControllers:vcArr2 titles:array type:1];
    vc.dic = dic;
    
    [self pushViewController:vc];
}

- (CGFloat)setContents:(NSArray *)contents{

    if (contents.count<1) {
        return 0;
    }
    UIButton *wordBtn;
    NSString *titleStr;
    CGSize titleSize;
    NSString *tmpStr; //下一个tag str
    CGSize tmpSize;   //下一个tag str size
    CGFloat nextBtnWidth;
    CGFloat btnWidth;
    
    CGFloat x = 15;
    CGFloat y = 15.f+30.f+5.f;
    
    
    //CGFloat wordBtn_bottom = y;
    int rowNum = 1;
    for (int i = 0 ; i < contents.count; i++) {
        BrandHotModel *model = contents[i];
        titleStr = model.name;
        titleSize = [titleStr sizeWithAttributes:@{NSFontAttributeName:SYSTEMFONT(12)}];
        if (i+1<[contents count]) {
            BrandHotModel *model1 = contents[i+1];
            
            tmpStr = model1.name;
            tmpSize = [tmpStr sizeWithAttributes:@{NSFontAttributeName:SYSTEMFONT(12)}];
        }else{
            tmpSize = CGSizeZero;
        }
        

        btnWidth = titleSize.width+16.f;
        if (btnWidth>SCREEN_WIDTH) {
            btnWidth=SCREEN_WIDTH;
        }
        
        nextBtnWidth = tmpSize.width+16.f;
        if (nextBtnWidth>SCREEN_WIDTH) {
            nextBtnWidth = SCREEN_WIDTH;
        }
        
        wordBtn.frame = CGRectMake(x, y, btnWidth, 27.f);

        
        x = x + btnWidth +5;
        if (x+nextBtnWidth>SCREEN_WIDTH-15.f) {
            x = 15.f;
            y = y + 27.f + 10.f;
            rowNum+=1;
        }
        
        
        
        
    }
    
    //        [_delegate returnHeight:self.height];
    //    }
    return y + 27.f + 10.f;
}


-(void)searchAvtion:(UIButton *)sender
{
    
    [self.text resignFirstResponder];
    [self.text endEditing:YES];

    
        NSMutableArray *vcArr2 = [NSMutableArray array];
        for (int i =0; i<2; i++) {
            UIViewController *vc = [[UIViewController alloc] init];
            vc.view.backgroundColor = [UIColor whiteColor];
            [vcArr2 addObject:vc];
        }
        NSArray *array = @[@"寄卖商品",@"寄租商品"];
        NSDictionary *dic = @{@"title":@"搜索列表",@"content":self.text.text,@"type":@"6"};

        Search1VC *vc = [[Search1VC alloc] initWithControllers:vcArr2 titles:array type:1];
        vc.dic = dic;
    
        [self pushViewController:vc];
//        [self PushViewControllerByClassName:@"Search1VC" info:dic];
    
    
    NSMutableDictionary *searchDic = DEFAULTS_GET_OBJ(@"search");
    if (searchDic.count == 0) {
        
        NSMutableDictionary *newDic = [[NSMutableDictionary alloc] init];
        [newDic setValue:self.text.text forKey:@"1"];
        DEFAULTS_SET_OBJ(newDic, @"search");
        
    }else if (searchDic.count == 10){
        NSMutableDictionary *dic1 = [[NSMutableDictionary alloc] initWithDictionary:searchDic];
        [dic1 setValue:self.text.text forKey:@"10"];
        DEFAULTS_SET_OBJ(dic1, @"search");
        
    }else{
//        NSLog(@"%@",describe(searchDic));
        NSArray * array = [searchDic allKeys];
        NSInteger max = [[array valueForKeyPath:@"@max.intValue"] integerValue];
        NSLog(@"%@",array);
        if (max < 10) {
            NSMutableDictionary *dic1 = [[NSMutableDictionary alloc] initWithDictionary:searchDic];
            [dic1 setValue:self.text.text forKey:[NSString stringWithFormat:@"%ld",max+1]];
            DEFAULTS_SET_OBJ(dic1, @"search");
            
        }
        
        
    }
    
    
}

-(void)clearBtn:(UIButton *)sender
{
    NSMutableDictionary *searchDic = [[NSMutableDictionary alloc] init];
    DEFAULTS_SET_OBJ(searchDic, @"search");
    [self.dataArr removeAllObjects];
    [self.tableView reloadData];

}


-(void)backAction:(UIButton *)sender
{
    [self dismissGoback];
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
