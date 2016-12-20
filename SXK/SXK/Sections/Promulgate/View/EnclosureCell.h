//
//  EnclosureCell.h
//  SXK
//
//  Created by 杨伟康 on 2016/12/20.
//  Copyright © 2016年 ywk. All rights reserved.
//

#import "BaseCell.h"

@interface EnclosureCell : BaseCell

-(void)fillWithTitle:(NSString *)title;
-(void)changeTitle:(NSString *)title;
-(NSMutableDictionary *)getData;

@end
