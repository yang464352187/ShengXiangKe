//
//  QuestionListModel.h
//  SXK
//
//  Created by 杨伟康 on 2017/1/20.
//  Copyright © 2017年 ywk. All rights reserved.
//

#import "BaseModel.h"

@interface QuestionListModel : BaseModel

@property (nonatomic, strong)NSString *content, *name;

@property (nonatomic, strong)NSNumber *questionid;

@end
