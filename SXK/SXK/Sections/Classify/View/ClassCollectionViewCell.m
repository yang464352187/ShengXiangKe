//
//  ClassCollectionViewCell.m
//  SXK
//
//  Created by 杨伟康 on 2016/12/8.
//  Copyright © 2016年 ywk. All rights reserved.
//

#import "ClassCollectionViewCell.h"

@implementation ClassCollectionViewCell{
    UIImageView *_headImage;
}


-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self loadSubViews];
    }
    return self;
}

-(void)loadSubViews
{
    _headImage = [[UIImageView alloc] init];
    _headImage.image = [UIImage imageNamed:@"背景"];
    
    [self addSubview:_headImage];
    
    [_headImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(0);
        make.bottom.equalTo(self.mas_bottom).offset(0);
        make.left.equalTo(self.mas_left).offset(0);
        make.right.equalTo(self.mas_right).offset(0);
    }];
}


-(void)fillWithImage:(NSString *)image
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",APP_BASEIMG,image]];
    [_headImage sd_setImageWithURL:url];
}

@end
