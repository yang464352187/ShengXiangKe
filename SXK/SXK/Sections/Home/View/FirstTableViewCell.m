//
//  FirstTableViewCell.m
//  SXK
//
//  Created by 杨伟康 on 2016/11/21.
//  Copyright © 2016年 ywk. All rights reserved.
//

#import "FirstTableViewCell.h"

@implementation FirstTableViewCell{
    UILabel *_title1_1;
    UILabel *_title1_2;
    UILabel *_title1_3;
    
    UILabel *_title2_1;
    UILabel *_title2_2;
    
    UILabel *_title3_1;
    UILabel *_title3_2;


    UIImageView *_imageView1;
    UIImageView *_imageView2;
    UIImageView *_imageView3;

    UIView *_view1;
    UIView *_view2;
    UIView *_view3;
    
    UIView *_line1;
    UIView *_line2;

    
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
        _view1 = [[UIView alloc] init];
        _view1.frame = CommonVIEWFRAME(0, 0, 140, 173);
        
        _view2 = [[UIView alloc] init];
        _view2.frame = CommonVIEWFRAME(140, 0, 235, 86.5);
        
        _view3 = [[UIView alloc] init];
        _view3.frame = CommonVIEWFRAME(140, 86.5, 235, 86.5);
        
        _title1_1 = [UILabel createLabelWithFrame:CommonVIEWFRAME(30, 24, 110, 12)
                                        andText:@"名牌推荐"
                                   andTextColor:[UIColor blackColor]
                                     andBgColor:[UIColor clearColor]
                                        andFont:SYSTEMFONT(12)
                               andTextAlignment:NSTextAlignmentLeft];
        
        _title1_2 = [UILabel createLabelWithFrame:CommonVIEWFRAME(30, 44, 110, 12)
                                          andText:@"全球大牌限时秒"
                                     andTextColor:[UIColor colorWithHexColorString:@"a1a1a1"]
                                       andBgColor:[UIColor clearColor]
                                          andFont:SYSTEMFONT(10)
                                 andTextAlignment:NSTextAlignmentLeft];

        
        _title1_3 = [UILabel createLabelWithFrame:CommonVIEWFRAME(30, 62, 110, 12)
                                          andText:@"每天三场 GO>"
                                     andTextColor:[UIColor colorWithHexColorString:@"a1a1a1"]
                                       andBgColor:[UIColor clearColor]
                                          andFont:SYSTEMFONT(10)
                                 andTextAlignment:NSTextAlignmentLeft];
        
        _imageView1 = [[UIImageView alloc] initWithFrame:CommonVIEWFRAME(28, 92, 70, 50)];
        _imageView1.image = [UIImage imageNamed:@"图层-137"];

        _title2_1 = [UILabel createLabelWithFrame:CommonVIEWFRAME(30, 24, 110, 12)
                                          andText:@"精选顾问"
                                     andTextColor:[UIColor blackColor]
                                       andBgColor:[UIColor clearColor]
                                          andFont:SYSTEMFONT(12)
                                 andTextAlignment:NSTextAlignmentLeft];

        _title2_2 = [UILabel createLabelWithFrame:CommonVIEWFRAME(30, 44, 110, 12)
                                          andText:@"一对一好货推荐"
                                     andTextColor:[UIColor colorWithHexColorString:@"a1a1a1"]
                                       andBgColor:[UIColor clearColor]
                                          andFont:SYSTEMFONT(10)
                                 andTextAlignment:NSTextAlignmentLeft];
        
        _imageView2 = [[UIImageView alloc] initWithFrame:CommonVIEWFRAME(120,18, 70,55)];
        _imageView2.image = [UIImage imageNamed:@"图层-1-副本-2"];
        
        _title3_1 = [UILabel createLabelWithFrame:CommonVIEWFRAME(30, 24, 110, 12)
                                          andText:@"实时上新"
                                     andTextColor:[UIColor blackColor]
                                       andBgColor:[UIColor clearColor]
                                          andFont:SYSTEMFONT(12)
                                 andTextAlignment:NSTextAlignmentLeft];
        
        _title3_2 = [UILabel createLabelWithFrame:CommonVIEWFRAME(30, 44, 110, 12)
                                          andText:@"新鲜好货每日速达"
                                     andTextColor:[UIColor colorWithHexColorString:@"a1a1a1"]
                                       andBgColor:[UIColor clearColor]
                                          andFont:SYSTEMFONT(10)
                                 andTextAlignment:NSTextAlignmentLeft];
        
        _imageView3 = [[UIImageView alloc] initWithFrame:CommonVIEWFRAME(120,18, 70,55)];
        _imageView3.image = [UIImage imageNamed:@"图层-155"];

        _line1 =[[UIView alloc] initWithFrame:CommonVIEWFRAME(139.5, 0, 0.5, 173)];
        _line1.backgroundColor = [UIColor colorWithHexColorString:@"dcdcdc"];
        
        _line2 =[[UIView alloc] initWithFrame:CommonVIEWFRAME(0, 86, 235, 0.5)];
        _line2.backgroundColor = [UIColor colorWithHexColorString:@"dcdcdc"];

        [_view1 addSubview:_title1_1];
        [_view1 addSubview:_title1_2];
        [_view1 addSubview:_title1_3];
        [_view1 addSubview:_imageView1];
        [_view1 addSubview:_line1];
        
        [_view2 addSubview:_title2_1];
        [_view2 addSubview:_title2_2];
        [_view2 addSubview:_imageView2];
        [_view2 addSubview:_line2];

        
        [_view3 addSubview:_title3_1];
        [_view3 addSubview:_title3_2];
        [_view3 addSubview:_imageView3];
        
    
        
        [self addSubview:_view1];
        [self addSubview:_view2];
        [self addSubview:_view3];
        
        
        

        
    }
    return  self;
}


@end
