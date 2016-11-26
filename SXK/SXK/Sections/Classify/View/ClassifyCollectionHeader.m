//
//  ClassifyCollectionHeader.m
//  SXK
//
//  Created by 杨伟康 on 2016/11/25.
//  Copyright © 2016年 ywk. All rights reserved.
//

#import "ClassifyCollectionHeader.h"

@implementation ClassifyCollectionHeader

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        btn.frame = VIEWFRAME((frame.size.width - 75)/2, (frame.size.height -15)/2 , 75, 15);
        UIImage *image = [UIImage imageNamed:@"矩形-9-拷贝-2"];
        [btn setImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        //        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitle:@"全部分类" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.titleLabel.font = SYSTEMFONT(13);
        btn.imageEdgeInsets = UIEdgeInsetsMake(0,-10,0,0);
        [self addSubview:btn];
    }
    return self;
}

@end
