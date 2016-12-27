//
//  BrandVC.h
//  SXK
//
//  Created by 杨伟康 on 2016/11/23.
//  Copyright © 2016年 ywk. All rights reserved.
//

#import "YTBaseTableVC.h"

@protocol BrandVCDelegate <NSObject>

-(void)returnBrand:(NSDictionary *)dic;

@end

@interface BrandVC : YTBaseTableVC

@property(nonatomic, weak)id<BrandVCDelegate>delegate;

@property(nonatomic, assign)NSInteger type;

@end
