//
//  NoDataView.m
//  SXK
//
//  Created by 杨伟康 on 2016/11/24.
//  Copyright © 2016年 ywk. All rights reserved.
//

#import "NoDataView.h"

@implementation NoDataView{
    UILabel *_titleLabel;
    UIImageView *_logo;
    UIButton *_addBtn;
}

- (instancetype)initWithTitle:(NSString *)title{
    if (self = [super initWithFrame:APP_BOUNDS]) {
        
        self.backgroundColor = APP_COLOR_BASE_BACKGROUND;
        
        _logo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"BaseLogo"]];
        
        _titleLabel = [UILabel createLabelWithFrame:VIEWFRAME(0, 25, SCREEN_WIDTH, 25)
                                            andText:title
                                       andTextColor:APP_COLOR_GRAY_666666
                                         andBgColor:[UIColor clearColor]
                                            andFont:SYSTEMFONT(14)
                                   andTextAlignment:NSTextAlignmentCenter];
        
        _addBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_addBtn setTitle:@"增加收货地址" forState:UIControlStateNormal];
        _addBtn.backgroundColor = APP_COLOR_GREEN;
        [_addBtn addTarget:self action:@selector(addBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [_addBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _addBtn.tag = 1001;
        _addBtn.titleLabel.font = SYSTEMFONT(14);
        _addBtn.frame = VIEWFRAME(15, 20, SCREEN_WIDTH - 30, 40);
        ViewRadius(_addBtn, _addBtn.frame.size.height/2);
        
        [self addSubview:_addBtn];
        [self addSubview:_logo];
        [self addSubview:_titleLabel];
        
        [_logo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(55, 65));
            make.centerX.equalTo(self.mas_centerX);
            make.centerY.equalTo(self.mas_centerY).offset(-145);
        }];
        
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_offset(20);
            make.top.equalTo(_logo.mas_bottom).offset(20);
            make.centerX.equalTo(_logo.mas_centerX);
        }];
        
        [_addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_offset(40);
            make.top.equalTo(_titleLabel.mas_bottom).offset(100);
            make.left.equalTo(self.mas_left).offset(15);
            make.width.mas_offset(SCREEN_WIDTH - 30);
        }];
    }
    return self;
}

- (instancetype)init{
    return [self initWithTitle:@""];
}


- (void)setTitle:(NSString *)title{
    if (![title isEqualToString:@"您还没有添加收货地址哦～"]) {
        [_addBtn removeFromSuperview];
    }
    _titleLabel.text = title;
}

-(void)addBtnAction:(UIButton *)sender
{
    NSDictionary *dic = @{@"title":@"添加地址"};
    [[PushManager sharedManager] pushToVCWithClassName:@"AddAddress" info:dic];
}
@end
