//
//  BrandDetailModel.h
//  SXK
//
//  Created by 杨伟康 on 2016/12/28.
//  Copyright © 2016年 ywk. All rights reserved.
//

#import "BaseModel.h"

@interface BrandDetailModel : BaseModel

@property (nonatomic, strong)NSString *name, *keyword, *description1, *color;

@property (nonatomic, strong)NSNumber *rentid, *counterPrice, *crowd, *sale, *sort, *categoryid, *brandid, *condition, *userid, *three, *twentyFive, *fiften, *seven, *marketPrice, *rentPrice, *risk, *sellingPrice,*purchaseid;

@property (nonatomic, strong)NSArray *attachList, *imgList, *commentList;

@property (nonatomic, strong)NSDictionary *brand, *user, *category;

@end
