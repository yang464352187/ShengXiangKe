//
//  ClaasifyCollectionViewCell.h
//  SXK
//
//  Created by 杨伟康 on 2016/11/21.
//  Copyright © 2016年 ywk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BrandDetailModel.h"
#import "HomeVC.h"
@interface ClaasifyCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) HomeVC *vc;
@property (nonatomic, strong)UILabel *title;
@property (nonatomic, strong)UILabel *title1;
@property (nonatomic, strong)UIImageView *headImage;

-(void)fillWithModel:(BrandDetailModel *)model andClassid:(NSNumber *)classid;
@end
