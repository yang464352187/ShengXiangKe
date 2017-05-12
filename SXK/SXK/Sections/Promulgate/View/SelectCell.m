//
//  SelectCell.m
//  SXK
//
//  Created by 杨伟康 on 2016/11/23.
//  Copyright © 2016年 ywk. All rights reserved.
//

#import "SelectCell.h"
#import "CategoryListModel.h"


@implementation SelectCell{
    UILabel *_title;
    UIView *_line;
    UIImageView *_head;
    UIButton *_select;
    NSInteger _isSelect;
    NSNumber *_categoryid;
    
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
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [self addGestureRecognizer:tap];

        
    }
    return  self;
}

-(void)tap:(UITapGestureRecognizer *)tap
{
    if ([_delegate respondsToSelector:@selector(sendValue:)]) { // 如果协议响应了sendValue:方法
        [_delegate sendValue:self]; // 通知执行协议方法
    }

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
//    self.categryid = _categryid;
    
}


-(void)fillTitle:(NSString *)title
{
    _title.text = title;
}
-(void)setModel:(id)model
{
    CategoryListModel *_model = model;
    _title.text = _model.name;
    _categoryid =_model.categoryid;
    self.categryid = _model.categoryid;
    
}
-(void)setAppraiseModel:(id)model
{
    AppraiseClassModel *_model = model;
    _title.text = _model.name;
    self.ACmodel = model;
}



@end
