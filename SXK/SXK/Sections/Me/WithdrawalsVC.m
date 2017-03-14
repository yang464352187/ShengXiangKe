//
//  WithdrawalsVC.m
//  SXK
//
//  Created by 杨伟康 on 2017/2/24.
//  Copyright © 2017年 ywk. All rights reserved.
//

#import "WithdrawalsVC.h"
#import "WithdrawalsCell.h"

@interface WithdrawalsVC ()<WithdrawalsCellDelegate>

@property (nonatomic, strong) NSArray *dataArr;

@property (nonatomic, assign) NSInteger amount;

@property (nonatomic, strong) NSString *cardNumber;

@property (nonatomic, strong) NSString *bank;

@property (nonatomic, strong) NSString *branch;

@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) NSString *code;


@end

@implementation WithdrawalsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"提现";
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];//设置电池条颜色为黑色
    self.dataArr = @[@"请输入提现金额",@"请输入提现卡号",@"开户银行",@"所属支行",@"开户人姓名",@"请输入验证码"];
    [self.view addSubview:self.tableView];
    
}


#pragma mark -- UITabelViewDelegate And DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WithdrawalsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WithdrawalsCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell fillWithTitle:self.dataArr[indexPath.row]];
    cell.delegate = self;
    cell.type = indexPath.row;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 54;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.00000001;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 100;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = APP_COLOR_GRAY_Header;
    
    UIButton *certainBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [certainBtn setTitle:@"申请提现" forState:UIControlStateNormal];
    certainBtn.backgroundColor = APP_COLOR_GREEN;
    [certainBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    certainBtn.titleLabel.font = SYSTEMFONT(14);
    certainBtn.frame = VIEWFRAME(15, 60, CommonWidth(335), 40);
    [certainBtn addTarget:self action:@selector(payAction:) forControlEvents:UIControlEventTouchUpInside];
    ViewRadius(certainBtn, certainBtn.frame.size.height/2);
    
    [view addSubview:certainBtn];
    
    return view;
}




- (UITableView *)tableView{
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:VIEWFRAME(0, 0, SCREEN_WIDTH, SCREEN_HIGHT-64) style:UITableViewStyleGrouped];
        _tableView.dataSource      = self;
        _tableView.delegate        = self;
        [_tableView registerClass:[WithdrawalsCell class] forCellReuseIdentifier:@"WithdrawalsCell"];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.backgroundColor = [UIColor colorWithHexColorString:@"f7f7f7"];
        _tableView.tableFooterView = [[UIView alloc] init];
        //      _tableView.tableHeaderView = self.headView;
        _tableView.separatorStyle  = UITableViewCellSeparatorStyleSingleLine;
        _tableView.sectionHeaderHeight = 0.0;
        _tableView.sectionFooterHeight = 0.0;
        
    }
    return _tableView;
}

-(void)returnText:(NSString *)text type:(NSInteger)type
{

    switch (type) {
        case 0:{
            self.amount = [text floatValue] * 100;
            break;
        }
        case 1:{
            self.cardNumber = text;
            break;
        }
        case 2:{
            self.bank = text;
            break;
        }
        case 3:{
            self.branch = text;
            break;
        }
        case 4:{
            self.name = text;
            break;
        }
        case 5:{
            self.code = text;
            break;
        }
        
        


            
        default:
            break;
    }
    
    
    
}

-(void)payAction:(UIButton *)sender
{
    
    CGFloat money = [self.myDict[@"money"] floatValue] / 100;

    if (self.amount == 0) {
        [ProgressHUDHandler showHudTipStr:@"金额不能为0"];
        return;
    }
    
    if (money < self.amount) {
        [ProgressHUDHandler showHudTipStr:@"余额不足"];
        return;
    }

    if ( ![self checkCardNo:self.cardNumber]) {
        [ProgressHUDHandler showHudTipStr:@"请输入正确的银行卡号"];
        return;
    }
    if (self.bank.length == 0) {
        [ProgressHUDHandler showHudTipStr:@"请输入开户行"];
        return;
    }
    if (self.branch.length == 0) {
        [ProgressHUDHandler showHudTipStr:@"请输入所属支行"];
        return;
    }
    if (self.name.length == 0) {
        [ProgressHUDHandler showHudTipStr:@"请输入姓名"];
        return;
    }
    if (self.code.length == 0) {
        [ProgressHUDHandler showHudTipStr:@"请输入验证码"];
        return;
    }
    
    _weekSelf(weakSelf);
    [BaseRequest WithdrawalsWithAmount:self.amount cardNumber:self.cardNumber bank:self.bank branch:self.branch name:self.name code:self.code succesBlock:^(id data) {
        [ProgressHUDHandler showHudTipStr:@"申请提现成功"];
        [weakSelf popGoBack];
        
    } failue:^(id data, NSError *error) {
        
    }];
    
}


- (BOOL) checkCardNo:(NSString*) cardNo{
    int oddsum = 0;     //奇数求和
    int evensum = 0;    //偶数求和
    int allsum = 0;
    int cardNoLength = (int)[cardNo length];
    int lastNum = [[cardNo substringFromIndex:cardNoLength-1] intValue];
    
    cardNo = [cardNo substringToIndex:cardNoLength - 1];
    for (int i = cardNoLength -1 ; i>=1;i--) {
        NSString *tmpString = [cardNo substringWithRange:NSMakeRange(i-1, 1)];
        int tmpVal = [tmpString intValue];
        if (cardNoLength % 2 ==1 ) {
            if((i % 2) == 0){
                tmpVal *= 2;
                if(tmpVal>=10)
                    tmpVal -= 9;
                evensum += tmpVal;
            }else{
                oddsum += tmpVal;
            }
        }else{
            if((i % 2) == 1){
                tmpVal *= 2;
                if(tmpVal>=10)
                    tmpVal -= 9;
                evensum += tmpVal;
            }else{
                oddsum += tmpVal;
            }
        }
    }
    
    allsum = oddsum + evensum;
    allsum += lastNum;
    if((allsum % 10) == 0)
        return YES;
    else
        return NO;
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
