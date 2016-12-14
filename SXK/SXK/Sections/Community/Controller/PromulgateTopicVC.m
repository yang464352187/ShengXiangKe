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

@interface PromulgateTopicVC ()<WSImagePickerViewDelegate>


@property (nonatomic, strong) WSImagePickerView *pickerView;
@property (strong, nonatomic) UIView            *headView;
@property (strong, nonatomic) FEPlaceHolderTextView       *content;
@property (nonatomic, assign) float heigh;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *photoViewHieghtConstrain;

@end

@implementation PromulgateTopicVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"社区";
    [self.view addSubview:self.headView];
}
- (UIView *)headView{
    if (!_headView) {
        _headView = [[UIView alloc] initWithFrame:VIEWFRAME(0, 0, SCREEN_WIDTH, (200.0000/667*SCREEN_HIGHT))];
        _headView.backgroundColor = [UIColor redColor];
        
        
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
        pickerView.type = 2;
        pickerView.delegate = self;
        __weak typeof(self) weakSelf = self;
        pickerView.viewHeightChanged = ^(CGFloat height) {
//            weakSelf.photoViewHieghtConstraint1.constant = height;
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
