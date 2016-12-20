//
//  EnclosureCell.m
//  SXK
//
//  Created by 杨伟康 on 2016/12/20.
//  Copyright © 2016年 ywk. All rights reserved.
//

#import "EnclosureCell.h"

@implementation EnclosureCell{
    UILabel *_title;
    UIView *_line;
    UILabel *_select;    
    UIImageView *_back;
    UITextField *_text;
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
        _title = [UILabel createLabelWithFrame:VIEWFRAME(15, 0, 100, 53)                                                 andText:@"类别"
                                  andTextColor:[UIColor blackColor]
                                    andBgColor:[UIColor clearColor]
                                       andFont:SYSTEMFONT(14)
                              andTextAlignment:NSTextAlignmentLeft];
        
        _line = [[UIView alloc] initWithFrame:VIEWFRAME(0, 54, SCREEN_WIDTH, 1)];
        _line.backgroundColor = [UIColor colorWithHexColorString:@"f7f7f7"];
        
        _select = [UILabel createLabelWithFrame:VIEWFRAME(SCREEN_WIDTH - 185, 0, 150, 53)                                                 andText:@""
                                   andTextColor:[UIColor colorWithHexColorString:@"a1a1a1"]
                                     andBgColor:[UIColor clearColor]
                                        andFont:SYSTEMFONT(14)
                               andTextAlignment:NSTextAlignmentRight];

        
        _back = [[UIImageView alloc] init];
        _back.image = [UIImage imageNamed:@"返回-"];
        
        [self addSubview:_title];
        [self addSubview:_line];
        [self addSubview:_select];
        [self addSubview:_back];
        
        [_back mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).offset(20);
            make.right.equalTo(self.mas_right).offset(-18);
            make.width.equalTo(@8);
            make.height.equalTo(@13);
        }];

    }
    return  self;
}

-(void)fillWithTitle:(NSString *)title
{
    _title.text = title;
}

-(void)changeTitle:(NSString *)title
{
    _select.text = title;
    
}

-(NSMutableDictionary *)getData
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setValue:_title.text forKey:@"attributeName"];
    if (_select.text.length > 0 ) {
        NSMutableArray *array = [[NSMutableArray alloc] init];
        [array addObject:_select.text];
        [dic setValue:array forKey:@"attributeValueList"];

    }
    
    return dic;
}

@end
