//
//  CommunityVC.m
//  SXK
//
//  Created by 杨伟康 on 2016/11/11.
//  Copyright © 2016年 ywk. All rights reserved.
//

#import "CommunityVC.h"
#import "CommunityCollectionCell.h"
#import "DFLineCellManager.h"
#import "DFLineCommentItem.h"
#import "DFLineLikeItem.h"
#import "CommentInputView.h"
#import "DFBaseLineCell.h"
#import "ModuleModel.h"
#import "CommunityTopicListModel.h"

@interface CommunityVC ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout,DFLineCellDelegate,CommentInputViewDelegate>


@property (strong, nonatomic) UIView    *headView;
@property (nonatomic, strong) NSMutableArray *items;

@property (nonatomic, strong) NSMutableDictionary *itemDic;
@property (strong, nonatomic) CommentInputView *commentInputView;
@property (assign, nonatomic) long long currentItemId;
@property (nonatomic, strong) UIImageView *headImage;
@property (nonatomic, strong) NSArray *moduleArr;
@property (nonatomic, strong) NSMutableDictionary *commentDic;
@property (nonatomic, strong) NSArray *topicArr;
@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation CommunityVC
#pragma mark - Lifecycle

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        
        _items = [NSMutableArray array];
        
        _itemDic = [NSMutableDictionary dictionary];
        
        _commentDic = [NSMutableDictionary dictionary];
        
    }
    return self;
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
    [_commentInputView addNotify];
    
    [_commentInputView addObserver];
    
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [_commentInputView removeNotify];
    
    [_commentInputView removeObserver];
}

-(void)loadingRequest
{
    _weekSelf(weakSelf);

    [BaseRequest GetCommunityHeadImageWithSetupID:1 succesBlock:^(id data) {
        NSDictionary *dic = data[@"setup"];
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",APP_BASEIMG,dic[@"img"]]];
        [weakSelf.headImage sd_setImageWithURL:url];
    } failue:^(id data, NSError *error) {
        
    }];
    
    [BaseRequest GetCommunityModuleWithPageNo:0 PageSize:0 order:1 succesBlock:^(id data) {
        NSArray *models = [ModuleModel modelsFromArray:data[@"moduleList"]];
        weakSelf.moduleArr = models;
        NSLog(@"------------话题%@-----------",describe(models));
        [weakSelf.collectionView reloadData];
    } failue:^(id data, NSError *error) {
        
    }];
    
    [BaseRequest GetCommunityTopicListWithPageNo:0 PageSize:0 topicid:1 succesBlock:^(id data) {
        NSArray *models = [CommunityTopicListModel modelsFromArray:data[@"topicList"]];
        NSLog(@"------------话题%@-----------",describe(models));
        [weakSelf handleModels:models];
    } failue:^(id data, NSError *error) {
        
    }];
}


-(void)handleModels:(NSArray *)models
{
    
    for (CommunityTopicListModel *model in models) {
        
        DFTextImageLineItem *textImageItem = [[DFTextImageLineItem alloc] init];
        
        textImageItem.itemId = [model.topicid integerValue];
        textImageItem.userId = [model.userid integerValue];
        textImageItem.userAvatar = model.headimgurl;
        textImageItem.userNick = model.nickname;
        textImageItem.text = model.content;
        
        for (NSDictionary *dic in  model.likeList) {
            DFLineLikeItem *likeItem1_1 = [[DFLineLikeItem alloc] init];
            likeItem1_1.userId = [dic[@"userid"] integerValue];
            likeItem1_1.userNick = dic[@"nickname"];
            [textImageItem.likes addObject:likeItem1_1];
        }
        
        for (NSDictionary *dic1 in model.commentList) {
            DFLineCommentItem *commentItem1_1 = [[DFLineCommentItem alloc] init];
            commentItem1_1.commentId = [dic1[@"userid"] integerValue];
            commentItem1_1.userId = [model.userid integerValue];
            commentItem1_1.userNick = dic1[@"nickname"];
            commentItem1_1.text = dic1[@"comment"];
            [textImageItem.comments addObject:commentItem1_1];
        }
        
//        for (nss in <#collection#>) {
//            <#statements#>
//        }
        
        textImageItem.ts = [model.createtime integerValue] ;
        
        [self addItem:textImageItem];

    }
    
    

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"社区";
    UIImage *image = [UIImage imageNamed:@"图层-130"] ;
     [self setRightBarButtonWith:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]selector:@selector(barButtonAction)];
//    [self initData];
    [self loadingRequest];
    [self initUI];
    [self initCommentInputView];
}

-(void) initCommentInputView
{
    if (_commentInputView == nil) {
        _commentInputView = [[CommentInputView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        NSLog(@"aaaaaa %@",NSStringFromCGRect(_commentInputView.frame));

        _commentInputView.hidden = YES;
        _commentInputView.delegate = self;
        [self.view addSubview:_commentInputView];
    }
    
}


-(void)barButtonAction
{
    [self.view addSubview:self.tableView];
}

-(void)initUI
{
    [self.view addSubview:self.tableView];
}

#pragma mark -- UITabelViewDelegate And DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    NSLog(@"1aaaaaa%ld",_items.count);
    return _items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DFBaseLineItem *item = [_items objectAtIndex:indexPath.row];
    DFBaseLineCell *typeCell = [self getCell:[item class]];
    
    
    NSString *reuseIdentifier = NSStringFromClass([typeCell class]);
    
    NSLog(@"class %@ ",NSStringFromClass([typeCell class]));
    DFBaseLineCell *cell = [tableView dequeueReusableCellWithIdentifier: reuseIdentifier];
    if (cell == nil ) {
        cell = [[[typeCell class] alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }else{
        NSLog(@"重用Cell: %@", reuseIdentifier);
    }
    
    cell.delegate = self;
    
    cell.separatorInset = UIEdgeInsetsZero;
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        cell.layoutMargins = UIEdgeInsetsZero;
    }
    [cell updateWithItem:item];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DFBaseLineItem *item = [_items objectAtIndex:indexPath.row];
    DFBaseLineCell *typeCell = [self getCell:[item class]];
    return  [typeCell getReuseableCellHeight:item];
;
}
#pragma mark - Method

-(DFBaseLineCell *) getCell:(Class)itemClass
{
    DFLineCellManager *manager = [DFLineCellManager sharedInstance];
    return [manager getCell:itemClass];
}

#pragma mark -- getters and setters


- (UITableView *)tableView{
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:VIEWFRAME(0, 0, SCREEN_WIDTH, SCREEN_HIGHT-44) style:UITableViewStyleGrouped];
        _tableView.dataSource      = self;
        _tableView.delegate        = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.tableHeaderView = self.headView;
        _tableView.sectionHeaderHeight = 0.0;
        _tableView.sectionFooterHeight = 0.0;

    }
    return _tableView;
}

- (UIView *)headView{
    if (!_headView) {
        _headView = [[UIView alloc] initWithFrame:VIEWFRAME(0, 0, SCREEN_WIDTH, 327.0000/667*SCREEN_HIGHT)];
        _headView.backgroundColor = [UIColor whiteColor];
        UIImageView *image = [[UIImageView alloc] initWithFrame:CommonVIEWFRAME(0, 0, 375, 219)];
        image.image = [UIImage imageNamed:@"背景"];
        self.headImage = image;
        
        UIImageView *image1 = [[UIImageView alloc] initWithFrame:CommonVIEWFRAME(178, 207, 19, 12)];
        image1.image = [UIImage imageNamed:@"多边形-1"];

        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CommonVIEWFRAME(0, 219, 375, 108) collectionViewLayout:layout];
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.backgroundColor = [UIColor whiteColor];
        collectionView.showsVerticalScrollIndicator = NO;
        collectionView.showsHorizontalScrollIndicator = NO;
        [collectionView registerClass:[CommunityCollectionCell class] forCellWithReuseIdentifier:@"cell"];
        
        
        [_headView addSubview: image];
        [_headView addSubview:image1];
        [_headView addSubview:collectionView];
        self.collectionView = collectionView;
    }
    return _headView;
}

#pragma mark - UICollectionViewDataSource
//这个collectionView有多少个段落
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//某一段有多少个item
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSLog(@"kkkkkkkkkkkkkkkkkkk%ld",self.moduleArr.count);
    return self.moduleArr.count;
}

//每个item应该如何展示
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CommunityCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    ModuleModel *model = self.moduleArr[indexPath.row];
    [cell setModel:model];
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        cell.layoutMargins = UIEdgeInsetsZero;
    }
    return cell;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(CommonHight(15), CommonHight(15), CommonHight(15), CommonHight(15));
}

//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section;
//{
//    return 50;
//}
//
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return CommonWidth(12.5);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
//    if (SCREEN_WIDTH < 375) {
//        return CGSizeMake(CommonWidth(105.5), CommonHight(160.5));
//        
//    }
    return CGSizeMake(CommonWidth(78), CommonHight(78));
}



#pragma mark - Method

//-(CommunityCell *) getCell:(Class)itemClass
//{
//    DFLineCellManager *manager = [DFLineCellManager sharedInstance];
//    return [manager getCell:itemClass];
//}

-(void)addItem:(DFBaseLineItem *)item
{
    [self insertItem:item index:_items.count];
}

-(void) addItemTop:(DFBaseLineItem *) item
{
    [self insertItem:item index:0];
}

-(void) insertItem:(DFBaseLineItem *) item index:(NSUInteger)index
{
    [self genLikeAttrString:item];
    [self genCommentAttrString:item];
    
    [_items insertObject:item atIndex:index];
    
    
    [_itemDic setObject:item forKey:[NSNumber numberWithLongLong:item.itemId]];
    
    [self.tableView reloadData];
}


-(void)deleteItem:(long long)itemId
{
    DFBaseLineItem *item = [self getItem:itemId];
    [_items removeObject:item];
    [_itemDic removeObjectForKey:[NSNumber numberWithLongLong:item.itemId]];
}

-(DFBaseLineItem *) getItem:(long long) itemId
{
    return [_itemDic objectForKey:[NSNumber numberWithLongLong:itemId]];
    
}

-(void)addLikeItem:(DFLineLikeItem *)likeItem itemId:(long long)itemId
{
    DFBaseLineItem *item = [self getItem:itemId];
    [item.likes insertObject:likeItem atIndex:item.likes.count];
    
    item.likesStr = nil;
    item.cellHeight = 0;
    
    [self genLikeAttrString:item];
    
    [self.tableView reloadData];
}


-(void)addCommentItem:(DFLineCommentItem *)commentItem itemId:(long long)itemId replyCommentId:(long long)replyCommentId

{
    DFBaseLineItem *item = [self getItem:itemId];
    [item.comments addObject:commentItem];
    
    if (replyCommentId > 0) {
        DFLineCommentItem *replyCommentItem = [self getCommentItem:replyCommentId];
        commentItem.replyUserId = replyCommentItem.userId;
        commentItem.replyUserNick = replyCommentItem.userNick;
    }
    
    item.cellHeight = 0;
    [self genCommentAttrString:item];
    [self.tableView reloadData];
    
}

-(DFLineCommentItem *)getCommentItem:(long long)commentId
{
    return [_commentDic objectForKey:[NSNumber numberWithLongLong:commentId]];
}

-(void) genLikeAttrString:(DFBaseLineItem *) item
{
    if (item.likes.count == 0) {
        return;
    }
    
    if (item.likesStr == nil) {
        NSMutableArray *likes = item.likes;
        NSString *result = @"";
        
        for (int i=0; i<likes.count;i++) {
            DFLineLikeItem *like = [likes objectAtIndex:i];
            if (i == 0) {
                result = [NSString stringWithFormat:@"%@",like.userNick];
            }else{
                result = [NSString stringWithFormat:@"%@, %@", result, like.userNick];
            }
        }
        
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc]initWithString:result];
        NSUInteger position = 0;
        for (int i=0; i<likes.count;i++) {
            DFLineLikeItem *like = [likes objectAtIndex:i];
            [attrStr addAttribute:NSLinkAttributeName value:[NSString stringWithFormat:@"%lu", (unsigned long)like.userId] range:NSMakeRange(position, like.userNick.length)];
            position += like.userNick.length+2;
        }
        
        item.likesStr = attrStr;
    }
    
}

-(void) genCommentAttrString:(DFBaseLineItem *)item
{
    NSMutableArray *comments = item.comments;
    
    [item.commentStrArray removeAllObjects];
    
    for (int i=0; i<comments.count;i++) {
        DFLineCommentItem *comment = [comments objectAtIndex:i];
        [_commentDic setObject:comment forKey:[NSNumber numberWithLongLong:comment.commentId]];
        
        NSString *resultStr;
        if (comment.replyUserId == 0) {
            resultStr = [NSString stringWithFormat:@"%@: %@",comment.userNick, comment.text];
        }else{
            resultStr = [NSString stringWithFormat:@"%@回复%@: %@",comment.userNick, comment.replyUserNick, comment.text];
        }
        
        NSMutableAttributedString *commentStr = [[NSMutableAttributedString alloc]initWithString:resultStr];
        if (comment.replyUserId == 0) {
            [commentStr addAttribute:NSLinkAttributeName value:[NSString stringWithFormat:@"%lu", (unsigned long)comment.userId] range:NSMakeRange(0, comment.userNick.length)];
        }else{
            NSUInteger localPos = 0;
            [commentStr addAttribute:NSLinkAttributeName value:[NSString stringWithFormat:@"%lu", (unsigned long)comment.userId] range:NSMakeRange(localPos, comment.userNick.length)];
            localPos += comment.userNick.length + 2;
            [commentStr addAttribute:NSLinkAttributeName value:[NSString stringWithFormat:@"%lu", (unsigned long)comment.replyUserId] range:NSMakeRange(localPos, comment.replyUserNick.length)];
        }
        
        NSLog(@"ffff: %@", resultStr);
        
        [item.commentStrArray addObject:commentStr];
    }
}

-(void)onCommentCreate:(long long)commentId text:(NSString *)text
{
    [self onCommentCreate:commentId text:text itemId:_currentItemId];
}
-(void)onCommentCreate:(long long)commentId text:(NSString *)text itemId:(long long) itemId
{
    
    [BaseRequest SetCommunityTopicWithTopicID:itemId comment:text succesBlock:^(id data) {
        NSLog(@"%@",data);
    } failue:^(id data, NSError *error) {
        
    }];
    
    DFLineCommentItem *commentItem = [[DFLineCommentItem alloc] init];
    commentItem.commentId = [[NSDate date] timeIntervalSince1970];
    commentItem.userId = 10098;
    commentItem.userNick = @"杨伟康";
    commentItem.text = text;
    [self addCommentItem:commentItem itemId:itemId replyCommentId:commentId];
    self.tabBarController.tabBar.hidden = NO;
}

#pragma mark - DFLineCellDelegate

-(void)onComment:(long long)itemId
{
//    self.tabBarController.tabBar.hidden = YES;

    _currentItemId = itemId;
    
    _commentInputView.commentId = 0;
    
    _commentInputView.hidden = NO;
    [_commentInputView show];
}


-(void)onClickComment:(long long)commentId itemId:(long long)itemId
{
    
//    _currentItemId = itemId;
//    
//    _commentInputView.hidden = NO;
//    
//    _commentInputView.commentId = commentId;
//    
//    [_commentInputView show];
//    
//    DFLineCommentItem *comment = [_commentDic objectForKey:[NSNumber numberWithLongLong:commentId]];
//    [_commentInputView setPlaceHolder:[NSString stringWithFormat:@"  回复: %@", comment.userNick]];
    
}

-(void)onLike:(long long)itemId
{
    
    //点赞
    NSLog(@"onLike: %lld", itemId);
    
    [BaseRequest SetCommunityTopicWithTopicID:itemId like:1 succesBlock:^(id data) {
        NSLog(@"%@",data);
        if (![data[@"code"] isEqualToString:@"0"]) {
            DFLineLikeItem *likeItem = [[DFLineLikeItem alloc] init];
            likeItem.userId = 10092;
            likeItem.userNick = @"杨伟康";
    
            
            [self addLikeItem:likeItem itemId:itemId];

        }
    } failue:^(id data, NSError *error) {
        
    }];
    
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
