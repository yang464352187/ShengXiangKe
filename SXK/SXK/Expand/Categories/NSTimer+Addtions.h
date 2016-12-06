//
//  NSTimer+Addtions.h
//  YunTShop
//
//  Created by sfgod on 16/6/3.
//  Copyright © 2016年 sufan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (Addtions)

/**
 *  计时器动作
 *
 *  @param interval 时间
 *  @param block    事件
 *  @param repeats  是否重复
 */
+ (NSTimer *)sf_scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                         block:(void(^)())block
                                       repeats:(BOOL)repeats;


@end
