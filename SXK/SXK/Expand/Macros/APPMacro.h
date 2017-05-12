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

//#define APP_BASEURL @"http://shexiangke.jcq.tbapps.cn"
//#define APP_BASEIMG @"http://ohqqvdngk.bkt.clouddn.com/"
#define APP_BASEURL @"https://shexiangke.boobe.com.cn"
#define APP_BASEIMG @"http://ohqqhwkx4.bkt.clouddn.com/"

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
#define APPINTERFACE__ReleaseProduct         @"/app/rent/addpost"
#define APPINTERFACE__AboutSetup             @"/app/aboutsetup/getpost"
#define APPINTERFACE__GetMaintainList        @"/app/maintain/listpost"
#define APPINTERFACE__GetMaintain            @"/app/maintain/getpost"
#define APPINTERFACE__GetAppraise            @"/app/identifysetup/getpost"
#define APPINTERFACE__GetTenancyList         @"/app/rent/listpost" //我的发布
#define APPINTERFACE__GetRentorderList       @"/app/rentorder/listpost" //我的租赁
#define APPINTERFACE__ProductDeta            @"/app/rent/getpost"
#define APPINTERFACE__CreateOrder            @"/app/rentorder/addpost"
#define APPINTERFACE__Pay                    @"/app/payment/chargepost"
#define APPINTERFACE__GetUser                @"/app/user/getpost"
#define APPINTERFACE__Advertisesetup         @"/app/advertisesetup/getpost"  //首页轮播图
#define APPINTERFACE__HomeLeftSetup          @"/app/leftsetup/getpost"  //首页左侧
#define APPINTERFACE__HomeRightUpSetup       @"/app/rightupsetup/getpost"  //首页右上
#define APPINTERFACE__HomeRightDownSetup     @"/app/rightdownsetup/getpost"  //首页右下
#define APPINTERFACE__HomeClassList          @"/app/class/listpost"  //首页精选分类列表
#define APPINTERFACE__HomeClass              @"/app/class/getpost"  //首页精选分类
#define APPINTERFACE__HomeTopicList          @"/app/topic/listpost"  //首页热门话题列表
#define APPINTERFACE__HomeTopic              @"/app/topic/getpost"  //首页热门话题
#define APPINTERFACE__ThirdLogin             @"/app/applogin/authloginpost"//第三方登录
#define APPINTERFACE__GetAddress             @"/app/receiver/getpost"//获取默认地址
#define APPINTERFACE__GetQuestionList        @"/app/question/listpost"//获取问答列表
#define APPINTERFACE__AddFollow              @"/app/follow/addpost" //添加关注
#define APPINTERFACE__GetFollowList          @"/app/follow/getpost" //关注列表
#define APPINTERFACE__DeleteFollow           @"/app/follow/delpost" //删除关注
#define APPINTERFACE__AddKeep                @"/app/collection/addpost" //添加收藏
#define APPINTERFACE__GetKeepList            @"/app/collection/getpost" //收藏列表
#define APPINTERFACE__CancelKeep             @"/app/collection/delpost" //取消收藏
#define APPINTERFACE__CreateMaintainOrder    @"/app/maintainorder/addpost"//添加养护订单
#define APPINTERFACE__DeleteRentOrder        @"/app/rent/delpost" //删除租赁订单
#define APPINTERFACE__ChangeRentOrder        @"/app/rent/setpost" //修改租赁订单
#define APPINTERFACE__GetMyMaintainList      @"/app/maintainorder/listpost" //获取我的养护订单
#define APPINTERFACE__ConfirmMyMaintainOrder @"/app/maintainorder/setpost" //确认养护订单
#define APPINTERFACE__GetMyAppraiseList      @"/app/identifyorder/listpost"//获取鉴定列表
#define APPINTERFACE__CreateAppraiseOrder    @"/app/identifyorder/addpost"//添加鉴定订单
#define APPINTERFACE__HomeShowSetupList      @"/app/showsetup/listpost" //首页啵呗秀列表
#define APPINTERFACE__HomeSwapSetupList      @"/app/swapsetup/listpost" //首页来换包列表
#define APPINTERFACE__ConfirmMyRentOrder     @"/app/rentorder/setpost" //我的租赁确认收货
#define APPINTERFAXE__RentComment            @"/app/rentcomment/addpost"//评论
#define APPINTERFACE__ChatWithUser           @"/app/rongyun/gettokenpost"
#define APPINTERFACE__GetCategoryHotList     @"/app/categoryhot/listpost"//分类中的热门品牌
#define APPINTERFACE__RechargeOrder          @"/app/rechargeorder/addpost"
#define APPINTERFACE__RewardSetup            @"/app/rewardsetup/getpost"
#define APPINTERFACE__ConfirmMyAppraise      @"/app/identifyorder/setpost"
#define APPINTERFACE__AddMaintainKeep        @"/app/collectionmaintain/addpost" //添加收藏
#define APPINTERFACE__Withdrawals            @"/app/withdraw/addpost"
#define APPINTERFACE__RecordList             @"/app/record/listpost"  //积分记录查询
#define APPINTERFACE__CommontList            @"/app/rentcomment/listpost"  //评论列表
#define APPINTERFACE__WalletList             @"/app/wallet/listpost"  //钱包记录查询
#define APPINTERFACE__AddPurchase            @"/app/purchase/addpost"  //提交预约寄卖
#define APPINTERFACE__PurchaseList           @"/app/purchase/listpost" //寄卖列表
#define APPINTERFACE__PutchaseOrderList      @"/app/purchaseorder/listpost"//我的寄卖列表
#define APPINTERFACE__DeletePurchaseOrder    @"/app/purchaseorder/delpost"//删除寄卖订单
#define APPINTERFACE__ConfirmPurchaseOrder   @"/app/purchaseorder/setpost"//寄卖确认收货
#define APPINTERFACE__PurchaseProductDetail  @"/app/purchase/getpost"
#define APPINTERFACE__PurchaseSetPost        @"/app/purchase/setpost"
#define APPINTERFACE__BussinessProtocol      @"/app/purchaseagreementsetup/getpost"//寄卖协议
#define APPINTERFACE__SetBussinessOrder      @"/app/purchaseorder/addpost"
#define APPINTERFACE__PayByWallet            @"/app/wallet/delpost"
#define APPINTERFACE__EnterActivity          @"/app/activityjoin/addpost"
#define APPINTERFACE__DamagesMonye           @"/app/penaltysetup/getpost"//违约金
#define APPINTERFAXE__ExplainSetup           @"/app/explainsetup/getpost"
#define APPINTERFACE__DelOrder               @"/app/rentorder/delpost"
#define APPINTERFACE__AddBusinessKeep        @"/app/collectionpurchase/addpost" //添加收藏
#define APPINTERFACE__BusinessKeepList       @"/app/collectionpurchase/getpost" //寄卖收藏列表
#define APPINTERFACE__MaintainKeepList       @"/app/collectionmaintain/getpost" //养护收藏列表
#define APPINTERFACE__CancelMaintainKeep     @"/app/collectionmaintain/delpost" //取消养护收藏
#define APPINTERFACE__CancelBusinessKeep     @"/app/collectionpurchase/delpost" //取消寄卖收藏
#define APPINTERFACE__DelAppraiseOrder       @"/app/identifyorder/delpost"
#define APPINTERFACE__AppraiseOrderDetail    @"/app/rentorder/getpost"
#define APPINTERFACE__BusinessOrderDetail    @"/app/purchaseorder/getpost"


#endif /* APPMacro_h */
