//
//  OrderDetailModel.h
//  SXK
//
//  Created by 杨伟康 on 2017/4/20.
//  Copyright © 2017年 ywk. All rights reserved.
//

#import "BaseModel.h"

@interface OrderDetailModel : BaseModel
@property (nonatomic, strong)NSString *keyword, *name, *oddNumber, *description1,*nickname,*headimgurl;

@property (nonatomic, strong)NSNumber *marketPrice, *rentPrice, *rentid, *condition, *orderid, *userid;

//@property (nonatomic, strong)NSArray *imgList;

@property (nonatomic, strong)NSDictionary *tenancy , *rent, *purchase;
@end
