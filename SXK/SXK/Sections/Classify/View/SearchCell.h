//
//  SearchCell.h
//  SXK
//
//  Created by 杨伟康 on 2017/3/3.
//  Copyright © 2017年 ywk. All rights reserved.
//

#import "BaseCell.h"
#import "SearchVC.h"

@protocol SearchCellDelegate <NSObject>
@end

@interface SearchCell : BaseCell

-(void)fillWithArray:(NSArray *)array;

@property (nonatomic, strong)SearchVC *vc;


@end
