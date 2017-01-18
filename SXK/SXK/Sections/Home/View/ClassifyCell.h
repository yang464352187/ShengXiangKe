//
//  ClassifyCell.h
//  SXK
//
//  Created by 杨伟康 on 2016/11/21.
//  Copyright © 2016年 ywk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeVC.h"

@interface ClassifyCell : UITableViewCell
@property (nonatomic, strong) HomeVC *vc;
@property (nonatomic, strong)NSNumber *classid;

-(void)fillWithDic:(NSDictionary *)dic;

@end
