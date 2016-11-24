//
//  SpecialCell.m
//  SXK
//
//  Created by 杨伟康 on 2016/11/21.
//  Copyright © 2016年 ywk. All rights reserved.
//

#import "SpecialCell.h"

@implementation SpecialCell{
    
    UIImageView *_headImage;
    
    UIView * _view;
    
    UILabel * _title;
    
    UIView * _footView;
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
        _headImage = [[UIImageView alloc] initWithFrame:CommonVIEWFRAME(0, 0, 375, 209)];
        _headImage.image = [UIImage imageNamed:@"背景"];
        
        _view = [[UIView alloc] initWithFrame:CommonVIEWFRAME(77.5, 172, 220, 37)];
        _view.backgroundColor = [UIColor whiteColor];
        _view.alpha = 0.8;
        
        _title = [UILabel createLabelWithFrame:CommonVIEWFRAME(77.5, 172, 220, 37)
                                          andText:@"经典LV包 让你秋冬造型更时髦"
                                     andTextColor:[UIColor blackColor]
                                       andBgColor:[UIColor clearColor]
                                          andFont:SYSTEMFONT(12)
                                 andTextAlignment:NSTextAlignmentCenter];
        
        _footView = [[UIView alloc] initWithFrame:CommonVIEWFRAME(0, 209, 375, 15)];
        _footView.backgroundColor = [UIColor colorWithHexColorString:@"f7f7f7"];
        
        
        [self addSubview:_headImage];
        [self addSubview:_view];
        [self addSubview:_title];
        [self addSubview:_footView];
    }
    return  self;
}


@end
