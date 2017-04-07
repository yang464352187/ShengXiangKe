//
//  WalletModel.h
//  SXK
//
//  Created by 杨伟康 on 2017/3/6.
//  Copyright © 2017年 ywk. All rights reserved.
//

#import "BaseModel.h"

@interface WalletModel : BaseModel

@property (nonatomic, strong) NSNumber *amount, *createtime, *balance, *type;

@end
