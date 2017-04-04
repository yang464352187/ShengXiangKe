//
//  BusinessCell.m
//  SXK
//
//  Created by 杨伟康 on 2017/3/15.
//  Copyright © 2017年 ywk. All rights reserved.
//

#import "BusinessCell.h"

@implementation BusinessCell{
    UIView *_view;
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
        _view = [[UIView alloc] init];
        _view.backgroundColor = APP_COLOR_GREEN;
        
        UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"矩形-3-拷贝1"]];
        
        UILabel *label = [UILabel createLabelWithFrame:VIEWFRAME(15, 0, 150, 53)                                                 andText:@"添加商品"
                                    andTextColor:[UIColor whiteColor]
                                      andBgColor:[UIColor clearColor]
                                         andFont:SYSTEMFONT(14)
                                andTextAlignment:NSTextAlignmentCenter];

        
        [self addSubview:_view];
        [_view addSubview:image];
        [_view addSubview:label];
        
        [_view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(15);
            make.right.equalTo(self.mas_right).offset(-15);
            make.top.equalTo(self.mas_top).offset(0);
            make.bottom.equalTo(self.mas_bottom).offset(-10);
        }];
        
        [image mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_view);
            make.centerY.equalTo(_view).offset(-10);
            make.size.mas_equalTo(CGSizeMake(25, 25));
        }];
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_view);
            make.centerY.equalTo(_view).offset(15);
            make.size.mas_equalTo(CGSizeMake(60, 20));
        }];
        
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [_view addGestureRecognizer:tap];
        
    }
    return  self;
}

-(void)tapAction:(UITapGestureRecognizer *)tap
{
    DEFAULTS_SET_OBJ(@"3", @"promulgateType");
    [[PushManager sharedManager] pushToVCWithClassName:@"PromulgateVC1" info:nil];
}


@end
