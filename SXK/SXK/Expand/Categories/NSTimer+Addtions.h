//
//  NSTimer+Addtions.h
//  SXK
//
//  Created by 杨伟康 on 2016/11/24.
//  Copyright © 2016年 ywk. All rights reserved.
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
