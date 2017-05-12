//
//  PromulgateTopicCell.m
//  SXK
//
//  Created by 杨伟康 on 2016/12/14.
//  Copyright © 2016年 ywk. All rights reserved.
//

#import "PromulgateTopicCell.h"
#import "ModuleModel.h"

@implementation PromulgateTopicCell{
    UILabel *_title;
    NSInteger _select;
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
        UIView *view = [[UIView alloc] initWithFrame:VIEWFRAME(15, 15, 4, 15)];
        view.backgroundColor = APP_COLOR_GREEN;
        
        _title = [UILabel createLabelWithFrame:VIEWFRAME(15, 15, 100, 15)                                                 andText:@"热门分类"
                                   andTextColor:[UIColor colorWithHexColorString:@"a1a1a1"]
                                     andBgColor:[UIColor clearColor]
                                        andFont:SYSTEMFONT(14)
                               andTextAlignment:NSTextAlignmentCenter];

        
        [self addSubview:view];
        [self addSubview:_title];
    }
    return  self;
}

-(void)fillWithArray:(NSArray *)array
{
    NSMutableArray *Arr = [[NSMutableArray alloc] init];
    for (ModuleModel *model in array) {
        if (![model.name isEqualToString:@"免费鉴定"]) {
            [Arr addObject:model];
        }
    }
    
    
    
    int j = 0;
    for (int i = 0; i < Arr.count; i++) {
        ModuleModel *model = Arr[i];
        
        
        
        int k = i / 3;
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        btn.frame = VIEWFRAME(CommonWidth(21 + j*(104+12)), 45 + k * (11 + 25), CommonWidth(104), 25);
        [btn setTitle:model.name forState:UIControlStateNormal];
        [btn setTitleColor:APP_COLOR_GRAY_Font forState:UIControlStateNormal];
        btn.tag = [model.moduleid integerValue];
        [btn addTarget:self action:@selector(ClickAction:) forControlEvents:UIControlEventTouchUpInside];
        ViewBorderRadius(btn , 5, 1, APP_COLOR_GRAY_Font);
        [self addSubview:btn];
        j++;
        if (j >= 3) {
            j = 0;
        }

    }
}

-(void)ClickAction:(UIButton *)sender
{

    ViewBorderRadius(sender , 5, 1, APP_COLOR_GREEN);
    [sender setTitleColor:APP_COLOR_GREEN forState:UIControlStateNormal];
    
    if ([_delegate respondsToSelector:@selector(sendModuleID:)]) { // 如果协议响应了sendModuleID:方法
        [_delegate sendModuleID:sender.tag]; // 通知执行协议方法
    }
    
    if (_select == 0 || _select == sender.tag) {
        _select = sender.tag;
    }else
    {
        UIButton *btn = [(UIButton *) self viewWithTag:_select];
        [btn setTitleColor:APP_COLOR_GRAY_Font forState:UIControlStateNormal];
        ViewBorderRadius(btn , 5, 1, APP_COLOR_GRAY_Font);
        _select = sender.tag;
    }

}

@end
