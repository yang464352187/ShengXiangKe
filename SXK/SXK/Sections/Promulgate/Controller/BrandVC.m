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
#import "BrandModel.h"


@interface BrandVC ()<BATableViewDelegate>

@property (nonatomic, strong) BATableView *contactTableView;
@property (nonatomic, strong)NSMutableArray *dataArray;
@property (nonatomic, strong)NSMutableDictionary *BrandDic;

@end

@implementation BrandVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadingRequest];
    
}

-(void)loadingRequest
{
    
    _weekSelf(weakSelf);
    [BaseRequest GetBrandListWithPageNo:0 PageSize:0 order:1 succesBlock:^(id data) {
        NSArray *models = [BrandModel modelsFromArray:data[@"brandList"]];
        [weakSelf handleModels:models];

    } failue:^(id data, NSError *error) {
    }];
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"品牌";
    
    [self loadData];
    [self initUI];
}

#pragma mark -- getters and setters
-(void)initUI
{
    self.contactTableView = [[BATableView alloc] initWithFrame:VIEWFRAME(0, 0, SCREEN_WIDTH, SCREEN_HIGHT-44)];
    self.contactTableView.delegate = self;
    [self.contactTableView.tableView registerClass:[BrandCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.contactTableView];

}

-(void)loadData
{
    self.BrandDic = [[NSMutableDictionary alloc] init];
    
    for (int i = 0; i < 26; i++) {
        NSMutableArray *array = [NSMutableArray new];
        [self.BrandDic setObject:array forKey:[NSString stringWithFormat:@"%c", 65+i]];
    }
    
}


#pragma mark - UITableViewDataSource
//多少段
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 26;
}

//多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSMutableArray *array = [self.BrandDic valueForKey:[NSString stringWithFormat:@"%c", 65+section]];
    if (array.count == 0) {
        return 1;
    }
    return array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BrandCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    NSMutableArray *array = [self.BrandDic valueForKey:[NSString stringWithFormat:@"%c", 65+indexPath.section]];
    if (array.count > 0) {
        [cell setModel:array[indexPath.row]];
        return cell;
    }else{
        [cell isNone];
    }
    
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
    NSMutableArray *array = [self.BrandDic valueForKey:[NSString stringWithFormat:@"%c", 65+indexPath.section]];
    BrandModel *model;
    if (self.type != 1) {
        if (array.count > 0) {
            model = array[indexPath.row];
            NSDictionary *dic = @{@"name":model.name,@"class":self.myDict[@"className"],@"brandid":model.brandid};
            NSNotification *notification =[NSNotification notificationWithName:@"tongzhi" object:nil userInfo:dic];
            //通过通知中心发送通知
            [[NSNotificationCenter defaultCenter] postNotification:notification];
            [self PopToIndexViewController:1];
        }else{
            [ProgressHUDHandler showHudTipStr:@"请选择品牌"];
        }
    }else{
        if (array.count >0) {
            model = array[indexPath.row];
            NSDictionary *dic = [model transformToDictionary];
            [_delegate returnBrand:dic];
            [self popGoBack];
        }else{
            [ProgressHUDHandler showHudTipStr:@"请选择品牌"];
        }
    }
    

}


- (NSArray *) sectionIndexTitlesForABELTableView:(BATableView *)tableView {
        NSMutableArray *titles = [NSMutableArray array];
        for (int i = 0; i < 26; i++) {
            
            [titles addObject:[NSString stringWithFormat:@"%c", 65+i]];
        }
    
        return titles;
}

-(void)handleModels:(NSArray *)models
{
    
    for (int i = 0; i < 26; i++) {
        NSMutableArray *array = [self.BrandDic valueForKey:[NSString stringWithFormat:@"%c", 65+i]];
        [array removeAllObjects];
        [self.BrandDic setObject:array forKey:[NSString stringWithFormat:@"%c", 65+i]];
    }
    
    for (BrandModel * model in models) {
        NSString *firstChar = [model.name substringToIndex:1];
        for (int i = 0; i < 26; i++) {
            if ([firstChar isEqualToString:[NSString stringWithFormat:@"%c", 65+i]]) {
                NSMutableArray *array = [self.BrandDic valueForKey:[NSString stringWithFormat:@"%c", 65+i]];
                [array addObject:model];
                [self.BrandDic setObject:array forKey:[NSString stringWithFormat:@"%c", 65+i]];
            }
        }
    }
    [self.contactTableView.tableView reloadData];
    
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
