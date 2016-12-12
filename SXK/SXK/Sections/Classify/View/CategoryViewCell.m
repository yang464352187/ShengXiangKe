//
//  CategoryViewCell.m
//  SXK
//
//  Created by 杨伟康 on 2016/12/12.
//  Copyright © 2016年 ywk. All rights reserved.
//

#import "CategoryViewCell.h"

@implementation CategoryViewCell{
    UIImageView *_headImage;
    UILabel *_title;
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
    
    _title = [[UILabel alloc] init];
    
    _title = [UILabel createLabelWithFrame:VIEWFRAME(16, 0, SCREEN_WIDTH- CommonWidth(72)-5, CommonHight(51.5))                                                 andText:@"单肩包"
                              andTextColor:[UIColor blackColor]
                                andBgColor:[UIColor clearColor]
                                   andFont:SYSTEMFONT(12)
                          andTextAlignment:NSTextAlignmentCenter];

    
    [self addSubview:_headImage];
    [self addSubview:_title];
    
    [_headImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(0);
        make.left.equalTo(self.mas_left).offset(0);
        make.right.equalTo(self.mas_right).offset(0);
        make.height.mas_equalTo(self.frame.size.width);
    }];
    
    [_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_headImage.mas_bottom).offset(5);
        make.left.equalTo(self.mas_left).offset(0);
        make.right.equalTo(self.mas_right).offset(0);
        make.bottom.equalTo(self.mas_bottom).offset(0);
    }];

}

-(void)fillWithImage:(NSString *)image andTitle:(NSString *)title
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://ohqqvdngk.bkt.clouddn.com/%@",image]];
    [_headImage sd_setImageWithURL:url];
    _title.text = title;
}

@end
