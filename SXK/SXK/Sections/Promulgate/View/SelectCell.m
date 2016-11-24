//
//  SelectCell.m
//  SXK
//
//  Created by 杨伟康 on 2016/11/23.
//  Copyright © 2016年 ywk. All rights reserved.
//

#import "SelectCell.h"

@implementation SelectCell{
    UILabel *_title;
    UIView *_line;
    UIImageView *_head;
    UIButton *_select;
    NSInteger _isSelect;
    
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _title = [UILabel createLabelWithFrame:VIEWFRAME(23, 5.5, 100, 41)                                                 andText:@"腕表"
                                  andTextColor:[UIColor blackColor]
                                    andBgColor:[UIColor clearColor]
                                       andFont:SYSTEMFONT(14)
                              andTextAlignment:NSTextAlignmentLeft];
        
        
        _line = [[UIView alloc] initWithFrame:VIEWFRAME(15, 51.5, SCREEN_WIDTH-15, 0.5)];
        _line.backgroundColor = [UIColor colorWithHexColorString:@"dcdcdc"];
        
        _select = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *image = [UIImage imageNamed:@"椭圆-1-拷贝"];
        UIImage *image1 = [UIImage imageNamed:@"打钩-1"];
        [_select addTarget:self  action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [_select setImage:[image imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)]   forState:UIControlStateNormal];
        [_select setImage:[image1 imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)]   forState:UIControlStateSelected];
//        _select.backgroundColor = [UIColor redColor];
        [self addSubview:_line];
        [self addSubview:_title];
        [self addSubview:_select];
        [_select mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).offset(0);
            //            make.bottom.equalTo(self.mas_bottom).offset(-18);
            make.right.equalTo(self.mas_right).offset(0);
            make.width.equalTo(@52);
            make.height.equalTo(@52);
        }];
        
    }
    return  self;
}

-(void)btnAction:(UIButton *)sender
{
    if ([_delegate respondsToSelector:@selector(sendValue:)]) { // 如果协议响应了sendValue:方法
        [_delegate sendValue:self]; // 通知执行协议方法
    }
}

-(void)isSelect
{
    if (!_isSelect) {
        [_select setSelected:YES];
        _isSelect = 1;
    }else{
        [_select setSelected:NO];
        _isSelect = 0;
    }
    self.name = _title.text;
}

-(void)fillTitle:(NSString *)title
{
    _title.text = title;
    

}


@end
