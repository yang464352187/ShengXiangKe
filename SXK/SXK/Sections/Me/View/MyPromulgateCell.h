//
//  MyPromulgateCell.h
//  SXK
//
//  Created by 杨伟康 on 2016/12/26.
//  Copyright © 2016年 ywk. All rights reserved.
//

#import "BaseCell.h"

@protocol MyPromulgateCellDelegate <NSObject>

-(void)returnIndex:(NSInteger)index;

@end

@interface MyPromulgateCell : BaseCell

@property (nonatomic, weak)id<MyPromulgateCellDelegate>delegate;
@property (nonatomic, assign)NSInteger index;

-(void)reName:(NSString *)title;

@end
