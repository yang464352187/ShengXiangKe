//
//  LeftCell.m
//  SXK
//
//  Created by 杨伟康 on 2016/11/25.
//  Copyright © 2016年 ywk. All rights reserved.
//

#import "LeftCell.h"
#import "CategoryListModel.h"

@implementation LeftCell{
    UILabel *_title;
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
        _title = [UILabel createLabelWithFrame:CommonVIEWFRAME(0, 0, 100, 30)
                                       andText:@"品牌"
                                  andTextColor:[UIColor blackColor]
                                    andBgColor:[UIColor clearColor]
                                       andFont:SYSTEMFONT(13)
                              andTextAlignment:NSTextAlignmentCenter];
        
        [self addSubview:_title];
        
        [_title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).offset(0);
            make.left.equalTo(self.mas_left).offset(0);
            make.right.equalTo(self.mas_right).offset(0);
            make.bottom.equalTo(self.mas_bottom).offset(0);
        }];
    }
    return  self;
}

-(void)setModel:(id)model
{
    CategoryListModel *_model = model;
    _title.text = _model.name;
}

-(void)fillTitle
{
    _title.text = @"品牌";
}

@end
