//
//  ActivityListModel.h
//  SXK
//
//  Created by 杨伟康 on 2016/12/9.
//  Copyright © 2016年 ywk. All rights reserved.
//

#import "BaseModel.h"

@interface ActivityListModel : BaseModel
@property (nonatomic, strong)NSString *img,*content,*place,*name;
@property (nonatomic, strong)NSNumber *time,*activityid;

@end
