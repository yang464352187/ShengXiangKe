//
//  AddressModel.h
//  SXK
//
//  Created by 杨伟康 on 2016/12/6.
//  Copyright © 2016年 ywk. All rights reserved.
//

#import "BaseModel.h"

@interface AddressModel : BaseModel

@property (nonatomic, strong)NSString *address,*city,*district,*name,*state,*mobile;
@property (nonatomic, assign)NSNumber *receiverid,*userid;

@end
