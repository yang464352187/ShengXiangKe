//
//  AppraiseClassVC.h
//  SXK
//
//  Created by 杨伟康 on 2016/12/24.
//  Copyright © 2016年 ywk. All rights reserved.
//

#import "YTBaseTableVC.h"

@protocol AppraiseClassVCDelegate <NSObject>

-(void)returndata:(NSDictionary *)dic;

@end

@interface AppraiseClassVC : YTBaseTableVC

@property (nonatomic, strong) NSArray *dataArr;
@property (nonatomic, weak)id <AppraiseClassVCDelegate>delegate;

@end
