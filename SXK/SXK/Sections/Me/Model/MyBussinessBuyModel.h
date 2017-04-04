//
//  MyBussinessBuyModel.h
//  SXK
//
//  Created by 杨伟康 on 2017/4/5.
//  Copyright © 2017年 ywk. All rights reserved.
//

#import "BaseModel.h"

@interface MyBussinessBuyModel : BaseModel
@property (nonatomic, strong)NSString  *oddNumber;

@property (nonatomic, strong)NSDictionary *purchase;

@property (nonatomic, strong)NSNumber *orderid;
//@property (nonatomic, strong)NSNumber *marketPrice,*advancePrice,*sellingPrice,*orderid;

//@property (nonatomic, strong)NSArray *imgList;

@end
