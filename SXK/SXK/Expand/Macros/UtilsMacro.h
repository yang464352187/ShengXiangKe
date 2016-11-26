//
//  UtilsMacro.h
//  SXK
//
//  Created by 杨伟康 on 2016/11/11.
//  Copyright © 2016年 ywk. All rights reserved.
//

#ifndef UtilsMacro_h
#define UtilsMacro_h

/******************************************************************************/
#pragma mark - Screen Frame Macros

// 应用程序Frame
#define APP_FRAME                           [[UIScreen mainScreen] applicationFrame]
#define APP_FRAME_HIGHT                     [[UIScreen mainScreen] applicationFrame].size.height
#define APP_FRAME_WIDTH                     [[UIScreen mainScreen] applicationFrame].size.width
#define APP_BOUNDS                          CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HIGHT)
#define KEY_WINDOW                          [[UIApplication sharedApplication] keyWindow]

// 屏幕尺寸
#define SCREEN_WIDTH                        [UIScreen mainScreen].bounds.size.width
#define SCREEN_HIGHT                        [UIScreen mainScreen].bounds.size.height
#define WIDTHFACTOR                         (SCREEN_WIDTH / 320) // 放大系数



/******************************************************************************/
#pragma mark - Color Macros
// 颜色
#define RGBCOLOR(r,g,b)                     [UIColor colorWithRed:r green:g blue:b alpha:1]
#define RGBACOLOR(r,g,b,a)                  [UIColor colorWithRed:r green:g blue:b alpha:a]
#define HEXCOLOR(c)                         [UIColor colorWithRed:((c>>16)&0xFF)/255.0f green:((c>>8)&0xFF)/255.0f blue:(c&0xFF)/255.0f alpha:1.0f]
#define HSVCOLOR(h,s,v)                     [UIColor colorWithHue:h saturation:s value:v alpha:1]
#define HSVACOLOR(h,s,v,a)                  [UIColor colorWithHue:h saturation:s value:v alpha:a]
#define RGBA(r,g,b,a)                       [UIColor colorWithRed:(float)r/255.0f green:(float)g/255.0f blue:(float)b/255.0f alpha:a]
#define HighLightTextColor [UIColor colorWithRed:92/255.0 green:140/255.0 blue:193/255.0 alpha:1.0]



/******************************************************************************/
#pragma mark - View Frame Macros
// View 坐标(x,y), 宽高(width,height)
#define VIEWFRAME(x,y,w,h)                  CGRectMake(x,y,w,h)
#define CommonVIEWFRAME(x,y,w,h)            CGRectMake(x/375.0000*SCREEN_WIDTH,y/667.0000*SCREEN_HIGHT,w/375.0000*SCREEN_WIDTH,h/667.0000*SCREEN_HIGHT)
#define CommonHight(h)                      (h/667.0000*SCREEN_HIGHT)
#define CommonWidth(w)                      (w/375.0000*SCREEN_WIDTH)
#define ViewX(view)                         view.frame.origin.x
#define ViewY(view)                         view.frame.origin.y
#define ViewWidth(view)                     view.frame.size.width
#define ViewHeight(view)                    view.frame.size.height

// View 坐标(x,y)的最小值,中间值和最大值
#define GetViewMinX(v)                      CGRectGetMinX((v).frame)
#define GetViewMinY(v)                      CGRectGetMinY((v).frame)

#define GetViewMidX(v)                      CGRectGetMidX((v).frame)
#define GetViewMidY(v)                      CGRectGetMidY((v).frame)

#define GetViewMaxX(v)                      CGRectGetMaxX((v).frame)
#define GetViewMaxY(v)                      CGRectGetMaxY((v).frame)

// View 上下左右(Top,Left,Bottom,Right)
#define View_Left(view)                     view.frame.origin.x
#define View_Top(view)                      view.frame.origin.y
#define View_Bottom(view)                   (view.frame.origin.y + view.frame.size.height)
#define View_Right(view)                    (view.frame.origin.x + view.frame.size.width)

#define EdgeInset(Top,Left,Bottom,Right)    UIEdgeInsetsMake((Top), (Left), (Bottom), (Right))



/******************************************************************************/
#pragma mark - ViewMacros

// 字体大小(常规/粗体)
#define BOLDSYSTEMFONT(FONTSIZE)            [UIFont boldSystemFontOfSize:FONTSIZE]
#define SYSTEMFONT(FONTSIZE)                [UIFont systemFontOfSize:FONTSIZE]
#define FONT(NAME, FONTSIZE)                [UIFont fontWithName:(NAME) size:(FONTSIZE)]

// View 圆角和加边框
#define ViewBorderRadius(View, Radius, Width, Color)\
\
[View.layer setCornerRadius:(Radius)];  \
[View.layer setMasksToBounds:YES];      \
[View.layer setBorderWidth:(Width)];    \
[View.layer setBorderColor:[Color CGColor]]

#define ViewBorder(View, Width, Color)  \
\
[View.layer setBorderWidth:(Width)];    \
[View.layer setBorderColor:[Color CGColor]]

#define ViewShadowAttibutes(View,Color,Radius,Opacity,OffsetSizeMake)      \
[View.layer setShadowColor:[UIColor darkGrayColor].CGColor];   \
[View.layer setShadowRadius:Radius];                           \
[View.layer setShadowOffset:OffsetSizeMake];                   \
[View.layer setShadowOpacity:Opacity];


// View 圆角
#define ViewRadius(View, Radius)      \
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES]

/******************************************************************************/



/******************************************************************************/
#pragma mark - Singletion(单例)

#ifndef SINGLETON_GCD
#define SINGLETON_GCD(classname)                   \
\
+ (classname *)sharedInstance##classname {         \
\
static dispatch_once_t oncePredicate;              \
static classname * sharedInstance##classname = nil;\
dispatch_once( &oncePredicate, ^{                  \
sharedInstance##classname = [[self alloc] init];   \
});                                                \
\
return sharedInstance##classname;                  \
}
#endif



/******************************************************************************/
#pragma mark - Weak Object
// 弱引用对象
#define _weekSelf(weakSelf)               __weak __typeof(&*self)weakSelf = self;// 弱引用
#define _weekObj(weakObj,variableObj)     __weak __typeof(&*variableObj)weakObj = variableObj;// 将对象弱引用

//强引用对象
#define _strongSelf(o)  __strong typeof(self) o = weakSelf;


// 数据的有效性
#define Validity_Str(string) (((string != nil) && (string.length>0))?YES:NO)// 判断字符串是否有效

/******************************************************************************/
#pragma mark - SystemMacros
// 系统方法
#define App_Delegate                        AppDelegate
#define APPLICATIONDELEGATE                 ((AppDelegate *)[[UIApplication sharedApplication] delegate])
#define SharedApplication                   [UIApplication sharedApplication]
#define BUNDLE                              [NSBundle mainBundle]
#define MAINSCREEN                          [UIScreen mainScreen]
#define NAVBAR                              self.navigationController.navigationBar
#define TABBAR                              self.tabBarController.tabBar

// 系统版本
#define IsIOS6Later ([[[UIDevice currentDevice] systemVersion] floatValue] >=6.0 ? YES : NO)
#define IsIOS7Later ([[[UIDevice currentDevice] systemVersion] floatValue] >=7.0 ? YES : NO)
#define IsIOS8Later ([[[UIDevice currentDevice] systemVersion] floatValue] >=8.0 ? YES : NO)
#define SUPPORT_IPHONE_OS_VERSION(version) ( __IPHONE_OS_VERSION_MIN_REQUIRED <= version && __IPHONE_OS_VERSION_MAX_ALLOWED >= version)



/******************************************************************************/
#pragma mark - NSDefaultsMacros
/*本地数据库快捷方法*/
#define DEFAULTS()                          [NSUserDefaults standardUserDefaults]
#define DEFAULTS_INIT(dictionary)			[DEFAULTS() registerDefaults:dictionary]
#define DEFAULTS_SAVE                       [DEFAULTS() synchronize]

// 存取数据对象
#define DEFAULTS_GET_OBJ(key)               [DEFAULTS() objectForKey:key]
#define DEFAULTS_SET_OBJ(object, key)       [DEFAULTS() setObject:object forKey:key]
#define DEFAULTS_REMOVE(key)				[DEFAULTS() removeObjectForKey:key]

// 存取BOOL值
#define DEFAULTS_GET_BOOL(key)              [DEFAULTS() boolForKey:key]
#define DEFAULTS_SET_BOOL(BOOL, key)        [DEFAULTS() setBool:BOOL forKey:key]

// 存取Integer
#define DEFAULTS_GET_INTEGER(key)           [DEFAULTS() integerForKey:key]
#define DEFAULTS_SET_INTEGER(Integer, key)  [DEFAULTS() setInteger:Integer forKey:key]



/******************************************************************************/
#pragma mark - TipAleart
#define TipAlert(_S_, ...)     [[[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:(_S_), ##__VA_ARGS__] delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil] show]


/******************************************************************************/
// 获取本地沙盒地址
#define DocumentsPath [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]

#endif /* UtilsMacro_h */
