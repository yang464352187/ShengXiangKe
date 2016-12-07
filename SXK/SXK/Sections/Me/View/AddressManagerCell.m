//
//  AddressManagerCell.m
//  SXK
//
//  Created by 杨伟康 on 2016/12/5.
//  Copyright © 2016年 ywk. All rights reserved.
//

#import "AddressManagerCell.h"
#import "AddressModel.h"

@implementation AddressManagerCell{
    UIButton *_selectBtn;
    UILabel *_nameLab;
    UILabel *_phoneLab;
    UILabel *_addressLab;
    UIView *_line;
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
     
        [self loadView];
        
    }
    return  self;
}

-(void)loadView
{
    UIImage *firstImage = [UIImage imageNamed:@"椭圆-12-拷贝-2"];
    UIImage *secondImage = [UIImage imageNamed:@"椭圆-12-拷贝"];
    _selectBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [_selectBtn setImage:[firstImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [_selectBtn setImage:[secondImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateSelected];
    [_selectBtn addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
    [_selectBtn setTintColor:[UIColor whiteColor]];
    _selectBtn.frame = VIEWFRAME(17.5,36, 18, 18);
    
    _nameLab = [UILabel createLabelWithFrame:VIEWFRAME(56, 14, 100, 16)                                                 andText:@"好肥一只鱼"
                              andTextColor:[UIColor blackColor]
                                andBgColor:[UIColor clearColor]
                                   andFont:SYSTEMFONT(14)
                          andTextAlignment:NSTextAlignmentLeft];

    _phoneLab = [UILabel createLabelWithFrame:VIEWFRAME(156, 14, 100, 16)                                                 andText:@"18659847929"
                                andTextColor:[UIColor blackColor]
                                  andBgColor:[UIColor clearColor]
                                     andFont:SYSTEMFONT(14)
                            andTextAlignment:NSTextAlignmentLeft];
    
    _addressLab = [UILabel createLabelWithFrame:VIEWFRAME(56, 38, SCREEN_WIDTH-56, 14)                                                 andText:@"福建省厦门市思明区厦门大学会计学院18号楼"
                                 andTextColor:[UIColor colorWithHexColorString:@"a1a1a1"]
                                   andBgColor:[UIColor clearColor]
                                      andFont:SYSTEMFONT(14)
                             andTextAlignment:NSTextAlignmentLeft];
    
    _line = [[UIView alloc] initWithFrame:VIEWFRAME(56, 59.5, SCREEN_WIDTH - 56, 0.5)];
    _line.backgroundColor = [UIColor colorWithHexColorString:@"eeeeee"];
    
    [self addSubview: _selectBtn];
    [self addSubview:_nameLab];
    [self addSubview:_phoneLab];
    [self addSubview:_addressLab];
    [self addSubview: _line];
}

-(void)selectAction:(UIButton *)sender
{
    
}

- (void)setModel:(id)model{
    
     AddressModel *_model = model;
    _nameLab.text = _model.name;
    _phoneLab.text = _model.mobile;
    _addressLab.text = [NSString stringWithFormat:@"%@%@%@%@",_model.state,_model.city,_model.district,_model.address];
//    NSLog(@"%lf",[_model.receiverid floatValue]);
}

@end
