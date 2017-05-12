//
//  BaseRequest.h
//  SXK
//
//  Created by 杨伟康 on 2016/11/11.
//  Copyright © 2016年 ywk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetworkClient.h"

@interface BaseRequest : NSObject

@property (nonatomic, strong) NSString *baseUrl;
@property (nonatomic, assign) NSTimeInterval *requestTimeoutInterval;
@property (nonatomic, readonly) AFNetworkReachabilityStatus status;

+ (instancetype)sharedInstance;


+ (void)requestGetCommonWithPath:(NSString *)aPath Params:(id)params succesBlock:(SuccessBlock)successBlock failue:(FailureBlock)failueBlock;

+ (void)requestPostCommonWithPath:(NSString *)aPath Params:(id)params succesBlock:(SuccessBlock)successBlock failue:(FailureBlock)failueBlock;

/**
 *  注册
 *
 *  @param userName     账号
 *  @param psw          密码
 *  @param verify       验证码
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)registerWithUserName:(NSString *)userName
                    password:(NSString *)psw
                      verify:(NSString *)verify
                  inviteCode:(NSString *)inviteCode
                 succesBlock:(SuccessBlock)successBlock
                      failue:(FailureBlock)failueBlock;


/**
 *  登陆
 *
 *  @param userName     账号
 *  @param psw          密码
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)loginWithUserName:(NSString *)userName
                 password:(NSString *)psw
              succesBlock:(SuccessBlock)successBlock
                   failue:(FailureBlock)failueBlock;

/**
 *  添加收货地址
 *
 *  @param name         姓名
 *  @param phone        电话
 *  @param address      地址
 *  @param state        省份
 *  @param city         城市
 *  @param district      区
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */

+ (void)addAddressWithname:(NSString *)name
                     phone:(NSString *)phone
                     state:(NSString *)state
                      city:(NSString *)city
                  district:(NSString *)district
                   address:(NSString *)address
               succesBlock:(SuccessBlock)successBlock
                    failue:(FailureBlock)failueBlock;

/**
 *  发送验证码
 *
 *  @param mobile       手机号
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */

+ (void)sendSmsWithmobile:(NSString *)mobile
              succesBlock:(SuccessBlock)successBlock
                   failue:(FailureBlock)failueBlock;


/**
 *  忘记密码
 *
 *  @param mobile       手机号
 *  @param psw          密码
 *  @param verify       验证码
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)resetPassWordWithmobile:(NSString *)mobile
                       password:(NSString *)psw
                         verify:(NSString *)verify
                    succesBlock:(SuccessBlock)successBlock
                         failue:(FailureBlock)failueBlock;


/**
 *  获取收获地址
 *  @param pageNo       页码
 *  @param pageSize     页数
 *  @param order        订单
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)getAddressWithPageNo:(NSInteger)pageNo
                    PageSize:(NSInteger)pageSize
                       order:(NSDictionary *)order
                 succesBlock:(SuccessBlock)successBlock
                      failue:(FailureBlock)failueBlock;

/**
 *  删除收货地址
 *
 *  @param index        位置
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)deleteAddressWithindex:(NSNumber *)index
                   succesBlock:(SuccessBlock)successBlock
                        failue:(FailureBlock)failueBlock;



/**
 *  添加收货地址
 *
 *  @param name         姓名
 *  @param phone        电话
 *  @param address      地址
 *  @param state        省份
 *  @param city         城市
 *  @param district      区
 *  @param index        地址标示
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */

+ (void)ChangeAddressWithname:(NSString *)name
                        phone:(NSString *)phone
                        state:(NSString *)state
                         city:(NSString *)city
                     district:(NSString *)district
                      address:(NSString *)address
                        index:(NSNumber *)index
                  succesBlock:(SuccessBlock)successBlock
                       failue:(FailureBlock)failueBlock;


/**
 *  添加收货地址
 *
 *  @param params       params
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */

+(void)ChangeAddressWithParams:(NSDictionary *)params
                   succesBlock:(SuccessBlock)successBlock
                        failue:(FailureBlock)failueBlock;



/**
 *  获取所有品牌
 *  @param pageNo       页码
 *  @param pageSize     页数
 *  @param order        订单
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)GetBrandListWithPageNo:(NSInteger)pageNo
                      PageSize:(NSInteger)pageSize
                         order:(NSInteger)order
                   succesBlock:(SuccessBlock)successBlock
                        failue:(FailureBlock)failueBlock;


/**
 *  获取热门品牌
 *  @param pageNo       页码
 *  @param pageSize     页数
 *  @param order        订单
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)GetBrandHotListWithPageNo:(NSInteger)pageNo
                         PageSize:(NSInteger)pageSize
                            order:(NSInteger)order
                      succesBlock:(SuccessBlock)successBlock
                           failue:(FailureBlock)failueBlock;

/**
 *  获取活动列表
 *  @param pageNo       页码
 *  @param pageSize     页数
 *  @param order        订单
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)GetActivityListWithPageNo:(NSInteger)pageNo
                         PageSize:(NSInteger)pageSize
                            order:(NSInteger)order
                      succesBlock:(SuccessBlock)successBlock
                           failue:(FailureBlock)failueBlock;

/**
 *  获取活动详情
 *  @param activityid    活动ID
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)GetActivityDetailWithActivityID:(NSInteger)activityid
                            succesBlock:(SuccessBlock)successBlock
                                 failue:(FailureBlock)failueBlock;

/**
 *  获取分类
 *  @param pageNo       页码
 *  @param pageSize     页数
 *  @param order        订单
 *  @param parentid     分类ID
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)GetCategoryListWithPageNo:(NSInteger)pageNo
                         PageSize:(NSInteger)pageSize
                            order:(NSInteger)order
                         parentid:(NSInteger)parentid
                      succesBlock:(SuccessBlock)successBlock
                           failue:(FailureBlock)failueBlock;


/**
 *  获取社区宣传图片
 *  @param setupid      ID
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)GetCommunityHeadImageWithSetupID:(NSInteger)setupid
                             succesBlock:(SuccessBlock)successBlock
                                  failue:(FailureBlock)failueBlock;

/**
 *  获取活动列表
 *  @param pageNo       页码
 *  @param pageSize     页数
 *  @param order        订单
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)GetCommunityModuleWithPageNo:(NSInteger)pageNo
                            PageSize:(NSInteger)pageSize
                               order:(NSInteger)order
                         succesBlock:(SuccessBlock)successBlock
                              failue:(FailureBlock)failueBlock;

/**
 *  获取话题列表
 *  @param pageNo       页码
 *  @param pageSize     页数
 *  @param topicid        订单
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)GetCommunityTopicListWithPageNo:(NSInteger)pageNo
                               PageSize:(NSInteger)pageSize
                                topicid:(NSInteger)topicid
                               moduleid:(NSInteger)moduleid
                            succesBlock:(SuccessBlock)successBlock
                                 failue:(FailureBlock)failueBlock;


/**
 *  评论
 *  @param topicid      ID
 *  @param comment      评论内容
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)SetCommunityTopicWithTopicID:(NSInteger)topicid
                             comment:(NSString *)comment
                         succesBlock:(SuccessBlock)successBlock
                              failue:(FailureBlock)failueBlock;

/**
 *  点赞
 *  @param topicid      ID
 *  @param like      评论内容
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)SetCommunityTopicWithTopicID:(NSInteger)topicid
                                like:(NSInteger )like
                         succesBlock:(SuccessBlock)successBlock
                              failue:(FailureBlock)failueBlock;

/**
 *  发布商品
 *  @param content      内容
 *  @param imgList      图片
 *  @param moduleid     ID
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)AddCommunityTopicWithContent:(NSString *)content
                             imgList:(NSArray *)imgList
                            moduleid:(NSInteger)moduleid
                         succesBlock:(SuccessBlock)successBlock
                              failue:(FailureBlock)failueBlock;


/**
 *  意见反馈
 *  @param content      内容
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)SubmitOpinion:(NSString *)content
          succesBlock:(SuccessBlock)successBlock
               failue:(FailureBlock)failueBlock;




/**
 *  用户协议
 *  @param setupid      ID
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)UserProtocolWithSetupID:(NSInteger)setupid
                    succesBlock:(SuccessBlock)successBlock
                         failue:(FailureBlock)failueBlock;


/**
 *  修改个人信息
 *
 *  @param params       params
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */

+(void)SetPersonalInfoWithParams:(NSDictionary *)params
                     succesBlock:(SuccessBlock)successBlock
                          failue:(FailureBlock)failueBlock;

/**
 *  获取个人信息
 *
 *  @param params       params
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */

+(void)GetPersonalInfoWithParams:(NSDictionary *)params
                     succesBlock:(SuccessBlock)successBlock
                          failue:(FailureBlock)failueBlock;

/**
 *  发布商品
 *
 *  @param params       params
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */

+(void)ReleaseProductWithParams:(NSDictionary *)params
                     succesBlock:(SuccessBlock)successBlock
                          failue:(FailureBlock)failueBlock;



/**
 *  关于啵呗
 *  @param setupid      ID
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)AboutBoobelWithSetupID:(NSInteger)setupid
                   succesBlock:(SuccessBlock)successBlock
                        failue:(FailureBlock)failueBlock;

/**
 *  获取养护列表
 *  @param pageNo       页码
 *  @param pageSize     页数
 *  @param order        订单
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)GetMaintainListWithPageNo:(NSInteger)pageNo
                        PageSize:(NSInteger)pageSize
                           order:(NSInteger)order
                     succesBlock:(SuccessBlock)successBlock
                          failue:(FailureBlock)failueBlock;

/**
 *  获取养护
 *  @param maintainid      ID
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)GetMaintainWithMaintainid:(NSInteger)maintainid
                      succesBlock:(SuccessBlock)successBlock
                           failue:(FailureBlock)failueBlock;


/**
 *  获取养护二级分类列表
 *  @param pageNo       页码
 *  @param pageSize     页数
 *  @param order        订单
 *  @param classifyid   分类ID
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)GetMaintainListWithPageNo:(NSInteger)pageNo
                         PageSize:(NSInteger)pageSize
                            order:(NSInteger)order
                       classifyid:(NSInteger)classifyid
                      succesBlock:(SuccessBlock)successBlock
                           failue:(FailureBlock)failueBlock;


/**
 *  中检鉴定
 *  @param setupid      ID
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)AppraiseWithSetupID:(NSInteger)setupid
                succesBlock:(SuccessBlock)successBlock
                     failue:(FailureBlock)failueBlock;


/**
 *  获取租赁列表
 *  @param pageNo       页码
 *  @param pageSize     页数
 *  @param order        订单
 *  @param status       状态
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)GetTenancyListWithPageNo:(NSInteger)pageNo
                        PageSize:(NSInteger)pageSize
                           order:(NSInteger)order
                          status:(NSInteger)status
                     succesBlock:(SuccessBlock)successBlock
                          failue:(FailureBlock)failueBlock;

/**
 *  产品详情
 *  @param rentID       ID
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)GetProductlWithRentID:(NSInteger)rentID
                   succesBlock:(SuccessBlock)successBlock
                        failue:(FailureBlock)failueBlock;


/**
 *  创建订单
 *
 *  @param params       params
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */

+(void)CreatOrderWithParams:(NSDictionary *)params
                   succesBlock:(SuccessBlock)successBlock
                        failue:(FailureBlock)failueBlock;

/**
 *  设置默认地址
 *  @param isDefault     BOOL
 *  @param receiverid    地址ID
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)SetPretermitAddressWithRentID:(NSInteger)isDefault
                           ReceiverID:(NSInteger)receiverid
                          succesBlock:(SuccessBlock)successBlock
                               failue:(FailureBlock)failueBlock;

/**
 *  支付
 *  @param channel        支付类型
 *  @param orderid     订单ID
 *  @param type        类型
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)PayWithChannel:(NSString *)channel
                orderID:(NSInteger)orderid
                  type:(NSInteger)type
        succesBlock:(SuccessBlock)successBlock
                               failue:(FailureBlock)failueBlock;


/**
 *  获取用户
 *  @param userID       ID
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)GetUserWithuserID:(NSInteger)userID
              succesBlock:(SuccessBlock)successBlock
                   failue:(FailureBlock)failueBlock;


/**
 *  获取首页轮播图
 *  @param setupid       ID
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)GetAdvertisesetupWithSetupID:(NSInteger)setupid
                         succesBlock:(SuccessBlock)successBlock
                              failue:(FailureBlock)failueBlock;

/**
 *  获取左侧轮播图
 *  @param setupid       ID
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)GetLeftSetupWithSetupID:(NSInteger)setupid
                    succesBlock:(SuccessBlock)successBlock
                        failue:(FailureBlock)failueBlock;

/**
 *  获取右上轮播图
 *  @param setupid       ID
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)GetRightUpSetupWithSetupID:(NSInteger)setupid
                       succesBlock:(SuccessBlock)successBlock
                            failue:(FailureBlock)failueBlock;
/**
 *  获取右下轮播图
 *  @param setupid       ID
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)GetRightDownSetupWithSetupID:(NSInteger)setupid
                         succesBlock:(SuccessBlock)successBlock
                              failue:(FailureBlock)failueBlock;

/**
 *  获取首页精选列表
 *  @param pageNo       页码
 *  @param pageSize     页数
 *  @param order        订单
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)GetHomeClassListWithPageNo:(NSInteger)pageNo
                          PageSize:(NSInteger)pageSize
                             order:(NSInteger)order
                       succesBlock:(SuccessBlock)successBlock
                            failue:(FailureBlock)failueBlock;

/**
 *  获取精选分类
 *  @param classid       ID
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)GetHomeClassWithSetupID:(NSInteger)classid
                    succesBlock:(SuccessBlock)successBlock
                         failue:(FailureBlock)failueBlock;

/**
 *  获取首页热门列表
 *  @param pageNo       页码
 *  @param pageSize     页数
 *  @param order        订单
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)GetHomeTopicListWithPageNo:(NSInteger)pageNo
                          PageSize:(NSInteger)pageSize
                             order:(NSInteger)order
                       succesBlock:(SuccessBlock)successBlock
                            failue:(FailureBlock)failueBlock;

/**
 *  获取话题
 *  @param topicid       ID
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)GetHomeTopicWithSetupID:(NSInteger)topicid
                    succesBlock:(SuccessBlock)successBlock
                         failue:(FailureBlock)failueBlock;


/**
 *  获取话题
 *  @param openid       ID
 *  @param nickname     昵称
 *  @param headimgurl   头像地址
 *  @param pf           类型
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)ThirdLoginWithOpenID:(NSString *)openid
                    nickname:(NSString *)nickname
                  headimgurl:(NSString *)headimgurl
                          pf:(NSInteger)pf
                    succesBlock:(SuccessBlock)successBlock
                         failue:(FailureBlock)failueBlock;

/**
 *  获取默认地址
 *  @param receiverid       ID
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)GetAddressWithReceiverid:(NSInteger)receiverid
                     succesBlock:(SuccessBlock)successBlock
                          failue:(FailureBlock)failueBlock;


/**
 *  获取问答列表
 *  @param pageNo       页码
 *  @param pageSize     页数
 *  @param order        订单
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)GetQuestionListWithPageNo:(NSInteger)pageNo
                         PageSize:(NSInteger)pageSize
                            order:(NSInteger)order
                      succesBlock:(SuccessBlock)successBlock
                           failue:(FailureBlock)failueBlock;

/**
 *  获取服务中心详情
 *  @param setupid       ID
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)GetServiceDetailWithSetupID:(NSInteger)setupid
                                url:(NSString *)url
                        succesBlock:(SuccessBlock)successBlock
                             failue:(FailureBlock)failueBlock;

/**
 *  添加关注
 *  @param userid       ID
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)AddFollowWithUserID:(NSInteger)userid
                succesBlock:(SuccessBlock)successBlock
                     failue:(FailureBlock)failueBlock;

/**
 *  关注列表
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)GetFollowListsuccesBlock:(SuccessBlock)successBlock
                          failue:(FailureBlock)failueBlock;

/**
 *  取消关注
 *  @param userid       ID
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)DeleteFollowWithUserID:(NSInteger)userid
                   succesBlock:(SuccessBlock)successBlock
                        failue:(FailureBlock)failueBlock;

/**
 *  收藏
 *  @param rentid       ID
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)AddKeepWithRentID:(NSInteger)rentid
              succesBlock:(SuccessBlock)successBlock
                   failue:(FailureBlock)failueBlock;


/**
 *  收藏列表
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)GetKeepListWithUrl:(NSString *)url
               succesBlock:(SuccessBlock)successBlock
                    failue:(FailureBlock)failueBlock;

/**
 *  取消关注
 *  @param rentid       ID
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)CancelKeepWithRentID:(NSInteger)rentid
                 succesBlock:(SuccessBlock)successBlock
                      failue:(FailureBlock)failueBlock;

/**
 *  取消关注
 *  @param maintainid   养护ID
 *  @param receiverid   地址ID
 *  @param price        价格
 *  @param message      留言
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)CreateMaintainWithMaintainid:(NSInteger)maintainid
                          receiverid:(NSInteger)receiverid
                               price:(NSInteger)price
                             message:(NSString *)message
                 succesBlock:(SuccessBlock)successBlock
                      failue:(FailureBlock)failueBlock;

/**
 *  身份认证
 *
 *  @param params       params
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+(void)VerifyIdetityWithParams:(NSDictionary *)params
                   succesBlock:(SuccessBlock)successBlock
                        failue:(FailureBlock)failueBlock;

/**
 *  删除租赁订单
 *  @param rentid       ID
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)DeleteRentOrderWithRentID:(NSInteger)rentid
                      succesBlock:(SuccessBlock)successBlock
                           failue:(FailureBlock)failueBlock;

/**
 *  下架租赁订单
 *  @param rentid       ID
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)UnderCarriageOrderWithRentID:(NSInteger)rentid
                      succesBlock:(SuccessBlock)successBlock
                           failue:(FailureBlock)failueBlock;

/**
 *  确认回收订单
 *  @param rentid       ID
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)RecoverOrderWithRentID:(NSInteger)rentid
                     oddNumber:(NSString *)oddNumber
                   succesBlock:(SuccessBlock)successBlock
                        failue:(FailureBlock)failueBlock;


/**
 *  获取我的租赁列表
 *  @param pageNo       页码
 *  @param pageSize     页数
 *  @param order        订单
 *  @param status       状态
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)GetRentorderListWithPageNo:(NSInteger)pageNo
                          PageSize:(NSInteger)pageSize
                             order:(NSInteger)order
                            status:(NSInteger)status
                       succesBlock:(SuccessBlock)successBlock
                            failue:(FailureBlock)failueBlock;

/**
 *  获取我的养护列表
 *  @param pageNo       页码
 *  @param pageSize     页数
 *  @param order        订单
 *  @param status       状态
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)GetMyMaintainListWithPageNo:(NSInteger)pageNo
                           PageSize:(NSInteger)pageSize
                              order:(NSInteger)order
                             status:(NSInteger)status
                        succesBlock:(SuccessBlock)successBlock
                             failue:(FailureBlock)failueBlock;

/**
 *  确认养护订单
 *  @param orderid      ID
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)ConfirmMyMaintainOrderWithOrderID:(NSInteger)orderid
                              succesBlock:(SuccessBlock)successBlock
                                   failue:(FailureBlock)failueBlock;

/**
 *  获取我的鉴定列表
 *  @param pageNo       页码
 *  @param pageSize     页数
 *  @param order        订单
 *  @param status       状态
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)GetMyAppraiseListWithPageNo:(NSInteger)pageNo
                           PageSize:(NSInteger)pageSize
                              order:(NSInteger)order
                             status:(NSInteger)status
                        succesBlock:(SuccessBlock)successBlock
                             failue:(FailureBlock)failueBlock;

/**
 *  创建鉴定订单
 *  @param receiverid   地址id
 *  @param brandid      品牌id
 *  @param genreid      类别id
 *  @param total        价格
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)CreateAppraiseOrderWithReceiverid:(NSInteger)receiverid
                                  brandid:(NSInteger)brandid
                                  genreid:(NSInteger)genreid
                                    total:(NSInteger)total
                              succesBlock:(SuccessBlock)successBlock
                                   failue:(FailureBlock)failueBlock;

/**
 *  获取啵呗秀列表
 *  @param setupid       ID
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)GetShowSetupListWithSetupID:(NSInteger)setupid
                        succesBlock:(SuccessBlock)successBlock
                             failue:(FailureBlock)failueBlock;

/**
 *  获取来换包列表
 *  @param setupid       ID
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)GetSwapSetupListWithSetupID:(NSInteger)setupid
                        succesBlock:(SuccessBlock)successBlock
                             failue:(FailureBlock)failueBlock;



/**
 *  确认收货
 *  @param rentid       ID
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)ConfirmOrderWithRentID:(NSInteger)rentid
                   succesBlock:(SuccessBlock)successBlock
                        failue:(FailureBlock)failueBlock;

/**
 *  退回
 *  @param rentid       ID
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)ConfirmOrderWithRentID:(NSInteger)rentid
                 backOddNumber:(NSString *)backOddNumber
                   succesBlock:(SuccessBlock)successBlock
                        failue:(FailureBlock)failueBlock;


/**
 *  发布商品
 *  @param content      内容
 *  @param imgList      图片
 *  @param orderid     ID
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)AddRentCommentWithContent:(NSString *)content
                          imgList:(NSArray *)imgList
                          orderid:(NSInteger)orderid
                      succesBlock:(SuccessBlock)successBlock
                           failue:(FailureBlock)failueBlock;

/**
 *  融云聊天
 *  @param userid       ID
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)ChatWithUserID:(NSInteger)userid
           succesBlock:(SuccessBlock)successBlock
                failue:(FailureBlock)failueBlock;

/**
 *  获取热门品牌
 *  @param pageNo       页码
 *  @param pageSize     页数
 *  @param order        订单
 *  @param categoryid   类别id
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)GetCategoryHotListWithPageNo:(NSInteger)pageNo
                            PageSize:(NSInteger)pageSize
                               order:(NSInteger)order
                          categoryid:(NSInteger)categoryid
                         succesBlock:(SuccessBlock)successBlock
                              failue:(FailureBlock)failueBlock;

/**
 *  获取租赁列表
 *  @param pageNo       页码
 *  @param pageSize     页数
 *  @param order        订单
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)GetRentListWithPageNo:(NSInteger)pageNo
                     PageSize:(NSInteger)pageSize
                        order:(NSInteger)order
                      brandid:(NSInteger)brandid
                         type:(NSInteger)type
                  succesBlock:(SuccessBlock)successBlock
                       failue:(FailureBlock)failueBlock;
/**
 *  获取租赁列表
 *  @param pageNo       页码
 *  @param pageSize     页数
 *  @param order        订单
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)GetRentList1WithPageNo:(NSInteger)pageNo
                      PageSize:(NSInteger)pageSize
                         order:(NSInteger)order
                    categoryid:(NSInteger)categoryid
                          type:(NSInteger)type
                   succesBlock:(SuccessBlock)successBlock
                        failue:(FailureBlock)failueBlock;

/**
 *  充值
 *  @param amount       金额
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)SetRechargeorderWithAmount:(NSInteger)amount
                      succesBlock:(SuccessBlock)successBlock
                           failue:(FailureBlock)failueBlock;


/**
 *  用户协议
 *  @param setupid      ID
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)RewardSetupWithSetupID:(NSInteger)setupid
                   succesBlock:(SuccessBlock)successBlock
                        failue:(FailureBlock)failueBlock;


/**
 *  绑定手机号码
 *
 *  @param params       params
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */

+(void)SetMobileWithParams:(NSDictionary *)params
               succesBlock:(SuccessBlock)successBlock
                    failue:(FailureBlock)failueBlock;

/**
 *  确认鉴定订单
 *  @param orderid      ID
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)ConfirmMyAppraiseWithOrderID:(NSInteger)orderid
                         succesBlock:(SuccessBlock)successBlock
                              failue:(FailureBlock)failueBlock;


/**
 *  养护收藏
 *  @param maintainid       ID
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)AddKeepWithMaintainid:(NSInteger)maintainid
                  succesBlock:(SuccessBlock)successBlock
                       failue:(FailureBlock)failueBlock;

/**
 *  提现
 *  @param amount       提现金额
 *  @param cardNumber   卡号
 *  @param bank         银行
 *  @param branch       支行
 *  @param name         姓名
 *  @param code         验证码
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)WithdrawalsWithAmount:(NSInteger)amount
                   cardNumber:(NSString *)cardNumber
                         bank:(NSString *)bank
                       branch:(NSString *)branch
                         name:(NSString *)name
                         code:(NSString *)code
                  succesBlock:(SuccessBlock)successBlock
                       failue:(FailureBlock)failueBlock;


/**
 *  获取积分列表
 *  @param pageNo       页码
 *  @param pageSize     页数
 *  @param order        订单
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)GetRecordListWithPageNo:(NSInteger)pageNo
                      PageSize:(NSInteger)pageSize
                         order:(NSInteger)order
                   succesBlock:(SuccessBlock)successBlock
                        failue:(FailureBlock)failueBlock;

/**
 *  获取评论列表
 *  @param pageNo       页码
 *  @param pageSize     页数
 *  @param order        订单
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)GetCommentListWithPageNo:(NSInteger)pageNo
                        PageSize:(NSInteger)pageSize
                           order:(NSInteger)order
                          rentid:(NSInteger)rentid
                     succesBlock:(SuccessBlock)successBlock
                          failue:(FailureBlock)failueBlock;

/**
 *  获取搜索列表
 *  @param pageNo       页码
 *  @param pageSize     页数
 *  @param order        订单
 *  @param word         关键词
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)GetSearchListWithPageNo:(NSInteger)pageNo
                       PageSize:(NSInteger)pageSize
                          order:(NSInteger)order
                           word:(NSString *)word
                    succesBlock:(SuccessBlock)successBlock
                         failue:(FailureBlock)failueBlock;

/**
 *  获取钱包记录列表
 *  @param pageNo       页码
 *  @param pageSize     页数
 *  @param order        订单
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */

+ (void)GetWalletListWithPageNo:(NSInteger)pageNo
                       PageSize:(NSInteger)pageSize
                          order:(NSInteger)order
                    succesBlock:(SuccessBlock)successBlock
                         failue:(FailureBlock)failueBlock;



/**
 *  发布寄卖
 *
 *  @param params       params
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+(void)SetPurchaseWithParams:(NSDictionary *)params
                 succesBlock:(SuccessBlock)successBlock
                      failue:(FailureBlock)failueBlock;


/**
 *  获取寄卖列表
 *  @param pageNo       页码
 *  @param pageSize     页数
 *  @param order        订单
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */

+ (void)GetPurchaseListWithPageNo:(NSInteger)pageNo
                         PageSize:(NSInteger)pageSize
                            order:(NSInteger)order
                      succesBlock:(SuccessBlock)successBlock
                           failue:(FailureBlock)failueBlock;

/**
 *  获取我的买卖列表
 *  @param pageNo       页码
 *  @param pageSize     页数
 *  @param order        订单
 *  @param status       状态
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)GetPutchaseOrderListWithPageNo:(NSInteger)pageNo
                              PageSize:(NSInteger)pageSize
                                 order:(NSInteger)order
                                status:(NSInteger)status
                           succesBlock:(SuccessBlock)successBlock
                                failue:(FailureBlock)failueBlock;

/**
 *  获取寄卖列表
 *  @param pageNo       页码
 *  @param pageSize     页数
 *  @param order        订单
 *  @param status       状态
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)GetPurchaseListWithPageNo:(NSInteger)pageNo
                         PageSize:(NSInteger)pageSize
                            order:(NSInteger)order
                           status:(NSInteger)status
                      succesBlock:(SuccessBlock)successBlock
                           failue:(FailureBlock)failueBlock;
/**
 *  删除寄卖订单
 *  @param orderid       ID
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)DeletePurchaseOrderWithOrderID:(NSInteger)orderid
                           succesBlock:(SuccessBlock)successBlock
                                failue:(FailureBlock)failueBlock;

/**
 *  确认收货
 *  @param rentid       ID
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)ConfirmPurchaseOrderWithRentID:(NSInteger)rentid
                           succesBlock:(SuccessBlock)successBlock
                                failue:(FailureBlock)failueBlock;

/**
 *  获取寄卖列表
 *  @param pageNo       页码
 *  @param pageSize     页数
 *  @param order        订单
 *  @param status       状态
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)GetPurchaseList1WithPageNo:(NSInteger)pageNo
                          PageSize:(NSInteger)pageSize
                             order:(NSInteger)order
                            status:(NSInteger)status
                       succesBlock:(SuccessBlock)successBlock
                            failue:(FailureBlock)failueBlock;
/**
 *  获取寄租列表
 *  @param pageNo       页码
 *  @param pageSize     页数
 *  @param order        订单
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)GetRentList1WithPageNo:(NSInteger)pageNo
                      PageSize:(NSInteger)pageSize
                         order:(NSInteger)order
                   succesBlock:(SuccessBlock)successBlock
                        failue:(FailureBlock)failueBlock;

/**
 *  产品详情
 *  @param purchaseid       ID
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)GetProductlWithPurchaseid:(NSInteger)purchaseid
                      succesBlock:(SuccessBlock)successBlock
                           failue:(FailureBlock)failueBlock;

+ (void)SetPurchaseWithPurchaseidList:(NSArray *)purchaseidList
                           receiverid:(NSInteger)receiverid
                          succesBlock:(SuccessBlock)successBlock
                               failue:(FailureBlock)failueBlock;

/**
 *  寄卖协议
 *  @param setupid      ID
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)BussinessProtocolWithSetupID:(NSInteger)setupid
                         succesBlock:(SuccessBlock)successBlock
                              failue:(FailureBlock)failueBlock;

/**
 *  创建购买订单
 *
 *  @param params       params
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */

+(void)CreatPurchaseOrderWithParams:(NSDictionary *)params
                        succesBlock:(SuccessBlock)successBlock
                             failue:(FailureBlock)failueBlock;

/**
 *  积分支付
 *  @param orderid      ID
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)PayWithWalletWithOrderid:(NSInteger)orderid
                            type:(NSInteger)type
                     succesBlock:(SuccessBlock)successBlock
                          failue:(FailureBlock)failueBlock;

/**
 *  活动报名
 *  @param activityid      ID
 *  @param nickname      昵称
 *  @param mobile        手机
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)EnterActivityWithActivityid:(NSInteger)activityid
                           nickname:(NSString *)nickname
                             mobile:(NSString *)mobile
                        succesBlock:(SuccessBlock)successBlock
                             failue:(FailureBlock)failueBlock;

/**
 *  违约金
 *  @param setupid      ID
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)DamagesMoneyWithSetupID:(NSInteger)setupid
                    succesBlock:(SuccessBlock)successBlock
                         failue:(FailureBlock)failueBlock;

/**
 *  租金说明
 *  @param setupid      ID
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)ExplainSetupWithSetupID:(NSInteger)setupid
                    succesBlock:(SuccessBlock)successBlock
                         failue:(FailureBlock)failueBlock;

/**
 *  获取寄卖列表
 *  @param pageNo       页码
 *  @param pageSize     页数
 *  @param order        订单
 *  @param status       状态
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)GetPurchaseList1WithPageNo:(NSInteger)pageNo
                          PageSize:(NSInteger)pageSize
                             order:(NSInteger)order
                            status:(NSInteger)status
                           brandid:(NSInteger)brandid
                              type:(NSInteger)type
                       succesBlock:(SuccessBlock)successBlock
                            failue:(FailureBlock)failueBlock;


/**
 *  获取寄卖列表
 *  @param pageNo       页码
 *  @param pageSize     页数
 *  @param order        订单
 *  @param status       状态
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)GetPurchaseList1WithPageNo:(NSInteger)pageNo
                          PageSize:(NSInteger)pageSize
                             order:(NSInteger)order
                            status:(NSInteger)status
                        categoryid:(NSInteger)categoryid
                              type:(NSInteger)type
                       succesBlock:(SuccessBlock)successBlock
                            failue:(FailureBlock)failueBlock;

/**
 *  获取搜索列表
 *  @param pageNo       页码
 *  @param pageSize     页数
 *  @param order        订单
 *  @param word         关键词
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)GetBussinessSearchListWithPageNo:(NSInteger)pageNo
                                PageSize:(NSInteger)pageSize
                                   order:(NSInteger)order
                                    word:(NSString *)word
                             succesBlock:(SuccessBlock)successBlock
                                  failue:(FailureBlock)failueBlock;

/**
 *  删除租赁订单
 *  @param rentid       ID
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)DeleteRentOrder1WithRentID:(NSInteger)rentid
                       succesBlock:(SuccessBlock)successBlock
                            failue:(FailureBlock)failueBlock;

/**
 *  寄卖收藏
 *  @param purchaseid       ID
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)AddKeepWithPurchaseID:(NSInteger)purchaseid
                  succesBlock:(SuccessBlock)successBlock
                       failue:(FailureBlock)failueBlock;

/**
 *  取消关注
 *  @param purchaseid       ID
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)CancelKeepWithPurchaseID:(NSInteger)purchaseid
                     succesBlock:(SuccessBlock)successBlock
                          failue:(FailureBlock)failueBlock;

/**
 *  取消关注
 *  @param maintainid       ID
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)CancelKeepWithMaintainID:(NSInteger)maintainid
                     succesBlock:(SuccessBlock)successBlock
                          failue:(FailureBlock)failueBlock;




/**
 *  删除鉴定订单
 *  @param orderid      ID
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)DelMyAppraiseWithOrderID:(NSInteger)orderid
                     succesBlock:(SuccessBlock)successBlock
                          failue:(FailureBlock)failueBlock;


/**
 *  租赁订单详情
 *  @param orderid      ID
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)AppraiseOrderDetailWithOrderID:(NSInteger)orderid
                           succesBlock:(SuccessBlock)successBlock
                                failue:(FailureBlock)failueBlock;

/**
 *  寄卖详情
 *  @param orderid      ID
 *  @param successBlock 成功回调
 *  @param failueBlock  失败回调
 */
+ (void)BusinessOrderDetailWithOrderID:(NSInteger)orderid
                           succesBlock:(SuccessBlock)successBlock
                                failue:(FailureBlock)failueBlock;


@end
