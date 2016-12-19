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
#define APP_BASEURL @"http://shexiangke.jcq.tbapps.cn"
#define APP_BASEIMG @"http://ohqqvdngk.bkt.clouddn.com/"

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
#define APP_COLOR_GREEN                 HEXCOLOR(0x14abad)

//header
#define APP_COLOR_GRAY_Header           HEXCOLOR(0xf7f7f7)
#define APP_COLOR_GRAY_Line             HEXCOLOR(0xdcdcdc)
#define APP_COLOR_GRAY_Font             HEXCOLOR(0xa1a1a1)


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

#pragma mark - Url Path

#define APPINTERFACE_Register                @"/app/applogin/registerpost"
#define APPINTERFACE_Login                   @"/app/applogin/loginpost"
#define APPINTERFACE__AddAddress             @"/app/receiver/addpost"
#define APPINTERFACE_SendMob                 @"/app/sms/addpost"
#define APPINTERFACE_ForgetUserPwd           @"/app/applogin/forgetpost"
#define APPINTERFACE__GetAddressList         @"/app/receiver/listpost"
#define APPINTERFACE__DelAddress             @"/app/receiver/delpost"
#define APPINTERFACE__ChangeAddress          @"/app/receiver/setpost"
#define APPINTERFACE__GetBrandlist           @"/app/brand/listpost"
#define APPINTERFACE__GetBrandHotlist        @"/app/brandhot/listpost"
#define APPINTERFACE__GetActivityList        @"/app/activity/listpost"
#define APPINTERFACE__GetActivityDetail      @"/app/activity/getpost/listpost"
#define APPINTERFACE__GetCategoryList        @"/app/category/listpost"
#define APPINTERFACE__GetCommunityHead       @"/app/communitysetup/getpost"
#define APPINTERFACE__GetCommunityModule     @"/app/communitymodule/listpost"
#define APPINTERFACE__GetCommunityTopicList  @"/app/communitytopic/listpost"
#define APPINTERFACE__SetCommunityTopic      @"/app/communitytopic/setpost"
#define APPINTERFACE__AddCommunityTopic      @"/app/communitytopic/addpost"
#define APPINTERFACE__SubmitOpinion          @"/app/feedback/addpost"
#define APPINTERFACE__UserProtocol           @"/app/agreementsetup/getpost"
#define APPINTERFACE__QuestionList           @"/app/question/listpost"
#define APPINTERFACE__SetPersonalInfo        @"/app/user/setpost"
#define APPINTERFACE__GetPersonalInfo        @"/app/user/getpost"

#endif /* APPMacro_h */
