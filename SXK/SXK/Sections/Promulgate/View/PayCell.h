//
//  PayCell.h
//  SXK
//
//  Created by 杨伟康 on 2016/11/29.
//  Copyright © 2016年 ywk. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SelectPayCellDelegate <NSObject>
// 代理传值方法
- (void)sendValue:(id) cell;

@end

@interface PayCell : UITableViewCell

@property (weak, nonatomic) id<SelectPayCellDelegate> delegate;

-(void)fillWithTitle:(NSString *)title;
-(void)isSelect;
@end
