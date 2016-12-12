//
//  ClassifyCollectionHeader.m
//  SXK
//
//  Created by 杨伟康 on 2016/11/25.
//  Copyright © 2016年 ywk. All rights reserved.
//

#import "ClassifyCollectionHeader.h"

@implementation ClassifyCollectionHeader{
    UIButton *_title;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        btn.frame = VIEWFRAME((frame.size.width - 75)/2, (frame.size.height -15)/2 , 75, 15);
        UIImage *image = [UIImage imageNamed:@""];
        [btn setImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        //        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitle:@"" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.titleLabel.font = SYSTEMFONT(13);
        btn.imageEdgeInsets = UIEdgeInsetsMake(0,-10,0,0);
        [self addSubview:btn];
        _title = btn;
    }
    return self;
}


-(void)changeTitle:(NSString *)title andImg:(NSString *)image
{
    [_title setTitle:title forState:UIControlStateNormal];
    UIImage *image1 = [UIImage imageNamed:image];
    [_title setImage:[image1 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
}

@end
