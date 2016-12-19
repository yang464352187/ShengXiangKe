//
//  PromulgateTopicCell.h
//  SXK
//
//  Created by 杨伟康 on 2016/12/14.
//  Copyright © 2016年 ywk. All rights reserved.
//

#import "BaseCell.h"


@protocol PromulgateTopicDelegate <NSObject>

-(void)sendModuleID:(NSInteger)module;

@end

@interface PromulgateTopicCell : BaseCell


@property (nonatomic, weak)id<PromulgateTopicDelegate>delegate;

-(void)fillWithArray:(NSArray *)array;

@end
