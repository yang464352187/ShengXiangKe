//
//  PromulgateTopicVC.m
//  SXK
//
//  Created by 杨伟康 on 2016/12/13.
//  Copyright © 2016年 ywk. All rights reserved.
//

#import "PromulgateTopicVC.h"

@interface PromulgateTopicVC ()

@property (strong, nonatomic) UIView    *headView;
@property (nonatomic, strong) UICollectionView *collectionView;


@end

@implementation PromulgateTopicVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"社区";
    [self.view addSubview:self.tableView];

}

#pragma mark -- getters and setters


- (UITableView *)tableView{
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:VIEWFRAME(0, 0, SCREEN_WIDTH, SCREEN_HIGHT-44) style:UITableViewStyleGrouped];
        _tableView.dataSource      = self;
        _tableView.delegate        = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.tableHeaderView = self.headView;
        _tableView.sectionHeaderHeight = 0.0;
        _tableView.sectionFooterHeight = 0.0;
        
    }
    return _tableView;
}

- (UIView *)headView{
    if (!_headView) {
        _headView = [[UIView alloc] initWithFrame:VIEWFRAME(0, 0, SCREEN_WIDTH, 327.0000/667*SCREEN_HIGHT)];
        _headView.backgroundColor = [UIColor whiteColor];
        UIImageView *image = [[UIImageView alloc] initWithFrame:CommonVIEWFRAME(0, 0, 375, 219)];
        image.image = [UIImage imageNamed:@"背景"];
        self.headImage = image;
        
        UIImageView *image1 = [[UIImageView alloc] initWithFrame:CommonVIEWFRAME(178, 207, 19, 12)];
        image1.image = [UIImage imageNamed:@"多边形-1"];
        
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CommonVIEWFRAME(0, 219, 375, 108) collectionViewLayout:layout];
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.backgroundColor = [UIColor whiteColor];
        collectionView.showsVerticalScrollIndicator = NO;
        collectionView.showsHorizontalScrollIndicator = NO;
        [collectionView registerClass:[CommunityCollectionCell class] forCellWithReuseIdentifier:@"cell"];
        
        
        [_headView addSubview: image];
        [_headView addSubview:image1];
        [_headView addSubview:collectionView];
        self.collectionView = collectionView;
    }
    return _headView;
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
