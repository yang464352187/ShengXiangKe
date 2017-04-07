//
//  MyBussinesModel.h
//  SXK
//
//  Created by 杨伟康 on 2017/4/5.
//  Copyright © 2017年 ywk. All rights reserved.
//

#import "BaseModel.h"

@interface MyBussinesModel : BaseModel


@property (nonatomic, strong)NSString *name, *description1, *oddNumber;

@property (nonatomic, strong)NSNumber *marketPrice,*advancePrice,*sellingPrice,*orderid,*purchaseid,*rentid;

@property (nonatomic, strong)NSArray *imgList;
@end
