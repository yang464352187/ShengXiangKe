//
//  YTBaseTableVC.h
//  SXK
//
//  Created by 杨伟康 on 2016/11/24.
//  Copyright © 2016年 ywk. All rights reserved.
//

#import "YTBaseVC.h"
#import "NoDataView.h"

@interface YTBaseTableVC : YTBaseVC<UITableViewDataSource,UITableViewDelegate>{
    UITableView *_tableView;
}

@property (strong, nonatomic) UITableView    *tableView;
@property (strong, nonatomic) NSMutableArray *listData;//数据源
@property (strong, nonatomic) NSMutableArray *cellHeights;//cell高度数组
@property (assign, nonatomic) NSInteger      pageSize;//当前页尺寸
@property (assign, nonatomic) NSInteger      pageNo;//当前页数
@property (strong, nonatomic) NoDataView     *noDataView;
@property (assign, nonatomic) BOOL           isUseNoDataView;
@property (nonatomic, assign) NSInteger first;
/** 标签栏底部的红色指示器 */
@property (nonatomic, weak) UIView *indicatorView;
/** 当前选中的按钮 */
@property (nonatomic, weak) UIButton *selectedButton;
/** 顶部的所有标签 */
@property (nonatomic, weak) UIView *titlesView;


/** 下拉刷新，根据需要可重写*/
- (void)refreshHeaderAction;

/** 上拉刷新，根据需要可重写*/
- (void)refreshFooterAction;

/** 网络请求，需要时必须重写*/
- (void)getDataByNetwork;

/**  停止刷新*/
- (void)stopRefresh;

/**  网络请求失败*/
- (void)getDataFailt:(NSError *)error;

/**  处理模型*/
- (void)handleModels:(NSArray *)models total:(NSInteger)total;

/**  处理模型*/
- (void)handleModels:(NSArray *)models total:(NSInteger)total iSrefresh:(NSInteger)refresh;

/**  删除数据源中的指定位置数据，并根据数据源是否显示nodataview*/
- (void)removeObjectAtIndex:(NSInteger)index;

- (void)setupTitlesView:(NSArray *)array;

- (void)titleClick:(UIButton *)button;

- (void)buttonStateChange:(UIButton *)button;
@end
