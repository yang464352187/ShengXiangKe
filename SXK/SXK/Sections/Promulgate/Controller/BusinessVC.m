//
//  BusinessVC.m
//  SXK
//
//  Created by 杨伟康 on 2017/3/14.
//  Copyright © 2017年 ywk. All rights reserved.
//

#import "BusinessVC.h"
#import "BoobeBussinessCell.h"
#import "BoobeBussinessCell1.h"

@interface BusinessVC ()

@property (nonatomic, strong) UIView *headView;

@property (nonatomic, strong) NSMutableArray *dataArr;

@property (nonatomic, strong) NSMutableArray *dataArr1;

@property (nonatomic, strong) NSMutableArray *dataArr2;

@property (nonatomic, strong) NSMutableArray *dataArr3;

@end

@implementation BusinessVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"啵呗寄卖";
    [self.view addSubview:self.tableView];
    [self initUI];
}

-(void)initUI
{
    self.dataArr = [[NSMutableArray alloc] initWithObjects:@"1、提交预约后，将放有预约号的商品寄至平台",@"2、平台签收后进行鉴定与估价。",@"3、您接收估价后平台为您发布商品，等待买家下单",@"4、交易完成后，平台收取服务费，打款至您啵呗账号", nil];
    
    self.dataArr1 = [[NSMutableArray alloc] initWithObjects:@"平台仅支持品牌正品，品牌与类别符合平台标准（详见“添加寄卖商品”中可选的品牌与类别）", nil];
    
    self.dataArr2 = [[NSMutableArray alloc] initWithObjects:@"结合闲置奢侈品估价体系的折扣、商品最新市场价，再由估价师按照使用程度来进行估价。一般为专柜购入价的3-5折。卖家可在一定价格区间内（估价上下浮动25%）选择价格",@"退回商品可能是由于成色太旧、品牌或品类不支持、商品不具备交易价值、鉴定不服（平台仅支持品牌正品）。退回商品将以顺丰到付的形式退回给您",@"商品上架一个月内若想召回，需收取您商品售卖价的5%-10%服务费。一个月后进行召回，平台不会收取您任何费用。所有商品均使用顺风到付的形式按照您预约填写的回寄地址邮寄给您" ,nil];
    
    self.dataArr3 = [[NSMutableArray alloc] initWithObjects:@"1、估价的标准有哪些?",@"2、商品为什么被退回",@"3、寄到平台不想卖了，想召回怎么办？" ,nil];
    
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn setTitle:@"开始预约寄卖" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.backgroundColor = APP_COLOR_GREEN;
    [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn];
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(57);
    }];
    
    
}
- (UITableView *)tableView{
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:VIEWFRAME(0, 0, SCREEN_WIDTH, SCREEN_HIGHT-64-44) style:UITableViewStyleGrouped];
        _tableView.dataSource      = self;
        _tableView.delegate        = self;
        _tableView.showsVerticalScrollIndicator = NO;
        [_tableView registerClass:[BoobeBussinessCell class] forCellReuseIdentifier:@"BoobeBussinessCell"];
        [_tableView registerClass:[BoobeBussinessCell1 class] forCellReuseIdentifier:@"BoobeBussinessCell1"];
        _tableView.backgroundColor = [UIColor colorWithHexColorString:@"f7f7f7"];
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
        
        _headView = [[UIView alloc] initWithFrame:VIEWFRAME(0, 0, SCREEN_WIDTH, (895.000/750*SCREEN_WIDTH +  336.0000/666*(SCREEN_WIDTH-30) -150))];
        _headView.backgroundColor = [UIColor colorWithHexColorString:@"f7f7f7"];

        
        UIImageView *image = [[UIImageView alloc] initWithFrame:VIEWFRAME(0, 0, SCREEN_WIDTH, 895.000/750*SCREEN_WIDTH)];
//        image.image = [self imageCompressForWidth:[UIImage imageNamed:@"啵呗寄卖"] targetWidth:SCREEN_WIDTH];
        image.image = [UIImage imageNamed:@"图层-0"];
        
        
        UIImageView *image1 = [[UIImageView alloc] initWithFrame:VIEWFRAME(0, 0, SCREEN_WIDTH, 895.000/750*SCREEN_WIDTH)];
        //        image.image = [self imageCompressForWidth:[UIImage imageNamed:@"啵呗寄卖"] targetWidth:SCREEN_WIDTH];
        image1.image = [UIImage imageNamed:@"寄卖流程"];

        [_headView addSubview:image];
        [_headView addSubview:image1];
        
        [image mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_headView).offset(0);
            make.left.equalTo(_headView.mas_left).offset(0);
            make.right.equalTo(_headView.mas_right).offset(0);
            make.height.mas_equalTo(@(895.000/750*SCREEN_WIDTH));
        }];
        
        [image1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_headView.mas_left).offset(15);
            make.right.equalTo(_headView.mas_right).offset(-15);
            make.top.equalTo(image.mas_bottom).offset(-150);
            make.height.mas_equalTo(@(336.0000/666*(SCREEN_WIDTH-30)));
        }];

    }
    
    return _headView;
}

#pragma mark -- UITabelViewDelegate And DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return self.dataArr.count;
    }
    if (section == 2) {
        return self.dataArr2.count;
    }
    
    
    return self.dataArr1.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 2) {
        BoobeBussinessCell1 *cell = [tableView dequeueReusableCellWithIdentifier:@"BoobeBussinessCell1"];
        [cell fillWithTitle:self.dataArr3[indexPath.row] andContent:self.dataArr2[indexPath.row]];
        return cell;
    }
    
    
    
    BoobeBussinessCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BoobeBussinessCell"];
    
    if (indexPath.section == 0) {
        [cell fillTitleWithContent:self.dataArr[indexPath.row]];

    }else{
        [cell fillTitleWithContent:self.dataArr1[indexPath.row]];
    }
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *str;
    if (indexPath.section == 0) {
        str = self.dataArr[indexPath.row];
    }else if (indexPath.section == 1){
        str = self.dataArr1[indexPath.row];
    }else{
        str = self.dataArr2[indexPath.row];
        
    }
    
    
    CGFloat height = [UILabel getHeightByWidth:SCREEN_WIDTH-30 title:str font:SYSTEMFONT(14)];
    
    if (indexPath.section ==2) {
        return height+30;
    }
    
    return height+10;

}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 2) {
        UIView *view = [[UIView alloc] init];
        
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = APP_COLOR_GRAY_Font;
        
        UILabel *label = [UILabel createLabelWithFrame:VIEWFRAME(15, 0, 150, 53)                                                 andText:@"常见问题解答"
                                          andTextColor:[UIColor blackColor]
                                            andBgColor:[UIColor clearColor]
                                               andFont:[UIFont boldSystemFontOfSize:16.0]
                                      andTextAlignment:NSTextAlignmentCenter];
        
        [view addSubview:label];
        [view addSubview:line];
        
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(view.mas_left).offset(0);
            make.right.equalTo(view.mas_right).offset(0);
            make.top.equalTo(view.mas_top).offset(30);
            make.bottom.equalTo(view.mas_bottom).offset(0);
        }];
        
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(view.mas_left).offset(0);
            make.right.equalTo(view.mas_right).offset(0);
            make.top.equalTo(view.mas_top).offset(30);
            make.height.mas_equalTo(@(0.5));
        }];
        
        return view;
    }
    
    
    
    NSString *str;
    if (section == 0) {
        str = @"规则说明";
    }else{
        str = @"寄卖商品要求";
    }
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor colorWithHexColorString:@"f7f7f7"];
    
    UIView *view1 = [[UIView alloc] init];
    view1.backgroundColor = APP_COLOR_GREEN;
    
    UILabel *label = [UILabel createLabelWithFrame:VIEWFRAME(15, 0, 150, 53)                                                 andText:str
                                      andTextColor:[UIColor blackColor]
                                        andBgColor:[UIColor clearColor]
                                           andFont:[UIFont boldSystemFontOfSize:16.0]
                                  andTextAlignment:NSTextAlignmentLeft];

    
    [view addSubview:view1];
    [view addSubview:label];
    
    [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view.mas_left).offset(15);
        make.centerY.equalTo(view);
        make.size.mas_equalTo(CGSizeMake(5, 16));
    }];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view1.mas_right).offset(5);
        make.centerY.equalTo(view1);
        make.size.mas_equalTo(CGSizeMake(150, 16));
    }];
    
    
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 2) {
        return 100;
    }
    return 50;
}



//指定宽度按比例缩放
-(UIImage *)imageCompressForWidth:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth{
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = defineWidth;
    CGFloat targetHeight = height / (width / targetWidth);
    CGSize size = CGSizeMake(targetWidth, targetHeight);
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0, 0.0);
    
    if(CGSizeEqualToSize(imageSize, size) ==NO){
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if(widthFactor > heightFactor){
            scaleFactor = widthFactor;
        }else{
            scaleFactor = heightFactor;
        }
        scaledWidth = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        if(widthFactor > heightFactor){
            thumbnailPoint.y = (targetHeight - scaledHeight) *0.5;
        }else if(widthFactor < heightFactor){
            thumbnailPoint.x = (targetWidth - scaledWidth) *0.5;
        }
    }
    
    UIGraphicsBeginImageContext(size);
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    [sourceImage drawInRect:thumbnailRect];
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    if(newImage == nil){
        NSLog(@"scale image fail");
    }
    UIGraphicsEndImageContext();
    return newImage;
}


-(void)btnAction:(UIButton *)sender
{
    if (![LoginModel isLogin]) {
        [ProgressHUDHandler showHudTipStr:@"请先登录"];
        [[PushManager sharedManager] presentLoginVC];
        return;
    }

    [self PushViewControllerByClassName:@"BusinessVC1" info:nil];
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
