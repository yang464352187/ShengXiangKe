//
//  FreeAppraiseVC.m
//  SXK
//
//  Created by 杨伟康 on 2017/2/10.
//  Copyright © 2017年 ywk. All rights reserved.
//

#import "FreeAppraiseVC.h"
#import "WSImagePickerView.h"
#import "FEPlaceHolderTextView.h"
#import "PromulgateTopicCell.h"
#import "ModuleModel.h"
#import "FreeAppraiseCell.h"

@interface FreeAppraiseVC ()<WSImagePickerViewDelegate>

@property (nonatomic, strong) WSImagePickerView *pickerView;
@property (strong, nonatomic) UIView            *headView;
@property (strong, nonatomic) FEPlaceHolderTextView       *content;
@property (nonatomic, assign) float heigh;
@property (nonatomic, strong) NSArray *photoArr;
@property (nonatomic, strong) NSMutableArray *uploadPhotoArr;


@end

@implementation FreeAppraiseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"免费鉴定";
    
    [self initUI];

}

-(void)initUI
{
    [self.view addSubview:self.tableView];
}

#pragma mark -- UITabelViewDelegate And DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FreeAppraiseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FreeAppraiseCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return 150;
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
    view.backgroundColor = APP_COLOR_GRAY_Header;
    
    UIButton *certainBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [certainBtn setTitle:@"提交鉴定" forState:UIControlStateNormal];
    certainBtn.backgroundColor = APP_COLOR_GREEN;
    [certainBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    certainBtn.titleLabel.font = SYSTEMFONT(14);
    certainBtn.frame = VIEWFRAME(15, 20, CommonWidth(335), 40);
    [certainBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    ViewRadius(certainBtn, certainBtn.frame.size.height/2);
    
    [view addSubview:certainBtn];
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 60;
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
        [_tableView registerClass:[FreeAppraiseCell class] forCellReuseIdentifier:@"FreeAppraiseCell"];
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
        pickerView.type = 1;
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

-(void)buttonClick:(UIButton *)sender
{
    if (self.photoArr.count != 9) {
        [ProgressHUDHandler showHudTipStr:@"必须9张图"];
        return;
    }else if (self.content.text.length == 0)
    {
        [ProgressHUDHandler showHudTipStr:@"内容不能为空"];
        return;
    }else
    {
        NSMutableArray *photo = [[NSMutableArray alloc] init];
        for (UIImage *image in self.photoArr) {
            NSData *image1 = UIImageJPEGRepresentation(image, 0.5);
            [photo addObject:image1];
        }
        [CustomHUD createHudCustomShowContent:@"正在提交"];
        _weekSelf(weakSelf);
        
        [[GCQiniuUploadManager sharedInstance] registerWithScope:@"shexiangke-jcq" accessKey:@"e6m0BrZSOPhaz6K2TboadoayOp-QwLge2JOQZbXa" secretKey:@"RxiQnoa8NqIe7lzSip-RRnBdX9_pwOQmBBPqGWvv"];
        [[GCQiniuUploadManager sharedInstance] createToken];
        
        [[GCQiniuUploadManager sharedInstance] uploadDatas:photo progress:^(float percent) {
            
        } oneTaskCompletion:^(NSError *error, NSString *link, NSInteger index) {
            
            NSArray *array = [link componentsSeparatedByString:@"/"];
            
            [weakSelf.uploadPhotoArr addObject:array[1]];
            
        } allTasksCompletion:^{
            
            [BaseRequest AddCommunityTopicWithContent:self.content.text imgList:self.uploadPhotoArr moduleid:1 succesBlock:^(id data) {
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
