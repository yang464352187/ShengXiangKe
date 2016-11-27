//
//  DFLineCellAdapterManager.h
//  DFTimelineView
//
//  Created by Allen Zhong on 15/9/27.
//  Copyright (c) 2015年 Datafans, Inc. All rights reserved.
//

#import "DFBaseLineItem.h"
#import "CommunityCell.h"

#import "DFTextImageLineItem.h"

#import "DFTextImageLineCell.h"

@interface DFLineCellManager : NSObject


+(instancetype) sharedInstance;

-(void) registerCell:(Class) itemClass cellClass:(Class ) cellClass;

-(CommunityCell *) getCell:(Class) itemClass;


@end
