//
//  FollowListModel.h
//  SXK
//
//  Created by 杨伟康 on 2017/1/20.
//  Copyright © 2017年 ywk. All rights reserved.
//

#import "BaseModel.h"

@interface FollowListModel : BaseModel

@property (nonatomic, strong) NSString *nickname, *headimgurl;

@property (nonatomic, strong) NSNumber *createtime, *userid;


@end
