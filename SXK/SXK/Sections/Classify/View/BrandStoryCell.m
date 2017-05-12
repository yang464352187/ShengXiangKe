//
//  BrandStoryCell.m
//  SXK
//
//  Created by 杨伟康 on 2017/1/16.
//  Copyright © 2017年 ywk. All rights reserved.
//

#import "BrandStoryCell.h"
#import "BrandDetailModel.h"

@implementation BrandStoryCell{
    UIImageView *_image;
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
    
        _image = [[UIImageView alloc] init];
//        _image.image = [UIImage imageNamed:@"图层-11"];
        _image.contentMode = UIViewContentModeScaleAspectFit;
        _image.clipsToBounds = YES;
        
        _title = [UILabel createLabelWithFrame:VIEWFRAME(15, 0, 150, 53)                                                 andText:@""
                                  andTextColor:[UIColor blackColor]
                                    andBgColor:[UIColor clearColor]
                                       andFont:SYSTEMFONT(13)
                              andTextAlignment:NSTextAlignmentLeft];

        _title.numberOfLines = 0;
        [self addSubview:_image];
        [self addSubview:_title];
        
        [_image mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).offset(0);
//            make.bottom.equalTo(self.mas_bottom).offset(0);
            make.left.equalTo(self.mas_left).offset(0);
            make.right.equalTo(self.mas_right).offset(0);
            make.height.mas_equalTo(@(270));
        }];
        

    }
    return  self;
}

-(void)setModel:(id)model
{
    BrandDetailModel *_model = model;
    NSDictionary *brand = _model.brand;
    [_image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",APP_BASEIMG,brand[@"story"]]]];
    _title.text = brand[@"description"];
    
    CGFloat height = [UILabel getHeightByWidth:SCREEN_WIDTH - 30 title:brand[@"description"] font:SYSTEMFONT(13)];

    [_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(15);
        make.right.equalTo(self.mas_right).offset(-15);
        make.top.equalTo(_image.mas_bottom).offset(0);
        make.height.mas_equalTo(@(height));

    }];

}


@end
