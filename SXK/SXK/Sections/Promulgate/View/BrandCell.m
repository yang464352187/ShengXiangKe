//
//  BrandCell.m
//  SXK
//
//  Created by 杨伟康 on 2016/11/23.
//  Copyright © 2016年 ywk. All rights reserved.
//

#import "BrandCell.h"
#import "BrandModel.h"

@implementation BrandCell{
    UILabel *_title;
    UIView *_line;
    UIImageView *_head;
    
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
        _head =[[UIImageView alloc] initWithFrame:VIEWFRAME(23, 5.5, 85, 41)];
        _head.image =[UIImage imageNamed:@"背景"];
        ViewBorderRadius(_head, 0, 0.5, [UIColor blackColor]);
        
        _title = [UILabel createLabelWithFrame:VIEWFRAME(113, 5.5, 150, 41)                                                 andText:@"A.Lange&Shone/朗格"
                                  andTextColor:[UIColor blackColor]
                                    andBgColor:[UIColor clearColor]
                                       andFont:SYSTEMFONT(14)
                              andTextAlignment:NSTextAlignmentLeft];

        
        _line = [[UIView alloc] initWithFrame:VIEWFRAME(15, 51.5, SCREEN_WIDTH-15, 0.5)];
        _line.backgroundColor = [UIColor colorWithHexColorString:@"dcdcdc"];
        
        [self addSubview:_head];
        [self addSubview:_line];
        [self addSubview:_title];
    }
    return  self;
}

-(void)fillWithTitle:(NSString *)title
{
    _title.text = title;
}

-(void)setModel:(id)model
{
    BrandModel *_model = model;
    _title.text = _model.name;
    [_head sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",APP_BASEIMG,_model.img]]];
}

-(void)isNone
{
    _title.text = @"暂未收录相关品牌";
    _head.image =[UIImage imageNamed:@"背景"];
}


@end
