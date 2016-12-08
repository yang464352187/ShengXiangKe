//
//  RightCell.m
//  SXK
//
//  Created by 杨伟康 on 2016/11/25.
//  Copyright © 2016年 ywk. All rights reserved.
//

#import "RightCell.h"
#import "BrandModel.h"

@implementation RightCell{
    UILabel *_title;
    UIView *_line;
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
  
        
        _title = [UILabel createLabelWithFrame:VIEWFRAME(16, 0, SCREEN_WIDTH- CommonWidth(72)-5, CommonHight(51.5))                                                 andText:@"暂未收录相关品牌"
                                  andTextColor:[UIColor blackColor]
                                    andBgColor:[UIColor clearColor]
                                       andFont:SYSTEMFONT(14)
                              andTextAlignment:NSTextAlignmentLeft];
        
        
        _line = [[UIView alloc] initWithFrame:VIEWFRAME(0, CommonHight(52)-0.5, SCREEN_WIDTH- CommonWidth(72)-5, 0.5)];
        _line.backgroundColor = [UIColor colorWithHexColorString:@"dcdcdc"];
        
        [self addSubview:_line];
        [self addSubview:_title];
    }
    return  self;
}

-(void)setModel:(id)model
{
    BrandModel *_model = model;
    _title.text = _model.name;
}

-(void)isNone
{
    _title.text = @"暂未收录相关品牌";
}

@end
