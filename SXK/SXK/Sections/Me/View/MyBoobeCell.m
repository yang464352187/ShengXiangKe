//
//  MyBoobeCell.m
//  SXK
//
//  Created by 杨伟康 on 2017/2/22.
//  Copyright © 2017年 ywk. All rights reserved.
//

#import "MyBoobeCell.h"
#import "RcordModel.h"

@implementation MyBoobeCell
{
    UILabel *_title;
    UILabel *_addLabel;
    UILabel *_title1;
    UILabel *_moneyLab;
    UILabel *_timeLab;
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
        
        _title = [UILabel createLabelWithFrame:VIEWFRAME(15, 0, 150, 53)                                                 andText:@"租赁成功:"
                                  andTextColor:[UIColor blackColor]
                                    andBgColor:[UIColor clearColor]
                                       andFont:SYSTEMFONT(13)
                              andTextAlignment:NSTextAlignmentLeft];
        
        _addLabel = [UILabel createLabelWithFrame:VIEWFRAME(15, 0, 150, 53)                                                 andText:@"+10"
                                     andTextColor:APP_COLOR_GREEN
                                       andBgColor:[UIColor clearColor]
                                          andFont:SYSTEMFONT(13)
                                 andTextAlignment:NSTextAlignmentRight];
        
        
        _title1 = [UILabel createLabelWithFrame:VIEWFRAME(15, 0, 150, 53)                                                 andText:@"余额:"
                                   andTextColor:[UIColor blackColor]
                                     andBgColor:[UIColor clearColor]
                                        andFont:SYSTEMFONT(13)
                               andTextAlignment:NSTextAlignmentLeft];
        
        
        _moneyLab = [UILabel createLabelWithFrame:VIEWFRAME(15, 0, 150, 53)                                                 andText:@"989.00"
                                     andTextColor:APP_COLOR_GREEN
                                       andBgColor:[UIColor clearColor]
                                          andFont:SYSTEMFONT(13)
                                 andTextAlignment:NSTextAlignmentLeft];
        
        
        _timeLab = [UILabel createLabelWithFrame:VIEWFRAME(15, 0, 150, 53)                                                 andText:@"2017-2-20   10:23"
                                    andTextColor:[UIColor blackColor]
                                      andBgColor:[UIColor clearColor]
                                         andFont:SYSTEMFONT(13)
                                andTextAlignment:NSTextAlignmentLeft];
        
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = APP_COLOR_GRAY_Line;
        
        [self addSubview:_title];
//        [self addSubview:_title1];
        [self addSubview:_addLabel];
        [self addSubview:_moneyLab];
        [self addSubview:_timeLab];
        [self addSubview:line];
        
        [_title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(15);
            make.top.equalTo(self.mas_top).offset(23);
            make.size.mas_equalTo(CGSizeMake(60, 15));
        }];
        
//        [_title1 mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(self.mas_left).offset(15);
//            make.top.equalTo(_title.mas_bottom).offset(13);
//            make.size.mas_equalTo(CGSizeMake(32, 15));
//        }];
        
        [_addLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).offset(-15);
            make.centerY.equalTo(_title);
            make.size.mas_equalTo(CGSizeMake(100, 15));
        }];
        
        [_moneyLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_title.mas_right).offset(0);
            make.centerY.equalTo(_title);
            make.size.mas_equalTo(CGSizeMake(100, 15));
        }];
        
        [_timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(15);
            make.top.equalTo(_title.mas_bottom).offset(13);
            make.size.mas_equalTo(CGSizeMake(200, 15));
        }];
        
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.mas_bottom).offset(0);
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 0.5));
        }];
        
    }
    return  self;
}

-(void)setModel:(id)model
{
    RcordModel *_model = model;
    _addLabel.text = [NSString stringWithFormat:@"+%@",_model.point];
    _moneyLab.text = [NSString stringWithFormat:@"%.2f",[_model.amount floatValue] / 100];
    
    
    
    long time = [_model.createtime integerValue];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
    NSString *nowtimeStr = [formatter stringFromDate:date];
    
    [formatter setDateFormat:@"HH:mm"];
    NSDate *date1 = [NSDate dateWithTimeIntervalSince1970:time];
    NSString *nowtimeStr1 = [formatter stringFromDate:date1];
    
    _timeLab.text = [NSString stringWithFormat:@"%@  %@",nowtimeStr,nowtimeStr1];

    
}


@end
