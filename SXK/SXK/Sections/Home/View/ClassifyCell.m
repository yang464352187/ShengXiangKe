//
//  ClassifyCell.m
//  SXK
//
//  Created by 杨伟康 on 2016/11/21.
//  Copyright © 2016年 ywk. All rights reserved.
//

#import "ClassifyCell.h"
#import "ClaasifyCollectionViewCell.h"
#import "BrandDetailModel.h"
@interface ClassifyCell ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong)NSArray *dataArr;

@end


@implementation ClassifyCell{
    UIImageView *_headImageView;
    UIImageView *_ImageView;
    UICollectionView *_collectionView;
    UIView *_view;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _headImageView = [[UIImageView alloc] initWithFrame:CommonVIEWFRAME(0, 0, 375, 256)];
        _headImageView.image = [UIImage imageNamed:@"背景"];
        _headImageView.userInteractionEnabled = YES;
        [_headImageView setUserInteractionEnabled:YES];
        UITapGestureRecognizer *singleTap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapAction1:)];
        [_headImageView addGestureRecognizer:singleTap1];

        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc] initWithFrame:CommonVIEWFRAME(0, 268.5, 375, 161.5) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView registerNib:[UINib nibWithNibName:@"ClaasifyCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
        
        _view = [[UIView alloc] initWithFrame:CommonVIEWFRAME(0, 445, 375, 15)];
        _view.backgroundColor = [UIColor colorWithHexColorString:@"f7f7f7"];
        
        _ImageView = [[UIImageView alloc] initWithFrame:CommonVIEWFRAME(178, 244, 19, 12)];
        _ImageView.image = [UIImage imageNamed:@"多边形-1"];
        
        
        [self addSubview:_headImageView];
        [self addSubview:_collectionView];
        [self addSubview:_view];
        [self addSubview:_ImageView];
        
    }
    return  self;
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
    NSLog(@"%ld" , self.dataArr.count);
    
    return self.dataArr.count;
}

//每个item应该如何展示
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ClaasifyCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    BrandDetailModel *model = self.dataArr[indexPath.row];
    [cell fillWithModel:model andClassid:self.classid];
    cell.vc = self.vc;
    return cell;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, CommonHight(15), 0, CommonHight(15));
}

//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section;
//{
//    return 50;
//}
//
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return CommonWidth(15);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (SCREEN_WIDTH < 375) {
        return CGSizeMake(CommonWidth(105.5), CommonHight(160.5));

    }
    return CGSizeMake(CommonWidth(105), CommonHight(160.5));
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    BrandDetailModel *model = self.dataArr[indexPath.row];
    NSDictionary *dic = @{@"rentid":model.rentid};
    [self.vc PushViewControllerByClassName:@"BrandDetailVC" info:dic];
    
}

-(void)fillWithDic:(NSDictionary *)dic;
{
    [_headImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",APP_BASEIMG,dic[@"img"]]] placeholderImage:[UIImage imageNamed:@"占位-0"]];
    NSArray *array = dic[@"rentList"];
    self.dataArr = [BrandDetailModel modelsFromArray:array];
    
    self.classid = dic[@"classid"];
    [_collectionView reloadData];
}

-(void)singleTapAction1:(UITapGestureRecognizer *)tap
{
    NSDictionary *dic = @{@"title":@"精选分类",@"classid":self.classid};
    [self.vc PushViewControllerByClassName:@"ThreeVC" info:dic];
}


@end
