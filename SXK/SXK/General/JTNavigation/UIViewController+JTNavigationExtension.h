//
//  UIViewController+JTNavigationExtension.h
//  SXK
//
//  Created by 杨伟康 on 2016/11/24.
//  Copyright © 2016年 ywk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JTNavigationController.h"

@interface UIViewController (JTNavigationExtension)

@property (nonatomic, assign) BOOL jt_fullScreenPopGestureEnabled;

@property (nonatomic, strong) JTNavigationController *jt_navigationController;


@end
