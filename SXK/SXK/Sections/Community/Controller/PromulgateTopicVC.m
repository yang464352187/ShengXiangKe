//
//  PromulgateTopicVC.m
//  SXK
//
//  Created by 杨伟康 on 2016/12/13.
//  Copyright © 2016年 ywk. All rights reserved.
//

#import "PromulgateTopicVC.h"
#import "WSImagePickerView.h"
#import "FEPlaceHolderTextView.h"
#import "PromulgateTopicCell.h"
#import "ModuleModel.h"

@interface PromulgateTopicVC ()<WSImagePickerViewDelegate, PromulgateTopicDelegate>


@property (nonatomic, strong) WSImagePickerView *pickerView;
@property (strong, nonatomic) UIView            *headView;
@property (strong, nonatomic) FEPlaceHolderTextView       *content;
@property (nonatomic, assign) float heigh;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *photoViewHieghtConstrain;
@property (nonatomic, strong) NSArray *moduleArr;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, strong) NSArray *photoArr;
@property (nonatomic, strong) NSMutableArray *uploadPhotoArr;


@end

@implementation PromulgateTopicVC

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self.first == 0) {
        [self loadingRequest];
        self.first = 1;
    }

    
}

-(void)loadingRequest
{
    _weekSelf(weakSelf);
    
    [BaseRequest GetCommunityModuleWithPageNo:0 PageSize:0 order:1 succesBlock:^(id data) {
        NSArray *models = [ModuleModel modelsFromArray:data[@"moduleList"]];
        weakSelf.moduleArr = models;
        [weakSelf.tableView reloadData];
    } failue:^(id data, NSError *error) {
        
    }];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"社区";
    [self setRightBarButtonWith:@"发表" selector:@selector(barButtonAction)];
    
    self.uploadPhotoArr = [[NSMutableArray alloc] init];
   

    [self initUI];
}

-(void)barButtonAction
{
    if (self.type == 0) {
        [ProgressHUDHandler showHudTipStr:@"请选择分类"];
    }else if (self.content.text.length == 0)
    {
        [ProgressHUDHandler showHudTipStr:@"内容不能为空"];
    }else
    {
        NSMutableArray *photo = [[NSMutableArray alloc] init];
        for (UIImage *image in self.photoArr) {
            NSData *image1 = UIImageJPEGRepresentation(image, 0.5);
            [photo addObject:image1];
        }
        [CustomHUD createHudCustomShowContent:@"正在发布"];
        _weekSelf(weakSelf);

        [[GCQiniuUploadManager sharedInstance] registerWithScope:@"production" accessKey:@"e6m0BrZSOPhaz6K2TboadoayOp-QwLge2JOQZbXa" secretKey:@"RxiQnoa8NqIe7lzSip-RRnBdX9_pwOQmBBPqGWvv"];
        [[GCQiniuUploadManager sharedInstance] createToken];
        
        [[GCQiniuUploadManager sharedInstance] uploadDatas:photo progress:^(float percent) {
            
        } oneTaskCompletion:^(NSError *error, NSString *link, NSInteger index) {
            
            NSArray *array = [link componentsSeparatedByString:@"/"];
            
            [weakSelf.uploadPhotoArr addObject:array[1]];
            
        } allTasksCompletion:^{
            
            [BaseRequest AddCommunityTopicWithContent:self.content.text imgList:self.uploadPhotoArr moduleid:self.type succesBlock:^(id data) {
                [weakSelf popGoBack];
//                NSLog(@"---------%@-----------",describe(data));
                [CustomHUD stopHidden];
                [ProgressHUDHandler showHudTipStr:@"发布成功"];

            } failue:^(id data, NSError *error) {
                [ProgressHUDHandler showHudTipStr:@"发布失败"];

            }];
            
            
        }];

    }
}

-(void)initUI
{
    [self.view addSubview:self.tableView];
    

}
#pragma mark -- getters and setters


- (UITableView *)tableView{
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:VIEWFRAME(0, 0, SCREEN_WIDTH, SCREEN_HIGHT-64) style:UITableViewStyleGrouped];
        _tableView.dataSource      = self;
        _tableView.delegate        = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.tableHeaderView = self.headView;
        _tableView.backgroundColor = APP_COLOR_BASE_BACKGROUND;
        _tableView.tableFooterView = [[UIView alloc] init];
        [_tableView registerClass:[PromulgateTopicCell class] forCellReuseIdentifier:@"cell"];
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
        
        [_headView addSubview:self.content];
        
        
        WSImagePickerConfig *config = [WSImagePickerConfig new];
        config.itemSize = CGSizeMake(CommonHight(80), CommonHight(80));
        config.photosMaxCount = 9;
        
        WSImagePickerView *pickerView = [[WSImagePickerView alloc] initWithFrame:CGRectMake(0, CommonHight(100), SCREEN_WIDTH, 0) config:config];
        pickerView.type = 2;
        pickerView.delegate = self;
        __weak typeof(self) weakSelf = self;
        pickerView.viewHeightChanged = ^(CGFloat height) {
            [weakSelf.view setNeedsLayout];
            [weakSelf.view layoutIfNeeded];
            weakSelf.heigh = self.pickerView.frame.size.height;
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

#pragma mark -- UITabelViewDelegate And DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PromulgateTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.delegate = self;
    [cell fillWithArray:self.moduleArr];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return (SCREEN_HIGHT - self.headView.size.height-64-15);
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = APP_COLOR_GRAY_Header;

    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.00000001;
}

-(void)change
{
    NSArray *array = [_pickerView getPhotos];
    NSInteger i ,j;
    self.photoArr = array;
    j = array.count + 2;
    if (j <= 4) {
        i = 0;
    }else if (j > 4 && j <=8)
    {
        i = 1;
    }else{
        i = 2;
    }
    
    _headView.frame = VIEWFRAME(0, 0, SCREEN_WIDTH, (205.0000/667*SCREEN_HIGHT+CommonHight(80)*i)+10*i );

//    [self.tableView reloadData];
    self.tableView.tableHeaderView = _headView;
}

-(void)showTeachView
{
    
}
-(void)sendModuleID:(NSInteger)module
{
    self.type = module;
//    NSLog(@"%ld",self.type);
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
