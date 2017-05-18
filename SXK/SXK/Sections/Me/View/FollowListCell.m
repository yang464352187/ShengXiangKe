//
//  FollowListCell.m
//  SXK
//
//  Created by 杨伟康 on 2017/1/20.
//  Copyright © 2017年 ywk. All rights reserved.
//

#import "FollowListCell.h"
#import "FollowListModel.h"

@implementation FollowListCell{
    UILabel *_title;
    UILabel *_time;
    UIImageView *_headImage;
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
        _time = [UILabel createLabelWithFrame:VIEWFRAME((SCREEN_WIDTH -  CommonWidth(148)*2)/3, 0, 150, 53)                                                 andText:@"专业腕表养护"
                                  andTextColor:APP_COLOR_GRAY_Font
                                    andBgColor:[UIColor clearColor]
                                       andFont:SYSTEMFONT(14)
                              andTextAlignment:NSTextAlignmentRight];

        _headImage = [[UIImageView alloc] initWithFrame:CGRectZero];
        ViewRadius(_headImage, 32/2);
        
        [self addSubview:_title];
        [self addSubview:_headImage];
        [self addSubview:_time];
        
        [_headImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.equalTo(self.mas_left).offset(15);
            make.size.mas_offset(CGSizeMake(32, 32));
        }];
        
        [_title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.equalTo(_headImage.mas_right).offset(5);
            make.size.mas_offset(CGSizeMake(120, 32));
        }];
        
        [_time mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.right.equalTo(self.mas_right).offset(-15);
            make.size.mas_offset(CGSizeMake(220, 32));
        }];
        
        UIView *deleteBgView = [UIView new];
        deleteBgView.backgroundColor = APP_COLOR_GREEN;
        [self addSubview:deleteBgView];
        
        UIButton *deleteBtn = [UIButton new];
        [deleteBtn setTitle:@"取消关注" forState:UIControlStateNormal];
        deleteBtn.titleLabel.font = SYSTEMFONT(14);
        [deleteBgView addSubview:deleteBtn];
        
        [deleteBgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset([UIScreen mainScreen].bounds.size.width);
            make.top.equalTo(self.contentView);
            make.bottom.equalTo(self.contentView).offset(1);
            make.width.mas_equalTo(180);
        }];
        
        [deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.offset(80);
            make.top.equalTo(deleteBgView);
            make.bottom.equalTo(deleteBgView);
            make.left.equalTo(deleteBgView);
        }];

        
        
    }
    return  self;
}

-(void)setModel:(id)model
{
    FollowListModel *_model = model;
    [_headImage sd_setImageWithURL:[NSURL URLWithString:_model.headimgurl] placeholderImage:[UIImage imageNamed:@"占位-0"]];
    _title.text = _model.nickname;
    
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

    _time.text = [NSString stringWithFormat:@"%@  %@",nowtimeStr,nowtimeStr1];
}



@end
