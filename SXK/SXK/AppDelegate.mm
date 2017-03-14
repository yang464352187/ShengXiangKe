//
//  AppDelegate.m
//  SXK
//
//  Created by 杨伟康 on 2016/11/11.
//  Copyright © 2016年 ywk. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeVC.h"
#import "ClassifyVC.h"
#import "PromulgateVC.h"
#import "CommunityVC.h"
#import "MeVC.h"
#import "BaseNavigationVC.h"
#import "VTingSeaPopView.h"
#import <MeiQiaSDK/MQManager.h>
#import "MQServiceToViewInterface.h"
#import <UMSocialCore/UMSocialCore.h>
#import "Pingpp.h"
#import <RongIMKit/RongIMKit.h>
//#import "UIView+Explode.h"
#import "objc/runtime.h"
#import "UIView+UIView_Boom.h"

typedef void(^GESTURE_Tapped)(void);
static NSString *GESTURE_BLOCK = @"GESTURE_BLOCK";

@interface UIView (PrivateExtensions)

-(void)setTappedGestureWithBlock:(GESTURE_Tapped)block;

@end


@interface AppDelegate ()<UITabBarControllerDelegate>

@property (nonatomic, strong) UIView *view1;

@property (nonatomic, strong) UIView *view2;

@property (nonatomic, strong) UIView *view3;

@property (nonatomic, assign) NSInteger index;

@property (nonatomic, assign) NSInteger total;

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    

    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    RootViewController *rootVC = [[RootViewController alloc] init];
    self.window.rootViewController = rootVC;
    self.window.backgroundColor = [UIColor whiteColor];
    [NSThread sleepForTimeInterval:1.0];
    [self.window makeKeyAndVisible];
    [self.window makeKeyWindow];
    
    [MQManager initWithAppkey:@"8a2358a00969823007f4ea328ad95bfa" completion:^(NSString *clientId, NSError *error) {
        
        if (!error) {
            NSLog(@"美洽 SDK：初始化成功");
            
        } else {
            NSLog(@"error:%@",error);
        }
        
        [MQServiceToViewInterface getUnreadMessagesWithCompletion:^(NSArray *messages, NSError *error) {
            NSLog(@">> unread message count: %d", (int)messages.count);
        }];
    }];
    
    [Pingpp setDebugMode:YES];
    
    //打开调试日志
    [[UMSocialManager defaultManager] openLog:YES];
    
    //设置友盟appkey
    [[UMSocialManager defaultManager] setUmSocialAppkey:@"587ece4b65b6d616f6002e47"];

    //设置微信的appKey和appSecret
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wx4bfb2d22ce82d40d" appSecret:@"6c5dcb4c683017363d5c580309ed1eff" redirectURL:@"http://mobile.umeng.com/social"];
    
    //设置分享到QQ互联的appKey和appSecret
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:@"1105855252"  appSecret:@"zOjjoUfd6sC1MTlh" redirectURL:@"http://mobile.umeng.com/social"];

    //设置新浪的appKey和appSecret
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:@"1084074774"  appSecret:@"26533dc2809fc7f5d6a0f1c2e0f68920" redirectURL:@"https://sns.whalecloud.com/sina2/callback"];
    

    
    //融云appkey qd46yzrfqdhzf 4z3hlwrv4ztht
    [[RCIM sharedRCIM] initWithAppKey:@"qd46yzrfqdhzf"];
    [RCIM sharedRCIM].enablePersistentUserInfoCache = YES;
    [RCIM sharedRCIM].enableMessageAttachUserInfo = YES;
    [RCIM sharedRCIM].globalConversationAvatarStyle = RC_USER_AVATAR_CYCLE;
    [RCIM sharedRCIM].globalMessageAvatarStyle = RC_USER_AVATAR_CYCLE;
    
    self.index = 1;
    self.total = 0;
    UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 150.0f, 110.0f)];
    
    [self.window addSubview:containerView];
    
    UIView *fromView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, containerView.frame.size.width, containerView.frame.size.height)];
    fromView.backgroundColor = [UIColor clearColor];
    
    UIImageView * image1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, containerView.frame.size.width, containerView.frame.size.height)];
    image1.image = [UIImage imageNamed:@"提示框-5"];
    UILabel *title1 = [UILabel createLabelWithFrame:VIEWFRAME(90,18, SCREEN_WIDTH - 120, 14)
                                      andText:@"这里可以发布属于你自己的商品和使用鉴定服务哦!"
                                 andTextColor:[UIColor blackColor]
                                   andBgColor:[UIColor clearColor]
                                      andFont:SYSTEMFONT(10)
                             andTextAlignment:NSTextAlignmentCenter];
    title1.numberOfLines = 0;
    [fromView addSubview:image1];
    [image1 addSubview:title1];
    
    UIView *toView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, containerView.frame.size.width, containerView.frame.size.height)];
    toView.backgroundColor = [UIColor clearColor];
    
    UIImageView * image2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, containerView.frame.size.width, containerView.frame.size.height)];
    image2.image = [UIImage imageNamed:@"提示框-5"];
    
    UILabel *title2 = [UILabel createLabelWithFrame:VIEWFRAME(90,18, SCREEN_WIDTH - 120, 14)
                                            andText:@"快点发布属于自己的奢侈品吧!"
                                       andTextColor:[UIColor blackColor]
                                         andBgColor:[UIColor clearColor]
                                            andFont:SYSTEMFONT(10)
                                   andTextAlignment:NSTextAlignmentCenter];
    title2.numberOfLines = 0;

    [toView addSubview:image2];
    [toView addSubview:title2];
    
    [containerView addSubview:fromView];
    
    UIView *containerView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 150.0f, 110.0f)];
    containerView1.alpha = 0;
    [self.window addSubview:containerView1];

    
    [containerView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.window);
        make.bottom.equalTo(self.window.mas_bottom).offset(-55);
        make.size.mas_equalTo(CGSizeMake(150, 110));
    }];

    
    [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.window);
        make.bottom.equalTo(self.window.mas_bottom).offset(-55);
        make.size.mas_equalTo(CGSizeMake(150, 110));
    }];
    
    [title1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(fromView);
        make.top.equalTo(fromView.mas_top).offset(0);
        make.bottom.equalTo(fromView.mas_bottom).offset(0);
        make.width.mas_equalTo(130);
    }];
    
    [title2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(toView);
        make.top.equalTo(toView.mas_top).offset(0);
        make.bottom.equalTo(toView.mas_bottom).offset(0);
        make.width.mas_equalTo(120);
    }];

    

    self.view1 = fromView;
    self.view2 = toView;
    self.view3 = containerView;


    
    NSTimer  *timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(checkUnreadCount) userInfo:nil repeats:YES];

    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
    self.timer  = timer;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
    [self.view3 addGestureRecognizer:tap];
    
    
//    __unsafe_unretained typeof(containerView) weakSelf = containerView;
//    [containerView setTappedGestureWithBlock:^{
//        [self.timer invalidate];
//        self.timer = nil;
//        [weakSelf lp_explode];
////        [weakSelf setTappedGestureWithBlock:nil];
//        [weakSelf setTappedGestureWithBlock:^{
//        }];
//        
//    }];
    
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
//    button.frame = VIEWFRAME(100, 100, 100, 100);
//    button.backgroundColor = [UIColor greenColor];
//    [button addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
//    [self.window addSubview:button];
    
    
    return YES;
    
}

-(void)btnAction:(UIButton *)btn
{
    [self.timer invalidate];
//    [self GCDMethod:self.view3 afterTime:0];
    [self.view3 boom];
//    [self.view3 lp_explode];
}


-(void)tapped:(UIGestureRecognizer *)gesture
{
    [self.timer invalidate];
    [self GCDMethod:self.view3 afterTime:0];

}


-(void)checkUnreadCount
{
    if (self.total == 10) {
        [self.timer invalidate];
//        [self.view1 removeFromSuperview];
//        [self.view2 removeFromSuperview];
        self.timer = nil;
  
        return;
    }else{
        self.total ++;
    }
    
    

    if (self.index == 1) {
        [CATransaction flush];
        
        [UIView transitionFromView:self.view1 toView:self.view2 duration:1.0f options:UIViewAnimationOptionTransitionFlipFromLeft completion:NULL];
        self.index = 2;
    }else{
        self.index =1;
        [CATransaction flush];
        
        [UIView transitionFromView:self.view2 toView:self.view1 duration:1.0f options:UIViewAnimationOptionTransitionFlipFromLeft completion:NULL];
    }

}


-(void)GCDMethod:(UIView *)myView afterTime:(NSTimeInterval)interval{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(interval * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [myView boom];
    });
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}
// 支持所有iOS系统
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result) {
        // 其他如支付等SDK的回调
        [Pingpp handleOpenURL:url withCompletion:nil];
        
    }
    return result;
}


#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"SXK"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                    */
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}



@end




@implementation UIView (PrivateExtensions)

-(void)setTappedGestureWithBlock:(GESTURE_Tapped)block
{
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
    tap.numberOfTapsRequired=1;
    [self addGestureRecognizer:tap];
    
    objc_setAssociatedObject(self,&GESTURE_BLOCK,block, OBJC_ASSOCIATION_COPY);
}

-(void)tapped:(UIGestureRecognizer *)gesture
{
    
    if (gesture.state==UIGestureRecognizerStateEnded)
    {
        GESTURE_Tapped block = (GESTURE_Tapped)objc_getAssociatedObject(self, &GESTURE_BLOCK);
        
        if (block)
        {
            block();
            block = nil;
        }
    }
}


@end

