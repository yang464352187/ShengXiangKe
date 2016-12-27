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


@end
