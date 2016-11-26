//
//  CommunityCell.m
//  SXK
//
//  Created by 杨伟康 on 2016/11/26.
//  Copyright © 2016年 ywk. All rights reserved.
//

#import "CommunityCell.h"
#import "MLLabel+Size.h"


#define UserNickFont [UIFont systemFontOfSize:16]
#define TitleLabelFont [UIFont systemFontOfSize:13]

#define LocationLabelFont [UIFont systemFontOfSize:10]

#define TimeLabelFont [UIFont systemFontOfSize:12]

//#define UserNickLabelHeight 15
#define UserNickMaxWidth 150

#define LocationLabelHeight 15

#define TimeLabelHeight 15

#define UserNickLineHeight 1.0f


#define LikeLabelFont [UIFont systemFontOfSize:14]

#define LikeLabelLineHeight 1.1f

#define LikeCommentTimeSpace 3

#define ToolbarWidth 150
#define ToolbarHeight 30

@interface CommunityCell()

//@property (nonatomic, strong) DFBaseLineItem *item;

@property (nonatomic, strong) UIImageView *userAvatarView;
@property (nonatomic, strong) UIButton *userAvatarButton;

@property (nonatomic, strong) MLLinkLabel *userNickLabel;

@property (nonatomic, strong) UILabel *titleLabel;


@property (nonatomic, strong) UILabel *locationLabel;

@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, strong) UIButton *likeCmtButton;


@property (nonatomic, strong) DFLikeCommentView *likeCommentView;


@property (nonatomic, strong) DFLikeCommentToolbar *likeCommentToolbar;

@end


@implementation CommunityCell



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initCell];
    }
    return self;
}
-(void) initCell
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    CGFloat x = 0.0, y, width, height;
    
    if (_userAvatarView == nil ) {
        
        x = Margin;
        y = Margin;
        width = UserAvatarSize;
        height = width;
        _userAvatarView = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _userAvatarView.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:_userAvatarView];
        
        _userAvatarButton = [[UIButton alloc] initWithFrame:_userAvatarView.frame];
        [_userAvatarButton addTarget:self action:@selector(onClickUserAvatar:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_userAvatarButton];
    }
    
    if (_userNickLabel == nil) {
        
        _userNickLabel =[[MLLinkLabel alloc] initWithFrame:CGRectZero];
        _userNickLabel.textColor = HighLightTextColor;
        _userNickLabel.font = UserNickFont;
        _userNickLabel.numberOfLines = 1;
        _userNickLabel.adjustsFontSizeToFitWidth = NO;
        _userNickLabel.textInsets = UIEdgeInsetsZero;
        _userNickLabel.text = @"sdafjklasjdklfjaksldjfklajdskl";
        _userNickLabel.dataDetectorTypes = MLDataDetectorTypeAll;
        _userNickLabel.allowLineBreakInsideLinks = NO;
        _userNickLabel.linkTextAttributes = nil;
        _userNickLabel.activeLinkTextAttributes = nil;
        _userNickLabel.lineHeightMultiple = UserNickLineHeight;
        [self.contentView addSubview:_userNickLabel];
    }
    
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.textColor = [UIColor lightGrayColor];
        _titleLabel.font = TitleLabelFont;
        [self.contentView addSubview:_titleLabel];
    }
    
//    if (_bodyView == nil) {
//        x = CGRectGetMaxX(_userAvatarView.frame) + Margin;
//        y = 40;
//        width = BodyMaxWidth;
//        height = 1;
//        _bodyView = [[UIView alloc] initWithFrame:CGRectMake(x, y, width, height)];
//        [self.contentView addSubview:_bodyView];
//    }
    
    
    
    if (_locationLabel == nil) {
        _locationLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _locationLabel.textColor = [UIColor colorWithRed:35/255.0 green:83/255.0 blue:120/255.0 alpha:1.0];
        _locationLabel.font = LocationLabelFont;
        _locationLabel.hidden = YES;
        _locationLabel.text = @"fasdlkfjklasdjklf";
        [self.contentView addSubview:_locationLabel];
    }
    
    
    
    if (_timeLabel == nil) {
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _timeLabel.textColor = [UIColor lightGrayColor];
        _timeLabel.font = TimeLabelFont;
        _timeLabel.hidden = YES;
        _timeLabel.text = @"sdafkjaskdl";
        [self.contentView addSubview:_timeLabel];
    }
    
    
    if (_likeCmtButton == nil) {
        _likeCmtButton = [[UIButton alloc] initWithFrame:CGRectZero];
        _likeCmtButton.hidden = YES;
        [_likeCmtButton setImage:[UIImage imageNamed:@"AlbumOperateMore"] forState:UIControlStateNormal];
        [_likeCmtButton setImage:[UIImage imageNamed:@"AlbumOperateMoreHL"] forState:UIControlStateHighlighted];
        [_likeCmtButton addTarget:self action:@selector(onClickLikeCommentBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_likeCmtButton];
    }
    
    
//    if (_likeCommentView == nil) {
//        y = 0;
//        width = BodyMaxWidth;
//        height = 10;
//        _likeCommentView = [[DFLikeCommentView alloc] initWithFrame:CGRectMake(x, y, width, height)];
//        _likeCommentView.delegate = self;
//        [self.contentView addSubview:_likeCommentView];
//    }
//    
//    
//    
//    if (_likeCommentToolbar == nil) {
//        y = 0;
//        x = 0;
//        width = ToolbarWidth;
//        height = ToolbarHeight;
//        _likeCommentToolbar = [[DFLikeCommentToolbar alloc] initWithFrame:CGRectMake(x, y, width, height)];
//        _likeCommentToolbar.delegate = self;
//        _likeCommentToolbar.hidden = YES;
//        [self.contentView addSubview:_likeCommentToolbar];
//    }
    
}




@end
