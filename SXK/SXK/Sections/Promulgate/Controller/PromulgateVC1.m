//
//  PromulgateVC1.m
//  SXK
//
//  Created by 杨伟康 on 2017/3/16.
//  Copyright © 2017年 ywk. All rights reserved.
//

#import "PromulgateVC1.h"
#import "VTingSeaPopView.h"
#import "FEPlaceHolderTextView.h"
#import "SummaryCell.h"
#import "TypeCell.h"
#import "AppDelegate.h"
#import "WSImagePickerView.h"
#import "CategoryListModel.h"
#import "PromulgateVC1Cell.h"

@interface PromulgateVC1 ()<WSImagePickerViewDelegate,SummaryCellDelegate,TypeCellDelegate,PromulgateVC1CellDelegate>

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
@property (nonatomic, strong) NSMutableDictionary *dataDic;
@property (nonatomic, assign) NSInteger selectCategory;
@property (nonatomic, assign) NSInteger categoryid;
@property (nonatomic, strong) NSArray *dataArr;
@property (nonatomic, strong) NSArray *enclosure;
@property (nonatomic, strong) NSArray *qualityArr;

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *descrip;
@property (nonatomic, strong) NSString *category;
@property (nonatomic, assign) NSInteger brand;
@property (nonatomic, assign) NSInteger quality;
@property (nonatomic, assign) NSInteger person;
@property (nonatomic, strong) NSString *color;
@property (nonatomic, assign) BOOL isSelect;
@property (nonatomic, strong) UIButton *selectBtn;


@end

@implementation PromulgateVC1

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

-(void)loadingRequest
{
    
    _weekSelf(weakSelf);
    [BaseRequest GetCategoryListWithPageNo:0 PageSize:0 order:1 parentid:0 succesBlock:^(id data) {
        NSArray *models = [CategoryListModel modelsFromArray:data[@"categoryList"]];
        [weakSelf.dataDic setValue:models forKey:@"category"];
        self.dataArr = models;
    } failue:^(id data, NSError *error) {
        
    }];

    
    
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [super viewDidLoad];
    self.navigationItem.title = @"发布商品";
    [self initData];
    [self.view addSubview:self.tableView];
    [self setRightBarButtonWith:[UIImage imageNamed:@"感叹号"] selector:@selector(barButtonAction)];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tongzhi:) name:@"tongzhi" object:nil];
    self.isSelect = 0;

    
    [self loadingRequest];
}

-(void)initData
{
    self.firstArr = @[@"宝贝名称 (必填)",@"专柜价 (必填)",@"关键字描述 (必填)"];
    self.SecondArr = @[@"类别",@"品牌",@"颜色",@"成色",@"适用人群",@"附件"];
    self.cellDic = [[NSMutableDictionary alloc] init];
    self.uploadPhotoArr = [[NSMutableArray alloc] init];
    self.dataDic = [[NSMutableDictionary alloc] init];
    self.qualityArr = [[NSMutableArray alloc] initWithObjects:@"99成新（未使用）",@"98成新",@"95成新",@"9成新",@"85成新",@"8成新", nil];
    
}

-(void)barButtonAction
{
    [self PushViewControllerByClassName:@"HowToShootVC" info:nil];
    
}
#pragma mark -- UITabelViewDelegate And DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 2;
    }
    
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        if (indexPath.row == 0) {
            SummaryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SummaryCell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.delegate = self;
            [cell fillWithTitle:self.firstArr[indexPath.row]];
            return cell;

        }else{
            PromulgateVC1Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"promulgateCell"];
            cell.delegate = self;
            return cell;
        }
        
        
    }
    NSString *CellIdentifier = [NSString stringWithFormat:@"cell%ld%ld",(long)indexPath.section,(long)indexPath.row];//不使用复用
    
    TypeCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[TypeCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    [cell fillWithTitle:self.SecondArr[indexPath.row] andType:0];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.delegate = self;
    
    [self.cellDic setObject:cell forKey:self.SecondArr[indexPath.row]];
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0  && indexPath.row == 1) {
        return 70;
    }
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
    
    UIImage *image = [UIImage imageNamed:@"打钩-1"];
    UIButton *selectBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [selectBtn addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
    selectBtn.frame = VIEWFRAME(0, 0, 16.5, 16.5);
    [selectBtn setImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    self.selectBtn = selectBtn;
    
    UILabel *title = [UILabel createLabelWithFrame:VIEWFRAME(16.5,0 , 135, 16.5)
                                           andText:@"已阅读并同意BOOBE的"
                                      andTextColor:[UIColor colorWithHexColorString:@"a1a1a1"]
                                        andBgColor:[UIColor clearColor]
                                           andFont:SYSTEMFONT(12)
                                  andTextAlignment:NSTextAlignmentCenter];
    
    UIButton *explainBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [explainBtn setTitle:@"《用户协议》" forState:UIControlStateNormal];
    [explainBtn setTitleColor:APP_COLOR_GRAY_333333 forState:UIControlStateNormal];
    [explainBtn addTarget:self action:@selector(explainBtn:) forControlEvents:UIControlEventTouchUpInside];
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
    
//    [view addSubview:image];
    [view addSubview:selectBtn];
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
                //                NSDictionary *dic = @{@"title":@"类别"};
                [self.dataDic setValue:@"类别" forKey:@"title"];
                [self PushViewControllerByClassName:@"CommonVC" info:self.dataDic];
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
                NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
                [dic setValue:@"附件" forKey:@"title"];
                for (CategoryListModel *model in self.dataArr) {
                    if (self.selectCategory == [model.categoryid integerValue]) {
                        [dic setValue:model forKey:@"data"];
                    }
                }
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
        [_tableView registerClass:[PromulgateVC1Cell class] forCellReuseIdentifier:@"promulgateCell"];
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
    [self PushViewControllerByClassName:@"HowToShootVC" info:nil];
    
}


-(void)showTeachView
{
    [self PushViewControllerByClassName:@"HowToShootVC" info:nil];
    
}

- (void)tongzhi:(NSNotification *)text{
    
    if ([text.userInfo[@"class"] isEqualToString:@"附件"]) {
        self.enclosure = text.userInfo[@"data"];
        
    }else{
        
        TypeCell *cell = (TypeCell *)[self.cellDic valueForKey:text.userInfo[@"class"]];
        [cell changeTitle1:text.userInfo[@"name"]];
        
        if ([text.userInfo[@"class"] isEqualToString:@"类别"]) {
            self.selectCategory = [text.userInfo[@"categoryid"] integerValue];
            self.categoryid = [text.userInfo[@"category"] integerValue];
            self.category = text.userInfo[@"name"];
            self.enclosure = nil;
        }
        
        if ([text.userInfo[@"class"] isEqualToString:@"成色"]) {
            
            for (int i = 0;  i < self.qualityArr.count; i++) {
                NSString *str = self.qualityArr[i];
                if ([text.userInfo[@"name"] isEqualToString:str]) {
                    self.quality = i+1;
                }
            }
        }
        if ([text.userInfo[@"class"] isEqualToString:@"适用人群"]) {
            if ([text.userInfo[@"name"] isEqualToString:@"所有人"]) {
                self.person = 1;
            }else if ([text.userInfo[@"name"] isEqualToString:@"男士"]){
                self.person = 2;
            }else{
                self.person =3;
            }
        }
        if ([text.userInfo[@"class"] isEqualToString:@"品牌"]) {
            self.brand = [text.userInfo[@"brandid"] integerValue];
        }
        //        NSLog(@"－－－－－接收到通知  %@------",text.userInfo[@"class"]);
    }
    
    
    
}

-(void)promulgateBtn:(UIButton *)sender
{
    if (self.photoArr.count != 9) {
        [ProgressHUDHandler showHudTipStr:@"必须9张图"];
        return;
    }
    
    if (self.content.text.length < 1 || self.name.length < 1 || self.price.length < 1 || self.description.length < 1 || self.category.length < 1 || self.brand < 1 || self.color.length < 1 || self.quality < 1 || self.person < 1) {
        [ProgressHUDHandler showHudTipStr:@"请完善商品信息"];
        return;
    }
    if (!self.isSelect) {
        [ProgressHUDHandler showHudTipStr:@"请仔细阅读并同意用户协议"];
        return;
    }
    
    NSMutableArray *photo = [[NSMutableArray alloc] init];
    for (UIImage *image in self.photoArr) {
        NSData *image1 = UIImageJPEGRepresentation(image, 0.5);
        [photo addObject:image1];
    }
    [self.uploadPhotoArr removeAllObjects];
    
    
    //    _weekSelf(weakSelf);
    [CustomHUD createHudCustomShowContent:@"发布中"];
    
    //    [[GCQiniuUploadManager sharedInstance] registerWithScope:@"shexiangke-jcq" accessKey:@"e6m0BrZSOPhaz6K2TboadoayOp-QwLge2JOQZbXa" secretKey:@"RxiQnoa8NqIe7lzSip-RRnBdX9_pwOQmBBPqGWvv"];
    
    [[GCQiniuUploadManager sharedInstance] registerWithScope:@"production" accessKey:@"e6m0BrZSOPhaz6K2TboadoayOp-QwLge2JOQZbXa" secretKey:@"RxiQnoa8NqIe7lzSip-RRnBdX9_pwOQmBBPqGWvv"];
    
    [[GCQiniuUploadManager sharedInstance] createToken];
    
    [[GCQiniuUploadManager sharedInstance] uploadDatas:photo progress:^(float percent) {
        
    } oneTaskCompletion:^(NSError *error, NSString *link, NSInteger index) {
        
        NSArray *array = [link componentsSeparatedByString:@"/"];
        //        NSDictionary *dic = @{@"image":array[1]};
        [self.uploadPhotoArr addObject:array[1]];
        
    } allTasksCompletion:^{
        
        NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
        [params setValue:self.name forKey:@"name"];
//        [params setValue:self.descrip forKey:@"keyword"];
        [params setValue:@([self.price integerValue]) forKey:@"advancePrice"];
        [params setValue:self.uploadPhotoArr forKey:@"imgList"];
        [params setValue:@(self.categoryid) forKey:@"categoryid"];
        [params setValue:self.content.text forKey:@"description"];
        [params setValue:self.color forKey:@"color"];
        [params setValue:@(self.quality) forKey:@"condition"];
        [params setValue:@(self.person) forKey:@"crowd"];
        if (self.enclosure.count < 1) {
            [params setValue:@{} forKey:@"attachList"];
        }else{
            [params setValue:self.enclosure forKey:@"attachList"];
        }
        
        [params setObject:@(self.brand) forKey:@"brandid"];
        [BaseRequest SetPurchaseWithParams:params succesBlock:^(id data) {
            [CustomHUD stopHidden];
            [ProgressHUDHandler showHudTipStr:@"发布成功"];
            [self popGoBack];
            
        } failue:^(id data, NSError *error) {
            [ProgressHUDHandler showHudTipStr:@"发布失败"];
            [CustomHUD stopHidden];
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

-(void)SendTextValue:(NSString *)content title:(NSString *)title
{
    
    if ([title isEqualToString:@"宝贝名称 (必填)"]) {
        self.name = content;
    }else if ([title isEqualToString:@"专柜价 (必填)"]){
        float i = [content floatValue];
        NSString *str = [NSString stringWithFormat:@"%.2lf",i];
        float j = [str floatValue];
        self.price = [NSString stringWithFormat:@"%d",(NSInteger)j*100];
        
    }else if ([title isEqualToString:@"关键字描述 (必填)"]){
        self.descrip = content;
    }else{
        self.color = content;
    }
}

-(void)SendTextValue1:(NSString *)content title:(NSString *)title
{
    float i = [content floatValue];
    NSString *str = [NSString stringWithFormat:@"%.2lf",i];
    float j = [str floatValue];
    self.price = [NSString stringWithFormat:@"%d",(NSInteger)j*100];
}

-(void)explainBtn:(UIButton *)sender
{
    NSDictionary *dic = @{@"title":@"用户协议"};
    [self PushViewControllerByClassName:@"UserProtocolVC" info:dic];
}

-(void)selectAction:(UIButton *)sender
{
    if (self.isSelect) {
        self.isSelect = 0;
        UIImage *image = [UIImage imageNamed:@"打钩-1"];
        [self.selectBtn setImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    }else{
        self.isSelect = 1;
        UIImage *image = [UIImage imageNamed:@"打钩"];
        [self.selectBtn setImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
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
