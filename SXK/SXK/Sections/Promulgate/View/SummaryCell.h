//
//  SummaryCell.h
//  SXK
//
//  Created by 杨伟康 on 2016/11/22.
//  Copyright © 2016年 ywk. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SummaryCellDelegate <NSObject>

-(void)SendTextValue:(NSString *)content title:(NSString *)title;

@end


@interface SummaryCell : UITableViewCell


@property (nonatomic, weak)id <SummaryCellDelegate>delegate;

-(void)fillWithTitle:(NSString *)title;


@end
