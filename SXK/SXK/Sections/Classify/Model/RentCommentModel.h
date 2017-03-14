//
//  RentCommentModel.h
//  SXK
//
//  Created by 杨伟康 on 2017/3/2.
//  Copyright © 2017年 ywk. All rights reserved.
//

#import "BaseModel.h"

@interface RentCommentModel : BaseModel

@property (nonatomic, strong) NSString *content, *nickname, *headimgurl;
@property (nonatomic, strong) NSArray *imgList;
@property (nonatomic, strong) NSNumber *createtime, *userid, *commentid;
@end
