
//
//  BrandDetailVC1.m
//  SXK
//
//  Created by 杨伟康 on 2017/4/5.
//  Copyright © 2017年 ywk. All rights reserved.
//

#import "BrandDetailVC1.h"
#import "StringAttributeHelper.h"
#import "BrandDetailCell1.h"
#import "BrandDetailCell2.h"
#import "BrandDetailModel.h"
#import "ProductDesCell.h"
#import "ProductCommentCell.h"
#import "ProductParamCell.h"
#import "UserIdModel.h"
#import "BrandStoryCell.h"
#import "YXCustomActionSheet.h"
#import <UMSocialCore/UMSocialCore.h>
#import "BrandDetailCell3.h"
#import "RentCommentModel.h"
#import "DFFaceManager.h"
#import "MLLabel+Size.h"
#import "NSString+MLExpression.h"
#import "BrandDetailCell4.h"
#import "MyBussinesModel.h"
#define Margin 15

#define Padding 10

#define UserAvatarSize 40

#define  BodyMaxWidth [UIScreen mainScreen].bounds.size.width - UserAvatarSize - 3*Margin

#define TextLineHeight 1.2f
@interface BrandDetailVC1 ()<SDCycleScrollViewDelegate,YXCustomActionSheetDelegate>
@property (strong, nonatomic) UIView            *headView;
@property (strong, nonatomic) SDCycleScrollView *cycleScrollView;// 头顶滑动视图
@property (strong, nonatomic) UILabel *indexLab;
@property (strong, nonatomic) UILabel *titleLab;
@property (strong, nonatomic) UILabel *content;
@property (strong, nonatomic) UILabel *minRentPrice;
@property (strong, nonatomic) UILabel *markPrice;
@property (strong, nonatomic) NSDictionary *dataDic;
@property (strong, nonatomic) NSArray *titleArr;
@property (strong, nonatomic) NSArray *desArr;
@property (assign, nonatomic) CGFloat cellHeight;
@property (strong, nonatomic) BrandDetailModel *model;
@property (strong, nonatomic) UserIdModel *useridModel;
@property (nonatomic, assign) CGFloat cellHeight1;
@property (strong, nonatomic) NSArray *dataArr;
@property (assign, nonatomic) NSInteger CommentTotal;
@property (strong, nonatomic) NSArray *dataArr1;
@property (assign, nonatomic) BOOL isKeep;
@property (strong, nonatomic) UIButton *btn;

@end

@implementation BrandDetailVC1

-(void)loadingRequest
{
    _weekSelf(weakSelf)
    [BaseRequest GetProductlWithPurchaseid:[self.myDict[@"purchaseid"] integerValue] succesBlock:^(id data) {
        BrandDetailModel *model = [BrandDetailModel modelFromDictionary:data[@"purchase"]];
        weakSelf.dataDic = [model transformToDictionary];
        weakSelf.model = model;
        self.cellHeight = [UILabel getHeightByWidth:SCREEN_WIDTH - 30 title:model.description1 font:SYSTEMFONT(13)];
        
        //        NSLog(@"=========%@=======",describe(model));
        
        [weakSelf initData];
        NSMutableArray *imgArr = [[NSMutableArray alloc] init];
        for (NSString *img in weakSelf.model.imgList) {
            NSString *image = [NSString stringWithFormat:@"%@%@",APP_BASEIMG,img];
            [imgArr addObject:image];
        }
        weakSelf.cycleScrollView.localizationImageNamesGroup = imgArr;
//        NSLog(@"+++++%@++++",describe(weakSelf.model));
        
        [weakSelf.tableView reloadData];

        
    } failue:^(id data, NSError *error) {
        
    }];
    
    
    
    
}

-(void)initData
{
    NSArray *array = [[NSArray alloc] initWithObjects:@"99成新（未使用）",@"98成新",@"95成新",@"9成新",@"85成新",@"8成新", nil];
    if (self.dataDic.count > 0) {
        //        NSLog(@"-----------%@--------",describe(self.dataDic));
        self.titleLab.text = self.dataDic[@"name"];
        self.content.text = [NSString stringWithFormat:@"%@",array[[self.dataDic[@"condition"] integerValue] - 1]];
        CGFloat rentPrice = [self.dataDic[@"marketPrice"] floatValue] / 100;
        NSString *minRent = [NSString stringWithFormat:@"市场价:¥%.2lf/天",rentPrice];
        NSString *price = [NSString stringWithFormat:@"¥%.2lf",rentPrice];
        CGFloat width = [UILabel getWidthWithTitle:@"市场价:/天" font:SYSTEMFONT(13)];
        CGFloat width1 = [UILabel getWidthWithTitle:price font:SYSTEMFONT(18)];
        FontAttribute *fullFont = [FontAttribute new];
        fullFont.font           = SYSTEMFONT(18);
        fullFont.effectRange    = NSMakeRange(4,price.length);
        ForegroundColorAttribute *fullColor = [ForegroundColorAttribute new];
        fullColor.color                     = APP_COLOR_GREEN;
        fullColor.effectRange               = NSMakeRange(4, minRent.length -4);
        self.minRentPrice.attributedText = [minRent mutableAttributedStringWithStringAttributes:@[fullFont,fullColor]];
        CGFloat markPrice1 = [self.dataDic[@"sellingPrice"] floatValue]/100;
        self.markPrice.text = [NSString stringWithFormat:@"售价:¥%.2lf",markPrice1];
        
        [self.minRentPrice mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.headView.mas_left).offset(15);
            make.top.equalTo(self.content.mas_bottom).offset(10);
            make.size.mas_equalTo(CGSizeMake(width+width1, 15));
        }];
        
        [self.markPrice mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.minRentPrice.mas_right).offset(5);
            make.centerY.equalTo(self.minRentPrice);
            make.right.equalTo(self.headView.mas_right).offset(0);
            make.height.mas_equalTo(15);
        }];
        
        
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadingRequest];
    //    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"产品详情";
    self.titleArr = [[NSArray alloc] initWithObjects:@"商品描述",@"商品参数",@"品牌故事", nil];
    self.desArr = [[NSArray alloc] initWithObjects:@"Description",@"Production infomation",@"Brand story" ,nil];
    UIImage *image = [UIImage imageNamed:@"分享11"];
    [self setRightBarButtonWith:image selector:@selector(barButtonAction)];
    
    [self initUI];
    self.isUseNoDataView = YES;
    [self.noDataView setTitle:@"暂无寄卖商品~"];

    
}

-(void)barButtonAction
{
    YXCustomActionSheet *cusSheet = [[YXCustomActionSheet alloc] init];
    cusSheet.delegate = self;
    NSArray *contentArray = @[@{@"name":@"微信",@"icon":@"微信-1"},
                              @{@"name":@"朋友圈 ",@"icon":@"朋友圈"},
                              @{@"name":@"QQ ",@"icon":@"QQ-1"},
                              @{@"name":@"新浪",@"icon":@"xinlang"}
                              ];
    
    [cusSheet showInView:[UIApplication sharedApplication].keyWindow contentArray:contentArray];
    
}

#pragma mark - YXCustomActionSheetDelegate

- (void) customActionSheetButtonClick:(YXActionSheetButton *)btn
{
    
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建网页内容对象
    NSString* thumbURL = [NSString stringWithFormat:@"%@%@",APP_BASEIMG,self.model.imgList[0]];
    
    UIImage *cachedImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:thumbURL];
    
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:self.model.name descr:self.model.keyword thumImage:cachedImage];
    
    //设置网页地址
    shareObject.webpageUrl = [NSString stringWithFormat:@"http://shexiangke.jcq.tbapps.cn/wechat/userpage/getrent/rentid/%@",self.model.rentid];
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    switch (btn.tag) {
        case 0:{
            
            //调用分享接口
            [[UMSocialManager defaultManager] shareToPlatform:UMSocialPlatformType_WechatSession messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
                if (error) {
                    UMSocialLogInfo(@"************Share fail with error %@*********",error);
                }else{
                    if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                        UMSocialShareResponse *resp = data;
                        //分享结果消息
                        UMSocialLogInfo(@"response message is %@",resp.message);
                        //第三方原始返回的数据
                        UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                        
                    }else{
                        UMSocialLogInfo(@"response data is %@",data);
                    }
                }
                //                [self alertWithError:error];
            }];
            
        }break;
            
        case 1:{
            
            //调用分享接口
            [[UMSocialManager defaultManager] shareToPlatform:UMSocialPlatformType_WechatTimeLine messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
                if (error) {
                    UMSocialLogInfo(@"************Share fail with error %@*********",error);
                }else{
                    if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                        UMSocialShareResponse *resp = data;
                        //分享结果消息
                        UMSocialLogInfo(@"response message is %@",resp.message);
                        //第三方原始返回的数据
                        UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                        
                    }else{
                        UMSocialLogInfo(@"response data is %@",data);
                    }
                }
                //                [self alertWithError:error];
            }];
            
        }break;
            
        case 2:{
            
            //调用分享接口
            [[UMSocialManager defaultManager] shareToPlatform:UMSocialPlatformType_QQ messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
                if (error) {
                    UMSocialLogInfo(@"************Share fail with error %@*********",error);
                }else{
                    if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                        UMSocialShareResponse *resp = data;
                        //分享结果消息
                        UMSocialLogInfo(@"response message is %@",resp.message);
                        //第三方原始返回的数据
                        UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                        
                    }else{
                        UMSocialLogInfo(@"response data is %@",data);
                    }
                }
                //                [self alertWithError:error];
            }];
            
        }break;
            
        case 3:{
            
            //调用分享接口
            [[UMSocialManager defaultManager] shareToPlatform:UMSocialPlatformType_Sina messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
                if (error) {
                    UMSocialLogInfo(@"************Share fail with error %@*********",error);
                }else{
                    if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                        UMSocialShareResponse *resp = data;
                        //分享结果消息
                        UMSocialLogInfo(@"response message is %@",resp.message);
                        //第三方原始返回的数据
                        UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                        
                    }else{
                        UMSocialLogInfo(@"response data is %@",data);
                    }
                }
                //                [self alertWithError:error];
            }];
            
        }break;
            
            
        default:
            break;
    }
    
    NSLog(@"第%li个按钮被点击了",(long)btn.tag);
}


-(void)initUI
{
    [self.view addSubview:self.tableView];
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor whiteColor];
    UIButton *certainBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [certainBtn setTitle:@"立即购买" forState:UIControlStateNormal];
    certainBtn.backgroundColor = APP_COLOR_GREEN;
    [certainBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    certainBtn.titleLabel.font = SYSTEMFONT(14);
    certainBtn.frame = VIEWFRAME(15, 20, CommonWidth(335), 40);
    [certainBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    ViewRadius(certainBtn, certainBtn.frame.size.height/2);
    
    [view addSubview:certainBtn];
    [self.view addSubview:view];
    
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.bottom.equalTo(self.view.mas_bottom).offset(0);
        make.height.mas_equalTo(80);
    }];
    
    
    
}
#pragma mark -- UITabelViewDelegate And DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //    MaintainCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MaintainCell"];
    //    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.section == 0) {
        BrandDetailCell1 *cell = [tableView dequeueReusableCellWithIdentifier:@"BrandDetailCell1"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    if (indexPath.section == 2) {
        ProductDesCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProductDesCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell fillWithContent:self.dataDic[@"description"]];
        return cell;
    }
    if (indexPath.section == 3) {
        ProductParamCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProductParamCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setModel:self.model];
        return cell;
    }
    if (indexPath.section == 4) {
        BrandStoryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BrandStoryCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setModel:self.model];
        return cell;
    }
//    if (indexPath.section == 2) {
//        BrandDetailCell3 *cell = [tableView dequeueReusableCellWithIdentifier:@"BrandDetailCell3"];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        cell.rentid = self.myDict[@"rentid"];
//        //        [cell setModel:self.model];
//        [cell setWithArray:self.dataArr];
//        return cell;
//    }
    
    BrandDetailCell4 *cell = [tableView dequeueReusableCellWithIdentifier:@"BrandDetailCell4"];
    [cell setModel:self.model];
    cell.vc = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        if (SCREEN_WIDTH <= 320) {
            return 150;
        }
        if (SCREEN_WIDTH > 750) {
            return 210;
        }
        return 180;
        
    }
    
    if (indexPath.section == 2) {
        return self.cellHeight+30;
    }
    if (indexPath.section == 3) {
        return 170;
    }
    if (indexPath.section == 4) {
        return 270;
    }
//    if (indexPath.section == 2) {
//        return self.cellHeight1;
//    }
    
    return 75;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0 || section == 1) {
        return 15;
    }
    return 50;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return 0.000001;
    }
    return 15;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = APP_COLOR_GRAY_Header;
    return view;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 66)];
    view.backgroundColor =  [UIColor whiteColor];
    
    if (section == 0 || section ==1) {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = APP_COLOR_GRAY_Header;
        return view;
        
    }
    NSString *title, *des, *des1;
    switch (section) {
//        case 2:{
//            title = self.titleArr[0];
//            des1 = self.desArr[0];
//            
//            UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
//            [button setTitle:@"更多>" forState:UIControlStateNormal];
//            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//            button.titleLabel.font = SYSTEMFONT(13);
//            [button addTarget:self action:@selector(sendAction:) forControlEvents:UIControlEventTouchUpInside];
//            [view addSubview:button];
//            
//            [button mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.centerY.equalTo(view);
//                make.right.equalTo(view.mas_right).offset(5);
//                make.size.mas_equalTo(CGSizeMake(80, 20));
//            }];
//            
//            break;
//        }
        case 2:{
            title = self.titleArr[0];
            des = self.desArr[0];
            
            break;
        }
        case 3:{
            title = self.titleArr[1];
            des = self.desArr[1];
            
            break;
        }
        case 4:{
            title = self.titleArr[2];
            des = self.desArr[2];
            
            break;
        }
            
        default:
            break;
    }
    
//    
//    if (section == 2) {
//        des = [NSString stringWithFormat:@"%@(%ld)",des1,self.CommentTotal];
//    }
    
    
    UILabel *title2 = [UILabel createLabelWithFrame:CommonVIEWFRAME(18, 13.5, 50, 12)
                                            andText:title
                                       andTextColor:[UIColor blackColor]
                                         andBgColor:[UIColor clearColor]
                                            andFont:SYSTEMFONT(13)
                                   andTextAlignment:NSTextAlignmentLeft];
    title2.adjustsFontSizeToFitWidth =YES;
    
    UIView * line =[[UIView alloc] initWithFrame:CommonVIEWFRAME(77, 13.5, 0.5, 12)];
    line.backgroundColor = [UIColor colorWithHexColorString:@"a0a0a0"];
    
    UILabel *title1 = [UILabel createLabelWithFrame:CommonVIEWFRAME(86, 8.5, 150, 22)
                                            andText:des
                                       andTextColor:[UIColor colorWithHexColorString:@"a1a1a1"]                                                andBgColor:[UIColor clearColor]
                                            andFont:SYSTEMFONT(12)
                                   andTextAlignment:NSTextAlignmentLeft];
    title1.adjustsFontSizeToFitWidth =YES;
    
    UIView * underLine =[[UIView alloc] initWithFrame:CommonVIEWFRAME(15, 74.5, SCREEN_WIDTH - 30, 0.5)];
    underLine.backgroundColor = [UIColor colorWithHexColorString:@"a0a0a0"];
    
    
    [view addSubview:title2];
    [view addSubview:line];
    [view addSubview:title1];
    [view addSubview:underLine];
    
    [title2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(view);
        make.left.equalTo(view.mas_left).offset(18);
        make.size.mas_equalTo(CGSizeMake(50, 12));
    }];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(view);
        make.left.equalTo(title2.mas_right).offset(9);
        make.size.mas_equalTo(CGSizeMake(0.5, 12));
    }];
    
    [title1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(view);
        make.left.equalTo(line.mas_right).offset(9);
        make.size.mas_equalTo(CGSizeMake(150, 22));
    }];
    
    [underLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(view.mas_bottom).offset(-0.5);
        make.left.equalTo(view.mas_left).offset(15);
        make.right.equalTo(view.mas_right).offset(-15);
        make.height.mas_equalTo(0.5);
    }];
    
    
    return view;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


#pragma mark -- getters and setters


- (UITableView *)tableView{
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:VIEWFRAME(0, 0, SCREEN_WIDTH, SCREEN_HIGHT-64-80) style:UITableViewStyleGrouped];
        _tableView.dataSource      = self;
        _tableView.delegate        = self;
        [_tableView registerClass:[BrandDetailCell1 class] forCellReuseIdentifier:@"BrandDetailCell1"];
        [_tableView registerClass:[BrandDetailCell2 class] forCellReuseIdentifier:@"BrandDetailCell2"];
        [_tableView registerClass:[BrandDetailCell3 class] forCellReuseIdentifier:@"BrandDetailCell3"];
        [_tableView registerClass:[BrandDetailCell4 class] forCellReuseIdentifier:@"BrandDetailCell4"];
        [_tableView registerClass:[ProductDesCell class] forCellReuseIdentifier:@"ProductDesCell"];
        [_tableView registerClass:[ProductParamCell class] forCellReuseIdentifier:@"ProductParamCell"];
        [_tableView registerClass:[BrandStoryCell class] forCellReuseIdentifier:@"BrandStoryCell"];
        
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.backgroundColor = APP_COLOR_BASE_BACKGROUND;
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.tableHeaderView = self.headView;
        _tableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
        _tableView.sectionHeaderHeight = 0.0;
        _tableView.sectionFooterHeight = 0.0;
        //        _tableView.header = [MJChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshHeaderAction)];
        //        _tableView.footer = [MJChiBaoZiFooter footerWithRefreshingTarget:self refreshingAction:@selector(refreshFooterAction)];
    }
    return _tableView;
}

- (UIView *)headView{
    if (!_headView) {
        _headView = [[UIView alloc] initWithFrame:VIEWFRAME(0, 0, SCREEN_WIDTH, 274.0000/667*SCREEN_HIGHT+100)];
        _headView.backgroundColor = [UIColor whiteColor];
        
        self.indexLab = [UILabel createLabelWithFrame:CommonVIEWFRAME(0,115.5 , 105, 12)
                                              andText:@"1/9"
                                         andTextColor:[UIColor colorWithHexColorString:@"2c2c2c"]
                                           andBgColor:[UIColor whiteColor]
                                              andFont:SYSTEMFONT(12)
                                     andTextAlignment:NSTextAlignmentCenter];
        self.indexLab.alpha = 0.6;
        
        UILabel *title = [UILabel createLabelWithFrame:CommonVIEWFRAME(0,115.5 , 105, 12)
                                               andText:@""
                                          andTextColor:[UIColor blackColor]
                                            andBgColor:[UIColor whiteColor]
                                               andFont:SYSTEMFONT(14)
                                      andTextAlignment:NSTextAlignmentLeft];
        self.titleLab = title;
        
        
        UILabel *content = [UILabel createLabelWithFrame:CommonVIEWFRAME(0,115.5 , 105, 12)
                                                 andText:@""
                                            andTextColor:APP_COLOR_GRAY_Font
                                              andBgColor:[UIColor whiteColor]
                                                 andFont:SYSTEMFONT(13)
                                        andTextAlignment:NSTextAlignmentLeft];
        self.content = content;
        
        UILabel *minPrice = [UILabel createLabelWithFrame:CommonVIEWFRAME(0,200 , 0, 0)
                                                  andText:@""
                                             andTextColor:[UIColor blackColor]
                                               andBgColor:[UIColor whiteColor]
                                                  andFont:SYSTEMFONT(13)
                                         andTextAlignment:NSTextAlignmentLeft];
        self.minRentPrice = minPrice;
        
        UILabel *marketPrice1 = [UILabel createLabelWithFrame:CommonVIEWFRAME(0,115.5 , 0, 0)
                                                      andText:@""
                                                 andTextColor:[UIColor blackColor]
                                                   andBgColor:[UIColor whiteColor]
                                                      andFont:SYSTEMFONT(13)
                                             andTextAlignment:NSTextAlignmentLeft];
        self.markPrice = marketPrice1;
        
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        UIImage *image = [UIImage imageNamed:@"嘴型@2x"];
        [btn setImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        [btn setTitle:@"啵一个" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(likeAciton:) forControlEvents:UIControlEventTouchUpInside];
        btn.titleLabel.font = SYSTEMFONT(13);
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 20, -40);
        btn.titleEdgeInsets = UIEdgeInsetsMake(20, -30, -10, -8);
        
        
        [_headView addSubview:self.cycleScrollView];
        [_headView addSubview:self.indexLab];
        [_headView addSubview:title];
        [_headView addSubview:content];
        [_headView addSubview:minPrice];
        [_headView addSubview:marketPrice1];
        [_headView addSubview:btn];
        
        [self.indexLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(_headView.mas_right).offset(-15);
            make.bottom.equalTo(self.cycleScrollView.mas_bottom).offset(-15);
            make.size.mas_equalTo(CGSizeMake(34, 20));
        }];
        
        [title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_headView.mas_left).offset(15);
            make.top.equalTo(self.cycleScrollView.mas_bottom).offset(15);
            make.size.mas_equalTo(CGSizeMake((SCREEN_WIDTH - 150), 15));
        }];
        
        [content mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_headView.mas_left).offset(15);
            make.top.equalTo(title.mas_bottom).offset(10);
            make.size.mas_equalTo(CGSizeMake((SCREEN_WIDTH - 150), 15));
        }];
        
        
        
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.cycleScrollView.mas_bottom).offset(12);
            make.right.equalTo(_headView.mas_right).offset(0);
            make.size.mas_equalTo(CGSizeMake(60, 50));
        }];
        
        self.btn = btn;
        
        self.isKeep = 0;
        //        _weekSelf(weakSelf);
        [BaseRequest GetKeepListWithUrl:APPINTERFACE__BusinessKeepList succesBlock:^(id data) {
            NSArray *models = [MyBussinesModel modelsFromArray:data[@"collection"][@"purchaseList"]];
            for (MyBussinesModel *model in models) {
                if ([self.model.userid integerValue] == [model.userid integerValue]) {
                    self.isKeep = 1;
                }
            }
            
            if (self.isKeep) {
                UIImage *image = [UIImage imageNamed:@"嘴型@2x"];
                [btn setImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
                
            }else{
                UIImage *image = [UIImage imageNamed:@"嘴型-1@2x"];
                [btn setImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
                
            }
            
            
        } failue:^(id data, NSError *error) {
            
        }];
        
    }
    return _headView;
}


- (SDCycleScrollView *)cycleScrollView{
    if (!_cycleScrollView) {
        //        占位-0
        //        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:VIEWFRAME(0, 0, SCREEN_WIDTH, 274.0000/667*SCREEN_HIGHT) imageNamesGroup:@[@"背景",@"图层-1-副本-2"]];
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:VIEWFRAME(0, 0, SCREEN_WIDTH, 274.0000/667*SCREEN_HIGHT)
                                                              delegate:self
                                                      placeholderImage:[UIImage imageNamed:@"占位-0"]];
        _cycleScrollView.showPageControl = YES;
        _cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleNone;
        _cycleScrollView.autoScrollTimeInterval = 3;
        _cycleScrollView.backgroundColor = APP_COLOR_BASE_BACKGROUND;
        _cycleScrollView.pageDotColor = [UIColor whiteColor];
        _cycleScrollView.currentPageDotColor = APP_COLOR_BASE_BAR;
        
    }
    return _cycleScrollView;
}


- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index
{
    self.indexLab.text = [NSString stringWithFormat:@"%ld/9",index+1];
    //    NSLog(@"图片%d",index);
    
}


-(void)buttonClick:(UIButton *)sender
{
    if (![LoginModel isLogin]) {
        [ProgressHUDHandler showHudTipStr:@"请先登录"];
        [[PushManager sharedManager] presentLoginVC];
        return;
    }
    UserModel *model =   [LoginModel curLoginUser];
    
    if ([self.model.userid integerValue] == [model.userid integerValue]) {
        [ProgressHUDHandler showHudTipStr:@"您不能购买自己的商品"];
        return;
    }


    [self PushViewControllerByClassName:@"BussinesOrderVC" info:self.dataDic];
}

-(void)likeAciton:(UIButton *)sender
{
    if (![LoginModel isLogin]) {
        [ProgressHUDHandler showHudTipStr:@"请先登录"];
        [[PushManager sharedManager] presentLoginVC];
        return;
    }

    UserModel *model =   [LoginModel curLoginUser];
    
    if ([self.model.userid integerValue] == [model.userid integerValue]) {
        [ProgressHUDHandler showHudTipStr:@"您不能收藏自己的商品"];
        return;
    }
    
    
    if (self.isKeep) {
        self.isKeep = 0;
        
        UIImage *image = [UIImage imageNamed:@"嘴型-1@2x"];
        [self.btn setImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        
        [BaseRequest CancelKeepWithPurchaseID:[self.model.purchaseid integerValue] succesBlock:^(id data) {
//            [self.listData removeObjectAtIndex:indexPath.section];
//            [weakSelf.tableView reloadData];
            if ([data[@"code"] integerValue] == 1) {
                [ProgressHUDHandler showHudTipStr:@"取消收藏"];
            }

        } failue:^(id data, NSError *error) {
            
        }];
        
    }else{
        self.isKeep = 1;
        
        UIImage *image = [UIImage imageNamed:@"嘴型@2x"];
        [self.btn setImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        
        [BaseRequest AddKeepWithPurchaseID:[self.model.purchaseid integerValue] succesBlock:^(id data) {
            if ([data[@"code"] integerValue] == 1) {
                [ProgressHUDHandler showHudTipStr:@"收藏成功"];
            }
            
        } failue:^(id data, NSError *error) {
            
        }];
        
    }

    
    
//    [BaseRequest AddKeepWithRentID:[self.model.rentid integerValue] succesBlock:^(id data) {
//        if ([data[@"code"] integerValue] == 1) {
//            [ProgressHUDHandler showHudTipStr:@"收藏成功"];
//        }
//        
//    } failue:^(id data, NSError *error) {
//        
//    }];
}

-(void)sendAction:(UIButton *)sender
{
    NSDictionary *dic = @{@"array":self.dataArr1};
    [self PushViewControllerByClassName:@"CommentVC" info:dic];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
