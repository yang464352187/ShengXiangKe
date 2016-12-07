//
//  AddAddress.m
//  SXK
//
//  Created by 杨伟康 on 2016/12/6.
//  Copyright © 2016年 ywk. All rights reserved.
//

#import "AddAddress.h"
#import "AddAddressCell.h"
#import "FEPlaceHolderTextView.h"
#import "AppDelegate.h"
#import "DQAreasView.h"
#import "DQAreasModel.h"
#import "AddressModel.h"

@interface AddAddress ()<DQAreasViewDelegate,AddAddressDelegate>


@property (nonatomic, strong)NSMutableArray *dataArray;
@property (nonatomic, strong)UIView *footerView;
@property (nonatomic, strong)FEPlaceHolderTextView *textView;
@property (nonatomic, strong)DQAreasView *areasView;//所在地
@property (nonatomic, strong)AddAddressCell *addressCell;
@property (nonatomic, strong)NSString *phoneNum;
@property (nonatomic, strong)NSString *name;
@property (nonatomic, strong)NSString *address;
@property (nonatomic, strong)NSString *province;
@property (nonatomic, strong)NSString *city;
@property (nonatomic, strong)NSString *area;
@property (nonatomic, strong)UITextField *firstTF;
@property (nonatomic, strong)AddressModel *model;


@end

@implementation AddAddress

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = self.myDict[@"title"];
    [self initDataArray];
    [self.view addSubview:self.tableView];
    self.areasView = [DQAreasView new];
    self.areasView.delegate = self;
    


}

-(void)initDataArray
{
    self.dataArray = [[NSMutableArray alloc] initWithObjects:@"请输入收货人姓名",@"请输入联系电话",@"请选择地区街道", nil];
    AddressModel *model = self.myDict[@"model"];
    if (model) {
        self.model = model;
        self.phoneNum = model.mobile;
        self.name = model.name;
        self.address = model.address;
        self.province = model.state;
        self.city = model.city;
        self.area = model.district;
    }
}

#pragma mark -- getters and setters
- (UITableView *)tableView{
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:VIEWFRAME(0, 0, SCREEN_WIDTH, SCREEN_HIGHT+44) style:UITableViewStyleGrouped];
        _tableView.dataSource      = self;
        _tableView.delegate        = self;
        [_tableView registerClass:[AddAddressCell class] forCellReuseIdentifier:@"AddAddressCell"];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.backgroundColor = [UIColor colorWithHexColorString:@"f7f7f7"];
        _tableView.tableFooterView = self.footerView;
        //        _tableView.tableHeaderView = [[UIView alloc] init];
        _tableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
        _tableView.sectionHeaderHeight = 0.0;
        _tableView.sectionFooterHeight = 0.0;
        
    }
    return _tableView;
}


-(UIView *)footerView
{
    if (!_footerView) {
        _footerView = [[UIView alloc] initWithFrame:VIEWFRAME(0, 0, SCREEN_WIDTH, 180)];
        _footerView.backgroundColor = [UIColor colorWithHexColorString:@"f7f7f7"];
        
        UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [addBtn setTitle:@"保存" forState:UIControlStateNormal];
        addBtn.backgroundColor = APP_COLOR_GREEN;
        [addBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [addBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        addBtn.tag = 101;
        addBtn.titleLabel.font = SYSTEMFONT(14);
        addBtn.frame = VIEWFRAME(20, 120, SCREEN_WIDTH - 40, 40);
        ViewRadius(addBtn, addBtn.frame.size.height/2);
        
        UIView *view = [[UIView alloc] initWithFrame:VIEWFRAME(0, 0, SCREEN_WIDTH, 96)];
        view.backgroundColor = [UIColor whiteColor];
        
        if (self.model) {
            self.textView.text = self.model.address;
        }

        
        [view addSubview:self.textView];
        [_footerView addSubview:view];
        [_footerView addSubview:addBtn];

    }
    return _footerView;
}

-(UITextView *)textView
{
    if (!_textView) {
        _textView = [[FEPlaceHolderTextView alloc] initWithFrame:VIEWFRAME(15, 0, SCREEN_WIDTH-21-22, 96)];
        _textView.backgroundColor = [UIColor whiteColor];
        _textView.placeholder = @"请输入您的个人简介";
        _textView.placeholderColor = [UIColor colorWithRed:188.0f/255.0f green:188.0/255.0f blue:188.0/255.0f alpha:1];
        [_textView setFont:SYSTEMFONT(14)];
    }
    return _textView;
}

#pragma mark -- UITabelViewDelegate And DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AddAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AddAddressCell"];
    [cell fillWithPlaceholder:self.dataArray[indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.delegate = self;
    if (self.model) {
        [cell fillWithContent:self.model];
    }
    if (indexPath.row == 2) {
        self.addressCell = cell;
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 52;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 13;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor colorWithHexColorString:@"f7f7f7"];
    return view;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor colorWithHexColorString:@"f7f7f7"];
    return view;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 2) {
//        [self.addressView show];
        [self.areasView startAnimationFunction];
        [self.firstTF resignFirstResponder];
        [self.textView resignFirstResponder];
    }
}



//点击选中哪一行 的代理方法
- (void)clickAreasViewEnsureBtnActionAreasDate:(DQAreasModel *)model{
    
    NSLog(@"%@",  [NSString stringWithFormat:@"%@%@%@",model.Province,model.city,model.county]);
    [self.addressCell changeAddress:[NSString stringWithFormat:@"%@ %@ %@",model.Province,model.city,model.county]];
    self.province =  model.Province;
    self.city = model.city;
    self.area = model.county;
    self.address = [NSString stringWithFormat:@"%@ %@ %@",model.Province,model.city,model.county];
}

-(void)sendInfo:(NSString *)info andType:(NSInteger)type
{
    if (type == 1) {
        self.name = info;
    }else{
        self.phoneNum = info;
    }
    
}

-(void)becomeFirstResponce:(UITextField *)firstTF
{
    self.firstTF = firstTF;
}

-(void)buttonAction:(UIButton *)sender
{
    [self.firstTF resignFirstResponder];
    [self.textView resignFirstResponder];
    _weekSelf(weakSelf);

    
    if (self.name.length < 1 || self.name.length > 50) {
        [ProgressHUDHandler showHudTipStr:@"请输入正确的名字"];
    }else if (![self isMobileNumber:self.phoneNum]) {
        [ProgressHUDHandler showHudTipStr:@"请输入正确的手机号"];
    }else if (self.textView.text.length < 1 || self.textView.text.length > 200 || self.province.length < 1){
        [ProgressHUDHandler showHudTipStr:@"请填写完整地址"];
    }else{
        if ([self.navigationItem.title isEqualToString:@"添加地址"]) {
                [BaseRequest addAddressWithname:self.name phone:self.phoneNum state:self.province city:self.city district:self.area address:self.textView.text succesBlock:^(id data) {
                    [weakSelf popGoBack];
                } failue:^(id data, NSError *error) {
                }];
        }else{
            
            if ([self params].count < 2) {
                [self popGoBack];
            }else{
                [BaseRequest ChangeAddressWithParams:[self params] succesBlock:^(id data) {
                    [weakSelf popGoBack];
                } failue:^(id data, NSError *error) {
                
                }];
            }
//            [BaseRequest ChangeAddressWithname:self.name phone:self.phoneNum state:self.province city:self.city district:self.area address:self.textView.text index:self.model.receiverid succesBlock:^(id data) {
//                NSLog(@"----------data%@----------",data);
//                [weakSelf popGoBack];
//            } failue:^(id data, NSError *error) {
//            }];
            
            
        }
    }
}


// 正则判断手机号码地址格式
- (BOOL)isMobileNumber:(NSString *)mobileNum {
    
    //    电信号段:133/153/180/181/189/177
    //    联通号段:130/131/132/155/156/185/186/145/176
    //    移动号段:134/135/136/137/138/139/150/151/152/157/158/159/182/183/184/187/188/147/178
    //    虚拟运营商:170
    
    NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|7[06-8])\\d{8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    
    return [regextestmobile evaluateWithObject:mobileNum];
}

-(NSMutableDictionary *)params
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:self.model.receiverid forKey:@"receiverid"];
    
    if (![self.name isEqualToString:self.model.name]) {
        [params setObject:self.name forKey:@"name"];
    }
    
    if (![self.phoneNum isEqualToString:self.model.mobile]) {
        [params setObject:self.phoneNum forKey:@"mobile"];
    }

    if (![self.province isEqualToString:self.model.state]) {
        [params setObject:self.province forKey:@"state"];
    }

    if (![self.city isEqualToString:self.model.city]) {
        [params setObject:self.city forKey:@"city"];
    }

    if (![self.area isEqualToString:self.model.district]) {
        [params setObject:self.area forKey:@"district"];
    }

    if (![self.textView.text isEqualToString:self.model.address]) {
        [params setObject:self.textView.text forKey:@"address"];
    }

    
    return params;
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
