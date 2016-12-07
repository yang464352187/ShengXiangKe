//
//  AddAddressCell.h
//  SXK
//
//  Created by 杨伟康 on 2016/12/6.
//  Copyright © 2016年 ywk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddressModel.h"

@protocol AddAddressDelegate <NSObject>

-(void)sendInfo:(NSString *)info andType:(NSInteger)type;
-(void)becomeFirstResponce:(UITextField *)firstTF;

@end

@interface AddAddressCell : UITableViewCell
@property (nonatomic, weak) id <AddAddressDelegate> delegate;
-(void)fillWithPlaceholder:(NSString *)placeHolder;
-(void)fillWithContent:(AddressModel *)model;
-(void)changeAddress:(NSString *)address;
@end
