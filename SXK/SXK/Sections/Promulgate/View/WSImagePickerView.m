//
//  WSImagePickerView.m
//  WSImagePicker
//
//  Created by 吴振松 on 16/10/17.
//  Copyright © 2016年 wsjtwzs. All rights reserved.
//

#import "WSImagePickerView.h"
#import "WSPhotosBroseVC.h"
#import "JFImagePickerController.h"

static NSString *imagePickerCellIdentifier = @"imagePickerCellIdentifier";

@interface WSImagePickerView()<UICollectionViewDelegate,UICollectionViewDataSource,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    NSMutableArray<UIImage *> *_photosArray;
}
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) WSImagePickerConfig *config;
@property (nonatomic, assign) BOOL isFull;


@end

@implementation WSImagePickerView

- (instancetype)initWithFrame:(CGRect)frame config:(WSImagePickerConfig *)config{
    if(self = [super initWithFrame:frame]) {
        _config = (config != nil)?config:([WSImagePickerConfig new]);
        [self setupView];
        [self initializeData];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    return [self initWithFrame:frame config:nil];
}

- (void)setupView {
    self.backgroundColor = [UIColor clearColor];
    
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.itemSize = _config.itemSize;
    layout.sectionInset = _config.sectionInset;
    layout.minimumLineSpacing = _config.minimumLineSpacing;
    layout.minimumInteritemSpacing = _config.minimumInteritemSpacing;
    
    _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.clipsToBounds = YES;
    _collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.bounces = NO;
    _collectionView.backgroundColor = [UIColor clearColor];
    [self addSubview:_collectionView];
    [_collectionView reloadData];
    
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:imagePickerCellIdentifier];
}

- (void)initializeData {
    _photosArray = [NSMutableArray new];
}

- (void)refreshCollectionView {
    NSInteger n;
    CGFloat width = _collectionView.frame.size.width - _config.sectionInset.left - _config.sectionInset.right;
    n = (width + _config.minimumInteritemSpacing)/(_config.itemSize.width + _config.minimumInteritemSpacing);
    CGFloat height = ((NSInteger)(_photosArray.count)/n +1) * (_config.itemSize.height + _config.minimumLineSpacing);
    height -= _config.minimumLineSpacing;
    height += _config.sectionInset.top;
    height += _config.sectionInset.bottom;
    CGRect frame = self.frame;
    frame.size.height = height+120;
    self.frame = frame;
    [_collectionView reloadData];
    if(self.viewHeightChanged) {
        self.viewHeightChanged(height);
    }
}

- (void)refreshImagePickerViewWithPhotoArray:(NSArray *)array {
    if(array.count > 0) {
        [_photosArray removeAllObjects];
        [_photosArray addObjectsFromArray:array];
    }
    [self refreshCollectionView];
}

- (NSArray<UIImage *> *)getPhotos {
    NSArray *array = [NSArray arrayWithArray:_photosArray];
    return array;
}

#pragma make - collectionViewDelegate -

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if(_photosArray.count < _config.photosMaxCount) {
        self.isFull = 0;
        return _photosArray.count + 3;
    }
    self.isFull = 1;
    return _photosArray.count+2;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:imagePickerCellIdentifier forIndexPath:indexPath];
    UIImageView *imgView = (UIImageView *)[cell.contentView viewWithTag:1];
    UIImageView *imgView1 = (UIImageView *)[cell.contentView viewWithTag:2];
    UIImageView *imgView2 = (UIImageView *)[cell.contentView viewWithTag:3];

    
    if (!imgView) {
        imgView = [[UIImageView alloc] initWithFrame:cell.bounds];
        imgView.contentMode = UIViewContentModeScaleAspectFill;
        imgView.clipsToBounds = YES;
        imgView.tag = 1;
//        imgView.image = [UIImage imageNamed:@"bg_photo_add"];

        [cell addSubview:imgView];
    }
    if (!imgView1) {
        imgView1 = [[UIImageView alloc] initWithFrame:cell.bounds];
        imgView1.contentMode = UIViewContentModeScaleAspectFill;
//        imgView1.image = [UIImage imageNamed:@"如何-拍摄"];
        imgView1.clipsToBounds = YES;
        imgView1.tag = 2;
        
       [cell addSubview:imgView1];
    }
    
    if (!imgView2) {
        imgView2 = [[UIImageView alloc] initWithFrame:cell.bounds];
        imgView2.contentMode = UIViewContentModeScaleAspectFill;
        //        imgView1.image = [UIImage imageNamed:@"如何-拍摄"];
        imgView2.clipsToBounds = YES;
        imgView2.tag = 3;
        
        [cell addSubview:imgView2];
    }


    if(indexPath.row < _photosArray.count) {
        UIImage *image = _photosArray[indexPath.row];
        imgView.image = image;
    }
//    else {
    if (self.isFull) {
        if (indexPath.row == _photosArray.count) {
            imgView.image = nil;
            imgView.image = [UIImage imageNamed:@"如何-拍摄"];
        }
        if (indexPath.row == _photosArray.count+1) {
            imgView1.image = nil;
            imgView1.image = [UIImage imageNamed:@"必须9张图"];
        }
//        if (indexPath.row == _photosArray.count+2) {
//            imgView2.image = nil;
//            imgView2.image = [UIImage imageNamed:@"必须9张图"];
//        }
    }else{
        if (indexPath.row == _photosArray.count) {
            imgView.image = nil;
            imgView.image = [UIImage imageNamed:@"拍摄"];
        }
        if (indexPath.row == _photosArray.count+1) {
            imgView1.image = nil;
            imgView1.image = [UIImage imageNamed:@"如何-拍摄"];
        }
        if (indexPath.row == _photosArray.count+2) {
            imgView2.image = nil;
            imgView2.image = [UIImage imageNamed:@"必须9张图"];
        }

    }
    
    

//    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray *tmpArray = [NSMutableArray new];
    if(indexPath.row < _photosArray.count) {
        for (UIImage *image in _photosArray) {
            WSImageModel *model = [WSImageModel new];
            model.image = image;
            [tmpArray addObject:model];
        }
        
        WSPhotosBroseVC *vc = [WSPhotosBroseVC new];
        vc.imageArray = tmpArray;
        vc.showIndex = indexPath.row;
        vc.completion = ^ (NSArray *array){
            dispatch_async(dispatch_get_main_queue(), ^{
                [_photosArray removeAllObjects];
                [_photosArray addObjectsFromArray:array];
                [self refreshCollectionView];
            });
        };
        [self.navigationController pushViewController:vc animated:YES];
    }
    else {
//        [self pickPhotos];
        if (!self.isFull) {
            if (indexPath.row == _photosArray.count) {
                [self pickPhotos];
            }
            if (indexPath.row == _photosArray.count +1) {
                if ([_delegate respondsToSelector:@selector(showTeachView)]) { // 如果协议响应了sendValue:方法
                    [_delegate showTeachView]; // 通知执行协议方法
                }
                
            }
        }
    }
}

- (void)pickPhotos{
    UIActionSheet *action = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从照片库选取",nil];
    [action showInView:self.navigationController.view];
}


#pragma mark - UIActionSheet delegate -
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (buttonIndex) {
        case 0:
        {
            UIImagePickerController *vc = [UIImagePickerController new];
            vc.sourceType = UIImagePickerControllerSourceTypeCamera;//sourcetype有三种分别是camera，photoLibrary和photoAlbum
            vc.delegate = self;
            [self.navigationController presentViewController:vc animated:YES completion:nil];
        }
            break;
        case 1:
        {
            NSInteger count = _config.photosMaxCount - _photosArray.count;
            [JFImagePickerController setMaxCount:count];
            JFImagePickerController *picker = [[JFImagePickerController alloc] initWithRootViewController:[UIViewController new]];
            picker.pickerDelegate = self;
            [self.navigationController presentViewController:picker animated:YES completion:nil];
        }
            break;
            
        default:
            break;
    }
}


#pragma mark - JFImagePicker Delegate -

- (void)imagePickerDidFinished:(JFImagePickerController *)picker{
    
    __weak typeof(self) weakself = self;
    for (ALAsset *asset in picker.assets) {
        [[JFImageManager sharedManager] imageWithAsset:asset resultHandler:^(CGImageRef imageRef, BOOL longImage) {
            UIImage *image = [UIImage imageWithCGImage:imageRef];
            dispatch_async(dispatch_get_main_queue(), ^{
                [_photosArray addObject:image];
                [weakself refreshCollectionView];
            });
        }];
    }
    [self imagePickerDidCancel:picker];
}

- (void)imagePickerDidCancel:(JFImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
    [JFImagePickerController clear];
}

#pragma  mark - imagePickerController Delegate -
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [self imageHandleWithpickerController:picker MdediaInfo:info];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:^{}];
}

- (void)imageHandleWithpickerController:(UIImagePickerController *)picker MdediaInfo:(NSDictionary *)info {
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [_photosArray addObject:image];
    [self refreshCollectionView];
    [picker dismissViewControllerAnimated:YES completion:^{}];
}


@end

@implementation WSImagePickerConfig

- (instancetype)init {
    if(self = [super init]) {
        _itemSize = CGSizeMake(60, 60);
        _sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        _minimumLineSpacing = 10.0f;
        _minimumInteritemSpacing = 10.0f;
        _photosMaxCount = 9;
    }
    return self;
}


@end
