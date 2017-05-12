//
//  ServeveCenterCell.m
//  SXK
//
//  Created by 杨伟康 on 2017/1/20.
//  Copyright © 2017年 ywk. All rights reserved.
//

#import "ServeveCenterCell.h"
#import "QuestionListModel.h"

@implementation ServeveCenterCell{
    UILabel *_title;
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
        _title = [UILabel createLabelWithFrame:VIEWFRAME((SCREEN_WIDTH -  CommonWidth(148)*2)/3, 0, 150, 53)                                                 andText:@"专业腕表养护"
                                  andTextColor:[UIColor blackColor]
                                    andBgColor:[UIColor clearColor]
                                       andFont:SYSTEMFONT(14)
                              andTextAlignment:NSTextAlignmentLeft];
        
        [self addSubview:_title];
        
    }
    return  self;
}

-(void)setModel:(id)model
{
    QuestionListModel *_model = model;
    _title.text = _model.name;
}

@end
