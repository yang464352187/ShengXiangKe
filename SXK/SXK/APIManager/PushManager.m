//
//  PushManager.m
//  SXK
//
//  Created by 杨伟康 on 2016/11/24.
//  Copyright © 2016年 ywk. All rights reserved.
//


#import "PushManager.h"

@implementation PushManager

+ (instancetype)sharedManager{
    static PushManager *pushmanager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        pushmanager = [[PushManager alloc] init];
    });
    return pushmanager;
}

- (void)pushToVCWithClassName:(NSString *)name info:(NSDictionary *)info{
    if ([self.delegate respondsToSelector:@selector(pushToVCWithClassName:info:)]) {
        [self.delegate pushToVCWithClassName:name info:info];
    }
}

- (void)presentLoginVC{
    if ([self.delegate respondsToSelector:@selector(presentLoginVC)]) {
        [self.delegate presentLoginVC];
    }
}


@end
