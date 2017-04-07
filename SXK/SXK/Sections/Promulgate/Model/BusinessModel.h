//
//  BusinessModel.h
//  SXK
//
//  Created by 杨伟康 on 2017/3/17.
//  Copyright © 2017年 ywk. All rights reserved.
//

#import "BaseModel.h"

@interface BusinessModel : BaseModel

@property (nonatomic, strong) NSNumber *condition, *advancePrice, *purchaseid;

@property (nonatomic, strong) NSDictionary *category;

@property (nonatomic, strong) NSString *name;

@end
