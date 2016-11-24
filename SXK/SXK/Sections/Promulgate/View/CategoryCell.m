//
//  CategoryCell.m
//  SXK
//
//  Created by 杨伟康 on 2016/11/23.
//  Copyright © 2016年 ywk. All rights reserved.
//

#import "CategoryCell.h"

@implementation CategoryCell{
    UILabel *_title;
    UIView *_line;
    UIImageView *_head;
    UIImageView *_back;

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
        
        _back = [[UIImageView alloc] init];
        _back.image = [UIImage imageNamed:@"返回-"];
        
        [self addSubview:_line];
        [self addSubview:_title];
        [self addSubview:_back];
        [_back mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).offset(20);
            //            make.bottom.equalTo(self.mas_bottom).offset(-18);
            make.right.equalTo(self.mas_right).offset(-18);
            make.width.equalTo(@8);
            make.height.equalTo(@13);
        }];

    }
    return  self;
}

-(void)fillTitle:(NSString *)title
{
    _title.text = title;
}

@end
