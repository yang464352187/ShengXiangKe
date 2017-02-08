//
//  OrderReturnVC.m
//  SXK
//
//  Created by 杨伟康 on 2017/2/6.
//  Copyright © 2017年 ywk. All rights reserved.
//

#import "OrderReturnVC.h"
#import "WSImagePickerView.h"
#import "OrderReturnCell.h"
#import "OrderReturnCell1.h"
@interface OrderReturnVC ()<WSImagePickerViewDelegate,OrderReturnCell1Delegate>

@property (strong, nonatomic) UIView            *headView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *photoViewHieghtConstraint;
@property (nonatomic, strong) WSImagePickerView *pickerView;
@property (nonatomic, assign) float heigh;
@property (nonatomic, strong) NSArray *photoArr;

@property (nonatomic, strong) NSString *backOddNumber;
@property (nonatomic, strong) NSString *comment;
@property (nonatomic, strong) NSMutableArray *uploadPhotoArr;
@end

@implementation OrderReturnVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"寄回拍照";
    [self.view addSubview:self.tableView];
    self.uploadPhotoArr = [[NSMutableArray alloc] init];

}


#pragma mark -- UITabelViewDelegate And DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    OrderReturnCell1 *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderReturnCell1"];
    if (indexPath.section == 0) {
        [cell fillWithTitle:@"请输入单号"];
    }else{
        [cell fillWithTitle:@"请输入评论"];
    }
    cell.delegate = self;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        return 80;
    }
    return 30;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 1) {
        return 100;
    }
    return 0.0000000001;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor whiteColor];
    return view;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor whiteColor];
    
    if (section == 1) {
        UIButton *certainBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [certainBtn setTitle:@"确认寄回" forState:UIControlStateNormal];
        certainBtn.backgroundColor = APP_COLOR_GREEN;
        [certainBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        certainBtn.titleLabel.font = SYSTEMFONT(14);
        certainBtn.frame = VIEWFRAME(15, 50, CommonWidth(335), 40);
        [certainBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        ViewRadius(certainBtn, certainBtn.frame.size.height/2);
        [view addSubview:certainBtn];

    }
    return view;
}


#pragma mark -- getters and setters


- (UITableView *)tableView{
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:VIEWFRAME(0, 0, SCREEN_WIDTH, SCREEN_HIGHT-64) style:UITableViewStyleGrouped];
        _tableView.dataSource      = self;
        _tableView.delegate        = self;
        [_tableView registerClass:[OrderReturnCell class] forCellReuseIdentifier:@"OrderReturnCell"];
        [_tableView registerClass:[OrderReturnCell1 class] forCellReuseIdentifier:@"OrderReturnCell1"];
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
        _headView = [[UIView alloc] initWithFrame:VIEWFRAME(0, 0, SCREEN_WIDTH, (100.0000/667*SCREEN_HIGHT))];
        _headView.backgroundColor = [UIColor whiteColor];
        
        UIButton *shootBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        shootBtn.frame = VIEWFRAME(CommonWidth(15), CommonHight(105), CommonHight(111.5), CommonHight(111.5));
        UIImage *image = [UIImage imageNamed:@"拍摄"];
        [shootBtn setImage:[image imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)] forState:UIControlStateNormal];
        
        UIButton *HshootBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        HshootBtn.frame = VIEWFRAME(CommonWidth(139), CommonHight(105), CommonHight(111.5), CommonHight(111.5));
        UIImage *image1 = [UIImage imageNamed:@"如何-拍摄"];
        [HshootBtn setImage:[image1 imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)] forState:UIControlStateNormal];
//        [HshootBtn addTarget:self action:@selector(BtnAction:) forControlEvents:UIControlEventTouchUpInside];
        
//        [_headView addSubview:self.content];
        WSImagePickerConfig *config = [WSImagePickerConfig new];
        config.itemSize = CGSizeMake(CommonHight(80), CommonHight(80));
        config.photosMaxCount = 9;
        
        WSImagePickerView *pickerView = [[WSImagePickerView alloc] initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 0) config:config];
        
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
    
    _headView.frame = VIEWFRAME(0, 0, SCREEN_WIDTH, (118.0000/667*SCREEN_HIGHT+CommonHight(80)*i)+10*i );
    self.tableView.tableHeaderView = _headView;
    //    [self.tableView reloadData];
    
}

-(void)showTeachView
{
    [self PushViewControllerByClassName:@"HowToShootVC" info:nil];
}

-(void)returnTitle:(NSString *)title Content:(NSString *)content
{
    if ([title isEqualToString:@"请输入单号"]) {
        self.backOddNumber = content;
    }else{
        self.comment = content;
    }
//    NSLog(@"%@    %@",title,content);
}


-(void)buttonClick:(UIButton *)sender
{
    if (self.photoArr.count != 9) {
        [ProgressHUDHandler showHudTipStr:@"必须9张图"];
        return;
    }
    if (self.backOddNumber.length == 0 ) {
        [ProgressHUDHandler showHudTipStr:@"请输入单号"];
        return;
    }
    if (self.comment.length == 0 ) {
        [ProgressHUDHandler showHudTipStr:@"请输入评论"];
        return;
    }

    NSMutableArray *photo = [[NSMutableArray alloc] init];
    for (UIImage *image in self.photoArr) {
        NSData *image1 = UIImageJPEGRepresentation(image, 0.5);
        [photo addObject:image1];
    }
    [self.uploadPhotoArr removeAllObjects];
    
    
    [CustomHUD createHudCustomShowContent:@"发布中"];
    
    [[GCQiniuUploadManager sharedInstance] registerWithScope:@"shexiangke-jcq" accessKey:@"e6m0BrZSOPhaz6K2TboadoayOp-QwLge2JOQZbXa" secretKey:@"RxiQnoa8NqIe7lzSip-RRnBdX9_pwOQmBBPqGWvv"];
    [[GCQiniuUploadManager sharedInstance] createToken];
    
    [[GCQiniuUploadManager sharedInstance] uploadDatas:photo progress:^(float percent) {
        
    } oneTaskCompletion:^(NSError *error, NSString *link, NSInteger index) {
        
        NSArray *array = [link componentsSeparatedByString:@"/"];
        //        NSDictionary *dic = @{@"image":array[1]};
        [self.uploadPhotoArr addObject:array[1]];
        
    } allTasksCompletion:^{
        
//        NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
//        [params setValue:self.comment forKey:@"content"];
//        [params setValue: forKey:@"orderid"];
//        [params setValue:self.uploadPhotoArr forKey:@"imgList"];
        
        [BaseRequest AddRentCommentWithContent:self.comment imgList:self.uploadPhotoArr orderid:[self.myDict[@"orderid"] integerValue] succesBlock:^(id data) {
            
            [BaseRequest ConfirmOrderWithRentID:[self.myDict[@"orderid"] integerValue] backOddNumber:self.backOddNumber succesBlock:^(id data) {
                
                [CustomHUD stopHidden];
                [ProgressHUDHandler showHudTipStr:@"提交成功"];
                [self popGoBack];

            } failue:^(id data, NSError *error) {
                [CustomHUD stopHidden];
                [ProgressHUDHandler showHudTipStr:@"提交失败"];

                
            }];
            
            
        } failue:^(id data, NSError *error) {
            
        }];
        
    }];

    
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
