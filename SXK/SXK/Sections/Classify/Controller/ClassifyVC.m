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


@interface ClassifyVC ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout,BATableViewDelegate>

@property (nonatomic, strong)NSMutableArray *dataArr;
@property (nonatomic, strong)UITableView *selectView;
//@property (nonatomic, strong)UITableView *rightTableView;
@property (nonatomic, strong) UIView *headView;
@property (nonatomic, strong)UICollectionView *collectionView;
//@property (nonatomic, strong)NSMutableArray *dataArray;
@property (nonatomic, strong) BATableView *contactTableView;
@end

@implementation ClassifyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.view.backgroundColor = [UIColor greenColor];
    self.navigationItem.title = @"分类";
    [self loadData];
    [self initUI];
    //2c2b30
}

-(void)loadData
{
    self.dataArr = [[NSMutableArray alloc] initWithObjects:@"品牌",@"包袋",@"腕表" ,nil];
//    self.dataArray = [NSMutableArray array];
//    for (int i = 0; i < 26; i++) {
//        //         循环段数据
//        NSMutableArray *sectionArr = [NSMutableArray array];
//        for (int j = 0; j < 5; j++) {
//            //            循环行数据
//            NSString *rowStr = [NSString stringWithFormat:@"第%d段，%d行", i, j];
//            [sectionArr addObject:rowStr];
//        }
//        [self.dataArray addObject:sectionArr];
//    }

}

-(void)initUI
{
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    searchBtn.frame = VIEWFRAME(15, CommonHight(11), SCREEN_WIDTH - 30,CommonHight(35) );
    UIImage *image = [UIImage imageNamed:@"搜索-6"];
    [searchBtn setImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [searchBtn.imageView setContentMode:UIViewContentModeScaleAspectFill]; //防止图片变形
    [self.view addSubview:searchBtn];
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.contactTableView];
    
//    self.contactTableView.tableViewIndex.frame = VIEWFRAME(SCREEN_WIDTH- CommonWidth(72)-5-20, 0, 20,50);
//    [self. bringSubviewToFront:self.contactTableView.tableViewIndex];
    [self.view bringSubviewToFront:self.contactTableView.tableViewIndex];

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
//        NSArray *sectionArr = self.dataArray[section];
        return 5;
    }

    return 13;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _contactTableView.tableView) {
        RightCell *cell = [tableView dequeueReusableCellWithIdentifier:@"rightCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }

    
    LeftCell *cell = [tableView dequeueReusableCellWithIdentifier:@"leftCell"];
    cell.backgroundColor = [UIColor colorWithHexColorString:@"eeeeee"];
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


#pragma mark - UICollectionViewDataSource
//这个collectionView有多少个段落
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//某一段有多少个item
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return 15;
}

//每个item应该如何展示
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ClassCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    return cell;
}

//- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
//{
//    return UIEdgeInsetsMake(0, 0, 0, 0);
//}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section;
{
    return CommonHight(8);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return CommonWidth(7);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(CommonWidth(88), CommonHight(60));
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
        _headView = [[UIView alloc] initWithFrame:VIEWFRAME(0, 0,  SCREEN_WIDTH- CommonWidth(72)-5, 400.0000/667*SCREEN_HIGHT)];
        _headView.backgroundColor = [UIColor whiteColor];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        btn.frame = VIEWFRAME((SCREEN_WIDTH- CommonWidth(72)-5-75)/2,  381.0000/667*SCREEN_HIGHT, 75, 15);
        UIImage *image = [UIImage imageNamed:@"矩形-9-拷贝-2"];
        [btn setImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
//        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitle:@"全部分类" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.titleLabel.font = SYSTEMFONT(13);
        btn.imageEdgeInsets = UIEdgeInsetsMake(0,-10,0,0);
//        btn.backgroundColor = [UIColor greenColor];
        [_headView addSubview:btn];
        [_headView addSubview:self.collectionView];
        
        
        
        
        
    }
    return _headView;
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:VIEWFRAME(0, 0, SCREEN_WIDTH- CommonWidth(72)-5, 340.0000/667*SCREEN_HIGHT ) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView registerNib:[UINib nibWithNibName:@"ClassCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
        
        
        
    }
    return _collectionView;
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
