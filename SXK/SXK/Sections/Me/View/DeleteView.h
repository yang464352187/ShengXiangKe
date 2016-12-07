//
//  DeleteView.h
//  SXK
//
//  Created by 杨伟康 on 2016/12/7.
//  Copyright © 2016年 ywk. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol DeleteAddressDelegate <NSObject>

-(void)deleteAddress;

@end

@interface DeleteView : UIView

@property (nonatomic, weak) id<DeleteAddressDelegate> delegate;
-(void)show;
@end
