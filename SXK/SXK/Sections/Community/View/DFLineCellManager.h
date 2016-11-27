//
//  DFLineCellAdapterManager.h
//  DFTimelineView
//
//  Created by Allen Zhong on 15/9/27.
//  Copyright (c) 2015年 Datafans, Inc. All rights reserved.
//

#import "DFBaseLineItem.h"
#import "DFBaseLineCell.h"

#import "DFTextImageLineItem.h"

#import "DFTextImageLineCell.h"

@interface DFLineCellManager : NSObject


+(instancetype) sharedInstance;

-(void) registerCell:(Class) itemClass cellClass:(Class ) cellClass;

-(DFBaseLineCell *) getCell:(Class) itemClass;


@end
