//
//  qualityVC.h
//  SXK
//
//  Created by 杨伟康 on 2016/11/23.
//  Copyright © 2016年 ywk. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol qualityCellDelegate <NSObject>

// 代理传值方法
- (void)sendValue:(id) cell;

@end


@interface qualityVC : UITableViewCell

@property (weak, nonatomic) id<qualityCellDelegate> delegate;
@property (nonatomic, strong)NSString *name;

-(void)fillTitle:(NSString *)title andContent:(NSString *)content;
-(void)isSelect;


@end
