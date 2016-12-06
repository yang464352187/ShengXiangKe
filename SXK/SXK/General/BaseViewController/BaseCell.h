//
//  BaseCell.h
//  YunTShop
//
//  Created by sfgod on 16/4/13.
//  Copyright © 2016年 sufan. All rights reserved.
//

#import <UIKit/UIKit.h>




@interface BaseCell : UITableViewCell

+ (id)cellForTableView:(UITableView *)tableView;

- (void)setModel:(id)model;

@end
