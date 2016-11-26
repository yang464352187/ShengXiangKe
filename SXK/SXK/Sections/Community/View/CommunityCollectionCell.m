//
//  CommunityCollectionCell.m
//  SXK
//
//  Created by 杨伟康 on 2016/11/26.
//  Copyright © 2016年 ywk. All rights reserved.
//

#import "CommunityCollectionCell.h"

@implementation CommunityCollectionCell

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        UIImageView *headImage =[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CommonWidth(105),CommonHight(100.5))];
        headImage.image =[UIImage imageNamed:@"背景"];
        [self addSubview:headImage];
        
        [headImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).offset(0);
            make.left.equalTo(self.mas_left).offset(0);
            make.right.equalTo(self.mas_right).offset(0);
            make.bottom.equalTo(self.mas_bottom).offset(0);
        }];
    }
    return self;
}

@end
