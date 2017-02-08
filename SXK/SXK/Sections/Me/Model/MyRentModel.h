//
//  MyRentModel.h
//  SXK
//
//  Created by 杨伟康 on 2017/1/23.
//  Copyright © 2017年 ywk. All rights reserved.
//

#import "BaseModel.h"

@interface MyRentModel : BaseModel

@property (nonatomic, strong)NSString *backOddNumber, *oddNumber;

@property (nonatomic, strong)NSDictionary *rent;

@property (nonatomic, strong)NSNumber *rentid, *orderid;

@end
