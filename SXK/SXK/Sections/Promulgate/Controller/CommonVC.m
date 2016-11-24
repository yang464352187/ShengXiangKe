//
//  CommonVC.m
//  SXK
//
//  Created by 杨伟康 on 2016/11/23.
//  Copyright © 2016年 ywk. All rights reserved.
//

#import "CommonVC.h"
#import "CategoryCell.h"
#import "SecondCommonVC.h"
#import "qualityVC.h"
#import "SelectCell.h"

@interface CommonVC ()<qualityCellDelegate,SelectCellDelegate>

@property (nonatomic, strong)NSMutableArray *CategoryArr;
@property (nonatomic, strong)NSMutableArray *personArr;
@property (nonatomic, strong)NSMutableArray *qualityArr;
@property (nonatomic, strong)NSMutableArray *qualityContentArr;
@property (nonatomic, strong)NSMutableArray *enclosureArr;

@property (nonatomic, strong) qualityVC *selectCell;


@end

@implementation CommonVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = self.myDict[@"title"];
    if (![self.myDict[@"title"] isEqualToString:@"类别"] && ![self.myDict[@"title"] isEqualToString:@"附件"]) {
         [self setRightBarButtonWith:[NSString stringWithFormat:@"完成"] selector:@selector(barButtonAction)];
    }
    
    if ([self.myDict[@"title"] isEqualToString:@"附件"]) {
        [self setRightBarButtonWith:[NSString stringWithFormat:@"保存"] selector:@selector(barButtonAction)];
    }
    
    self.jt_navigationController.line.backgroundColor = [UIColor colorWithHexColorString:@"dcdcdc"];
    [self initData];
    [self.view addSubview:self.tableView];
}

-(void)barButtonAction
{
    //    NSArray * ctrlArray = self.jt_navigationController.viewControllers;
    //    [self.jt_navigationController popToViewController:[ctrlArray objectAtIndex:1] animated:YES];
    
  
    NSDictionary *dic = @{@"name":self.selectCell.name,@"class":self.myDict[@"title"]};
    NSLog(@"%@",describe(dic));
    NSNotification *notification =[NSNotification notificationWithName:@"tongzhi" object:nil userInfo:dic];
    //通过通知中心发送通知
    [[NSNotificationCenter defaultCenter] postNotification:notification];
    [self PopToIndexViewController:1];
}


-(void)initData
{
    self.CategoryArr = [[NSMutableArray alloc] initWithObjects:@"腕表",@"包袋",@"其他", nil];
    self.personArr = [[NSMutableArray alloc] initWithObjects:@"所有人",@"男士",@"女士", nil];
    self.qualityArr = [[NSMutableArray alloc] initWithObjects:@"99成新（未使用）",@"98成新",@"95成新",@"9成新",@"85成新",@"8成新", nil];
    self.qualityContentArr = [[NSMutableArray alloc] initWithObjects:@"未使用，包装配件齐全",@"包装配件不齐全，或因存放产生细微痕迹",@"未使用但有明显存放痕迹，或轻微适用痕迹",@"有使用痕迹，整体无变形或护理后状态非常好",@"有明显适用痕迹，整体轻微变形",@"有明显适用痕迹，整体状态有变化", nil];
    self.enclosureArr = [[NSMutableArray alloc] initWithObjects:@"表扣材质",@"表壳材质",@"表带材质", nil];


}
- (UITableView *)tableView{
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:VIEWFRAME(0, 0, SCREEN_WIDTH, SCREEN_HIGHT) style:UITableViewStyleGrouped];
        _tableView.dataSource      = self;
        _tableView.delegate        = self;
        [_tableView registerClass:[CategoryCell class] forCellReuseIdentifier:@"CategoryCell"];
        [_tableView registerClass:[qualityVC class] forCellReuseIdentifier:@"QualityCell"];
        [_tableView registerClass:[SelectCell class] forCellReuseIdentifier:@"SelectCell"];

        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.tableFooterView = [[UIView alloc] init];
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
    if ([self.myDict[@"title"] isEqualToString:@"类别"]) {
        return self.CategoryArr.count;
    }
    if ([self.myDict[@"title"] isEqualToString:@"适用人群"]) {
        return self.personArr.count;
    }
    if ([self.myDict[@"title"] isEqualToString:@"附件"]) {
        return self.enclosureArr.count;
    }

    
    return self.qualityArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.myDict[@"title"] isEqualToString:@"类别"]) {
        CategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CategoryCell"];
        [cell fillTitle:self.CategoryArr[indexPath.row]];
        return cell;

    }
    if ([self.myDict[@"title"] isEqualToString:@"适用人群"]) {
        SelectCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SelectCell"];
        [cell fillTitle:self.personArr[indexPath.row]];
        cell.delegate = self;
        return cell;
    }
    if ([self.myDict[@"title"] isEqualToString:@"附件"]) {
        CategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CategoryCell"];
        [cell fillTitle:self.enclosureArr[indexPath.row]];
        return cell;
    }
    
    qualityVC *cell = [tableView dequeueReusableCellWithIdentifier:@"QualityCell"];
    cell.delegate = self;
    [cell fillTitle:self.qualityArr[indexPath.row] andContent:self.qualityContentArr[indexPath.row]];
        return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([self.myDict[@"title"] isEqualToString:@"成色"]) {
        return 70;
    }
    return 52;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.0001;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = @{@"title":self.CategoryArr[indexPath.row],@"className":self.myDict[@"title"]};
    NSLog(@"%@",describe(dic));
    switch (indexPath.row) {
        case 0:{
            [self PushViewControllerByClassName:@"SecondCommonVC" info:dic];
        }
            break;
        case 1:{
            [self PushViewControllerByClassName:@"SecondCommonVC" info:dic];
            break;
        }
        case 2:{
//            [self PushViewControllerByClassName:@"SecondCommonVC" info:dic];
        }
            break;
            
        default:
            break;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    UILabel *title = [UILabel createLabelWithFrame:VIEWFRAME(23, 10, 60, 41)                                                 andText:@"宝贝附件"
                                      andTextColor:[UIColor blackColor]
                                        andBgColor:[UIColor clearColor]
                                           andFont:SYSTEMFONT(14)
                                  andTextAlignment:NSTextAlignmentLeft];
    NSArray *titleArr = [[NSArray alloc] initWithObjects:@"盒子",@"保修卡",@"说明书",@"发票",@"防尘袋", nil];
    int k = 0;
    for (int i = 0; i < 2; i++) {
        for (int j = 0; j <3; j++) {
            if (k == 5) {
                continue;
            }
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
            btn.frame = VIEWFRAME(100 + j*CommonWidth(85), 20+i*35, 70, 20);
            UIImage *image = [UIImage imageNamed:@"椭圆-1-拷贝"];
            [btn setImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
            UIImage *image1 = [UIImage imageNamed:@"打钩-1"];
            [btn setImage:[image1 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateSelected];
            [btn setTitle:titleArr[k] forState:UIControlStateNormal];
            btn.tag = 100 + k;
            [btn setTintColor:[UIColor blackColor]];
            btn.titleLabel.font = SYSTEMFONT(14);
            btn.imageEdgeInsets = UIEdgeInsetsMake(0,-10,0,0);
            [view addSubview:btn];
             k++;

        }
    }
    
    
//    view.backgroundColor = [UIColor redColor];
    [view addSubview:title];
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if ([self.myDict[@"title"] isEqualToString:@"附件"]) {
        
        return 100;
    }
    return 0.00000;
}


-(void)sendValue:(id)cell
{
    if (self.selectCell) {
        [self.selectCell isSelect];
        [(qualityVC *)cell isSelect];
        self.selectCell = (qualityVC *)cell;
    }else{
        [(qualityVC *)cell isSelect];
        self.selectCell = (qualityVC *)cell;
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
