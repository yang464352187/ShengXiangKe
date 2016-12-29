//
//  LXViewSelectorController.h
//  SXK
//
//  Created by 杨伟康 on 2016/12/28.
//  Copyright © 2016年 ywk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LXViewSelectorController : YTBaseTableVC
-(instancetype)initWithControllers:(NSArray<UIViewController*>*)controllers titles:(NSArray<NSString*>*)titles;
//标题字体大小（默认14）
@property (nonatomic,assign)CGFloat fontSize;
//提示条大小(默认为40，2)
@property (nonatomic,assign)CGSize tipSize;
//选中颜色(默认为红色)
@property (nonatomic,strong)UIColor *selectedColor;
//未选中颜色(默认为黑色)
@property (nonatomic,strong)NSArray<UIViewController*> *controllers;//子控制器

@property (nonatomic,assign)UIColor *normalColor;

//@property (nonatomic, assign)NSInteger *index;

@property (nonatomic, strong)NSMutableArray *tableViewArr;

- (void)handlePan:(UIPanGestureRecognizer *)sender;
-(void)setAnimationWithOrigin:(CGFloat)x;
@end
