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
#import "UMessage.h"
//#import "UserNotifications.h"

typedef void(^GESTURE_Tapped)(void);
static NSString *GESTURE_BLOCK = @"GESTURE_BLOCK";

@interface UIView (PrivateExtensions)

-(void)setTappedGestureWithBlock:(GESTURE_Tapped)block;

@end


@interface AppDelegate ()<UITabBarControllerDelegate,UNUserNotificationCenterDelegate>

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
    [UMessage openDebugMode:YES];
//    [UMessage addLaunchMessageWithWindow:self.window finishViewController:rootVC];

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
    
    
    
    
    
    [UMessage startWithAppkey:@"587ece4b65b6d616f6002e47" launchOptions:launchOptions];
    //注册通知，如果要使用category的自定义策略，可以参考demo中的代码。
    [UMessage registerForRemoteNotifications];
    
    //iOS10必须加下面这段代码。
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    center.delegate=self;
    UNAuthorizationOptions types10=UNAuthorizationOptionBadge|  UNAuthorizationOptionAlert|UNAuthorizationOptionSound;
    [center requestAuthorizationWithOptions:types10     completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (granted) {
            //点击允许
            //这里可以添加一些自己的逻辑
        } else {
            //点击不允许
            //这里可以添加一些自己的逻辑
        }
    }];
    
  [UMessage setLogEnabled:YES];
    
    
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


- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    
    [UMessage didReceiveRemoteNotification:userInfo];
    
//        self.userInfo = userInfo;
        //定制自定的的弹出框
        if([UIApplication sharedApplication].applicationState == UIApplicationStateActive)
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"标题"
                                                                message:@"Test On ApplicationStateActive"
                                                               delegate:self
                                                      cancelButtonTitle:@"确定"
                                                      otherButtonTitles:nil];
    
            [alertView show];
    
        }
    
    
}

//iOS10新增：处理前台收到通知的代理方法
-(void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler{
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        //应用处于前台时的远程推送接受
        //关闭U-Push自带的弹出框
        [UMessage setAutoAlert:NO];
        //必须加这句代码
        [UMessage didReceiveRemoteNotification:userInfo];
        
    }else{
        //应用处于前台时的本地推送接受
    }
    //当应用处于前台时提示设置，需要哪个可以设置哪一个
    completionHandler(UNNotificationPresentationOptionSound|UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionAlert);
}

//iOS10新增：处理后台点击通知的代理方法
-(void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler{
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        //应用处于后台时的远程推送接受
        //必须加这句代码
        [UMessage didReceiveRemoteNotification:userInfo];
        
    }else{
        //应用处于后台时的本地推送接受
    }
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    //1.2.7版本开始不需要用户再手动注册devicetoken，SDK会自动注册
    // [UMessage registerDeviceToken:deviceToken];
    NSLog(@"token%@",deviceToken);
    //下面这句代码只是在demo中，供页面传值使用。
//    [self postTestParams:[self stringDevicetoken:deviceToken] idfa:[self idfa] openudid:[self openUDID]];
    
    NSLog(@"token%@",[[[[deviceToken description] stringByReplacingOccurrencesOfString: @"<" withString: @""]
                  stringByReplacingOccurrencesOfString: @">" withString: @""]
                 stringByReplacingOccurrencesOfString: @" " withString: @""]);
}




@end

