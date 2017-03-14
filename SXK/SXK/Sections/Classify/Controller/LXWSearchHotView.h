//
//  LXWSearchHotView.h
//  Qwang
//
//  Created by 2.qwang.com.cn on 2017/2/23.
//  Copyright © 2017年 sundy_young. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,SectionType){
    SectionType_Price = 1,
    SectionType_Category
};

@protocol LXWSearchHotViewDelegate<NSObject>
- (void)didClickCategoryVieWithContent:(NSString *)content categoryType:(NSString *)categoryType Tag:(NSInteger)tag;
- (void)changeHotWord;
@end

@interface LXWSearchHotView : UIView

@property (nonatomic, assign) SectionType sectionType;
@property (nonatomic, strong) NSArray *contents;
@property (nonatomic, assign) BOOL changeBgColor;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, weak)id<LXWSearchHotViewDelegate> delegate;
@property (nonatomic, copy) NSString *categoryType;

- (void)resetAllState;

@end
