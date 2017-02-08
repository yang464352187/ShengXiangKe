//
//  ProductParamCell.m
//  SXK
//
//  Created by 杨伟康 on 2016/12/29.
//  Copyright © 2016年 ywk. All rights reserved.
//

#import "ProductParamCell.h"
#import "BrandDetailModel.h"
@implementation ProductParamCell{
    UILabel *_category;
    UILabel *_brand;
    UILabel *_color;
    UILabel *_quality;
    UILabel *_person;
    UILabel *_enclosure;
    UILabel *_category1;
    UILabel *_brand1;
    UILabel *_color1;
    UILabel *_quality1;
    UILabel *_person1;
    UILabel *_enclosure1;

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
        _category = [UILabel createLabelWithFrame:VIEWFRAME(15, 15, 150, 53)                                                 andText:@"类别"
                                    andTextColor:APP_COLOR_GRAY_Font
                                       andBgColor:[UIColor clearColor]
                                         andFont:SYSTEMFONT(13)
                                andTextAlignment:NSTextAlignmentLeft];
        
        _brand = [UILabel createLabelWithFrame:VIEWFRAME(15, 0, 150, 53)                                                 andText:@"品牌"
                                     andTextColor:APP_COLOR_GRAY_Font
                                    andBgColor:[UIColor clearColor]
                                          andFont:SYSTEMFONT(13)
                                 andTextAlignment:NSTextAlignmentLeft];

        
        _color = [UILabel createLabelWithFrame:VIEWFRAME(15, 0, 150, 53)                                                 andText:@"颜色"
                                     andTextColor:APP_COLOR_GRAY_Font
                                    andBgColor:[UIColor clearColor]
                                          andFont:SYSTEMFONT(13)
                                 andTextAlignment:NSTextAlignmentLeft];

        
        _quality = [UILabel createLabelWithFrame:VIEWFRAME(15, 0, 150, 53)                                                 andText:@"成色"
                                     andTextColor:APP_COLOR_GRAY_Font
                                      andBgColor:[UIColor clearColor]
                                          andFont:SYSTEMFONT(13)
                                 andTextAlignment:NSTextAlignmentLeft];

        
        _person = [UILabel createLabelWithFrame:VIEWFRAME(15, 0, 150, 53)                                                 andText:@"适用人群"
                                     andTextColor:APP_COLOR_GRAY_Font
                                     andBgColor:[UIColor clearColor]
                                          andFont:SYSTEMFONT(13)
                                 andTextAlignment:NSTextAlignmentLeft];
        
        _enclosure = [UILabel createLabelWithFrame:VIEWFRAME(15, 0, 150, 53)                                                 andText:@"附件"
                                     andTextColor:APP_COLOR_GRAY_Font
                                        andBgColor:[UIColor clearColor]
                                          andFont:SYSTEMFONT(13)
                                 andTextAlignment:NSTextAlignmentLeft];
        
        _category1 = [UILabel createLabelWithFrame:VIEWFRAME(15, 15, 150, 53)                                                 andText:@""
                                     andTextColor:[UIColor blackColor]
                                       andBgColor:[UIColor clearColor]
                                          andFont:SYSTEMFONT(13)
                                 andTextAlignment:NSTextAlignmentRight];
        
        _brand1 = [UILabel createLabelWithFrame:VIEWFRAME(15, 0, 150, 53)                                                 andText:@""
                                  andTextColor:[UIColor blackColor]
                                    andBgColor:[UIColor clearColor]
                                       andFont:SYSTEMFONT(13)
                              andTextAlignment:NSTextAlignmentRight];
        
        _color1 = [UILabel createLabelWithFrame:VIEWFRAME(15, 0, 150, 53)                                                 andText:@""
                                  andTextColor:[UIColor blackColor]
                                    andBgColor:[UIColor clearColor]
                                       andFont:SYSTEMFONT(13)
                              andTextAlignment:NSTextAlignmentRight];
        
        _quality1 = [UILabel createLabelWithFrame:VIEWFRAME(15, 0, 150, 53)                                                 andText:@""
                                    andTextColor:[UIColor blackColor]
                                      andBgColor:[UIColor clearColor]
                                         andFont:SYSTEMFONT(13)
                                andTextAlignment:NSTextAlignmentRight];
        
        _person1 = [UILabel createLabelWithFrame:VIEWFRAME(15, 0, 150, 53)                                                 andText:@""
                                   andTextColor:[UIColor blackColor]
                                     andBgColor:[UIColor clearColor]
                                        andFont:SYSTEMFONT(13)
                               andTextAlignment:NSTextAlignmentRight];
        
        _enclosure1 = [UILabel createLabelWithFrame:VIEWFRAME(15, 0, 150, 53)                                                 andText:@""
                                      andTextColor:[UIColor blackColor]
                                        andBgColor:[UIColor clearColor]
                                           andFont:SYSTEMFONT(13)
                                  andTextAlignment:NSTextAlignmentRight];

        [self addSubview:_category];
        [self addSubview:_brand];
        [self addSubview:_color];
        [self addSubview:_quality];
        [self addSubview:_person];
        [self addSubview:_enclosure];
        [self addSubview:_category1];
        [self addSubview:_brand1];
        [self addSubview:_color1];
        [self addSubview:_quality1];
        [self addSubview:_person1];
        [self addSubview:_enclosure1];
        
        [_category mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).offset(15);
            make.left.equalTo(self.mas_left).offset(15);
            make.size.mas_equalTo(CGSizeMake(50, 15));
        }];
        
        [_brand mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_category.mas_bottom).offset(10);
            make.left.equalTo(self.mas_left).offset(15);
            make.size.mas_equalTo(CGSizeMake(50, 15));
        }];

        [_color mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_brand.mas_bottom).offset(10);
            make.left.equalTo(self.mas_left).offset(15);
            make.size.mas_equalTo(CGSizeMake(50, 15));
        }];
        
        [_quality mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_color.mas_bottom).offset(10);
            make.left.equalTo(self.mas_left).offset(15);
            make.size.mas_equalTo(CGSizeMake(50, 15));
        }];
        
        [_person mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_quality.mas_bottom).offset(10);
            make.left.equalTo(self.mas_left).offset(15);
            make.size.mas_equalTo(CGSizeMake(80, 15));
        }];
        
        [_enclosure mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_person.mas_bottom).offset(10);
            make.left.equalTo(self.mas_left).offset(15);
            make.size.mas_equalTo(CGSizeMake(50, 15));
        }];
        
        [_category1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).offset(15);
            make.left.equalTo(_category.mas_right).offset(0);
            make.right.equalTo(self.mas_right).offset(-15);
            make.height.mas_equalTo(15);
        }];
        
        [_brand1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_category1.mas_bottom).offset(10);
            make.left.equalTo(_brand.mas_right).offset(0);
            make.right.equalTo(self.mas_right).offset(-15);
            make.height.mas_equalTo(15);
        }];
        
        [_color1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_brand1.mas_bottom).offset(10);
            make.left.equalTo(_color.mas_right).offset(0);
            make.right.equalTo(self.mas_right).offset(-15);
            make.height.mas_equalTo(15);
        }];
        
        [_quality1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_color1.mas_bottom).offset(10);
            make.left.equalTo(_quality.mas_right).offset(0);
            make.right.equalTo(self.mas_right).offset(-15);
            make.height.mas_equalTo(15);
        }];
        
        [_person1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_quality1.mas_bottom).offset(10);
            make.left.equalTo(_person.mas_right).offset(15);
            make.right.equalTo(self.mas_right).offset(-15);
            make.height.mas_equalTo(15);
        }];
        
        [_enclosure1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_person1.mas_bottom).offset(10);
            make.left.equalTo(_enclosure.mas_right).offset(15);
            make.right.equalTo(self.mas_right).offset(-15);
            make.height.mas_equalTo(15);
        }];
        
    }
    return  self;
}

-(void)setModel:(id)model
{
    BrandDetailModel *_model = model;
    
    //根据brandid选择品牌
    _brand1.text = [NSString stringWithFormat:@"%@",_model.brand[@"name"]];

    //根据categoryid选择类别
    _category1.text = [NSString stringWithFormat:@"%@",_model.category[@"name"]];
    
    //产品新旧
    NSArray *qualityArr = [[NSArray alloc] initWithObjects:@"99成新（未使用）",@"98成新",@"95成新",@"9成新",@"85成新",@"8成新", nil];
    NSInteger quality = [_model.condition integerValue];
    _quality1.text = qualityArr[quality];
    
    //适用人群
    NSArray *personArr = [[NSArray alloc] initWithObjects:@"所有人",@"男士",@"女士", nil];
    NSInteger personID = [_model.crowd integerValue];
    _person1.text = personArr[personID-1];
    
    //颜色
    _color1.text = _model.color;
    
    //附件
    NSMutableString *str = [[NSMutableString alloc] init];
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    for (NSDictionary *dic in _model.attachList) {
        NSArray *attributeArr = dic[@"attributeValueList"];
        for (NSString *str1 in attributeArr) {
            if (arr.count > 0) {
                [str appendString:@"、"];
            }
            [str appendString:str1];
            [arr addObject:str1];
        }
    }
    _enclosure1.text = str;
}



@end
