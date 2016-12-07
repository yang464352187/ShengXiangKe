//
//
// 作者:邓琪 QQ:350218638 gitHub:https://github.com/DQ-qi/DQAddress
//
#import "DQAreasView.h"
#import "DQCanCerEnsureView.h"
#import "DQAreasModel.h"

@interface DQAreasView ()<DQCanCerEnsureViewDelegate>
@property (nonatomic, copy) NSDictionary *areasDict;
@property (nonatomic, strong)DQCanCerEnsureView *CancerEnsure;
@property (strong, nonatomic) NSDictionary *selectedDict;
@property (strong,nonatomic) UIPickerView * pickerView;
@property (nonatomic, strong) UITapGestureRecognizer *ges;
@property (nonatomic, strong) UIWindow *window;
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong)UIPickerView *provincePick;
@property (nonatomic, strong)UIPickerView *cityPick;
@property (nonatomic, strong)UIPickerView *areaPick;
@property (nonatomic, strong)NSMutableDictionary *provinceDic;

@end    
@implementation DQAreasView
- (instancetype)init{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.frame = CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HIGHT);
        self.window = [[[UIApplication sharedApplication] delegate] window];
        [self.window addSubview:self];
        UIView *blackView1 = [UIView new];
        blackView1.backgroundColor = [UIColor colorWithHexColorString:@"3c3c3c"];
        blackView1.alpha = 0.8;
        blackView1.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HIGHT);
        [self addSubview:blackView1];
        self.ges = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(GestureCloseSelectViewAnimation:)];
        [self.window bringSubviewToFront:self];
        [blackView1 addGestureRecognizer:self.ges];
        self.backView = [UIView new];
        self.backView.backgroundColor = [UIColor whiteColor];
        self.backView.frame = CGRectMake(0, SCREEN_HIGHT, SCREEN_WIDTH, 260);
        [self addSubview:self.backView];
        [self creadedtionSubview];
        self.hidden = YES;
    }
    return self;
}



- (void)creadedtionSubview{
    self.provinceDic = [[NSMutableDictionary alloc] init];
    //解析地址
    NSString *path = [[NSBundle mainBundle]pathForResource:@"areas.json" ofType:nil];
    NSData *data = [NSData dataWithContentsOfFile:path];
    self.areasDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];

//    self.ProvinceArr = [self.areasDict allKeys];
    //    self.ProvinceArr = [ZinkSortArray sortArrayWithArray:self.ProvinceArr];
//    NSLog(@"%@",describe(self.ProvinceArr));
    
    self.ProvinceArr = @[	@"安徽省",
                            @"澳门特别行政区",
                            @"北京市",
                            @"重庆市",
                            @"福建省",
                            @"甘肃省",
                            @"广东省",
                            @"广西壮族自治区",
                            @"贵州省",
                            @"海南省",
                            @"河北省",
                            @"黑龙江省",
                            @"河南省",
                            @"湖北省",
                            @"湖南省",
                            @"江苏省",
                            @"江西省",
                            @"吉林省",
                            @"辽宁省",
                            @"内蒙古自治区",
                            @"宁夏回族自治区",
                            @"青海省",
                            @"山东省",
                            @"上海市",
                            @"陕西省",
                            @"四川省",
                            @"台湾",
                            @"天津市",
                            @"香港特别行政区",
                            @"西藏自治区",
                            @"新疆维吾尔自治区",
                            @"云南省",
                            @"浙江省",
                            ];
    NSString *ProvinceStr = [self.ProvinceArr objectAtIndex:0];

    self.selectedDict = [self.areasDict objectForKey:ProvinceStr];
    [self calculateCityArrAndCounty:0 andRow:0];
    _CancerEnsure = [[DQCanCerEnsureView alloc]init];
    [_CancerEnsure setTitleText:@"选择所在地区"];
    _CancerEnsure.delegate = self;
    UIView *sub = self.backView;
    [sub  addSubview:_CancerEnsure];
    [_CancerEnsure mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(sub);
        make.left.equalTo(sub);
        make.right.equalTo(sub);
        make.height.mas_equalTo(43);
    }];
    
    CGFloat width = (self.frame.size.width - 196.5)/4;
    
    self.pickerView = [UIPickerView new];
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    self.pickerView.showsSelectionIndicator = YES;
    
    self.provincePick = [[UIPickerView alloc] initWithFrame:CGRectMake(width, 44, 65.5, 100)];
    self.provincePick.delegate = self;
    self.provincePick.dataSource = self;
    
    self.cityPick = [[UIPickerView alloc] initWithFrame:CGRectMake(width*2+65.5, 44, 65.5, 100)];
    self.cityPick.delegate = self;
    self.cityPick.dataSource = self;
    
    self.areaPick = [[UIPickerView alloc] initWithFrame:CGRectMake(width*3+65.5*2, 44, 65.5, 100)];
    self.areaPick.delegate = self;
    self.areaPick.dataSource = self;
    
    UIButton *cancelBtn =[UIButton buttonWithType:UIButtonTypeSystem];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor colorWithHexColorString:@"aaaaaa"] forState:UIControlStateNormal];
    cancelBtn.frame = VIEWFRAME((SCREEN_WIDTH - 212)/2, 210, 81, 27);
    [cancelBtn addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
    ViewBorderRadius(cancelBtn, 27/2, 0.5, [UIColor colorWithHexColorString:@"aaaaaa"]);
    
    UIButton *certainBtn =[UIButton buttonWithType:UIButtonTypeSystem];
    [certainBtn setTitle:@"确定" forState:UIControlStateNormal];
    [certainBtn setTitleColor:APP_COLOR_GREEN forState:UIControlStateNormal];
    certainBtn.frame = VIEWFRAME(81+(SCREEN_WIDTH - 212)/2+50, 210, 81, 27);
    [certainBtn addTarget:self action:@selector(certainAction:) forControlEvents:UIControlEventTouchUpInside];
    ViewBorderRadius(certainBtn, 27/2, 0.5, APP_COLOR_GREEN);


    [sub addSubview:self.provincePick];
    [sub addSubview:self.cityPick];
    [sub addSubview:self.areaPick];
    [sub addSubview:cancelBtn];
    [sub addSubview:certainBtn];

    
//    [sub addSubview:self.pickerView];
    
//    [self.pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(sub.mas_top).offset(45);
//        make.left.equalTo(sub);
//        make.right.equalTo(sub);
//        make.bottom.equalTo(sub);
//    }];

}

-(void)cancelAction:(UIButton *)sender
{
    [self ClickCancerDelegateFunction];

}

-(void)certainAction:(UIButton *)sender
{
    [self ClickEnsureDelegateFunction];
}
//及时更新数据
- (void)calculateCityArrAndCounty:(UIPickerView * )section andRow:(NSInteger )row{
    if (section == self.provincePick) {
        if (self.ProvinceArr.count>row) {
            NSString *ProvinceStr = [self.ProvinceArr objectAtIndex:row];
            self.selectedDict = [self.areasDict objectForKey:ProvinceStr];
            self.cityArr = [self.selectedDict allKeys];
            NSString *countyStr = [self.cityArr firstObject];
            self.countyArr = [self.selectedDict objectForKey:countyStr];
        }
        
    }else if(section == self.cityPick){
        if (self.cityArr.count>row) {
            NSString *countyStr = self.cityArr[row];
            self.countyArr = [self.selectedDict objectForKey:countyStr];
        }
        
    }else{
        
        
        
    }
    
    
}
#pragma mark - UIPicker Delegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    return 1;//三组
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (pickerView == self.provincePick) {
        return self.ProvinceArr.count;
    } else if (pickerView == self.cityPick) {
        return self.cityArr.count;
    } else {
        return self.countyArr.count;
    }
}
-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel *lable=[[UILabel alloc]init];
    lable.font = SYSTEMFONT(15);
    lable.adjustsFontSizeToFitWidth = YES;
    lable.textAlignment=NSTextAlignmentCenter;
    //    lable.font=[UIFont systemFontOfSize:13];
    if (pickerView == self.provincePick) {
        lable.text=[self.ProvinceArr objectAtIndex:row];
    } else if (pickerView == self.cityPick) {
        lable.text=[self.cityArr objectAtIndex:row];
    } else if(pickerView == self.areaPick){
        if (self.countyArr.count>row) {
            lable.text=[self.countyArr objectAtIndex:row];

        }
    }
    
    for(UIView *singleLine in pickerView.subviews)
    {
        if (singleLine.frame.size.height < 1)
        {
            singleLine.backgroundColor = [UIColor colorWithHexColorString:@"dcdcdc"];
        }
    }

    return lable;
}
//- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
//}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    
    return 35;
    
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    
    [self calculateCityArrAndCounty:pickerView andRow:row];//实时更新数据
    
    if (pickerView == self.provincePick) {
        [self.cityPick reloadComponent:0];
        [self.cityPick selectRow:0 inComponent:0 animated:YES];
        [self.areaPick reloadComponent:0];
        [self.areaPick selectRow:0 inComponent:0 animated:YES];
    }
    
    if (pickerView == self.cityPick) {
        [self.areaPick reloadComponent:0];
        [self.areaPick selectRow:0 inComponent:0 animated:YES];
    }
    
}

- (void)ClickCancerDelegateFunction{
    
    [self CloseAnimationFunction];
    
}
- (void)ClickEnsureDelegateFunction{
    
    DQAreasModel *model = [DQAreasModel new];
    model.Province = self.ProvinceArr[[self.provincePick selectedRowInComponent:0]];
    model.city = self.cityArr[[self.cityPick selectedRowInComponent:0]];
    model.county = self.countyArr[[self.areaPick selectedRowInComponent:0]];
    [self CloseAnimationFunction];
    if ([self.delegate respondsToSelector:@selector(clickAreasViewEnsureBtnActionAreasDate:)]) {
        [self.delegate clickAreasViewEnsureBtnActionAreasDate:model];
    }
}
- (void)startAnimationFunction{
    UIView *AnView = self.backView;
    self.hidden = NO;
    CGRect rect = AnView.frame;
    rect.origin.y = SCREEN_HIGHT-260;
    [self.window bringSubviewToFront:self];
    [UIView animateWithDuration:0.4 animations:^{
        
        AnView.frame = rect;
    }];
    
}
- (void)CloseAnimationFunction{
    
    UIView *AnView = self.backView;
    CGRect rect = AnView.frame;
    rect.origin.y = SCREEN_HIGHT;
    [UIView animateWithDuration:0.4f animations:^{
        AnView.frame = rect;
    } completion:^(BOOL finished) {
        self.hidden = YES;
    }];
    
}

- (void)GestureCloseSelectViewAnimation:(UIGestureRecognizer *)ges{
    
    [self CloseAnimationFunction];
}

- (void)dealloc{
    
    self.ges = nil;
    
}
@end
