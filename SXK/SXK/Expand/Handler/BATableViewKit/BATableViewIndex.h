//
//  ABELTableViewIndex.h
//  SXK
//
//  Created by 杨伟康 on 2016/11/23.
//  Copyright © 2016年 ywk. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BATableViewIndexDelegate;

@interface BATableViewIndex : UIView
@property (nonatomic, strong) NSArray *indexes;
@property (nonatomic, weak) id <BATableViewIndexDelegate> tableViewIndexDelegate;
@end

@protocol BATableViewIndexDelegate <NSObject>

/**
 *  触摸到索引时触发
 *
 *  @param tableViewIndex 触发didSelectSectionAtIndex对象
 *  @param index          索引下标
 *  @param title          索引文字
 */
- (void)tableViewIndex:(BATableViewIndex *)tableViewIndex didSelectSectionAtIndex:(NSInteger)index withTitle:(NSString *)title;

/**
 *  开始触摸索引
 *
 *  @param tableViewIndex 触发tableViewIndexTouchesBegan对象
 */
- (void)tableViewIndexTouchesBegan:(BATableViewIndex *)tableViewIndex;
/**
 *  触摸索引结束
 *
 *
 */
- (void)tableViewIndexTouchesEnd:(BATableViewIndex *)tableViewIndex;

/**
 *  TableView中右边右边索引title
 *
 *  @param tableViewIndex 触发tableViewIndexTitle对象
 *
 *  @return 索引title数组
 */
- (NSArray *)tableViewIndexTitle:(BATableViewIndex *)tableViewIndex;

@end
