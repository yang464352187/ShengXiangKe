//
//  ABELTableView.m
//  SXK
//
//  Created by 杨伟康 on 2016/11/23.
//  Copyright © 2016年 ywk. All rights reserved.
//

#import "BATableView.h"

@interface BATableView()<BATableViewIndexDelegate>
@property (nonatomic, strong) UILabel * flotageLabel;
@end

@implementation BATableView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.tableView = [[UITableView alloc] initWithFrame:VIEWFRAME(0, 0, frame.size.width, frame.size.height) style:UITableViewStyleGrouped];
//        self.tableView.backgroundColor = [UIColor redColor];
        self.tableView.showsVerticalScrollIndicator = NO;
        [self addSubview:self.tableView];
        
        self.tableViewIndex = [[BATableViewIndex alloc] initWithFrame:(CGRect){frame.size.width-16,0,20,frame.size.height}];
        [self addSubview:self.tableViewIndex];
        
        self.tableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
        self.tableView.sectionHeaderHeight = 0.0;
        self.tableView.sectionFooterHeight = 0.0;
        self.flotageLabel = [[UILabel alloc] initWithFrame:(CGRect){(self.bounds.size.width - 64 ) / 2,(self.bounds.size.height - 64) / 2,64,64}];
        self.flotageLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"flotageBackgroud"]];
        self.flotageLabel.hidden = YES;
        self.flotageLabel.textAlignment = NSTextAlignmentCenter;
        self.flotageLabel.textColor = [UIColor whiteColor];
        [self addSubview:self.flotageLabel];
    }
    return self;
}

- (void)setDelegate:(id<BATableViewDelegate>)delegate
{
    _delegate = delegate;
    self.tableView.delegate = delegate;
    self.tableView.dataSource = delegate;
    self.tableViewIndex.indexes = [self.delegate sectionIndexTitlesForABELTableView:self];
    CGRect rect = self.tableViewIndex.frame;
    rect.size.height = self.tableViewIndex.indexes.count * 16;
    int i = 0;
    if (SCREEN_HIGHT < 568) {
        i =1;
    }
    rect.origin.y = (self.bounds.size.height - rect.size.height) / 2+55*i;
//    rect.origin.x = SCREEN_WIDTH - 20;
    self.tableViewIndex.frame = rect;
    
    self.tableViewIndex.tableViewIndexDelegate = self;
}

- (void)reloadData
{
    [self.tableView reloadData];
    
    UIEdgeInsets edgeInsets = self.tableView.contentInset;
    int i = 0;
    if (SCREEN_HIGHT < 568) {
        i =1;
    }

    self.tableViewIndex.indexes = [self.delegate sectionIndexTitlesForABELTableView:self];
    CGRect rect = self.tableViewIndex.frame;
    rect.size.height = self.tableViewIndex.indexes.count * 16;
    rect.origin.y = (self.bounds.size.height - rect.size.height - edgeInsets.top - edgeInsets.bottom) / 2 + edgeInsets.top + 20+55*i;
//    rect.origin.x = SCREEN_WIDTH - 20;

    self.tableViewIndex.frame = rect;
    self.tableViewIndex.tableViewIndexDelegate = self;
}


#pragma mark -
- (void)tableViewIndex:(BATableViewIndex *)tableViewIndex didSelectSectionAtIndex:(NSInteger)index withTitle:(NSString *)title
{
    if ([self.tableView numberOfSections] > index && index > -1){   // for safety, should always be YES
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:index]
                              atScrollPosition:UITableViewScrollPositionTop
                                      animated:NO];
        self.flotageLabel.text = title;
    }
}

- (void)tableViewIndexTouchesBegan:(BATableViewIndex *)tableViewIndex
{
    self.flotageLabel.hidden = NO;
}

- (void)tableViewIndexTouchesEnd:(BATableViewIndex *)tableViewIndex
{
    CATransition *animation = [CATransition animation];
    animation.type = kCATransitionFade;
    animation.duration = 0.4;
    [self.flotageLabel.layer addAnimation:animation forKey:nil];
    
    self.flotageLabel.hidden = YES;
}

- (NSArray *)tableViewIndexTitle:(BATableViewIndex *)tableViewIndex
{
    return [self.delegate sectionIndexTitlesForABELTableView:self];
}
@end
