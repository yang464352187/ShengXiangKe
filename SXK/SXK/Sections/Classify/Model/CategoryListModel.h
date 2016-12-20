//
//  CategoryListModel.h
//  SXK
//
//  Created by 杨伟康 on 2016/12/10.
//  Copyright © 2016年 ywk. All rights reserved.
//

#import "BaseModel.h"

@interface CategoryListModel : BaseModel

@property (nonatomic, strong)NSString *name, * img;

@property (nonatomic, strong)NSNumber *categoryid;

@property (nonatomic, strong)NSArray *attachList;

@end
