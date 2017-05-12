//
//  BrandDetailCell2.m
//  SXK
//
//  Created by 杨伟康 on 2016/12/27.
//  Copyright © 2016年 ywk. All rights reserved.
//

#import "BrandDetailCell2.h"
#import "BrandDetailModel.h"
#import <RongIMKit/RongIMKit.h>
#import "RCConversationVC.h"
#import "FollowListModel.h"

@interface BrandDetailCell2 ()<RCIMUserInfoDataSource,RCIMGroupInfoDataSource
>

@end

@implementation BrandDetailCell2{
    UILabel *_label;
    UIImageView *_image;
    UIButton *_talkBtn;
    UIButton *_likeBtn;
    NSInteger _userid;
    NSString *_title;
    NSString *_image1;
    BOOL _isFollow;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _image = [[UIImageView alloc] init];
        _image.image = [UIImage imageNamed:@"矢量智能对象111"];
        
        _label = [UILabel createLabelWithFrame:VIEWFRAME(15, 0, 150, 53)                                                 andText:@""
                                          andTextColor:[UIColor blackColor]
                                            andBgColor:[UIColor clearColor]
                                               andFont:SYSTEMFONT(13)
                                      andTextAlignment:NSTextAlignmentLeft];
        
        
        UIImage *talkImage = [UIImage imageNamed:@"对话"];
        _talkBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_talkBtn setTitle:@"聊呗" forState:UIControlStateNormal];
        [_talkBtn setImage:[talkImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        _talkBtn.frame = VIEWFRAME(SCREEN_WIDTH - 130, 11, 60, 15);
        _talkBtn.titleLabel.font = SYSTEMFONT(12);
        _talkBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 8, 0, 0);
        [_talkBtn addTarget:self action:@selector(buttonAction1:) forControlEvents:UIControlEventTouchUpInside];
        [_talkBtn setTintColor:[UIColor blackColor]];
        
        _likeBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_likeBtn setTitle:@"啵一个" forState:UIControlStateNormal];

        _likeBtn.frame = VIEWFRAME(SCREEN_WIDTH - 130, 11, 50, 15);
        _likeBtn.titleLabel.font = SYSTEMFONT(12);
        _likeBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 8, 0, 0);
        [_likeBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_likeBtn setTintColor:[UIColor blackColor]];
        
        _isFollow = 0;
        [BaseRequest GetFollowListsuccesBlock:^(id data) {
            NSArray *models = [FollowListModel modelsFromArray:data[@"follow"][@"userList"]];
            NSLog(@"%@",describe(models));
            for (FollowListModel *model1 in models) {
                if (_userid == [model1.userid integerValue]) {
                    _isFollow = 1;
                }
            }
            
            if (_isFollow) {
                UIImage *talkImage = [UIImage imageNamed:@"已经关注1"];
                [_likeBtn setImage:[talkImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
                
            }else{
                UIImage *likeImage = [UIImage imageNamed:@"关注-(1)"];
                [_likeBtn setImage:[likeImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
            }
            //        [weakSelf handleModels:models total:models.count];
        } failue:^(id data, NSError *error) {
            
        }];
        

        
        
        [self addSubview:_image];
        [self addSubview:_label];
        [self addSubview:_talkBtn];
        [self addSubview:_likeBtn];
        
        [_image mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.equalTo(self.mas_left).offset(20);
            make.size.mas_equalTo(CGSizeMake(37, 37));
        }];
        
        [_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.equalTo(_image.mas_right).offset(10);
            make.size.mas_equalTo(CGSizeMake(150, 66));
        }];
        
        [_talkBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.right.equalTo(self.mas_right).offset(-15);
            make.size.mas_equalTo(CGSizeMake(60, 25));
        }];
        
        [_likeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.right.equalTo(_talkBtn.mas_left).offset(0);
            make.size.mas_equalTo(CGSizeMake(70, 25));
        }];
        
        ViewRadius(_image, 37/2.0000);
    
    }

    return  self;
}


-(void)setModel:(id)model
{

    
    BrandDetailModel *_model = model;
    _label.text = [NSString stringWithFormat:@"啵主:%@",_model.user[@"nickname"]];
    [_image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",_model.user[@"headimgurl"]]]];
    _userid = [_model.userid integerValue];
    _title = _model.user[@"nickname"];
    _image1 = [NSString stringWithFormat:@"%@",_model.user[@"headimgurl"]];
    
    
//    _weekSelf(weakSelf);


}


-(void)buttonAction:(UIButton *)sender
{
    if (![LoginModel isLogin]) {
        [ProgressHUDHandler showHudTipStr:@"请先登录"];
        [[PushManager sharedManager] presentLoginVC];
        return;
    }
    
    UserModel *model =   [LoginModel curLoginUser];
    
    if (_userid == [model.userid integerValue]) {
        [ProgressHUDHandler showHudTipStr:@"您不能关注自己"];
        return;
    }

    
    if (_isFollow) {
        UIImage *likeImage = [UIImage imageNamed:@"关注-(1)"];
        [_likeBtn setImage:[likeImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        [BaseRequest DeleteFollowWithUserID:_userid succesBlock:^(id data) {
            if ([data[@"code"] integerValue] == 1) {
                [ProgressHUDHandler showHudTipStr:@"取消关注"];
            }

        } failue:^(id data, NSError *error) {
            
        }];

        _isFollow = 0;
    }else{
        UIImage *talkImage = [UIImage imageNamed:@"已经关注1"];
        [_likeBtn setImage:[talkImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        [BaseRequest AddFollowWithUserID:_userid succesBlock:^(id data) {
            if ([data[@"code"] integerValue] == 1) {
                [ProgressHUDHandler showHudTipStr:@"关注成功"];
            }
        } failue:^(id data, NSError *error) {
            
        }];
        
        _isFollow = 1;

    }
    
    
    
}



-(void)buttonAction1:(UIButton *)sender
{
//    _weekSelf(weakSelf);
//    UserModel *model =   [LoginModel curLoginUser];
//    [BaseRequest ChatWithUserID:[model.userid integerValue] succesBlock:^(id data) {
//    
//        NSString *str = data[@"token"];
//        NSLog(@"%@",model.userid);
//        [[RCIM sharedRCIM] connectWithToken:@"zBbOKhqOqfIUr0bkv/NwZxcVsrzPMjtqVVmGkXkKGocNO+oCEvtryc6/75FbHMcdDoEV6/eQYc0HzMX/Rr/xgg==" success:^(NSString *userId) {
//            NSLog(@"登陆成功。当前登录的用户ID：%@", userId);
//            
//        } error:^(RCConnectErrorCode status) {
//            NSLog(@"登陆的错误码为:%d", status);
//        } tokenIncorrect:^{
//            //token过期或者不正确。
//            //如果设置了token有效期并且token过期，请重新请求您的服务器获取新的token
//            //如果没有设置token有效期却提示token错误，请检查您客户端和服务器的appkey是否匹配，还有检查您获取token的流程。
//            NSLog(@"token错误");
//        }];
//
//        
//        
//    } failue:^(id data, NSError *error) {
//        
//    }];
    if (![LoginModel isLogin]) {
        [ProgressHUDHandler showHudTipStr:@"请先登录"];
        [[PushManager sharedManager] presentLoginVC];
        return;
    }
    
    UserModel *model =   [LoginModel curLoginUser];
    
    if (_userid == [model.userid integerValue]) {
        [ProgressHUDHandler showHudTipStr:@"您不能和自己聊天"];
        return;
    }


    [self push];
    
}

-(void)push
{

    UserModel *model =   [LoginModel curLoginUser];
    
    RCConversationVC *chat = [[RCConversationVC alloc] initWithConversationType:ConversationType_PRIVATE
                                                                                               targetId:[NSString stringWithFormat:@"%@",model.userid]];
    [RCIM sharedRCIM].currentUserInfo = [[RCUserInfo alloc] initWithUserId:[NSString stringWithFormat:@"%@",model.userid] name:model.nickname portrait:model.headimgurl];
   
    [RCIM sharedRCIM].globalMessageAvatarStyle = RC_USER_AVATAR_CYCLE;
    
    [[RCIM sharedRCIM] setUserInfoDataSource:self];

    chat.conversationType = ConversationType_PRIVATE;
    
    chat.targetId = [NSString stringWithFormat:@"%ld",_userid];
    
    chat.title = _title;
    
    [RCIM sharedRCIM].enablePersistentUserInfoCache = YES;
    [RCIM sharedRCIM].enableMessageAttachUserInfo = YES;
    
    
    RCUserInfo *user = [[RCUserInfo alloc] initWithUserId: [NSString stringWithFormat:@"%ld",_userid] name:_title portrait:_image1];
    [[RCIM sharedRCIM] refreshUserInfoCache:user withUserId:[NSString stringWithFormat:@"%ld",_userid]];

    
    [self.vc.navigationController pushViewController:chat animated:YES];
    
    
//    NSLog(@"-----%ld-----",_userid);
}

- (void)getUserInfoWithUserId:(NSString *)userId
                   completion:(void (^)(RCUserInfo *userInfo))completion
{
    UserModel *model =   [LoginModel curLoginUser];

    if ([userId isEqualToString:[NSString stringWithFormat:@"%@",model.userid]]) {
        return completion([[RCUserInfo alloc] initWithUserId:[NSString stringWithFormat:@"%@",model.userid] name:model.nickname portrait:model.headimgurl]);
    }else
    {
//        根据存储联系人信息的模型，通过 userId 来取得对应的name和头像url，进行以下设置（此处因为项目接口尚未实现，所以就只能这样给大家说说，请见谅）
        return completion([[RCUserInfo alloc] initWithUserId:[NSString stringWithFormat:@"%ld",_userid] name:_title portrait:_image1]);
    }
}



@end
