//
//  MyPromulgateModel.h
//  SXK
//
//  Created by 杨伟康 on 2016/12/27.
//  Copyright © 2016年 ywk. All rights reserved.
//

#import "BaseModel.h"

@interface MyPromulgateModel : BaseModel

@property (nonatomic, strong)NSString *keyword, *name, *oddNumber;

@property (nonatomic, strong)NSNumber *marketPrice, *rentPrice, *rentid;

@property (nonatomic, strong)NSArray *imgList;


@end
