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
//        NSLog(@"11111111   a%ld",self.listData.count);
        self.noDataView.hidden = self.listData.count;
    }
}



- (void)handleModels:(NSArray *)models total:(NSInteger)total iSrefresh:(NSInteger)refresh;
{
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
    //    [self.tableView reloadData];
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

/**
 * 设置顶部的标签栏
 */
- (void)setupTitlesView:(NSArray *)array
{
    
    // 标签栏整体
    UIView *titlesView = [[UIView alloc] init];
    titlesView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1];
    titlesView.width = self.view.width;
    titlesView.height = 35;
    titlesView.y = 0;
    //    titlesView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:titlesView];
    self.titlesView = titlesView;
    
    // 底部的红色指示器
    UIView *indicatorView = [[UIView alloc] init];
    indicatorView.backgroundColor = APP_COLOR_GREEN;
    indicatorView.height = 2;
    indicatorView.tag = -1;
    indicatorView.y = titlesView.height - indicatorView.height;
    self.indicatorView = indicatorView;
    
    // 内部的子标签
    CGFloat width = titlesView.width / array.count;
    CGFloat height = titlesView.height;
    for (NSInteger i = 0; i< array.count; i++) {
        UIButton *button = [[UIButton alloc] init];
        button.tag = i+1;
        button.height = height;
        button.width = width;
        button.x = i * width;
        NSString *title = array[i];
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button setTitleColor:APP_COLOR_GREEN forState:UIControlStateDisabled];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        [titlesView addSubview:button];
        // 默认点击了第一个按钮
        if (i == 0) {
            button.enabled = NO;
            self.selectedButton = button;
            
            // 让按钮内部的label根据文字内容来计算尺寸
            [button.titleLabel sizeToFit];
            self.indicatorView.width = button.titleLabel.width;
            self.indicatorView.centerX = button.centerX;
        }
    }
    
    [titlesView addSubview:indicatorView];
}


- (void)titleClick:(UIButton *)button
{
    [self buttonStateChange:button];
    // 滚动
    //    [self setShowingIndex:button.tag animate:YES];
}

- (void)buttonStateChange:(UIButton *)button
{
    
    // 修改按钮状态
    self.selectedButton.enabled = YES;
    button.enabled = NO;
    self.selectedButton = button;
    [UIView animateWithDuration:0.25 animations:^{
        self.indicatorView.width = button.titleLabel.width;
        self.indicatorView.centerX = button.centerX;
    }];
    
}



@end
