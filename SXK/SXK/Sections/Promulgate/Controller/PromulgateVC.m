//
//  PromulgateVC.m
//  SXK
//
//  Created by 杨伟康 on 2016/11/11.
//  Copyright © 2016年 ywk. All rights reserved.
//

#import "PromulgateVC.h"
#import "VTingSeaPopView.h"
#import "FEPlaceHolderTextView.h"
#import "SummaryCell.h"
#import "TypeCell.h"
#import "AppDelegate.h"
#import "WSImagePickerView.h"


@interface PromulgateVC ()<WSImagePickerViewDelegate>

@property (strong, nonatomic) UIView            *headView;
@property (strong, nonatomic) FEPlaceHolderTextView       *content;
@property (strong, nonatomic) UIView *teachView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *photoViewHieghtConstraint;
@property (nonatomic, strong) WSImagePickerView *pickerView;
@property (nonatomic, assign) float heigh;
@property (nonatomic, strong) NSArray *firstArr;
@property (nonatomic, strong) NSArray *SecondArr;
@property (nonatomic, strong) NSMutableDictionary *cellDic;
@property (nonatomic, strong) NSArray *photoArr;
@property (nonatomic, strong) NSMutableArray *uploadPhotoArr;


@end

@implementation PromulgateVC


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"发布商品";
    [self initData];
//    self.view.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.tableView];
//    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0)) {
//        self.edgesForExtendedLayout = UIRectEdgeNone;
//        self.extendedLayoutIncludesOpaqueBars = NO;
//        self.modalPresentationCapturesStatusBarAppearance = NO;
//    }
//    self.extendedLayoutIncludesOpaqueBars = NO;
//    self.edgesForExtendedLayout = UIRectEdgeBottom | UIRectEdgeLeft | UIRectEdgeRight;
//    self.heigh = 0;
    [self setRightBarButtonWith:[UIImage imageNamed:@"感叹号"] selector:@selector(barButtonAction)];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tongzhi:) name:@"tongzhi" object:nil];


}
-(void)initData
{
    self.firstArr = @[@"宝贝名称 (必填)",@"专柜价 (必填)",@"关键字描述 (必填)"];
    self.SecondArr = @[@"类别",@"品牌",@"颜色",@"成色",@"适用人群",@"附件"];
    self.cellDic = [[NSMutableDictionary alloc] init];
    self.uploadPhotoArr = [[NSMutableArray alloc] init];
}

-(void)barButtonAction
{
    self.teachView = [self loadTeachView];
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    
    dispatch_async(queue, ^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [UIView animateWithDuration:0.5 animations:^{
                
                CGRect frame = CGRectMake(0, -64, SCREEN_WIDTH, SCREEN_HIGHT+64);
                self.teachView .frame = frame;
                
            } completion:^(BOOL finished) {
                
                
            }];
        });
    });

}
#pragma mark -- UITabelViewDelegate And DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 3;
    }
    
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        SummaryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SummaryCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell fillWithTitle:self.firstArr[indexPath.row]];
        return cell;
    }
    NSString *CellIdentifier = [NSString stringWithFormat:@"cell%ld%ld",(long)indexPath.section,(long)indexPath.row];//不使用复用
    
    TypeCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[TypeCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    [cell fillWithTitle:self.SecondArr[indexPath.row] andType:0];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.cellDic setObject:cell forKey:self.SecondArr[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 54;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor colorWithHexColorString:@"f7f7f7"];
    
    return view;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 15;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 1) {
        return 140;
    }
    return 0;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footView =[[UIView alloc] initWithFrame:VIEWFRAME(0, 0, SCREEN_WIDTH, 140)];
    footView.backgroundColor = [UIColor colorWithHexColorString:@"f7f7f7"];
    
    UIView *view = [[UIView alloc] init];
    view.frame = VIEWFRAME((SCREEN_WIDTH - 214.5)/2, 23.5, 214.5, 16.5);
    
    UIImageView *image = [[UIImageView alloc] initWithFrame:VIEWFRAME(0, 0, 16.5, 16.5)];
    image.image = [UIImage imageNamed:@"打钩"];
    
    UILabel *title = [UILabel createLabelWithFrame:VIEWFRAME(16.5,0 , 135, 16.5)
                                           andText:@"已阅读并同意BOOBE的"
                                      andTextColor:[UIColor colorWithHexColorString:@"a1a1a1"]
                                        andBgColor:[UIColor clearColor]
                                           andFont:SYSTEMFONT(12)
                                  andTextAlignment:NSTextAlignmentCenter];
    
    UIButton *explainBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [explainBtn setTitle:@"《用户协议》" forState:UIControlStateNormal];
    [explainBtn setTitleColor:APP_COLOR_GRAY_333333 forState:UIControlStateNormal];
    explainBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    explainBtn.frame = VIEWFRAME(136.5, 0, 90, 16.5);
    
    UIButton *promulgateBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    promulgateBtn.backgroundColor = APP_COLOR_GRAY_333333;
    promulgateBtn.frame = CGRectMake(15, 65, SCREEN_WIDTH-30, 44);
    [promulgateBtn setTitle:@"立即发布" forState:UIControlStateNormal];
    [promulgateBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    promulgateBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [promulgateBtn addTarget:self action:@selector(promulgateBtn:) forControlEvents:UIControlEventTouchUpInside];
    ViewRadius(promulgateBtn, 22);
    
    [view addSubview:image];
    [view addSubview:title];
    [view addSubview:explainBtn];
    [footView addSubview:promulgateBtn];
    [footView addSubview:view];
    return footView;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        switch (indexPath.row) {
            case 0:{
                NSDictionary *dic = @{@"title":@"类别"};
                [self PushViewControllerByClassName:@"CommonVC" info:dic];
            }
                break;
            case 1:{
                NSDictionary *dic = @{@"className":@"品牌"};
                [self PushViewControllerByClassName:@"BrandVC" info:dic];
            }
                break;
            case 3:{
                NSDictionary *dic = @{@"title":@"成色"};
                [self PushViewControllerByClassName:@"CommonVC" info:dic];
            }
                break;
            case 4:{
                NSDictionary *dic = @{@"title":@"适用人群"};
                [self PushViewControllerByClassName:@"CommonVC" info:dic];
            }
                break;
            case 5:{
                NSDictionary *dic = @{@"title":@"附件"};
                [self PushViewControllerByClassName:@"CommonVC" info:dic];
            }
                break;


                
            default:
                break;
        }
    }
}

#pragma mark -- getters and setters


- (UITableView *)tableView{
    if (!_tableView) {
        
          _tableView = [[UITableView alloc] initWithFrame:VIEWFRAME(0, 0, SCREEN_WIDTH, SCREEN_HIGHT-64) style:UITableViewStyleGrouped];
        _tableView.dataSource      = self;
        _tableView.delegate        = self;
        [_tableView registerClass:[SummaryCell class] forCellReuseIdentifier:@"SummaryCell"];
        [_tableView registerClass:[TypeCell class] forCellReuseIdentifier:@"TypeCell"];
//        [_tableView registerClass:[SpecialCell class] forCellReuseIdentifier:@"SpecialCell"];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.backgroundColor = APP_COLOR_BASE_BACKGROUND;
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
        _headView = [[UIView alloc] initWithFrame:VIEWFRAME(0, 0, SCREEN_WIDTH, (200.0000/667*SCREEN_HIGHT))];
        _headView.backgroundColor = [UIColor whiteColor];
        
        
        UIButton *shootBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        shootBtn.frame = VIEWFRAME(CommonWidth(15), CommonHight(105), CommonHight(111.5), CommonHight(111.5));

        UIImage *image = [UIImage imageNamed:@"拍摄"];
        [shootBtn setImage:[image imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)] forState:UIControlStateNormal];
        
        UIButton *HshootBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        HshootBtn.frame = VIEWFRAME(CommonWidth(139), CommonHight(105), CommonHight(111.5), CommonHight(111.5));
        UIImage *image1 = [UIImage imageNamed:@"如何-拍摄"];
        [HshootBtn setImage:[image1 imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)] forState:UIControlStateNormal];
        [HshootBtn addTarget:self action:@selector(BtnAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [_headView addSubview:self.content];
        
        
        WSImagePickerConfig *config = [WSImagePickerConfig new];
        config.itemSize = CGSizeMake(CommonHight(80), CommonHight(80));
        config.photosMaxCount = 9;
        
        WSImagePickerView *pickerView = [[WSImagePickerView alloc] initWithFrame:CGRectMake(0, CommonHight(100), SCREEN_WIDTH, 0) config:config];
        pickerView.type = 1;
        pickerView.delegate = self;
        __weak typeof(self) weakSelf = self;
        pickerView.viewHeightChanged = ^(CGFloat height) {
            weakSelf.photoViewHieghtConstraint.constant = height;
            [weakSelf.view setNeedsLayout];
            [weakSelf.view layoutIfNeeded];
            weakSelf.heigh = self.pickerView.frame.size.height;
//            weakSelf.headView.frame.size.height =height;
            [weakSelf change];
        };
        pickerView.navigationController = self.navigationController;
        [_headView addSubview:pickerView];
        self.pickerView = pickerView;
        
        //refresh superview height
        [pickerView refreshImagePickerViewWithPhotoArray:nil];


        
    }

    return _headView;
}
-(void)change
{
    NSArray *array = [_pickerView getPhotos];
    self.photoArr = array;
    NSInteger i ,j;
    j = array.count + 3;
    if (j <= 4) {
        i = 0;
    }else if (j > 4 && j <=8)
    {
        i = 1;
    }else{
        i = 2;
    }
    
     _headView.frame = VIEWFRAME(0, 0, SCREEN_WIDTH, (205.0000/667*SCREEN_HIGHT+CommonHight(80)*i)+10*i );
    self.tableView.tableHeaderView = _headView;
//    [self.tableView reloadData];
    
}

-(FEPlaceHolderTextView *)content
{
    if (!_content) {
        _content = [[FEPlaceHolderTextView alloc] initWithFrame:CommonVIEWFRAME(0, 8, 375, 95)];
        _content.backgroundColor = [UIColor clearColor];
        [_content setTintColor:[UIColor blackColor]];
        _content.placeholderColor = [UIColor colorWithHexColorString:@"b6b6b6"];
        [_content setFont:SYSTEMFONT(13)];
        _content.placeholder =  @"描述下你的宝贝吧";

    }
    return _content;
}

-(void)BtnAction:(UIButton *)sender
{
    self.teachView = [self loadTeachView];
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    
    dispatch_async(queue, ^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            
            [UIView animateWithDuration:0.5 animations:^{
                
                CGRect frame = CGRectMake(0, -64, SCREEN_WIDTH, SCREEN_HIGHT+64);
                self.teachView .frame = frame;
                
            } completion:^(BOOL finished) {

                
            }];
        });
    });
    

}

-(UIView *)loadTeachView
{
    
    UIView *teachView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HIGHT, SCREEN_WIDTH, SCREEN_HIGHT+64)];
    teachView.backgroundColor = [UIColor blackColor];
    teachView.alpha = 0.8;
    
    UILabel *title = [UILabel createLabelWithFrame:VIEWFRAME(0,128 , SCREEN_WIDTH, 18)
                                           andText:@"如何拍摄"
                                      andTextColor:[UIColor whiteColor]
                                        andBgColor:[UIColor clearColor]
                                           andFont:SYSTEMFONT(18)
                                  andTextAlignment:NSTextAlignmentCenter];
    
    
    for (int i = 0; i  < 3 ; i++) {
        for (int j = 0; j < 3 ; j++) {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:VIEWFRAME(CommonWidth(77+j*(80+14)), CommonHight(117+i*(80+12.5)+64), CommonHight(80), CommonHight(80))];
            imageView.backgroundColor = [UIColor whiteColor];
            
//            UILabel *lab = [UILabel createLabelWithFrame:VIEWFRAME(0,128 , SCREEN_WIDTH, 18)
//                                                   andText:@"如何拍摄"
//                                              andTextColor:[UIColor whiteColor]
//                                                andBgColor:[UIColor clearColor]
//                                                   andFont:SYSTEMFONT(18)
//                                          andTextAlignment:NSTextAlignmentCenter];

            [teachView addSubview:imageView];
        }
    }
    
    
    
    
    
    [teachView addSubview:title];
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate.window addSubview:teachView];

//    appDelegate.window.rootViewController = self.tabbarVC;
//    [self.view addSubview:teachView];
    return teachView;
}

-(void)showTeachView
{
    self.teachView = [self loadTeachView];
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    
    dispatch_async(queue, ^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            
            [UIView animateWithDuration:0.5 animations:^{
                
                CGRect frame = CGRectMake(0, -64, SCREEN_WIDTH, SCREEN_HIGHT+64);
                self.teachView .frame = frame;
                
            } completion:^(BOOL finished) {
                
                
            }];
        });
    });

}

- (void)tongzhi:(NSNotification *)text{
    NSLog(@"%@",text.userInfo[@"class"]);
    TypeCell *cell = (TypeCell *)[self.cellDic valueForKey:text.userInfo[@"class"]];
    [cell changeTitle:text.userInfo[@"name"]];
    NSLog(@"－－－－－接收到通知------");
    
}

-(void)promulgateBtn:(UIButton *)sender
{
    NSMutableArray *photo = [[NSMutableArray alloc] init];
    for (UIImage *image in self.photoArr) {
        
//        CGSize imagesize = image.size;
//        imagesize.height =SCREEN_HIGHT;
//        imagesize.width =SCREEN_WIDTH;
//        
//        UIImage *newImage =  [self imageWithImage:image scaledToSize:imagesize];
//        
//        NSData *imageData = UIImagePNGRepresentation(newImage);
        
        NSData *image1 = UIImageJPEGRepresentation(image, 0.5);
        [photo addObject:image1];
    }

    [CustomHUD createHudCustomShowContent:@"正在上传"];

    [[GCQiniuUploadManager sharedInstance] registerWithScope:@"shexiangke-jcq" accessKey:@"e6m0BrZSOPhaz6K2TboadoayOp-QwLge2JOQZbXa" secretKey:@"RxiQnoa8NqIe7lzSip-RRnBdX9_pwOQmBBPqGWvv"];
    [[GCQiniuUploadManager sharedInstance] createToken];
    
    [[GCQiniuUploadManager sharedInstance] uploadDatas:photo progress:^(float percent) {
        
    } oneTaskCompletion:^(NSError *error, NSString *link, NSInteger index) {
        
        NSArray *array = [link componentsSeparatedByString:@"/"];
        
        [self.uploadPhotoArr addObject:array[1]];
        
    } allTasksCompletion:^{
        
        [BaseRequest AddCommunityTopicWithContent:@"MDZZZZZZZZZZZZZZZZZZ" imgList:self.uploadPhotoArr moduleid:2 succesBlock:^(id data) {
            NSLog(@"---------%@-----------",describe(data));
            [CustomHUD stopHidden];

        } failue:^(id data, NSError *error) {
            
        }];
        

    }];

}

-(UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    
    // Return the new image.
    return newImage;
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
