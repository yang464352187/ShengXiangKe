//
//  YTBaseTableVC.h
//  YunTShop
//
//  Created by sfgod on 16/5/10.
//  Copyright © 2016年 sufan. All rights reserved.
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


/**  删除数据源中的指定位置数据，并根据数据源是否显示nodataview*/
- (void)removeObjectAtIndex:(NSInteger)index;

@end
