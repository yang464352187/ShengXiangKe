//
//  IdentityVC.m
//  SXK
//
//  Created by 杨伟康 on 2017/1/22.
//  Copyright © 2017年 ywk. All rights reserved.
//

#import "IdentityVC.h"
#import "IdentityCell.h"

@interface IdentityVC ()<IdentityCellDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>


@property (nonatomic, strong)UIView *headView;

@property (nonatomic, strong)NSArray *dataArr;

@property (nonatomic, assign)NSInteger index;

@property (nonatomic, strong)UIButton *firstBtn;

@property (nonatomic, strong)UIButton *secondBtn;

@property (nonatomic, strong)NSString *frontImage;

@property (nonatomic, strong)NSString *backImage;

@property (nonatomic, strong)NSString *idNumber;

@property (nonatomic, strong)NSString *name;

@end

@implementation IdentityVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"身份认证";
    [self initUI];
}

-(void)initUI
{
    self.dataArr = @[@"姓名",@"身份证号码"];
    [self.view addSubview:self.tableView];
}

#pragma mark -- UITabelViewDelegate And DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    IdentityCell *cell = [tableView dequeueReusableCellWithIdentifier:@"IdentityCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.delegate = self;
    [cell fillWithTitle:self.dataArr[indexPath.row]];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 50;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 150+CommonHight(105);
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = APP_COLOR_GRAY_Header;
    return view;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor whiteColor];
    
    UILabel *title = [UILabel createLabelWithFrame:VIEWFRAME(23, 23, 300, 15)                                                 andText:@"上传身份证正反面照片(支持jpg、png格式)"
                              andTextColor:[UIColor blackColor]
                                andBgColor:[UIColor clearColor]
                                   andFont:SYSTEMFONT(14)
                          andTextAlignment:NSTextAlignmentLeft];
    UIImage *image = [UIImage imageNamed:@"相机-(2)"];

    UIButton *firstBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [firstBtn setImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [firstBtn addTarget:self  action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    firstBtn.tag = 100;
    
    UIButton *secondBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [secondBtn setImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [secondBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    secondBtn.tag = 200;
    
    UIButton *certainBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [certainBtn setTitle:@"提交" forState:UIControlStateNormal];
    certainBtn.backgroundColor = APP_COLOR_GREEN;
    [certainBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    certainBtn.titleLabel.font = SYSTEMFONT(14);
    certainBtn.frame = VIEWFRAME(15, 20, CommonWidth(335), 40);
    ViewRadius(certainBtn, certainBtn.frame.size.height/2);
    certainBtn.tag = 300;
    [certainBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [view addSubview:title];
    [view addSubview:firstBtn];
    [view addSubview:secondBtn];
    [view addSubview:certainBtn];
    
    [firstBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(title.mas_bottom).offset(19);
        make.left.equalTo(view.mas_left).offset(23);
        make.size.mas_equalTo(CGSizeMake((SCREEN_WIDTH - 70)/2,  CommonHight(105)));
    }];
    
    [secondBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(title.mas_bottom).offset(19);
        make.left.equalTo(firstBtn.mas_right).offset(23);
        make.size.mas_equalTo(CGSizeMake((SCREEN_WIDTH - 70)/2, CommonHight(105)));
    }];
    
    [certainBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(firstBtn.mas_bottom).offset(40);
        make.left.equalTo(view.mas_left).offset(15);
        make.right.equalTo(view.mas_right).offset(-15);
        make.height.mas_equalTo(40);
    }];
    
    self.firstBtn = firstBtn;
    self.secondBtn = secondBtn;
    return view;
}

#pragma mark -- getters and setters


- (UITableView *)tableView{
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:VIEWFRAME(0, 0, SCREEN_WIDTH, SCREEN_HIGHT-64) style:UITableViewStyleGrouped];
        _tableView.dataSource      = self;
        _tableView.delegate        = self;
        [_tableView registerClass:[IdentityCell class] forCellReuseIdentifier:@"IdentityCell"];
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
        UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"序列-3"]];
        
        UILabel *title = [UILabel createLabelWithFrame:VIEWFRAME(55, 5.5, 100, 41)                                                 andText:@"请如实填写您本人的身份信息以认证为实名用户。次信息将用于为您购买运输期间的保险，同时也用于保障您账户钱包的安全，我们将确保其安全性。"
                                  andTextColor:[UIColor colorWithHexColorString:@"a1a1a1"]
                                    andBgColor:[UIColor clearColor]
                                       andFont:SYSTEMFONT(14)
                              andTextAlignment:NSTextAlignmentLeft];
        title.numberOfLines = 0;
        
        CGFloat height = [UILabel getHeightByWidth:SCREEN_WIDTH - 46 title:@"请如实填写您本人的身份信息以认证为实名用户。次信息将用于为您购买运输期间的保险，同时也用于保障您账户钱包的安全，我们将确保其安全性。" font:SYSTEMFONT(14) ];
        
        _headView = [[UIView alloc] initWithFrame:VIEWFRAME(0, 0, SCREEN_WIDTH, 126 + height/667.00000*SCREEN_HIGHT)];
        _headView.backgroundColor = [UIColor whiteColor];

        [_headView addSubview:image];
        [_headView addSubview:title];
        
        [image mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_headView);
            make.top.equalTo(_headView.mas_top).offset(23);
            make.size.mas_equalTo(CGSizeMake(49, 60));
        }];
        
        [title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(image.mas_bottom).offset(19);
            make.left.equalTo(_headView.mas_left).offset(23);
            make.right.equalTo(_headView.mas_right).offset(-23);
            make.height.mas_equalTo(height);
        }];
        
    }
    return _headView;
}

-(void)SendTextValue:(NSString *)content title:(NSString *)title
{
    
    if ([title isEqualToString:@"姓名"]) {
        self.name = content;
    }else{
        self.idNumber = content;
    }
    
}

-(void)btnAction:(UIButton *)sender
{
    if (sender.tag > 200) {
        
        if (self.name.length == 0) {
            [ProgressHUDHandler showHudTipStr:@"请输入名字"];
            
            return;
        }
        if (![self judgeIdentityStringValid:self.idNumber] || self.idNumber.length != 18) {
            [ProgressHUDHandler showHudTipStr:@"请输入正确的身份证号码"];
            return;
        }
        if (self.frontImage.length == 0 || self.backImage.length == 0) {
            [ProgressHUDHandler showHudTipStr:@"请上传身份证照片"];
            return;
        }
        
        
        
        NSDictionary *dic = @{
                              @"name":self.name,
                              @"idNumber":self.idNumber,
                              @"front":self.frontImage,
                              @"back":self.backImage,
                              };
        NSDictionary *params = @{@"buyer":dic};
        
        _weekSelf(weakSelf);
        [BaseRequest VerifyIdetityWithParams:params succesBlock:^(id data) {
            
            if ([data[@"code"] integerValue] == 1) {
                [ProgressHUDHandler showHudTipStr:@"提交成功"];
            }
            [weakSelf popGoBack];
            
        } failue:^(id data, NSError *error) {
            
            if ([data[@"code"] integerValue] == 0) {
                [ProgressHUDHandler showHudTipStr:@"请输入正确的身份证号码"];
            }
 
        }];
        
        
        
        
    }else{
        self.index = sender.tag;
        UIActionSheet *action = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从照片库选取",nil];
        [action showInView:self.view];

    }
    

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
        
        if (self.index == 100) {
            [self.firstBtn setImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        }else{
            [self.secondBtn setImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        }
        
        [CustomHUD createHudCustomShowContent:@"正在上传"];

        _weekSelf(weakSelf);
        [[GCQiniuUploadManager sharedInstance] registerWithScope:@"production" accessKey:@"e6m0BrZSOPhaz6K2TboadoayOp-QwLge2JOQZbXa" secretKey:@"RxiQnoa8NqIe7lzSip-RRnBdX9_pwOQmBBPqGWvv"];
        [[GCQiniuUploadManager sharedInstance] createToken];
        
        [[GCQiniuUploadManager sharedInstance] uploadData:image1 progress:^(float percent) {
            
        } completion:^(NSError *error, NSString *link, NSInteger index) {
            NSArray *array = [link componentsSeparatedByString:@"/"];
            [CustomHUD stopHidden];
            if (weakSelf.index == 100) {
                weakSelf.frontImage = array[1];
            }else{
                weakSelf.backImage = array[1];
            }
            [ProgressHUDHandler showHudTipStr:@"上传成功"];

        }];
        
    }
    [picker dismissViewControllerAnimated:false completion:nil];
}



- (BOOL)judgeIdentityStringValid:(NSString *)identityString {
    
    if (identityString.length != 18) return NO;
    // 正则表达式判断基本 身份证号是否满足格式
    NSString *regex2 = @"^(^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$)|(^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])((\\d{4})|\\d{3}[Xx])$)$";
    NSPredicate *identityStringPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    //如果通过该验证，说明身份证格式正确，但准确性还需计算
    if(![identityStringPredicate evaluateWithObject:identityString]) return NO;
    
    //** 开始进行校验 *//
    
    //将前17位加权因子保存在数组里
    NSArray *idCardWiArray = @[@"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2"];
    
    //这是除以11后，可能产生的11位余数、验证码，也保存成数组
    NSArray *idCardYArray = @[@"1", @"0", @"10", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2"];
    
    //用来保存前17位各自乖以加权因子后的总和
    NSInteger idCardWiSum = 0;
    for(int i = 0;i < 17;i++) {
        NSInteger subStrIndex = [[identityString substringWithRange:NSMakeRange(i, 1)] integerValue];
        NSInteger idCardWiIndex = [[idCardWiArray objectAtIndex:i] integerValue];
        idCardWiSum+= subStrIndex * idCardWiIndex;
    }
    
    //计算出校验码所在数组的位置
    NSInteger idCardMod=idCardWiSum%11;
    //得到最后一位身份证号码
    NSString *idCardLast= [identityString substringWithRange:NSMakeRange(17, 1)];
    //如果等于2，则说明校验码是10，身份证号码最后一位应该是X
    if(idCardMod==2) {
        if(![idCardLast isEqualToString:@"X"]||[idCardLast isEqualToString:@"x"]) {
            return NO;
        }
    }
    else{
        //用计算出的验证码与最后一位身份证号码匹配，如果一致，说明通过，否则是无效的身份证号码
        if(![idCardLast isEqualToString: [idCardYArray objectAtIndex:idCardMod]]) {
            return NO;
        }
    }
    return YES;
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
