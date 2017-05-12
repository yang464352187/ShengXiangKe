//
//  SelectCell.h
//  SXK
//
//  Created by 杨伟康 on 2016/11/23.
//  Copyright © 2016年 ywk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppraiseClassModel.h"
@protocol SelectCellDelegate <NSObject>
// 代理传值方法
- (void)sendValue:(id) cell;

@end


@interface SelectCell : BaseCell

@property (nonatomic, strong)NSString *name;
@property (nonatomic, strong)NSNumber *categryid;
@property (nonatomic, strong)AppraiseClassModel *ACmodel;
@property (weak, nonatomic) id<SelectCellDelegate> delegate;


-(void)fillTitle:(NSString *)title;
-(void)isSelect;
-(void)setAppraiseModel:(id)model;



@end
