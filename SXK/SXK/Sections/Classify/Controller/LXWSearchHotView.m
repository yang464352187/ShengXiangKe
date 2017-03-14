//
//  LXWSearchHotView.m
//  Qwang
//
//  Created by 2.qwang.com.cn on 2017/2/23.
//  Copyright © 2017年 sundy_young. All rights reserved.
//

#import "LXWSearchHotView.h"
#import "BrandHotModel.h"
#define MIN_WIDTH (SCREEN_WIDTH - 60) / 4
#define MAX_WIDTH (SCREEN_WIDTH - 40) / 2

#define btnBgColor RGB(245,245,245)

@interface LXWSearchHotView ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, assign) NSInteger selectedIndex;

@end

@implementation LXWSearchHotView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        if (!self.titleLabel) {
            self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake( 20.f, 15.f, 100.f, 30.f)];
            //self.titleLabel.text = @"品牌:";
            self.titleLabel.textColor =  [UIColor greenColor];
            [self addSubview:self.titleLabel];
        }
        
        UIButton *changeHotWordBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 15.f, 90.f, 30.f)];
        [changeHotWordBtn setTitle:@"热门搜索" forState:UIControlStateNormal];
        [changeHotWordBtn setTitleColor:APP_COLOR_GRAY_Font forState:UIControlStateNormal];
        [changeHotWordBtn addTarget:self action:@selector(changeHotWordBtn:) forControlEvents:UIControlEventTouchUpInside];
        changeHotWordBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:changeHotWordBtn];
        
    }
    return self;
}

#pragma mark - Set
- (void)setTitle:(NSString *)title{
    _title = title;
    self.titleLabel.text = title;
}
- (void)setContents:(NSArray *)contents{
    _contents = contents;
    if (contents.count<1) {
        return;
    }
    _selectedIndex = -1;
//    if (self.sectionType == SectionType_Price) {
//        CGFloat btnWidth = (SCREEN_WIDTH-30.f)/_contents.count;
//        for (int i = 0 ; i < _contents.count; i++) {
//            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//            btn.frame = CGRectMake(btnWidth*i+15.f, 50.f, btnWidth, 35.f);
//            btn.layer.borderColor =  [UIColor greenColor].CGColor;
//            btn.layer.borderWidth = 0.5f;
//            
//            [btn setTag:1000+i];
//            [btn setBackgroundColor:[UIColor redColor]];
//            
//            [btn setTitle:_contents[i] forState:UIControlStateNormal];
//            [btn setTitleColor: [UIColor greenColor] forState:UIControlStateNormal];
//            [btn addTarget:self action:@selector(wordBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//            [self addSubview:btn];
//        }
//        self.height = 100.f;
//    }else if (self.sectionType == SectionType_Category){
        UIButton *wordBtn;
        NSString *titleStr;
        CGSize titleSize;
        NSString *tmpStr; //下一个tag str
        CGSize tmpSize;   //下一个tag str size
        CGFloat nextBtnWidth;
        CGFloat btnWidth;
        
        CGFloat x = 15;
        CGFloat y = 15.f+30.f+5.f;

        //CGFloat wordBtn_bottom = y;
        int rowNum = 1;
        for (int i = 0 ; i < _contents.count; i++) {
            BrandHotModel *model = _contents[i];
            titleStr = model.name;
            titleSize = [titleStr sizeWithAttributes:@{NSFontAttributeName:SYSTEMFONT(12)}];
            if (i+1<[_contents count]) {
                BrandHotModel *model1 = _contents[i+1];

                tmpStr = model1.name;
                tmpSize = [tmpStr sizeWithAttributes:@{NSFontAttributeName:SYSTEMFONT(12)}];
            }else{
                tmpSize = CGSizeZero;
            }
            
            wordBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            wordBtn.titleLabel.font = SYSTEMFONT(12);
            wordBtn.backgroundColor =  [UIColor whiteColor];
            wordBtn.layer.cornerRadius = 5.f;
            wordBtn.layer.masksToBounds = YES;
            ViewBorderRadius(wordBtn, 8.f, 0.5, APP_COLOR_GRAY_Font);
            [wordBtn setTitle:titleStr forState:UIControlStateNormal];
            [wordBtn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
            
            [wordBtn setTag:1000+i];
            [wordBtn addTarget:self action:@selector(wordBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [wordBtn setTitleColor:APP_COLOR_GRAY_Font forState:UIControlStateNormal];
            wordBtn.adjustsImageWhenHighlighted = NO;
            btnWidth = titleSize.width+16.f;
            if (btnWidth>SCREEN_WIDTH) {
                btnWidth=SCREEN_WIDTH;
            }
            
            nextBtnWidth = tmpSize.width+16.f;
            if (nextBtnWidth>SCREEN_WIDTH) {
                nextBtnWidth = SCREEN_WIDTH;
            }
            
            wordBtn.frame = CGRectMake(x, y, btnWidth, 27.f);
            if (rowNum<=3) {
                [self addSubview:wordBtn];
            }else{
                break;
            }
            
            x = x + btnWidth +5;
            if (x+nextBtnWidth>SCREEN_WIDTH-15.f) {
                x = 15.f;
                y = y + 27.f + 10.f;
                rowNum+=1;
            }
        }
        self.height = y+27.f+10;
    
//    }
    
}
- (void)wordBtnClick:(UIButton *)sender{
    if (sender.tag-1000==_selectedIndex) {
        return;
    }
//    sender.selected = !sender.selected;
    
    if (self.changeBgColor){
        UIButton *selectdBtn = [self viewWithTag:_selectedIndex+1000];
        [selectdBtn setBackgroundColor:[UIColor whiteColor]];
        [selectdBtn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
        [sender setBackgroundColor:[UIColor redColor]];
        [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    
    _selectedIndex = sender.tag-1000;
    NSLog(@"%ld",_selectedIndex);
    if ([self.delegate respondsToSelector:@selector(didClickCategoryVieWithContent:categoryType:Tag:)]) {
        [self.delegate didClickCategoryVieWithContent:sender.titleLabel.text categoryType:_categoryType Tag:_selectedIndex];
    }
}
- (void)resetAllState{
    _selectedIndex = -1;
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[UIButton class]]) {
            UIButton *btn = (UIButton *)obj;
            [btn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
            [btn setBackgroundColor:[UIColor whiteColor]];
        }
    }];
}


- (void)changeHotWordBtn:(UIButton *)sender{
    if ([self.delegate respondsToSelector:@selector(changeHotWord)]) {
        [self.delegate changeHotWord];
    }
}

@end
