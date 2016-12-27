//
//  MaintainCellModel.h
//  SXK
//
//  Created by 杨伟康 on 2016/12/22.
//  Copyright © 2016年 ywk. All rights reserved.
//

#import "BaseModel.h"

@interface MaintainCellModel : BaseModel


@property (nonatomic, strong)NSString *description1,  *name, *img ,*keyword;

@property (nonatomic, strong)NSNumber *classifyid,*maintainid, *price;

@end
