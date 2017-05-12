//
//  ClassifyVC.m
//  SXK
//
//  Created by 杨伟康 on 2016/11/11.
//  Copyright © 2016年 ywk. All rights reserved.
//

#import "ClassifyVC.h"
#import "LeftCell.h"
#import "ClassCollectionViewCell.h"
#import "RightCell.h"
#import "BATableView.h"
#import "ClassifyCollectionHeader.h"
#import "ClassifyCollectionFooter.h"
#import "BrandModel.h"
#import "BrandHotModel.h"
#import "CategoryListModel.h"
#import "CategoryViewCell.h"
#import "Search1VC.h"
@interface ClassifyVC ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout,BATableViewDelegate>

@property (nonatomic, strong)NSMutableArray *dataArr;
@property (nonatomic, strong)NSArray *BrandHotArr;
@property (nonatomic, strong)UITableView *selectView;
@property (nonatomic, strong)UIView *headView;
@property (nonatomic, strong)UICollectionView *collectionView;
@property (nonatomic, strong)UICollectionView *listCollectionView;
@property (nonatomic, strong)BATableView *contactTableView;
@property (nonatomic, strong)NSMutableDictionary *BrandDic;
@property (nonatomic, strong)NSArray *CategoryListArr;
@property (nonatomic, strong)LeftCell *firstCell;
@property (nonatomic, assign)NSInteger isSelect;
@property (nonatomic, strong)NSString *collectionHeaderImg;
@property (nonatomic, strong)NSArray *CategoryArr;
@property (nonatomic, strong)NSArray *CategoryHotArr;
@end

@implementation ClassifyVC


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (self.first == 0) {
        [self loadingRequest];
    }
    
}

-(void)loadingRequest
{
    [self startLoadingView:VIEWFRAME(0, 0, SCREEN_WIDTH, SCREEN_HIGHT)];

    _weekSelf(weakSelf);
    [BaseRequest GetBrandListWithPageNo:0 PageSize:0 order:1 succesBlock:^(id data) {
        NSArray *models = [BrandModel modelsFromArray:data[@"brandList"]];
        
        //处理model
        [weakSelf handleModels:models];
    } failue:^(id data, NSError *error) {
    }];
    
    [BaseRequest GetBrandHotListWithPageNo:0 PageSize:0 order:1 succesBlock:^(id data) {
        NSArray *models = [BrandHotModel modelsFromArray:data[@"hotList"]];
        weakSelf.BrandHotArr = models;
        [weakSelf changeFrame];
        [weakSelf.collectionView reloadData];
        
        [BaseRequest GetCategoryListWithPageNo:0 PageSize:0 order:1 parentid:0 succesBlock:^(id data) {
            NSArray *models = [CategoryListModel modelsFromArray:data[@"categoryList"]];
            weakSelf.CategoryListArr = models;
            
            [weakSelf.tableView reloadData];
            [weakSelf stopLoadingView];
            self.first = 1;
            
//            NSLog(@"--------%@-------",describe(models));
        } failue:^(id data, NSError *error) {
            
        }];

    } failue:^(id data, NSError *error) {
    }];

    
}


-(void)loadCategoryData:(CategoryListModel *)model
{
    _weekSelf(weakSelf);
    self.collectionHeaderImg = model.img;
    [BaseRequest GetCategoryListWithPageNo:0 PageSize:0 order:1 parentid:[model.categoryid integerValue] succesBlock:^(id data) {
        NSArray *models = [CategoryListModel modelsFromArray:data[@"categoryList"]];
        weakSelf.CategoryArr = models;
        
        
        [BaseRequest GetCategoryHotListWithPageNo:0 PageSize:0 order:1 categoryid:[model.categoryid integerValue] succesBlock:^(id data) {
            
            NSArray *models = [BrandModel modelsFromArray:data[@"hotList"]];
            weakSelf.CategoryHotArr = models;
            [weakSelf.listCollectionView reloadData];
            
        } failue:^(id data, NSError *error) {
            
        }];
        
        
        
        

    } failue:^(id data, NSError *error) {
    }];

}

-(void)changeFrame
{
    NSInteger count = 0;
    if (self.BrandHotArr.count % 3 == 0) {
        count = self.BrandHotArr.count / 3;
    }else{
        count = self.BrandHotArr.count / 3 + 1;
    }
    CGRect frame = self.collectionView.frame;
    frame.size.height = (CommonHight(60) + CommonWidth(7)) * count + 70;
    self.collectionView.frame = frame;
    self.headView.frame = frame;
    self.contactTableView.tableView.tableHeaderView = self.headView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"分类";
    [self loadData];
    [self initUI];
    

}

-(void)loadData
{
    self.BrandDic = [[NSMutableDictionary alloc] init];

    for (int i = 0; i < 26; i++) {
        NSMutableArray *array = [NSMutableArray new];
        [self.BrandDic setObject:array forKey:[NSString stringWithFormat:@"%c", 65+i]];
    }
    self.dataArr = [[NSMutableArray alloc] initWithObjects:@"品牌",@"包袋",@"腕表" ,nil];

}

-(void)initUI
{
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    searchBtn.frame = VIEWFRAME(15, CommonHight(11), SCREEN_WIDTH - 30,CommonHight(35) );
    UIImage *image = [UIImage imageNamed:@"搜索-6"];
    [searchBtn setImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [searchBtn.imageView setContentMode:UIViewContentModeScaleAspectFill]; //防止图片变形
    [searchBtn addTarget:self  action:@selector(searchBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:searchBtn];
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.contactTableView];
    
//    self.contactTableView.tableViewIndex.frame = VIEWFRAME(SCREEN_WIDTH- CommonWidth(72)-5-20, 0, 20,50);
//    [self. bringSubviewToFront:self.contactTableView.tableViewIndex];
//    [self.view bringSubviewToFront:self.contactTableView.tableViewIndex];

}

#pragma mark -- UITabelViewDelegate And DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (tableView == _contactTableView.tableView) {
        return 27;
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == _contactTableView.tableView) {
        
        if (section > 0) {
            NSMutableArray *array = [self.BrandDic valueForKey:[NSString stringWithFormat:@"%c", 65+section-1]];
            if (array.count == 0) {
                return 1;
            }
            else{
                return array.count;
            }
        }
        return 1;
    }
    
    return self.CategoryListArr.count+1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _contactTableView.tableView) {
        
        RightCell *cell = [tableView dequeueReusableCellWithIdentifier:@"rightCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (indexPath.section > 0) {
            NSMutableArray *array = [self.BrandDic valueForKey:[NSString stringWithFormat:@"%c", 65+indexPath.section-1]];
            if (array.count > 0) {
                [cell setModel:array[indexPath.row]];
                return cell;
            }
        }
        [cell isNone];
        return cell;
    
    }

    LeftCell *cell = [tableView dequeueReusableCellWithIdentifier:@"leftCell"];
    if (indexPath.row < 1) {
        self.firstCell = cell;
        [cell fillTitle];
        
        cell.backgroundColor = [UIColor whiteColor];
    }else{
        [cell setModel:self.CategoryListArr[indexPath.row-1]];
        cell.backgroundColor = [UIColor colorWithHexColorString:@"eeeeee"];

    }
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor = [UIColor whiteColor];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _contactTableView.tableView) {
            if (indexPath.section == 0) {
                return 0;
        }
        return CommonHight(52);
    }
    return CommonHight(60);
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView == _contactTableView.tableView) {
        if (section == 0) {
            return 0;
        }
        return CommonHight(52);
    }
    return 0.00001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.000001;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
    if (tableView == _contactTableView.tableView && section != 0) {
        view.backgroundColor = [UIColor whiteColor];
        UILabel *title = [UILabel createLabelWithFrame:VIEWFRAME(16,0 ,  SCREEN_WIDTH- CommonWidth(72)-5, CommonHight(51.5))
                                               andText:[NSString stringWithFormat:@"%c", (int)(section + 64)]
                                          andTextColor:[UIColor blackColor]
                                            andBgColor:[UIColor clearColor]
                                               andFont:SYSTEMFONT(14)
                                      andTextAlignment:NSTextAlignmentLeft];
        UIView *line = [[UIView alloc] initWithFrame:VIEWFRAME(0, CommonHight(52)-0.5, SCREEN_WIDTH, 0.5)];
        line.backgroundColor = [UIColor colorWithHexColorString:@"dcdcdc"];
    
        [view addSubview:title];
        [view addSubview:line];
    }
  
    return view;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView == _contactTableView.tableView) {
        
        if (indexPath.section > 0) {
            NSMutableArray *array = [self.BrandDic valueForKey:[NSString stringWithFormat:@"%c", 65+indexPath.section-1]];
            if (array.count > 0) {
                BrandModel *model = array[indexPath.row];
                NSDictionary *dic = @{@"title":model.name,@"brandid":model.brandid,@"type":@"1"};
                [self PushViewControllerByClassName:@"ClassifyDetailVC" info:dic];
            }else{
                [ProgressHUDHandler showHudTipStr:@"暂无收入相关品牌信息"];
            }
        }
        
        
    }else{
        if (indexPath.row == 0) {
            [self.listCollectionView removeFromSuperview];
            [self.view addSubview:self.contactTableView];
            
        }else{
            self.firstCell.backgroundColor = [UIColor colorWithHexColorString:@"eeeeee"];
            CategoryListModel *model = self.CategoryListArr[indexPath.row - 1];
            [self loadCategoryData:model];
            [self.contactTableView removeFromSuperview];
            [self.view addSubview: self.listCollectionView];
            
        }

    }
    
    


}

#pragma mark - UICollectionViewDataSource
//这个collectionView有多少个段落
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    if (collectionView == _listCollectionView) {
        return 3;
    }
    return 1;
}

//某一段有多少个item
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (collectionView == _listCollectionView) {
        if (section == 0) {
            return 1;
        }
        if (section == 1) {
            return self.CategoryHotArr.count;
        }
        if (section == 2) {
            return self.CategoryArr.count;
        }
        return 3;
    }
    
    return self.BrandHotArr.count;
}

//每个item应该如何展示
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ClassCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    if (collectionView == _collectionView) {
        if (indexPath.row < self.BrandHotArr.count) {
            BrandHotModel *model = self.BrandHotArr[indexPath.row];
            [cell fillWithImage:model.img];
        }
    }else{
        
        if (indexPath.section == 0) {
            if (self.collectionHeaderImg.length > 0) {
                [cell fillWithImage:self.collectionHeaderImg];
            }
        }
        if (indexPath.section == 1) {
            BrandHotModel *model = self.CategoryHotArr[indexPath.row];
            [cell fillWithImage:model.img];
        }
        if (indexPath.section == 2) {
            CategoryViewCell *CategoryCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CategoryViewCell" forIndexPath:indexPath];
            CategoryListModel *model = self.CategoryArr[indexPath.row];
            [CategoryCell fillWithImage:model.img andTitle:model.name];
            return CategoryCell;
        }
        
    }
    return cell;
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section;
{
    return CommonHight(8);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    if (collectionView == _listCollectionView) {
        if (section == 2) {
            return CommonWidth(15);
        }
    }
    return CommonWidth(7);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView == _listCollectionView) {
        if (indexPath.section == 0) {
            return CGSizeMake(CommonWidth(280), CommonHight(108));
        }
        if (indexPath.section == 2) {
            return CGSizeMake(CommonWidth(63), 85);
        }
    }
    
    
    return CGSizeMake(CommonWidth(88), CommonHight(60));
}
//设置段落的内边距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if (collectionView == _listCollectionView) {
        if (section == 2) {
            return UIEdgeInsetsMake(0, 15, 0, self.listCollectionView.size.width-CommonWidth(280)+15);
        }
        return UIEdgeInsetsMake(0, 0, 0, self.listCollectionView.size.width-CommonWidth(280));
        
    }
    
        return UIEdgeInsetsMake(0, 0, 0, self.listCollectionView.size.width-CommonWidth(280));
}



#pragma mark -- getters and setters


- (UITableView *)tableView{
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:VIEWFRAME(0, CommonHight(68), CommonWidth(72),SCREEN_HIGHT - CommonHight(68)-64-44-6) style:UITableViewStyleGrouped];
        _tableView.dataSource      = self;
        _tableView.delegate        = self;
        [_tableView registerClass:[LeftCell class] forCellReuseIdentifier:@"leftCell"];
//        [_tableView registerClass:[ClassifyCell class] forCellReuseIdentifier:@"ClassifyCell"];
//        [_tableView registerClass:[SpecialCell class] forCellReuseIdentifier:@"SpecialCell"];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.backgroundColor = [UIColor colorWithHexColorString:@"eeeeee"];
        _tableView.tableFooterView = [[UIView alloc] init];
//        _tableView.tableHeaderView = self.headView;
        _tableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
        _tableView.sectionHeaderHeight = 0.0;
        _tableView.sectionFooterHeight = 0.0;

    }
    return _tableView;
}

- (BATableView *)contactTableView{
    if (!_contactTableView) {
        
        _contactTableView = [[BATableView alloc] initWithFrame:VIEWFRAME(CommonWidth(72)+5, CommonHight(68), SCREEN_WIDTH- CommonWidth(72)-5,SCREEN_HIGHT - CommonHight(68)-64-44-6)];
        _contactTableView.delegate        = self;
        [_contactTableView.tableView registerClass:[RightCell class] forCellReuseIdentifier:@"rightCell"];
        _contactTableView.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _contactTableView.tableView.showsVerticalScrollIndicator = NO;
        _contactTableView.tableView.backgroundColor = [UIColor whiteColor];
        _contactTableView.tableView.tableFooterView = [[UIView alloc] init];
        _contactTableView.tableView.tableHeaderView = self.headView;
        _contactTableView.tableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
        _contactTableView.tableView.sectionHeaderHeight = 0.0;
        _contactTableView.tableView.sectionFooterHeight = 0.0;
        
    }
    return _contactTableView;
}

- (UIView *)headView{
    if (!_headView) {
        _headView = [[UIView alloc] initWithFrame:VIEWFRAME(0, 0,  SCREEN_WIDTH- CommonWidth(72)-5, 100.0000/667*SCREEN_HIGHT)];
        _headView.backgroundColor = [UIColor whiteColor];
        [_headView addSubview:self.collectionView];
    }
    return _headView;
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
//        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:VIEWFRAME(0, 0, SCREEN_WIDTH- CommonWidth(72)-5, 100.0000/667*SCREEN_HIGHT ) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView registerClass:[ClassCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        [_collectionView registerClass:[ClassifyCollectionFooter class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer"];
    }
    return _collectionView;
}
- (UICollectionView *)listCollectionView{
    if (!_listCollectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
//        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        
        _listCollectionView = [[UICollectionView alloc] initWithFrame:VIEWFRAME(CommonWidth(72)+5, CommonHight(68), SCREEN_WIDTH- CommonWidth(72)-5,SCREEN_HIGHT - CommonHight(68)-64-44-6) collectionViewLayout:layout];
        _listCollectionView.delegate = self;
        _listCollectionView.dataSource = self;
        _listCollectionView.backgroundColor = [UIColor whiteColor];
        _listCollectionView.showsVerticalScrollIndicator = NO;
        _listCollectionView.showsHorizontalScrollIndicator = NO;
        [_listCollectionView registerClass:[ClassCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        [_listCollectionView registerClass:[CategoryViewCell class ] forCellWithReuseIdentifier:@"CategoryViewCell"];

        [_listCollectionView registerClass:[ClassifyCollectionHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
         [_listCollectionView registerClass:[ClassifyCollectionHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header1"];
        [_listCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer"];
    }
    return _listCollectionView;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader] ) {
        
        if (indexPath.section == 1) {
            ClassifyCollectionHeader *headerView =  [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"header" forIndexPath:indexPath];
            headerView.backgroundColor = [UIColor whiteColor];
            [headerView changeTitle:@"热门品牌" andImg:@"标签"];
            return headerView;
        }
        
        ClassifyCollectionHeader *headerView =  [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"header1" forIndexPath:indexPath];
        headerView.backgroundColor = [UIColor whiteColor];
        [headerView changeTitle:@"全部分类" andImg:@"分类"];
//        [headerView changeTitle:@"quan" andImg:@""];
        
        return headerView;
    }
    else {
        
        UICollectionReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"footer" forIndexPath:indexPath];
        footerView.backgroundColor = [UIColor whiteColor];
        return footerView;

    }

        
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (collectionView == _collectionView) {
        BrandHotModel *model = self.BrandHotArr[indexPath.row];
        NSDictionary *dic = @{@"title":model.name,@"brandid":model.brandid,@"type":@"1"};
        [self PushViewControllerByClassName:@"ClassifyDetailVC" info:dic];
    }else{
//        NSLog(@"行%d     段%d",indexPath.row,indexPath.section);
        
        if (indexPath.section == 1) {
            BrandHotModel *model = self.CategoryHotArr[indexPath.row];
            NSDictionary *dic = @{@"title":model.name,@"brandid":model.brandid,@"type":@"1"};
            [self PushViewControllerByClassName:@"ClassifyDetailVC" info:dic];
        }else if (indexPath.section == 2){
            CategoryListModel *model = self.CategoryArr[indexPath.row];
            NSDictionary *dic = @{@"title":model.name,@"categoryid":model.categoryid,@"type":@"2"};
            [self PushViewControllerByClassName:@"ClassifyDetailVC" info:dic];

//            NSLog(@"%@",describe(self.CategoryArr));
        }

    }
    
    
    
}


//设置段头的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (collectionView == _listCollectionView && section != 0) {
        return CGSizeMake(280, 59);
    }
    return CGSizeMake(0, 0);
}

//设置段尾的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    if (collectionView == _collectionView) {
        return CGSizeMake(SCREEN_WIDTH, 70);
    }
    
    return CGSizeMake(0, 0);
}


- (NSArray *) sectionIndexTitlesForABELTableView:(BATableView *)tableView {
    NSMutableArray *titles = [NSMutableArray array];
    [titles addObject:[NSString stringWithFormat:@"search"]];
    for (int i = 0; i < 26; i++) {
        
        [titles addObject:[NSString stringWithFormat:@"%c", 65+i]];
    }
    //    [titles addObject:UITableViewIndexSearch];
    
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

-(void)searchBtn:(UIButton *)sender
{
//    [self :@"LXWSearchHotView" info:nil];
//    [self PushViewControllerByClassName:@"SearchVC" info:nil];
//    NSMutableArray *vcArr2 = [NSMutableArray array];
//    for (int i =0; i<2; i++) {
//        UIViewController *vc = [[UIViewController alloc] init];
//        vc.view.backgroundColor = [UIColor whiteColor];
//        [vcArr2 addObject:vc];
//    }
//    NSArray *array = @[@"寄卖",@"寄租"];
//    Search1VC *vc = [[Search1VC alloc] initWithControllers:vcArr2 titles:array type:1];
//    [self pushViewController:vc];
    [self PresentViewControllerByClassName:@"SearchVC" info:nil];
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
