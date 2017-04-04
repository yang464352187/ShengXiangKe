
//
//  CommentVC.m
//  SXK
//
//  Created by 杨伟康 on 2017/3/7.
//  Copyright © 2017年 ywk. All rights reserved.
//

#import "CommentVC.h"
#import "RentCommentModel.h"
#import "BrandDetailModel.h"

@interface CommentVC ()<UITableViewDelegate, UITableViewDataSource,DFLineCellDelegate,CommentInputViewDelegate>


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
@property (nonatomic, strong) UIImageView *imageView1;
@property (nonatomic, assign) NSInteger type;


@end

@implementation CommentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"评论";
    [self.view addSubview:self.tableView];
    NSArray *array = self.myDict[@"array"];
    [self handleModels:array andTotal:array.count];
    
    
}

-(void)handleModels:(NSArray *)models andTotal:(NSInteger)total
{
    
    _items = [[NSMutableArray alloc] initWithArray:models];
    //    for (CommunityTopicListModel *model in models) {
    for (int i = 0 ; i < models.count; i++) {
        RentCommentModel *model = models[i];
        
        DFTextImageLineItem *textImageItem = [[DFTextImageLineItem alloc] init];
        
        textImageItem.itemId = [model.commentid integerValue];
        textImageItem.userId = [model.userid integerValue];
        textImageItem.userAvatar = model.headimgurl;
        if (model.nickname.length < 1) {
            textImageItem.userNick = @"无名";
        }else{
            textImageItem.userNick = model.nickname;
        }
        textImageItem.text = model.content;
        
        NSMutableArray *srcImages = [NSMutableArray array];
        
        for (NSString *str in model.imgList) {
            [srcImages addObject: [NSString stringWithFormat:@"%@%@",APP_BASEIMG,str]];
        }
        
        
        textImageItem.srcImages = srcImages;
        textImageItem.thumbImages = srcImages;
        textImageItem.ts = [model.createtime integerValue];
        
        if (srcImages.count <= 1  && srcImages.count > 0) {
            textImageItem.width = 100;
            textImageItem.height = 100;
            [self addItem:textImageItem index:i];
            
        }else{
            [self addItem:textImageItem index:i];
            
        }
        
    }
    
    
    
    [self.tableView reloadData];
    
}


- (UITableView *)tableView{
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:VIEWFRAME(0, -40, SCREEN_WIDTH, SCREEN_HIGHT) style:UITableViewStyleGrouped];
        _tableView.dataSource      = self;
        _tableView.delegate        = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.tableHeaderView = self.headView;
        _tableView.sectionHeaderHeight = 0.0;
        _tableView.sectionFooterHeight = 0.0;
        //        _tableView.header = [MJChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshHeaderAction)];
        //        _tableView.footer = [MJChiBaoZiFooter footerWithRefreshingTarget:self refreshingAction:@selector(refreshFooterAction)];
    }
    return _tableView;
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
    
    //    NSLog(@"class %@ ",NSStringFromClass([typeCell class]));
    DFBaseLineCell *cell = [tableView dequeueReusableCellWithIdentifier: reuseIdentifier];
    
    if (cell == nil ) {
        cell = [[[typeCell class] alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }else{
        //        NSLog(@"重用Cell: %@", reuseIdentifier);
    }
    
    cell.delegate = self;
    cell.separatorInset = UIEdgeInsetsZero;
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        cell.layoutMargins = UIEdgeInsetsZero;
    }
    [cell updateWithItem:item];
    [cell hiddenButton];
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


#pragma mark - Method

//-(CommunityCell *) getCell:(Class)itemClass
//{
//    DFLineCellManager *manager = [DFLineCellManager sharedInstance];
//    return [manager getCell:itemClass];
//}
-(void)addItem:(DFBaseLineItem *)item index:(NSInteger)index
{
    [self insertItem:item index:index];
}


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
    
    //    NSLog(@"%ld kkkkkkk  %ld",_items.count,index);
    [_items replaceObjectAtIndex:index withObject:item];
    
    
    [_itemDic setObject:item forKey:[NSNumber numberWithLongLong:item.itemId]];
    
    //    [self.tableView reloadData];
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
    
    [_tableView reloadData];
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
    [_tableView reloadData];
    
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
    
    [BaseRequest SetCommunityTopicWithTopicID:(NSInteger)itemId comment:text succesBlock:^(id data) {
        NSLog(@"%@",data);
    } failue:^(id data, NSError *error) {
        
    }];
    UserModel *model = [LoginModel curLoginUser];
    DFLineCommentItem *commentItem = [[DFLineCommentItem alloc] init];
    commentItem.commentId = [[NSDate date] timeIntervalSince1970];
    commentItem.userId = [model.userid integerValue];
    commentItem.userNick = model.nickname;
    commentItem.text = text;
    [self addCommentItem:commentItem itemId:itemId replyCommentId:commentId];
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
    //    NSLog(@"onLike: %lld", itemId);
    [BaseRequest SetCommunityTopicWithTopicID:(NSInteger)itemId like:1 succesBlock:^(id data) {
        UserModel *model =   [LoginModel curLoginUser];
        DFLineLikeItem *likeItem = [[DFLineLikeItem alloc] init];
        likeItem.userId = [model.userid integerValue];
        likeItem.userNick = model.nickname;
        [self addLikeItem:likeItem itemId:itemId];
        
    } failue:^(id data, NSError *error) {
        
    }];
    
}
// 根据图片url获取图片尺寸
-(CGSize)getImageSizeWithURL:(id)imageURL
{
    NSURL* URL = nil;
    if([imageURL isKindOfClass:[NSURL class]]){
        URL = imageURL;
    }
    if([imageURL isKindOfClass:[NSString class]]){
        URL = [NSURL URLWithString:imageURL];
    }
    if(URL == nil)
        return CGSizeZero;                  // url不正确返回CGSizeZero
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:URL];
    NSString* pathExtendsion = [URL.pathExtension lowercaseString];
    
    CGSize size = CGSizeZero;
    if([pathExtendsion isEqualToString:@"png"]){
        size =  [self getPNGImageSizeWithRequest:request];
    }
    else if([pathExtendsion isEqual:@"gif"])
    {
        size =  [self getGIFImageSizeWithRequest:request];
    }
    else{
        size = [self getJPGImageSizeWithRequest:request];
    }
    if(CGSizeEqualToSize(CGSizeZero, size))                    // 如果获取文件头信息失败,发送异步请求请求原图
    {
        NSData* data = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:URL] returningResponse:nil error:nil];
        //        NSData *data = [[NSData alloc] initWithContentsOfURL:URL];
        UIImage* image = [UIImage imageWithData:data];
        if(image)
        {
            size = image.size;
        }
    }
    return size;
}

//  获取PNG图片的大小
-(CGSize)getPNGImageSizeWithRequest:(NSMutableURLRequest*)request
{
    [request setValue:@"bytes=16-23" forHTTPHeaderField:@"Range"];
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if(data.length == 8)
    {
        int w1 = 0, w2 = 0, w3 = 0, w4 = 0;
        [data getBytes:&w1 range:NSMakeRange(0, 1)];
        [data getBytes:&w2 range:NSMakeRange(1, 1)];
        [data getBytes:&w3 range:NSMakeRange(2, 1)];
        [data getBytes:&w4 range:NSMakeRange(3, 1)];
        int w = (w1 << 24) + (w2 << 16) + (w3 << 8) + w4;
        int h1 = 0, h2 = 0, h3 = 0, h4 = 0;
        [data getBytes:&h1 range:NSMakeRange(4, 1)];
        [data getBytes:&h2 range:NSMakeRange(5, 1)];
        [data getBytes:&h3 range:NSMakeRange(6, 1)];
        [data getBytes:&h4 range:NSMakeRange(7, 1)];
        int h = (h1 << 24) + (h2 << 16) + (h3 << 8) + h4;
        return CGSizeMake(w, h);
    }
    return CGSizeZero;
}
//  获取gif图片的大小
-(CGSize)getGIFImageSizeWithRequest:(NSMutableURLRequest*)request
{
    [request setValue:@"bytes=6-9" forHTTPHeaderField:@"Range"];
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if(data.length == 4)
    {
        short w1 = 0, w2 = 0;
        [data getBytes:&w1 range:NSMakeRange(0, 1)];
        [data getBytes:&w2 range:NSMakeRange(1, 1)];
        short w = w1 + (w2 << 8);
        short h1 = 0, h2 = 0;
        [data getBytes:&h1 range:NSMakeRange(2, 1)];
        [data getBytes:&h2 range:NSMakeRange(3, 1)];
        short h = h1 + (h2 << 8);
        return CGSizeMake(w, h);
    }
    return CGSizeZero;
}
//  获取jpg图片的大小
-(CGSize)getJPGImageSizeWithRequest:(NSMutableURLRequest*)request
{
    [request setValue:@"bytes=0-209" forHTTPHeaderField:@"Range"];
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    if ([data length] <= 0x58) {
        return CGSizeZero;
    }
    
    if ([data length] < 210) {// 肯定只有一个DQT字段
        short w1 = 0, w2 = 0;
        [data getBytes:&w1 range:NSMakeRange(0x60, 0x1)];
        [data getBytes:&w2 range:NSMakeRange(0x61, 0x1)];
        short w = (w1 << 8) + w2;
        short h1 = 0, h2 = 0;
        [data getBytes:&h1 range:NSMakeRange(0x5e, 0x1)];
        [data getBytes:&h2 range:NSMakeRange(0x5f, 0x1)];
        short h = (h1 << 8) + h2;
        return CGSizeMake(w, h);
    } else {
        short word = 0x0;
        [data getBytes:&word range:NSMakeRange(0x15, 0x1)];
        if (word == 0xdb) {
            [data getBytes:&word range:NSMakeRange(0x5a, 0x1)];
            if (word == 0xdb) {// 两个DQT字段
                short w1 = 0, w2 = 0;
                [data getBytes:&w1 range:NSMakeRange(0xa5, 0x1)];
                [data getBytes:&w2 range:NSMakeRange(0xa6, 0x1)];
                short w = (w1 << 8) + w2;
                short h1 = 0, h2 = 0;
                [data getBytes:&h1 range:NSMakeRange(0xa3, 0x1)];
                [data getBytes:&h2 range:NSMakeRange(0xa4, 0x1)];
                short h = (h1 << 8) + h2;
                return CGSizeMake(w, h);
            } else {// 一个DQT字段
                short w1 = 0, w2 = 0;
                [data getBytes:&w1 range:NSMakeRange(0x60, 0x1)];
                [data getBytes:&w2 range:NSMakeRange(0x61, 0x1)];
                short w = (w1 << 8) + w2;
                short h1 = 0, h2 = 0;
                [data getBytes:&h1 range:NSMakeRange(0x5e, 0x1)];
                [data getBytes:&h2 range:NSMakeRange(0x5f, 0x1)];
                short h = (h1 << 8) + h2;
                return CGSizeMake(w, h);
            }
        } else {
            return CGSizeZero;
        }
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
