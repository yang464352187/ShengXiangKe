//
//  YTBaseTableVC.m
//  SXK
//
//  Created by 杨伟康 on 2016/11/24.
//  Copyright © 2016年 ywk. All rights reserved.
//

#import "YTBaseTableVC.h"

@interface YTBaseTableVC ()

@property (assign, nonatomic) NSInteger total;

@end

@implementation YTBaseTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.listData = [NSMutableArray array];
    self.pageNo = 1;
    self.pageSize = 10;
    //self.tableView = _tableView;
}

/** 下拉刷新，根据需要可重写*/
- (void)refreshHeaderAction{
    self.pageNo = 1;
    [self getDataByNetwork];
}

/** 上拉刷新，根据需要可重写*/
- (void)refreshFooterAction{
    if ([self.tableView.header isRefreshing]) {
        [self.tableView.header endRefreshing];
    }
    _pageNo ++;
    [self getDataByNetwork];
}

/** 网络请求，需要时必须重写*/
- (void)getDataByNetwork{
//    _weekSelf(weakSelf);    
//    [BaseRequest getStoreListWithpageSize:self.pageSize pageNo:self.pageNo city:nil categoryid:0 searchName:nil isWaimai:NO isDiancan:NO isMeishi:NO succesBlock:^(id data) {
//        [weakSelf stopRefresh];
//        NSArray *models = [HomeModel modelsFromArray:data[@"storeList"]];
//        [weakSelf handleModels:models total:[data[@"total"] integerValue]];
//    } failue:^(id data, NSError *error) {
//        [weakSelf getDataFailt:error];
//    }];
}




/**  停止刷新*/
- (void)stopRefresh{
    [_tableView.header endRefreshing];
    [_tableView.footer endRefreshing];
}

/**  网络请求失败*/
- (void)getDataFailt:(NSError *)error{
    [self stopRefresh];
    if (self.pageNo > 1) {
        self.pageNo --;
    }
    //刷新失败后如果大于前一次的总数则重新锁定下拉
    if (self.listData.count >= self.total) {
        [self.tableView.footer endRefreshingWithNoMoreData];
    }
    if (error && (error.code == 2000) && _isUseNoDataView) {
        //如果之前有数据 则清除并刷新
        if (self.listData.count) {
            [self.listData removeAllObjects];
            [self.tableView reloadData];
        }
        self.noDataView.hidden = NO;
    }
}

/**  处理模型*/
- (void)handleModels:(NSArray *)models total:(NSInteger)total{
    self.total = total;
    if (self.pageNo == 1) {
        self.listData = [NSMutableArray arrayWithArray:models];
    } else {
        NSInteger lastCount = self.pageSize * (self.pageNo-1);
        if (self.listData.count > lastCount) {
            [self.listData replaceObjectsInRange:NSMakeRange(lastCount, models.count) withObjectsFromArray:models];
        }else{
            [self.listData addObjectsFromArray:models];
        }
        
    }
    if (self.listData.count >= total) {
        [self.tableView.footer endRefreshingWithNoMoreData];
        [self.tableView.header endRefreshing];
    }else{
        [self.tableView.footer resetNoMoreData];
    }
    [self.tableView reloadData];
    if (_isUseNoDataView) {
        self.noDataView.hidden = self.listData.count;
    }
}


/**  删除数据源中的指定位置数据，并根据数据源是否显示nodataview*/
- (void)removeObjectAtIndex:(NSInteger)index {
    [self.listData removeObjectAtIndex:index];
    if (_isUseNoDataView && (self.listData.count == 0)) {
        self.noDataView.hidden = NO;
    }
}


/**  设置是否使用空数据视图*/
- (void)setIsUseNoDataView:(BOOL)isUseNoDataView{
    _isUseNoDataView = isUseNoDataView;
    if (_isUseNoDataView) {
        [self.tableView addSubview:self.noDataView];
        self.noDataView.hidden = YES;
    }
}



- (NoDataView *)noDataView{
    if (!_noDataView) {
        _noDataView = [[NoDataView alloc] initWithTitle:@""];
        
    }
    return _noDataView;
}


@end
