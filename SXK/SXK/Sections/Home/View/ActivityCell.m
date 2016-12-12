//
//  ActivityCell.m
//  SXK
//
//  Created by 杨伟康 on 2016/12/8.
//  Copyright © 2016年 ywk. All rights reserved.
//

#import "ActivityCell.h"
#import "ActivityListModel.h"

@implementation ActivityCell{
    UIImageView *_headImage;
    UILabel *_titleLab;
    UILabel *_timeLab;
    UIImageView *_locationImage;
    UILabel *_addressLab;
    UIImageView *_back;

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
        [self loadSubViews];
    }
    return  self;
}

-(void)loadSubViews
{
    _headImage = [[UIImageView alloc] initWithFrame:VIEWFRAME(15, 15, 63, 63)];
    _headImage.image = [UIImage imageNamed:@"背景"];
    
     _titleLab = [UILabel createLabelWithFrame:VIEWFRAME(90,18, SCREEN_WIDTH - 120, 14)
                                           andText:@"这是标题标题标题标题标题标题标题"
                                      andTextColor:[UIColor blackColor]
                                        andBgColor:[UIColor clearColor]
                                           andFont:SYSTEMFONT(14)
                                  andTextAlignment:NSTextAlignmentLeft];
    
    _timeLab = [UILabel createLabelWithFrame:VIEWFRAME(90,40, SCREEN_WIDTH - 120, 12)
                                      andText:@"2016-06-18  18:00"
                                 andTextColor:[UIColor colorWithHexColorString:@"a1a1a1"]
                                   andBgColor:[UIColor clearColor]
                                      andFont:SYSTEMFONT(12)
                             andTextAlignment:NSTextAlignmentLeft];
    
    _locationImage = [[UIImageView alloc] initWithFrame:VIEWFRAME(90, 60, 15, 15)];
    _locationImage.image = [UIImage imageNamed:@"常用地址"];
    
    _addressLab = [UILabel createLabelWithFrame:VIEWFRAME(115,60, SCREEN_WIDTH - 145, 12)
                                     andText:@"厦门市软件园二期望海路十号之一521"
                                andTextColor:[UIColor colorWithHexColorString:@"a1a1a1"]
                                  andBgColor:[UIColor clearColor]
                                     andFont:SYSTEMFONT(12)
                            andTextAlignment:NSTextAlignmentLeft];

    _back = [[UIImageView alloc] init];
    _back.image = [UIImage imageNamed:@"返回-"];
    
    [self addSubview:_headImage];
    [self addSubview:_titleLab];
    [self addSubview:_timeLab];
    [self addSubview:_locationImage];
    [self addSubview:_addressLab];
    [self addSubview:_back];
    
    [_back mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.right.equalTo(self.mas_right).offset(-12);
        make.width.equalTo(@8);
        make.height.equalTo(@13);
    }];

}


-(void)setModel:(id)model
{
    ActivityListModel *_model = model;
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",APP_BASEIMG,_model.img]];
    [_headImage sd_setImageWithURL:url];
    
    _titleLab.text = _model.name;
    _addressLab.text = _model.place;
//    NSInteger num = [_model.time integerValue]/1000;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:@"yyyy年MM月dd日 HH:mm"];
    
    NSDate*confromTimesp = [NSDate dateWithTimeIntervalSince1970:[_model.time integerValue]];
    
    NSString*confromTimespStr = [formatter stringFromDate:confromTimesp];
    _timeLab.text = confromTimespStr;
}


@end
