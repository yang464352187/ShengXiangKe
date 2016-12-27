//
//  CommonVC.m
//  SXK
//
//  Created by 杨伟康 on 2016/11/23.
//  Copyright © 2016年 ywk. All rights reserved.
//

#import "CommonVC.h"
#import "CategoryCell.h"
#import "SecondCommonVC.h"
#import "qualityVC.h"
#import "SelectCell.h"
#import "CategoryListModel.h"
#import "EnclosureCell.h"

@interface CommonVC ()<qualityCellDelegate,SelectCellDelegate>

@property (nonatomic, strong)NSArray *CategoryArr;
@property (nonatomic, strong)NSMutableArray *personArr;
@property (nonatomic, strong)NSMutableArray *qualityArr;
@property (nonatomic, strong)NSMutableArray *qualityContentArr;
@property (nonatomic, strong)NSMutableArray *enclosureArr;
@property (nonatomic, strong)NSMutableDictionary *dataDic;
@property (nonatomic, assign)NSInteger btnTag;
@property (nonatomic, strong)NSMutableDictionary *cellDic;
@property (nonatomic, strong)NSMutableArray *enclosureArr1;
@property (nonatomic, strong)NSMutableDictionary *enclosureDic1;
@property (nonatomic, strong)NSArray *dataArr;
@property (nonatomic, strong)NSMutableArray *attachList;

@property (nonatomic, strong) qualityVC *selectCell;


@end

@implementation CommonVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    



}

-(void)loadingRequest
{
    _weekSelf(weakSelf);
    [BaseRequest GetCategoryListWithPageNo:0 PageSize:0 order:1 parentid:0 succesBlock:^(id data) {
        NSArray *models = [CategoryListModel modelsFromArray:data[@"categoryList"]];
        weakSelf.CategoryArr = models;
        [weakSelf.tableView reloadData];
        
    } failue:^(id data, NSError *error) {
        
    }];

}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = self.myDict[@"title"];
    if (![self.myDict[@"title"] isEqualToString:@"类别"] && ![self.myDict[@"title"] isEqualToString:@"附件"]) {
         [self setRightBarButtonWith:[NSString stringWithFormat:@"完成"] selector:@selector(barButtonAction)];
    }
    if ([self.myDict[@"title"] isEqualToString:@"附件"]) {
        [self setRightBarButtonWith:[NSString stringWithFormat:@"保存"] selector:@selector(barButtonAction)];
    }
    
    [self initData];
    
    [self.view addSubview:self.tableView];
    
    [self loadData];
}

-(void)loadData
{
    if ([self.myDict[@"title"] isEqualToString:@"类别"]) {
        NSArray *array = self.myDict[@"category"];
        if (array.count > 0) {
            self.CategoryArr = array;
            [self.tableView reloadData];
        }else{
            [self loadingRequest];
        }
    }
    if ([self.myDict[@"title"] isEqualToString:@"附件"]) {
        CategoryListModel *model = self.myDict[@"data"];
        NSArray *array = model.attachList;
        [self.enclosureArr removeAllObjects];
        for (NSDictionary *dic  in array) {
            NSString *title = dic[@"attributeName"];
            if (![title isEqualToString:@"相关配件"]) {
                [self.enclosureArr addObject:title];
                NSArray *array = dic[@"attributeValueList"];
                [self.dataDic setValue:array forKey:title];
            }else{
                NSArray *array = dic[@"attributeValueList"];
                self.dataArr = array;
            }
        }
        [self.tableView reloadData];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(huidiao:) name:@"huidiao" object:nil];

    }
}


-(void)barButtonAction
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    if ([self.myDict[@"title"] isEqualToString:@"附件"]) {
        for (NSString *title in self.enclosureArr) {
            EnclosureCell *cell = [self.cellDic valueForKey:title];
            NSDictionary *dic = [cell getData];
            if (dic.count > 1) {
                NSLog(@"%@",describe([cell getData]));
                [array addObject:dic];
            }
        }
    
        if (self.enclosureDic1.count > 1) {
            [array addObject:self.enclosureDic1];
        }
        if (array.count < 1 ) {
            [ProgressHUDHandler showHudTipStr:@"未选择附件"];
            return;
        }
        
        NSDictionary *dic = @{@"data":array,@"class":self.myDict[@"title"]};
        NSNotification *notification =[NSNotification notificationWithName:@"tongzhi" object:nil userInfo:dic];
        //通过通知中心发送通知
        [[NSNotificationCenter defaultCenter] postNotification:notification];
        
        
        
        [self popGoBack];
        
    }else{
        if (self.selectCell.name.length < 1) {
            [ProgressHUDHandler showHudTipStr:@"未选择类型"];
            return;
        }
        
    NSDictionary *dic = @{@"name":self.selectCell.name,@"class":self.myDict[@"title"]};
    NSNotification *notification =[NSNotification notificationWithName:@"tongzhi" object:nil userInfo:dic];
    //通过通知中心发送通知
    [[NSNotificationCenter defaultCenter] postNotification:notification];
    [self PopToIndexViewController:1];
        
        
        
    }
    
    
}


-(void)initData
{
//    self.CategoryArr = [[NSMutableArray alloc] initWithObjects:@"腕表",@"包袋",@"其他", nil];
    self.personArr = [[NSMutableArray alloc] initWithObjects:@"所有人",@"男士",@"女士", nil];
    self.qualityArr = [[NSMutableArray alloc] initWithObjects:@"99成新（未使用）",@"98成新",@"95成新",@"9成新",@"85成新",@"8成新", nil];
    self.qualityContentArr = [[NSMutableArray alloc] initWithObjects:@"未使用，包装配件齐全",@"包装配件不齐全，或因存放产生细微痕迹",@"未使用但有明显存放痕迹，或轻微适用痕迹",@"有使用痕迹，整体无变形或护理后状态非常好",@"有明显适用痕迹，整体轻微变形",@"有明显适用痕迹，整体状态有变化", nil];
    self.enclosureArr = [[NSMutableArray alloc] init];
    self.enclosureArr1 = [[NSMutableArray alloc] init];
    self.enclosureDic1 = [[NSMutableDictionary alloc] init];
    self.dataDic = [[NSMutableDictionary alloc] init];
    self.cellDic = [[NSMutableDictionary alloc] init];
    self.attachList = [[NSMutableArray alloc] init];

}
- (UITableView *)tableView{
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:VIEWFRAME(0, 0, SCREEN_WIDTH, SCREEN_HIGHT) style:UITableViewStyleGrouped];
        _tableView.dataSource      = self;
        _tableView.delegate        = self;
        [_tableView registerClass:[CategoryCell class] forCellReuseIdentifier:@"CategoryCell"];
        [_tableView registerClass:[qualityVC class] forCellReuseIdentifier:@"QualityCell"];
        [_tableView registerClass:[SelectCell class] forCellReuseIdentifier:@"SelectCell"];
        [_tableView registerClass:[EnclosureCell class] forCellReuseIdentifier:@"EnclosureCell"];
        
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
    if ([self.myDict[@"title"] isEqualToString:@"类别"]) {
        return self.CategoryArr.count;
    }
    if ([self.myDict[@"title"] isEqualToString:@"适用人群"]) {
        return self.personArr.count;
    }
    if ([self.myDict[@"title"] isEqualToString:@"附件"]) {
        return self.enclosureArr.count;
    }

    
    return self.qualityArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.myDict[@"title"] isEqualToString:@"类别"]) {
        CategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CategoryCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setModel:self.CategoryArr[indexPath.row]];
        return cell;

    }
    if ([self.myDict[@"title"] isEqualToString:@"适用人群"]) {
        SelectCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SelectCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell fillTitle:self.personArr[indexPath.row]];
        cell.delegate = self;
        return cell;
    }
    if ([self.myDict[@"title"] isEqualToString:@"附件"]) {
        EnclosureCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EnclosureCell"];
        [cell fillWithTitle:self.enclosureArr[indexPath.row]];
        [self.cellDic setObject:cell  forKey:self.enclosureArr[indexPath.row]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    qualityVC *cell = [tableView dequeueReusableCellWithIdentifier:@"QualityCell"];
    cell.delegate = self;
    [cell fillTitle:self.qualityArr[indexPath.row] andContent:self.qualityContentArr[indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([self.myDict[@"title"] isEqualToString:@"成色"]) {
        return 70;
    }
    return 52;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.0001;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.myDict[@"title"] isEqualToString:@"类别"]) {
        CategoryListModel *model = self.CategoryArr[indexPath.row];
        NSDictionary *dic = @{@"title":model.name,@"className":self.myDict[@"title"],@"categoryID":model.categoryid,@"type":@"类别"};
        [self PushViewControllerByClassName:@"SecondCommonVC" info:dic];
    }
    if ([self.myDict[@"title"] isEqualToString:@"附件"]) {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        NSString *title = self.enclosureArr[indexPath.row];
        NSArray *array = [self.dataDic valueForKey:title];
        [dic setValue:title forKey:@"title"];
        [dic setValue:array forKey:@"data"];
        [dic setValue:@"附件" forKey:@"type"];

        [self PushViewControllerByClassName:@"SecondCommonVC" info:dic];
    }

    
    
    
    
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    
    
    UILabel *title = [UILabel createLabelWithFrame:VIEWFRAME(23, 10, 60, 41)                                                 andText:@"宝贝附件"
                                      andTextColor:[UIColor blackColor]
                                        andBgColor:[UIColor clearColor]
                                           andFont:SYSTEMFONT(14)
                                  andTextAlignment:NSTextAlignmentLeft];
//    self.dataArr = [[NSMutableArray alloc] initWithObjects:@"盒子",@"保修卡",@"说明书",@"发票",@"防尘袋",@"aa",@"123",@"333", nil];
    
    NSInteger i = self.dataArr.count % 3;
    NSInteger t;
    if (i != 0) {
        t = (self.dataArr.count + i)/3;
    }else{
        t = self.dataArr.count/3;
    }
    
    int k = 0;
    for (int i = 0; i < t; i++) {
        for (int j = 0; j <3; j++) {
            if (k == self.dataArr.count) {
                continue;
            }
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = VIEWFRAME(100 + j*CommonWidth(85), 20+i*35, 70, 20);
            UIImage *image = [UIImage imageNamed:@"椭圆-1-拷贝"];
            [btn setImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
            UIImage *image1 = [UIImage imageNamed:@"打钩-1"];
            [btn setImage:[image1 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateSelected];
            [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
            [btn setTitle:self.dataArr [k] forState:UIControlStateNormal];
            btn.tag = 100 + k;
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            btn.titleLabel.font = SYSTEMFONT(14);
            btn.imageEdgeInsets = UIEdgeInsetsMake(0,-10,0,0);
            [view addSubview:btn];
             k++;

        }
    }
    
    
//    view.backgroundColor = [UIColor redColor];
    if (self.dataArr.count > 0) {
        [view addSubview:title];

    }

    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if ([self.myDict[@"title"] isEqualToString:@"附件"]) {
        
        return 100;
    }
    return 0.00000;
}


-(void)sendValue:(id)cell
{
    if (self.selectCell) {
        [self.selectCell isSelect];
        [(qualityVC *)cell isSelect];
        self.selectCell = (qualityVC *)cell;
    }else{
        [(qualityVC *)cell isSelect];
        self.selectCell = (qualityVC *)cell;
    }
}

-(void)btnAction:(UIButton *)sender
{
    if (sender.isSelected) {
        for (int i = 0; i < self.enclosureArr1.count; i++) {
            if ([self.dataArr[sender.tag -100] isEqualToString:self.enclosureArr1[i]]) {
                [self.enclosureArr1 removeObjectAtIndex:i];
            }
        }
        [sender setSelected:NO];
    }else{
        [self.enclosureArr1 addObject:self.dataArr[sender.tag -100]];
        [sender setSelected:YES];
    }
    
    [self.enclosureDic1 setValue:@"相关配件" forKey:@"attributeName"];
    if (self.enclosureArr1.count < 1) {
        [self.enclosureDic1 removeObjectForKey:@"attributeValueList"];
    }else{
        [self.enclosureDic1 setValue:self.enclosureArr1 forKey:@"attributeValueList"];
    }
    

}

- (void)huidiao:(NSNotification *)text{
    EnclosureCell *cell = (EnclosureCell *) [self.cellDic valueForKey:text.userInfo[@"class"]];
    [cell changeTitle:text.userInfo[@"name"]];
    
    
    
    NSLog(@"huidiao   %@",describe(text.userInfo));
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
