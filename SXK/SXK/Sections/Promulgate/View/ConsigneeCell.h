//
//  ConsigneeCell.h
//  SXK
//
//  Created by 杨伟康 on 2016/11/29.
//  Copyright © 2016年 ywk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddressModel.h"


@interface ConsigneeCell : UITableViewCell


-(void)fillWithModel:(AddressModel *)model str:(NSString *)str;
-(void)fillWithTitle:(NSString *)str;
@end
