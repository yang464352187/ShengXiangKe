//
//  PersonalInfoVC.m
//  SXK
//
//  Created by 杨伟康 on 2016/11/30.
//  Copyright © 2016年 ywk. All rights reserved.
//

#import "PersonalInfoVC.h"
#import "TypeCell.h"
#import "PopView.h"
#import "AppDelegate.h"
#import "YXCustomActionSheet.h"
#import <UMSocialCore/UMSocialCore.h>

@interface PersonalInfoVC ()<PopViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,YXCustomActionSheetDelegate>

@property (strong, nonatomic) UIView  *headView;
@property (strong, nonatomic) NSArray *firstArr;
@property (strong, nonatomic) NSArray *secondArr;
@property (strong, nonatomic) PopView *popView;
@property (strong, nonatomic) TypeCell *sexCell;
@property (strong, nonatomic) TypeCell *nicknameCell;
@property (strong, nonatomic) TypeCell *phoneCell;
@property (strong, nonatomic) TypeCell *birthCell;
@property (strong, nonatomic) NSString *nickName;
@property (strong, nonatomic) NSString *phoneNum;
@property (strong, nonatomic) NSString *birthday;
@property (assign, nonatomic) NSInteger sex;
@property (strong, nonatomic) UIImageView *headImage;

@end

@implementation PersonalInfoVC

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];//设置电池条颜色为黑色

}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"个人资料";
    [self initData];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.popView];
    
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",self.myDict[@"headimgurl"]]]];
//    NSDictionary *params = @{};
//    [BaseRequest GetPersonalInfoWithParams:params succesBlock:^(id data) {
//        NSLog(@"yang %@",params);
//    } failue:^(id data, NSError *error) {
//        
//    }];
    
}

-(void)initData
{
    self.firstArr = [[NSArray alloc] initWithObjects:@"昵称",@"性别",@"生日",@"个人简介" ,nil];
    self.secondArr = [[NSArray alloc] initWithObjects:@"手机号码",@"修改密码", nil];
}
#pragma mark -- getters and setters
- (UITableView *)tableView{
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:VIEWFRAME(0, 0, SCREEN_WIDTH, SCREEN_HIGHT-44) style:UITableViewStyleGrouped];
        _tableView.dataSource      = self;
        _tableView.delegate        = self;
        [_tableView registerClass:[TypeCell class] forCellReuseIdentifier:@"TypeCell"];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.tableHeaderView = self.headView;
        _tableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
        _tableView.sectionHeaderHeight = 0.0;
        _tableView.sectionFooterHeight = 0.0;
        
    }
    return _tableView;
}

- (UIView *)headView{
    if (!_headView) {
        _headView = [[UIView alloc] initWithFrame:VIEWFRAME(0, 0, SCREEN_WIDTH, (203.0000/667*SCREEN_HIGHT))];
        _headView.backgroundColor = [UIColor whiteColor];
        
        
        UserModel *model =   [LoginModel curLoginUser];

        UIImageView *headImage = [[UIImageView alloc] initWithFrame:VIEWFRAME( (SCREEN_WIDTH - CommonHight(94))/2, CommonHight(18), CommonHight(94), CommonHight(94))];
        [headImage setUserInteractionEnabled:YES];
        headImage.userInteractionEnabled = YES;
        headImage.image = [UIImage imageNamed:@"头像"];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];

        [headImage addGestureRecognizer:tap];
        
        ViewRadius(headImage, CommonHight(94)/2);
        self.headImage = headImage;
        
        UIButton *shootBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        UIImage *shootImage = [UIImage imageNamed:@"相机"];
        [shootBtn setImage:[shootImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        shootBtn.frame = VIEWFRAME(CommonWidth(200), CommonHight(90), CommonHight(25), CommonHight(25));
        
        UILabel *siteLab = [UILabel createLabelWithFrame:CommonVIEWFRAME(24, 137.5, 262, 32)                                                 andText:[NSString stringWithFormat:@"分享专属邀请码%@给好友获得奖励哦!",model.invitationCode]
                                  andTextColor:[UIColor blackColor]
                                    andBgColor:[UIColor clearColor]
                                       andFont:SYSTEMFONT(13)
                              andTextAlignment:NSTextAlignmentCenter];
        ViewBorder(siteLab, 0.5, [UIColor colorWithHexColorString:@"a0a0a0"]);
        
        UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        shareBtn.frame = CommonVIEWFRAME(296, 137.5, 60.5, 32);
        [shareBtn setTitle:@"分享" forState:UIControlStateNormal];
        [shareBtn setBackgroundColor:APP_COLOR_GREEN];
        [shareBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [shareBtn addTarget:self action:@selector(shareAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [_headView addSubview:headImage];
        [_headView addSubview:shootBtn];
        [_headView addSubview:siteLab];
        [_headView addSubview:shareBtn];
    }
    return _headView;
}

#pragma mark -- UITabelViewDelegate And DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return self.firstArr.count;
    }
    return self.secondArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    NSString *CellIdentifier = [NSString stringWithFormat:@"cell%ld%ld",(long)indexPath.section,(long)indexPath.row];//不使用复用
    
    TypeCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[TypeCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
//    if (indexPath.section == 0) {
//        [cell fillWithTitle1:self.firstArr[indexPath.row] andType:1];
//    }else{
//        [cell fillWithTitle1:self.secondArr[indexPath.row] andType:1];
//    }
    
    if (indexPath.section == 0 && indexPath.row == 1) {
        
        if ([self.myDict[@"sex"] integerValue] == 1) {
            [cell fillWithTitle1:self.firstArr[indexPath.row] Content:@"男"];
        }else{
            [cell fillWithTitle1:self.firstArr[indexPath.row] Content:@"女"];
        }
        self.sexCell = cell;
    }
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        [cell fillWithTitle1:self.firstArr[indexPath.row] Content:self.myDict[@"nickname"]];
        self.nicknameCell = cell;
    }
    
    if (indexPath.section == 0 && indexPath.row == 2) {
        long time = [self.myDict[@"birthday"] integerValue];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateStyle:NSDateFormatterMediumStyle];
        [formatter setTimeStyle:NSDateFormatterShortStyle];
        [formatter setDateFormat:@"YYYY-MM"];
        
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
        NSString *nowtimeStr = [formatter stringFromDate:date];
        [cell fillWithTitle1:self.firstArr[indexPath.row] Content:nowtimeStr];
        self.birthCell = cell;
    }
    if (indexPath.section == 0 && indexPath.row == 3) {
        [cell fillWithTitle1:self.firstArr[indexPath.row] Content:self.myDict[@"profile"]];
//        self.birthCell = cell;
    }

    if (indexPath.section == 1 && indexPath.row == 0) {
        [cell fillWithTitle1:self.secondArr[indexPath.row] Content:self.myDict[@"mobile"]];
    }
    
    if (indexPath.section == 1 && indexPath.row == 1) {
        [cell fillWithTitle1:self.secondArr[indexPath.row] Content:@""];
    }


    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return 52;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor colorWithHexColorString:@"f7f7f7"];
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.section == 0 && indexPath.row == 0) {
        [self.popView fillWithTitle:@"修改昵称"];
        [self.popView show];
    }
    
    if (indexPath.section == 0 && indexPath.row == 1) {
        [self.popView fillWithTitle:@"修改性别"];
        [self.popView show1];
    }
    
    if (indexPath.section == 0 && indexPath.row == 2) {
        [self.popView fillWithTitle:@"出生年月"];
        [self.popView show2];
    }
    
    if (indexPath.section == 0 && indexPath.row == 3) {
        NSDictionary *dic = @{@"title":@"个人简介",
                              @"opinion":@"请输入您的个人简介"};
        [self PushViewControllerByClassName:@"PersonalSummaryVC" info:dic];
    }
    
    if (indexPath.section == 1 && indexPath.row == 0) {

    }
    
    if (indexPath.section == 1 && indexPath.row == 1) {
        NSDictionary *dic = @{@"title":@"修改密码"};
        [self PushViewControllerByClassName:@"ForgetVC" info:dic];
    }


}

-(PopView *)popView
{
    if (!_popView) {
        _popView =  [[PopView alloc] initWithFrame:VIEWFRAME(0, 0, SCREEN_WIDTH, SCREEN_HIGHT)];
        _popView.delegate =self;
    }
    return _popView;
}

-(void)sexual:(NSInteger)tag
{
    
    if (tag == 1) {
        [self.sexCell changeTitle:@"男"];
        self.sex = 1;
    }else{
        [self.sexCell changeTitle:@"女"];
        self.sex = 2;
    }
}

-(void)sendInfo:(NSString *)info andType:(NSInteger)type
{

    switch (type) {
        case 1:{
            [self.nicknameCell changeTitle:info];
            self.nickName = info;
            
            break;
        }
        case 2:{
            [self.phoneCell changeTitle:info];
            self.phoneNum = info;
            break;
        }
        case 3:{
            [self.birthCell changeTitle:info];
            self.birthday = info;
            break;
        }

        default:
            break;
    }
    NSLog(@"%@",info);
}


-(void)tapAction:(UIGestureRecognizer *)tap
{
    UIActionSheet *action = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从照片库选取",nil];
    [action showInView:self.view];

}

#pragma mark - UIActionSheet delegate -
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    UIImagePickerController *pick=[[UIImagePickerController alloc]init];
    pick.allowsEditing = true;//设置是否可以编辑相片涂鸦
    pick.delegate = self;
    
    if (buttonIndex==0) {
        //判断用户是否有权限访问相机
        //        if ([[AuthorityManager sharedManager] hasAuthorityWithType:AuthorityType_Camera animated:YES]) {
        //判断相机是否可用,因为模拟机是不可以的
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            
            pick.sourceType = UIImagePickerControllerSourceTypeCamera;//设置 pick 的类型为相机
            [self presentViewController:pick animated:true completion:nil];
        }
        else
        {
            NSLog(@"相机不可用");
        }
        
    }
    else if (buttonIndex==1)
    {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            pick.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [self presentViewController:pick animated:true completion:nil];
        }
        else
        {
            NSLog(@"相册不可用");
        }
    }

}

#pragma  mark - imagePickerController Delegate -
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *type=[info objectForKey:UIImagePickerControllerMediaType];
    //判断选择的是否是图片,这个 public.image和public.movie是固定的字段.
    if ([type isEqualToString:@"public.image"])
    {
        UIImage *image=[info objectForKey:UIImagePickerControllerOriginalImage];
        
        NSData *image1 = UIImageJPEGRepresentation(image, 0.5);
        
        self.headImage.image = image;

        [[GCQiniuUploadManager sharedInstance] registerWithScope:@"production" accessKey:@"e6m0BrZSOPhaz6K2TboadoayOp-QwLge2JOQZbXa" secretKey:@"RxiQnoa8NqIe7lzSip-RRnBdX9_pwOQmBBPqGWvv"];
        
        [[GCQiniuUploadManager sharedInstance] createToken];
        
        [[GCQiniuUploadManager sharedInstance] uploadData:image1 progress:^(float percent) {
            
        } completion:^(NSError *error, NSString *link, NSInteger index) {
            NSArray *array = [link componentsSeparatedByString:@"/"];
            NSDictionary *params = @{
                                     @"headimgurl":[NSString stringWithFormat:@"%@%@",APP_BASEIMG,array[1]]
                                     };
            
            [BaseRequest SetPersonalInfoWithParams:params succesBlock:^(id data) {
                
            } failue:^(id data, NSError *error) {
                
            }];
            
            
        }];
        
//        [[GCQiniuUploadManager sharedInstance] uploadDatas:photo progress:^(float percent) {
//            
//        } oneTaskCompletion:^(NSError *error, NSString *link, NSInteger index) {
//            
//            NSArray *array = [link componentsSeparatedByString:@"/"];
//            
//            [weakSelf.uploadPhotoArr addObject:array[1]];
//            
//        } allTasksCompletion:^{
//            
//            [BaseRequest AddCommunityTopicWithContent:self.content.text imgList:self.uploadPhotoArr moduleid:self.type succesBlock:^(id data) {
//                [weakSelf popGoBack];
//                NSLog(@"---------%@-----------",describe(data));
//                [CustomHUD stopHidden];
//                [ProgressHUDHandler showHudTipStr:@"发布成功"];
//                
//            } failue:^(id data, NSError *error) {
//                [ProgressHUDHandler showHudTipStr:@"发布失败"];
//                
//            }];
//            
//            
//        }];
        
        

    }
    [picker dismissViewControllerAnimated:false completion:nil];
}

-(void)shareAction:(UIButton *)sender
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
    
    
    UserModel *model =   [LoginModel curLoginUser];
//    NSLog(@"%@",describe(model));
//    
//    return;
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    UIImage *cachedImage = [UIImage imageNamed:@"未标题-1"];
    NSString *str = [NSString stringWithFormat:@"下载啵呗APP,注册并输入邀请码就可以获得奖励哦!邀请码为%@",model.invitationCode];
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"啵呗" descr:str thumImage:cachedImage];
    
    //设置网页地址
    shareObject.webpageUrl = [NSString stringWithFormat:@"http://itunes.apple.com/us/app/id1183709449"];

    
//    //创建网页内容对象
//    NSString* thumbURL = [NSString stringWithFormat:@"%@%@",APP_BASEIMG,self.model.imgList[0]];
//    
//    UIImage *cachedImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:thumbURL];
//    
//    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:self.model.name descr:self.model.keyword thumImage:cachedImage];
//    
//    //设置网页地址
//    shareObject.webpageUrl = [NSString stringWithFormat:@"http://shexiangke.jcq.tbapps.cn/wechat/userpage/getrent/rentid/%@",self.model.rentid];
    
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
