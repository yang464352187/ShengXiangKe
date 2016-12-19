//
//  TypeCell.h
//  SXK
//
//  Created by 杨伟康 on 2016/11/22.
//  Copyright © 2016年 ywk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TypeCell : UITableViewCell


-(void)fillWithTitle:(NSString *)title andType:(NSInteger) type;

-(void)fillWithTitle1:(NSString *)title Content:(NSString *)content;

-(void)changeTitle:(NSString *)title;
@end
