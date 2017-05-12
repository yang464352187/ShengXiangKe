//
//  SetVC.m
//  SXK
//
//  Created by 杨伟康 on 2016/11/30.
//  Copyright © 2016年 ywk. All rights reserved.
//

#import "SetVC.h"
#import "CommonCell.h"
#import "YXCustomActionSheet.h"
#import <UMSocialCore/UMSocialCore.h>


//#define   kAPP_URL : @"http://itunes.apple.com/lookup?id="

@interface SetVC ()<YXCustomActionSheetDelegate>

@property (nonatomic, strong)NSArray *dataArr;
@property (nonatomic, strong)NSString *trackViewUrl;
@end

@implementation SetVC


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"设置";
    [self initData];
    
    [self.view addSubview:self.tableView];
}

-(void)initData
{
    self.dataArr = [[NSMutableArray alloc] initWithObjects:@"常用地址",@"分享APP",@"清除缓存",@"意见反馈",@"用户协议",@"关于啵呗", nil];
}


#pragma mark -- getters and setters
- (UITableView *)tableView{
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:VIEWFRAME(0, 0, SCREEN_WIDTH, SCREEN_HIGHT+44) style:UITableViewStyleGrouped];
        _tableView.dataSource      = self;
        _tableView.delegate        = self;
        [_tableView registerClass:[CommonCell class] forCellReuseIdentifier:@"CommonCell"];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.tableFooterView = [[UIView alloc] init];
//        _tableView.tableHeaderView = [[UIView alloc] init];
        _tableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
        _tableView.sectionHeaderHeight = 0.0;
        _tableView.sectionFooterHeight = 0.0;
        

    }
    return _tableView;
}

#pragma mark -- UITabelViewDelegate And DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CommonCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommonCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell fillWithTitle:self.dataArr[indexPath.row]];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 54;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.0000001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.0000001;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
            
            [self PushViewControllerByClassName:@"AddressManagerVC" info:nil];
            break;
            
        case 2:{
            
            SDImageCache * cache = [SDImageCache sharedImageCache];
//            NSLog(@"%ld",[cache getSize]);
            NSString *str = [NSString stringWithFormat:@"缓存共%.1fMB",[cache getSize]/1024/1024.00];
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"清除缓存" message:str preferredStyle:  UIAlertControllerStyleAlert];
            
            [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                //点击按钮的响应事件；
                [self showRightWithTitle: @"清除成功" autoCloseTime: 0.2];
                [cache clearDisk];
                
            }]];

            [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                //点击按钮的响应事件；
            }]];
            [self presentViewController:alert animated:true completion:nil];
            break;
        }
            
//        case 3:{
//            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"版本更新" message:@"当前版本已经是最新版本" preferredStyle:  UIAlertControllerStyleAlert];
//            
//            [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//                //点击按钮的响应事件；
//            }]];
//
//            
//            //弹出提示框；
//            [self presentViewController:alert animated:true completion:nil];
//            [self updateApp];
//        }
            break;
        
        case 3:{
            NSDictionary *dic = @{@"title":@"意见反馈",
                                  @"opinion":@"请输入您的宝贵意见"};
            [self PushViewControllerByClassName:@"PersonalSummaryVC" info:dic];
            break;
        }
            
        case 4:{
            NSDictionary *dic = @{@"title":@"用户协议"};
            [self PushViewControllerByClassName:@"UserProtocolVC" info:dic];
            break;
        }
            
        case 5:{
            NSDictionary *dic = @{@"title":@"关于啵呗"};
            [self PushViewControllerByClassName:@"AboutBoobe" info:dic];
            break;
        }
        case 1:{
            YXCustomActionSheet *cusSheet = [[YXCustomActionSheet alloc] init];
            cusSheet.delegate = self;
            NSArray *contentArray = @[@{@"name":@"微信",@"icon":@"微信-1"},
                                      @{@"name":@"朋友圈 ",@"icon":@"朋友圈"},
                                      @{@"name":@"QQ ",@"icon":@"QQ-1"},
                                      @{@"name":@"新浪",@"icon":@"xinlang"}
                                      ];
            
            [cusSheet showInView:[UIApplication sharedApplication].keyWindow contentArray:contentArray];

        }
        default:
            break;
    }
}

#pragma mark - YXCustomActionSheetDelegate

- (void) customActionSheetButtonClick:(YXActionSheetButton *)btn
{
    
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建网页内容对象
//    NSString* thumbURL = [NSString stringWithFormat:@"%@%@",APP_BASEIMG,self.model.imgList[0]];
    
//    UIImage *cachedImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:@"http://itunes.apple.com/us/app/id1140378025"];
    
    UIImage *cachedImage = [UIImage imageNamed:@"未标题-1"];
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"啵呗" descr:@"亲们快来下载啵呗吧" thumImage:cachedImage];
    
    //设置网页地址
    shareObject.webpageUrl = [NSString stringWithFormat:@"http://itunes.apple.com/us/app/id1183709449"];
    
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

- (void)updateApp
{
    //    kAppID : 在iTunes connect上申请的APP ID;
    NSString *urlStr = [NSString stringWithFormat:@"%@%@", @"http://itunes.apple.com/lookup?id="
, @"1183709449"];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    //网络请求
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLSessionTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSError *err;
        //NSLog(@"%@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
        NSDictionary *appInfoDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&err];
        
        if (err) {
            NSLog(@"%@", err.description);
            return;
        }
        
        NSArray *resultArray = [appInfoDict objectForKey:@"results"];
        if (![resultArray count]) {
            NSLog(@"error : resultArray == nil");
            return;
        }
        
        NSDictionary *infoDict = [resultArray objectAtIndex:0];
        
        //获取服务器上应用的最新版本号
        NSString *updateVersion = infoDict[@"version"];
        NSString *trackName = infoDict[@"trackName"];
        
        //_trackViewUrl : 更新的时候用到的地址
        _trackViewUrl = infoDict[@"trackViewUrl"];
        
        //获取当前设备中应用的版本号
        NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
        NSString *currentVersion = [infoDic objectForKey:@"CFBundleShortVersionString"];
        
        //判断两个版本是否相同
        if ([currentVersion doubleValue] < [updateVersion doubleValue]) {
            NSString *titleStr = [NSString stringWithFormat:@"检查更新：%@", trackName];
            NSString *messageStr = [NSString stringWithFormat:@"发现新版本（%@）,是否更新", updateVersion];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:titleStr message:messageStr delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"升级", nil];
            alert.tag = [@"1183709449" intValue];
            [alert show];
            
        } else {  //版本号和app store上的一致
            NSString *titleStr = [NSString stringWithFormat:@"检查更新：%@", trackName];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:titleStr message:@"暂无新版本" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            alert.tag = [@"1183709449" intValue] + 1;
            [alert show];
        }
    }];
    [task resume];
}
//判断用户点击了哪一个按钮
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == [@"1183709449" intValue]) {
        if (buttonIndex == 1) { //点击”升级“按钮，就从打开app store上应用的详情页面
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.trackViewUrl]];
        }
    }
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
