//
//  DebugMacro.h
//  SXK
//
//  Created by 杨伟康 on 2016/11/11.
//  Copyright © 2016年 ywk. All rights reserved.
//

#ifndef DebugMacro_h
#define DebugMacro_h

#ifdef DEBUG
#define DebugMethod()           NSLog(@"[DEBUG]%s", __func__)
#define DebugLog(format, ...)   NSLog((@"[DEBUG]%s " format), __PRETTY_FUNCTION__, ##__VA_ARGS__);
//#define NSLog(format, ...)      NSLog((@"[DEBUG]%s " format), __PRETTY_FUNCTION__, ##__VA_ARGS__);
#else
#define DebugMethod()
#define DebugLog(...)
#define NSLog(...)
#endif


#endif /* DebugMacro_h */
