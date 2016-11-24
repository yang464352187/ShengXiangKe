//
//  APPMacro.h
//  SXK
//
//  Created by 杨伟康 on 2016/11/11.
//  Copyright © 2016年 ywk. All rights reserved.
//

#ifndef APPMacro_h
#define APPMacro_h


// 接口链接地址
#define APP_BASEURL @"http://www.arogo.cn"


#pragma mark - BaseColor
// 基本颜色
#define APP_COLOR_BASE_BAR              HEXCOLOR(0xfcd204)

#define APP_COLOR_BASE_BACKGROUND       HEXCOLOR(0xf1f1f1)
#define APP_COLOR_BASE_TABBAR           [UIColor colorWithRed:0.16 green:0.64 blue:0.99 alpha:1.00]
#define APP_COLOR_BASE_LINE             [UIColor colorWithRed:0.16 green:0.64 blue:0.99 alpha:1.00]

// 按钮 黄色
#define APP_COLOR_BASE_YELLOW           [UIColor colorWithRed:1.00 green:0.73 blue:0.01 alpha:1.00]

//灰色分类
#define APP_COLOR_GRAY_333333           HEXCOLOR(0x16a5af)
#define APP_COLOR_GRAY_666666           HEXCOLOR(0x666666)
#define APP_COLOR_GRAY_999999           HEXCOLOR(0x999999)
#define APP_COLOR_GRAY_eeeeee           HEXCOLOR(0xeeeeee)
#define APP_COLOR_GRAY_cccccc           HEXCOLOR(0xcccccc)


//红色
#define APP_BUTTON_BASE_RED             HEXCOLOR(0xff0000)
#define APP_COLOR_LIGHT_RED             HEXCOLOR(0xff6e7e)
#define APP_COLOR_DARK_RED              HEXCOLOR(0xd00101)

//蓝色
#define APP_COLOR_BASE_BLUE             HEXCOLOR(0x00c6ff)


//画线1像素
#define SINGLE_LINE_WIDTH           (1 / [UIScreen mainScreen].scale)
#define SINGLE_LINE_ADJUST_OFFSET   ((1 / [UIScreen mainScreen].scale) / 2)

#pragma mark - Define Name


// APP内部使用宏定义名称


#endif /* APPMacro_h */
