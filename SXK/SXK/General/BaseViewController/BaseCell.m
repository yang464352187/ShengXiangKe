//
//  BaseCell.m
//  YunTShop
//
//  Created by sfgod on 16/4/13.
//  Copyright © 2016年 sufan. All rights reserved.
//

#import "BaseCell.h"

@implementation BaseCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


+ (id)cellForTableView:(UITableView *)tableView {
    id cell = [tableView  dequeueReusableCellWithIdentifier:NSStringFromClass(self.class)];
    if (!cell) {
        cell = [[self.class alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass(self.class)];
    }
    return cell;

}

- (void)setModel:(id)model{}

@end
