//
//  JTNavigationController.h
//  SXK
//
//  Created by 杨伟康 on 2016/11/24.
//  Copyright © 2016年 ywk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JTWrapViewController : UIViewController

@property (nonatomic, strong, readonly) UIViewController *rootViewController;

+ (JTWrapViewController *)wrapViewControllerWithViewController:(UIViewController *)viewController;

@end

@interface JTNavigationController : UINavigationController

@property (nonatomic, strong) UIImage *backButtonImage;

@property (nonatomic, assign) BOOL fullScreenPopGestureEnabled;

@property (nonatomic, copy, readonly) NSArray *jt_viewControllers;


@end
