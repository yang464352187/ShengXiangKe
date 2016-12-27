//
//  BrandDetailCell2.m
//  SXK
//
//  Created by 杨伟康 on 2016/12/27.
//  Copyright © 2016年 ywk. All rights reserved.
//

#import "BrandDetailCell2.h"

@implementation BrandDetailCell2{
    UILabel *_label;
    UIImageView *_image;
    UIButton *_talkBtn;
    UIButton *_likeBtn;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _image = [[UIImageView alloc] init];
        _image.image = [UIImage imageNamed:@"矢量智能对象111"];
        
        _label = [UILabel createLabelWithFrame:VIEWFRAME(15, 0, 150, 53)                                                 andText:@"啵住:好肥一只鱼"
                                          andTextColor:[UIColor blackColor]
                                            andBgColor:[UIColor clearColor]
                                               andFont:SYSTEMFONT(13)
                                      andTextAlignment:NSTextAlignmentLeft];
        
        
        UIImage *talkImage = [UIImage imageNamed:@"对话"];
        _talkBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_talkBtn setTitle:@"聊呗" forState:UIControlStateNormal];
        [_talkBtn setImage:[talkImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        _talkBtn.frame = VIEWFRAME(SCREEN_WIDTH - 130, 11, 60, 15);
        _talkBtn.titleLabel.font = SYSTEMFONT(12);
        _talkBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 8, 0, 0);
        //    [talkBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_talkBtn setTintColor:[UIColor blackColor]];
        
        UIImage *likeImage = [UIImage imageNamed:@"关注-(1)"];
        _likeBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_likeBtn setTitle:@"啵一个" forState:UIControlStateNormal];
        [_likeBtn setImage:[likeImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        _likeBtn.frame = VIEWFRAME(SCREEN_WIDTH - 130, 11, 50, 15);
        _likeBtn.titleLabel.font = SYSTEMFONT(12);
        _likeBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 8, 0, 0);
        //    [talkBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_likeBtn setTintColor:[UIColor blackColor]];
        
        [self addSubview:_image];
        [self addSubview:_label];
        [self addSubview:_talkBtn];
        [self addSubview:_likeBtn];
        
        [_image mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.equalTo(self.mas_left).offset(20);
            make.size.mas_equalTo(CGSizeMake(37, 37));
        }];
        
        [_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.equalTo(_image.mas_right).offset(10);
            make.size.mas_equalTo(CGSizeMake(100, 66));
        }];
        
        [_talkBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.right.equalTo(self.mas_right).offset(-15);
            make.size.mas_equalTo(CGSizeMake(60, 25));
        }];
        
        [_likeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.right.equalTo(_talkBtn.mas_left).offset(0);
            make.size.mas_equalTo(CGSizeMake(70, 25));
        }];
    
    }
    return  self;
}

@end
