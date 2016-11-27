//
//  CommunityVC.m
//  SXK
//
//  Created by 杨伟康 on 2016/11/11.
//  Copyright © 2016年 ywk. All rights reserved.
//

#import "CommunityVC.h"
#import "CommunityCollectionCell.h"
#import "CommunityCell.h"
#import "DFLineCellManager.h"
#import "DFLineCommentItem.h"
#import "DFLineLikeItem.h"

@interface CommunityVC ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout,DFLineCellDelegate>


@property (strong, nonatomic) UIView    *headView;
@property (nonatomic, strong) NSMutableArray *items;

@property (nonatomic, strong) NSMutableDictionary *itemDic;

@property (nonatomic, strong) NSMutableDictionary *commentDic;

@end

@implementation CommunityVC
#pragma mark - Lifecycle

- (instancetype)init
{
    self = [super init];
    if (self) {
//        
//        
//        [[MMPopupWindow sharedWindow] cacheWindow];
//        [MMPopupWindow sharedWindow].touchWildToHide = NO;
//        
//        MMSheetViewConfig *sheetConfig = [MMSheetViewConfig globalConfig];
//        sheetConfig.defaultTextCancel = @"取消";
        
        
        
        _items = [NSMutableArray array];
        
        _itemDic = [NSMutableDictionary dictionary];
        
        _commentDic = [NSMutableDictionary dictionary];
        
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"社区";
    UIImage *image = [UIImage imageNamed:@"图层-130"] ;
     [self setRightBarButtonWith:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]selector:@selector(barButtonAction)];
    [self initData];

    [self initUI];
    
}
-(void) initData
{
    DFTextImageLineItem *textImageItem = [[DFTextImageLineItem alloc] init];
    textImageItem.itemId = 1;
    textImageItem.userId = 10086;
    textImageItem.userAvatar = @"https://ss0.bdstatic.com/94oJfD_bAAcT8t7mm9GUKT-xh_/timg?image&quality=100&size=b4000_4000&sec=1479108586&di=c1243381373a079e9cc76ec88e77b48e&src=http://5.26923.com/download/pic/000/337/3cc141673013966cb8ded94d09e9b09f.jpg";
    textImageItem.userNick = @"Allen";
    textImageItem.title = @"";
    textImageItem.text = @"你是我的小苹果 小苹果 我爱你 就像老鼠爱大米 18680551720 [亲亲]";
    
    NSMutableArray *srcImages = [NSMutableArray array];
    [srcImages addObject:@"https://ss0.bdstatic.com/94oJfD_bAAcT8t7mm9GUKT-xh_/timg?image&quality=100&size=b4000_4000&sec=1479108586&di=c1243381373a079e9cc76ec88e77b48e&src=http://5.26923.com/download/pic/000/337/3cc141673013966cb8ded94d09e9b09f.jpg"];
    [srcImages addObject:@"https://ss0.bdstatic.com/94oJfD_bAAcT8t7mm9GUKT-xh_/timg?image&quality=100&size=b4000_4000&sec=1479108586&di=c1243381373a079e9cc76ec88e77b48e&src=http://5.26923.com/download/pic/000/337/3cc141673013966cb8ded94d09e9b09f.jpg"];
    [srcImages addObject:@"https://ss0.bdstatic.com/94oJfD_bAAcT8t7mm9GUKT-xh_/timg?image&quality=100&size=b4000_4000&sec=1479108586&di=c1243381373a079e9cc76ec88e77b48e&src=http://5.26923.com/download/pic/000/337/3cc141673013966cb8ded94d09e9b09f.jpg"];
    [srcImages addObject:@"http://file-cdn.datafans.net/temp/14.jpg"];
    [srcImages addObject:@"http://file-cdn.datafans.net/temp/15.jpg"];
    [srcImages addObject:@"http://file-cdn.datafans.net/temp/16.jpg"];
    [srcImages addObject:@"http://file-cdn.datafans.net/temp/17.jpg"];
    [srcImages addObject:@"http://file-cdn.datafans.net/temp/18.jpg"];
    [srcImages addObject:@"http://file-cdn.datafans.net/temp/19.jpg"];
    
    
    
    textImageItem.srcImages = srcImages;
    
    
    NSMutableArray *thumbImages = [NSMutableArray array];
    [thumbImages addObject:@"https://ss0.bdstatic.com/94oJfD_bAAcT8t7mm9GUKT-xh_/timg?image&quality=100&size=b4000_4000&sec=1479108586&di=c1243381373a079e9cc76ec88e77b48e&src=http://5.26923.com/download/pic/000/337/3cc141673013966cb8ded94d09e9b09f.jpg"];
    [thumbImages addObject:@"https://ss0.bdstatic.com/94oJfD_bAAcT8t7mm9GUKT-xh_/timg?image&quality=100&size=b4000_4000&sec=1479108586&di=c1243381373a079e9cc76ec88e77b48e&src=http://5.26923.com/download/pic/000/337/3cc141673013966cb8ded94d09e9b09f.jpg"];
    [thumbImages addObject:@"https://ss0.bdstatic.com/94oJfD_bAAcT8t7mm9GUKT-xh_/timg?image&quality=100&size=b4000_4000&sec=1479108586&di=c1243381373a079e9cc76ec88e77b48e&src=http://5.26923.com/download/pic/000/337/3cc141673013966cb8ded94d09e9b09f.jpg"];
    [thumbImages addObject:@"https://ss0.bdstatic.com/94oJfD_bAAcT8t7mm9GUKT-xh_/timg?image&quality=100&size=b4000_4000&sec=1479108586&di=c1243381373a079e9cc76ec88e77b48e&src=http://5.26923.com/download/pic/000/337/3cc141673013966cb8ded94d09e9b09f.jpg"];
    [thumbImages addObject:@"https://ss0.bdstatic.com/94oJfD_bAAcT8t7mm9GUKT-xh_/timg?image&quality=100&size=b4000_4000&sec=1479108586&di=c1243381373a079e9cc76ec88e77b48e&src=http://5.26923.com/download/pic/000/337/3cc141673013966cb8ded94d09e9b09f.jpg"];
    [thumbImages addObject:@"https://ss0.bdstatic.com/94oJfD_bAAcT8t7mm9GUKT-xh_/timg?image&quality=100&size=b4000_4000&sec=1479108586&di=c1243381373a079e9cc76ec88e77b48e&src=http://5.26923.com/download/pic/000/337/3cc141673013966cb8ded94d09e9b09f.jpg"];
    [thumbImages addObject:@"https://ss0.bdstatic.com/94oJfD_bAAcT8t7mm9GUKT-xh_/timg?image&quality=100&size=b4000_4000&sec=1479108586&di=c1243381373a079e9cc76ec88e77b48e&src=http://5.26923.com/download/pic/000/337/3cc141673013966cb8ded94d09e9b09f.jpg"];
    [thumbImages addObject:@"https://ss0.bdstatic.com/94oJfD_bAAcT8t7mm9GUKT-xh_/timg?image&quality=100&size=b4000_4000&sec=1479108586&di=c1243381373a079e9cc76ec88e77b48e&src=http://5.26923.com/download/pic/000/337/3cc141673013966cb8ded94d09e9b09f.jpg"];
    [thumbImages addObject:@"https://ss0.bdstatic.com/94oJfD_bAAcT8t7mm9GUKT-xh_/timg?image&quality=100&size=b4000_4000&sec=1479108586&di=c1243381373a079e9cc76ec88e77b48e&src=http://5.26923.com/download/pic/000/337/3cc141673013966cb8ded94d09e9b09f.jpg"];
    textImageItem.thumbImages = thumbImages;
    
    textImageItem.location = @"中国 • 广州";
    textImageItem.ts = [[NSDate date] timeIntervalSince1970]*1000;
    
    
    DFLineLikeItem *likeItem1_1 = [[DFLineLikeItem alloc] init];
    likeItem1_1.userId = 10086;
    likeItem1_1.userNick = @"Allen";
    [textImageItem.likes addObject:likeItem1_1];
    
    
    DFLineLikeItem *likeItem1_2 = [[DFLineLikeItem alloc] init];
    likeItem1_2.userId = 10088;
    likeItem1_2.userNick = @"奥巴马";
    [textImageItem.likes addObject:likeItem1_2];
    
    
    
    DFLineCommentItem *commentItem1_1 = [[DFLineCommentItem alloc] init];
    commentItem1_1.commentId = 10001;
    commentItem1_1.userId = 10086;
    commentItem1_1.userNick = @"习大大";
    commentItem1_1.text = @"精彩 大家鼓掌";
    [textImageItem.comments addObject:commentItem1_1];
    
    
    DFLineCommentItem *commentItem1_2 = [[DFLineCommentItem alloc] init];
    commentItem1_2.commentId = 10002;
    commentItem1_2.userId = 10088;
    commentItem1_2.userNick = @"奥巴马";
    commentItem1_2.text = @"欢迎来到美利坚";
    commentItem1_2.replyUserId = 10086;
    commentItem1_2.replyUserNick = @"习大大";
    [textImageItem.comments addObject:commentItem1_2];
    
    
    DFLineCommentItem *commentItem1_3 = [[DFLineCommentItem alloc] init];
    commentItem1_3.commentId = 10003;
    commentItem1_3.userId = 10010;
    commentItem1_3.userNick = @"神雕侠侣";
    commentItem1_3.text = @"呵呵";
    [textImageItem.comments addObject:commentItem1_3];
    
    [self addItem:textImageItem];
    
    
    DFTextImageLineItem *textImageItem2 = [[DFTextImageLineItem alloc] init];
    textImageItem2.itemId = 2;
    textImageItem2.userId = 10088;
    textImageItem2.userAvatar = @"http://file-cdn.datafans.net/avatar/2.jpg";
    textImageItem2.userNick = @"奥巴马";
    textImageItem2.title = @"发表了";
    textImageItem2.text = @"京东JD.COM-专业的综合网上购物商城，销售超数万品牌、4020万种商品，http://jd.com 囊括家电、手机、电脑、服装、图书、母婴、个护、食品、旅游等13大品类。秉承客户为先的理念，京东所售商品为正品行货、全国联保、机打发票。@刘强东";
    
    NSMutableArray *srcImages2 = [NSMutableArray array];
    [srcImages2 addObject:@"http://file-cdn.datafans.net/temp/20.jpg"];
    [srcImages2 addObject:@"http://file-cdn.datafans.net/temp/21.jpg"];
    [srcImages2 addObject:@"http://file-cdn.datafans.net/temp/22.jpg"];
    [srcImages2 addObject:@"http://file-cdn.datafans.net/temp/23.jpg"];
    textImageItem2.srcImages = srcImages2;
    
    
    NSMutableArray *thumbImages2 = [NSMutableArray array];
    [thumbImages2 addObject:@"https://ss0.bdstatic.com/94oJfD_bAAcT8t7mm9GUKT-xh_/timg?image&quality=100&size=b4000_4000&sec=1479108586&di=c1243381373a079e9cc76ec88e77b48e&src=http://5.26923.com/download/pic/000/337/3cc141673013966cb8ded94d09e9b09f.jpg"];
    [thumbImages2 addObject:@"http://obfmhs0s5.bkt.clouddn.com/Fh9jlYTx2LAVBPFmHiR2k_f1hPsY"];
    [thumbImages2 addObject:@"http://obfmhs0s5.bkt.clouddn.com/Fh9jlYTx2LAVBPFmHiR2k_f1hPsY"];
    
    [thumbImages2 addObject:@"http://obfmhs0s5.bkt.clouddn.com/Fh9jlYTx2LAVBPFmHiR2k_f1hPsY"];
    [thumbImages2 addObject:@"http://obfmhs0s5.bkt.clouddn.com/Fh9jlYTx2LAVBPFmHiR2k_f1hPsY"];
    [thumbImages2 addObject:@"http://obfmhs0s5.bkt.clouddn.com/Fh9jlYTx2LAVBPFmHiR2k_f1hPsY"];
    
    [thumbImages2 addObject:@"http://obfmhs0s5.bkt.clouddn.com/Fh9jlYTx2LAVBPFmHiR2k_f1hPsY"];
    [thumbImages2 addObject:@"http://obfmhs0s5.bkt.clouddn.com/Fh9jlYTx2LAVBPFmHiR2k_f1hPsY"];
    
    [thumbImages2 addObject:@"http://obfmhs0s5.bkt.clouddn.com/Fh9jlYTx2LAVBPFmHiR2k_f1hPsY"];
    
    
    textImageItem2.thumbImages = thumbImages2;
    
    DFLineLikeItem *likeItem2_1 = [[DFLineLikeItem alloc] init];
    likeItem2_1.userId = 10086;
    likeItem2_1.userNick = @"Allen";
    [textImageItem2.likes addObject:likeItem2_1];
    
    
    DFLineCommentItem *commentItem2_1 = [[DFLineCommentItem alloc] init];
    commentItem2_1.commentId = 18789;
    commentItem2_1.userId = 10088;
    commentItem2_1.userNick = @"奥巴马";
    commentItem2_1.text = @"欢迎来到美利坚";
    commentItem2_1.replyUserId = 10086;
    commentItem2_1.replyUserNick = @"习大大";
    [textImageItem2.comments addObject:commentItem2_1];
    
    DFLineCommentItem *commentItem2_2 = [[DFLineCommentItem alloc] init];
    commentItem2_2.commentId = 234657;
    commentItem2_2.userId = 10010;
    commentItem2_2.userNick = @"神雕侠侣";
    commentItem2_2.text = @"大家好";
    [textImageItem2.comments addObject:commentItem2_2];
    
    
    [self addItem:textImageItem2];
    
    
    
    
    DFTextImageLineItem *textImageItem3 = [[DFTextImageLineItem alloc] init];
    textImageItem3.itemId = 3;
    textImageItem3.userId = 10088;
    textImageItem3.userAvatar = @"http://file-cdn.datafans.net/avatar/2.jpg";
    textImageItem3.userNick = @"奥巴马";
    textImageItem3.title = @"发表了";
    textImageItem3.text = @"京东JD.COM-专业的综合网上购物商城";
    
    NSMutableArray *srcImages3 = [NSMutableArray array];
    [srcImages3 addObject:@"http://file-cdn.datafans.net/temp/21.jpg"];
    textImageItem3.srcImages = srcImages3;
    
    
    NSMutableArray *thumbImages3 = [NSMutableArray array];
    [thumbImages3 addObject:@"http://file-cdn.datafans.net/temp/21.jpg_640x420.jpeg"];
    textImageItem3.thumbImages = thumbImages3;
    
    
    textImageItem3.width = 640;
    textImageItem3.height = 360;
    
    textImageItem3.location = @"广州信息港";
    
    DFLineCommentItem *commentItem3_1 = [[DFLineCommentItem alloc] init];
    commentItem3_1.commentId = 78718789;
    commentItem3_1.userId = 10010;
    commentItem3_1.userNick = @"狄仁杰";
    commentItem3_1.text = @"神探是我";
    [textImageItem3.comments addObject:commentItem3_1];
    
    
    
    
    [self addItem:textImageItem3];
    
    
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
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DFBaseLineItem *item = [_items objectAtIndex:indexPath.row];
    CommunityCell *typeCell = [self getCell:[item class]];

    NSString *reuseIdentifier = NSStringFromClass([typeCell class]);
    CommunityCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommunityCell"];
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
    CommunityCell *typeCell = [self getCell:[item class]];
    return  [typeCell getReuseableCellHeight:item];
;
}
#pragma mark - Method

-(CommunityCell *) getCell:(Class)itemClass
{
    DFLineCellManager *manager = [DFLineCellManager sharedInstance];
    return [manager getCell:itemClass];
}

#pragma mark -- getters and setters


- (UITableView *)tableView{
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:VIEWFRAME(0, -20, SCREEN_WIDTH, SCREEN_HIGHT+40) style:UITableViewStyleGrouped];
        _tableView.dataSource      = self;
        _tableView.delegate        = self;
        [_tableView registerClass:[CommunityCell class] forCellReuseIdentifier:@"CommunityCell"];
//        [_tableView registerClass:[ClassifyCell class] forCellReuseIdentifier:@"ClassifyCell"];
//        [_tableView registerClass:[SpecialCell class] forCellReuseIdentifier:@"SpecialCell"];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.backgroundColor = APP_COLOR_BASE_BACKGROUND;
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.tableHeaderView = self.headView;
        _tableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
        _tableView.sectionHeaderHeight = 0.0;
        _tableView.sectionFooterHeight = 0.0;
        //        _tableView.header = [MJChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshHeaderAction)];
        //        _tableView.footer = [MJChiBaoZiFooter footerWithRefreshingTarget:self refreshingAction:@selector(refreshFooterAction)];
    }
    return _tableView;
}

- (UIView *)headView{
    if (!_headView) {
        _headView = [[UIView alloc] initWithFrame:VIEWFRAME(0, 0, SCREEN_WIDTH, 327.0000/667*SCREEN_HIGHT)];
        _headView.backgroundColor = [UIColor whiteColor];
        UIImageView *image = [[UIImageView alloc] initWithFrame:CommonVIEWFRAME(0, 0, 375, 219)];
        image.image = [UIImage imageNamed:@"背景"];
        
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
        [_headView addSubview:collectionView];
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
    
    return 9;
}

//每个item应该如何展示
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CommunityCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
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
    [item.likes insertObject:likeItem atIndex:0];
    
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
