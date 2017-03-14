//
//  SearchCell.m
//  SXK
//
//  Created by 杨伟康 on 2017/3/3.
//  Copyright © 2017年 ywk. All rights reserved.
//

#import "SearchCell.h"
#import "LXWSearchHotView.h"
#import "BrandHotModel.h"

@interface SearchCell ()<LXWSearchHotViewDelegate>

@end


@implementation SearchCell{
    CGFloat _height;
    LXWSearchHotView *_view;
    NSArray *_array;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _view = [[LXWSearchHotView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0)];
        _view.delegate = self;
        _view.sectionType = SectionType_Category;

//        _view.changeBgColor = YES;
        [self addSubview:_view];
   
    }
    return  self;
}

-(void)didClickCategoryVieWithContent:(NSString *)content categoryType:(NSString *)categoryType Tag:(NSInteger)tag
{
    BrandHotModel *model = _array[tag];
    NSDictionary *dic = @{@"title":model.name,@"brandid":model.brandid,@"type":@"1"};

    [[PushManager sharedManager] pushToVCWithClassName:@"ClassifyDetailVC" info:dic];
    
//    [self PushViewControllerByClassName:@"ClassifyDetailVC" info:dic];

    NSLog(@"%ld",tag);
}


-(void)fillWithArray:(NSArray *)array
{
    [_view setContents:array];
    _array = array;
}

@end
