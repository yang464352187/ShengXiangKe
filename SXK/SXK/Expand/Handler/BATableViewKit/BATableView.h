//
//  ABELTableView.h
//  SXK
//
//  Created by 杨伟康 on 2016/11/23.
//  Copyright © 2016年 ywk. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "BATableViewIndex.h"

@protocol BATableViewDelegate;
@interface BATableView : UIView
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) BATableViewIndex * tableViewIndex;

@property (nonatomic, strong) id<BATableViewDelegate> delegate;
- (void)reloadData;
@end

@protocol BATableViewDelegate <UITableViewDataSource,UITableViewDelegate>

- (NSArray *)sectionIndexTitlesForABELTableView:(BATableView *)tableView;


@end

