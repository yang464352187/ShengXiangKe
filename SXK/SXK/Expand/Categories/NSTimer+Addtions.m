//
//  NSTimer+Addtions.m
//  SXK
//
//  Created by 杨伟康 on 2016/11/24.
//  Copyright © 2016年 ywk. All rights reserved.
//

#import "NSTimer+Addtions.h"

@implementation NSTimer(Addtions)

/**
 *  计时器动作
 *
 *  @param interval 时间
 *  @param block    事件
 *  @param repeats  是否重复
 */
+ (NSTimer *)sf_scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                    block:(void(^)())block
                                  repeats:(BOOL)repeats{
    return [self scheduledTimerWithTimeInterval:interval
                                         target:self
                                       selector:@selector(private_blockinvoke:)
                                       userInfo:[block copy]
                                        repeats:repeats];
}


+ (void)private_blockinvoke:(NSTimer *)timer{
    void (^block)() = timer.userInfo;
    if (block) {
        block();
    }
}

@end
