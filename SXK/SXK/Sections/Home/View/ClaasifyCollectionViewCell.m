//
//  ClaasifyCollectionViewCell.m
//  SXK
//
//  Created by 杨伟康 on 2016/11/21.
//  Copyright © 2016年 ywk. All rights reserved.
//

#import "ClaasifyCollectionViewCell.h"

@implementation ClaasifyCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    UIImageView *headImage =[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CommonWidth(105),CommonHight(100.5))];
    headImage.image =[UIImage imageNamed:@"背景"];
    
    UILabel *title = [UILabel createLabelWithFrame:CommonVIEWFRAME(0,115.5 , 105, 12)
                                           andText:@"GUCCI"
                                      andTextColor:[UIColor colorWithHexColorString:@"2c2c2c"]
                                        andBgColor:[UIColor clearColor]
                                           andFont:SYSTEMFONT(12)
                                  andTextAlignment:NSTextAlignmentCenter];
    
    UILabel *title2 = [UILabel createLabelWithFrame:CommonVIEWFRAME(0,142.5 , 105, 12)
                                           andText:@"租价：¥30/天"
                                      andTextColor:[UIColor colorWithHexColorString:@"14a8ad"]
                                        andBgColor:[UIColor clearColor]
                                           andFont:SYSTEMFONT(12)
                                  andTextAlignment:NSTextAlignmentCenter];
    
    
    UIView *line1 = [[UIView alloc] init];
    line1.backgroundColor = [UIColor colorWithHexColorString:@"dadada"];
    UIView *line2 = [[UIView alloc] init];
    line2.backgroundColor = [UIColor colorWithHexColorString:@"dadada"];
    UIView *line3 = [[UIView alloc] init];
    line3.backgroundColor = [UIColor colorWithHexColorString:@"dadada"];

    
    [self addSubview:headImage];
    [self addSubview:title];
    [self addSubview:title2];
    [self addSubview:line1];
    [self addSubview:line2];
    [self addSubview:line3];

    
    [headImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(0);
        make.left.equalTo(self.mas_left).offset(0);
        make.right.equalTo(self.mas_right).offset(0);
        make.height.mas_equalTo(CommonHight(100.5));
 
    }];
    
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headImage.mas_bottom).offset(10);
        make.left.equalTo(self.mas_left).offset(0);
        make.right.equalTo(self.mas_right).offset(0);
        make.height.equalTo(@(12.0000/667*SCREEN_HIGHT+1));
    }];
    
    [title2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(title.mas_bottom).offset(10);
        make.left.equalTo(self.mas_left).offset(0);
        make.right.equalTo(self.mas_right).offset(0);
        make.height.equalTo(@(12.0000/667*SCREEN_HIGHT));
    }];
    
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headImage.mas_bottom).offset(0);
        make.left.equalTo(self.mas_left).offset(0);
        make.bottom.equalTo(self.mas_bottom).offset(0);
        make.width.equalTo(@0.3);
    }];
     
     [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(0);
        make.left.equalTo(self.mas_left).offset(0);
        make.top.equalTo(self.mas_bottom).offset(-0.3);
        make.height.equalTo(@0.3);
    }];
     
     [line3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headImage.mas_bottom).offset(0);
        make.left.equalTo(self.mas_right).offset(-0.5);
        make.bottom.equalTo(self.mas_bottom).offset(0);
        make.width.equalTo(@0.5);
    }];


     

}



@end
