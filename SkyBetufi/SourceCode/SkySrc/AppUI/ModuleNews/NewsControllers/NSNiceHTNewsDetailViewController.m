#import "NSNiceHTNewsDetailViewController.h"
#import "WSKggHTNewsTopRequest.h"
#import "MMoogHTNewsHeaderCell.h"
#import "NSNiceHTNewsWebCell.h"
#import "KSasxHTNewsHomeCell.h"
#import "BlysaHTNewsTopHeaderView.h"
#import "YeYeePPXXBJNavigationController.h"
#import "YeYeeHTNewsAdditionRequest.h"
#import "TuTuosHTUserRequest.h"
#import <BlocksKit/BlocksKit.h>
#import <YYText/YYText.h>
#import "YeYeeHTCommentGetter.h"
#import "BByasHTNewsCommentCell.h"
#import "KSasxHTNoCommentFooterView.h"
#import "BByasHTAdViewCell.h"
#import <IQKeyboardManager/IQKeyboardManager.h>
#import "UIColor+WSKggKMonkeyHex.h"
#import "UIView+TuTuosPXFunBlockGesture.h"

#import "KSasxHTNewsImageTypeCell.h"
#import "KSasxHTNewsTextCell.h"
#import "FFlaliHTNewsDetailModel.h"
#import "UUaksBJUtility.h"
#import "KSasxHTFilmHomeCell.h"
#import "WSKggHTYoutubePlayerCell.h"
#import "UUaksYSPlayerController.h"
#import "WSKggHTNoUseHeaderTableViewCell.h"
#import "TuTuosHTImageBrowserViewController.h"

@import Firebase;

@interface NSNiceHTNewsDetailViewController () <UITableViewDelegate, UITableViewDataSource, PlayerTableViewCellDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;
@property (weak, nonatomic) IBOutlet UIButton *sendButton;
@property (weak, nonatomic) IBOutlet JXTextView *commentInputView;
@property (weak, nonatomic) IBOutlet UILabel *commentCountLabel;
@property (weak, nonatomic) IBOutlet JXView *commentCountContent;
@property (weak, nonatomic) IBOutlet UIView *buttonContentView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *comtentHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentRight;
@property (nonatomic, strong) UUaksHTNewsModel *newsModel;
@property (nonatomic, strong) NSArray *topNewsList;
//@property (nonatomic, copy) NSString *htmlContent;
@property (nonatomic, assign) CGFloat newsContentHeight;
@property (nonatomic, assign) BOOL topRequestDone;
@property (nonatomic, assign) BOOL htmlLoadDone;
@property (nonatomic, weak) NSNiceHTCommentModel *currentCommentModel;
@property (nonatomic, strong) YeYeeHTCommentGetter *commentGetter;
@property (nonatomic, strong) KSasxHTNoCommentFooterView *noCommentsFooterView;
@property (nonatomic, assign) BOOL isFirstShow;

@property (weak, nonatomic) IBOutlet UIView *playerContentView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *playContentViewTralling;


//========
//@property (strong, nonatomic) UUaksYSPlayerController *playerController;
@property (strong, nonatomic) UIView *playerView;
@property (nonatomic, assign) BOOL fullScreen;

@property (nonatomic, strong)UIView * replyInputAccessoryView;
@property (nonatomic, strong)UIButton * cancelButton;
@property (nonatomic, strong)UIButton * submitButton;
@property (nonatomic, strong)UITextView *replyTextView;

@property (nonatomic, assign) BOOL isFullScreen;
@property (nonatomic, weak) KSasxHTFilmHomeCell *playingCell;

@end
@implementation NSNiceHTNewsDetailViewController
+ (instancetype)taoviewController {
    return kLoadStoryboardWithName(@"UKRosRedNewsDetail");
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViews];
    self.isFirstShow = YES;

    self.commentInputView.inputAccessoryView = self.replyInputAccessoryView;
    
    [self.commentInputView addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        NSLog(@"_imTalkTextView addTapActionWithBlock:");
        [self.commentInputView becomeFirstResponder];
        [self.replyTextView becomeFirstResponder];
    }];
    
    
    [FIRAnalytics logEventWithName:@"IOS_NEWS_Detail"
                        parameters:@{
                                     kFIRParameterItemID:[NSString stringWithFormat:@"id:%@", self.newsModel.title],
                                     kFIRParameterItemName:@"新闻详情",
                                     kFIRParameterContentType:@"news-detail"
                                     }];
}

- (UIView *)replyInputAccessoryView
{
    if (!_replyInputAccessoryView) {
        _replyInputAccessoryView  = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 60)];
        _replyInputAccessoryView.backgroundColor = [UIColor whiteColor];
        
        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_cancelButton setTitleColor:[UIColor colorWithHexString:@"848484"] forState:UIControlStateHighlighted];
        [_cancelButton addTarget:self action:@selector(cancelButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        [_replyInputAccessoryView addSubview:_cancelButton];
        
        [_cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_replyInputAccessoryView).offset(10);
            make.height.centerY.equalTo(_replyInputAccessoryView);
        }];
        
        _submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _submitButton.titleLabel.font = [UIFont systemFontOfSize: 12.0f];
        [_submitButton setTitle:@"發佈" forState:UIControlStateNormal];
        [_submitButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_submitButton setTitleColor:[UIColor colorWithHexString:@"848484"] forState:UIControlStateHighlighted];
        [_submitButton addTarget:self action:@selector(submitButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        [_replyInputAccessoryView addSubview:_submitButton];
        
        [_submitButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(_replyInputAccessoryView).offset(-10);
            make.height.centerY.equalTo(_replyInputAccessoryView);
        }];
        
        _replyTextView = [[UITextView alloc] init];
        _replyTextView.layer.cornerRadius = 4.0f;
        _replyTextView.layer.masksToBounds = YES;
        _replyTextView.layer.borderColor = [UIColor colorWithHexString:@"848484"].CGColor;
        _replyTextView.layer.borderWidth = 1.0f / [[UIScreen mainScreen] scale];
        _replyTextView.font = [UIFont systemFontOfSize: 12.0f];
        _replyTextView.textColor = [UIColor blackColor];
        _replyTextView.backgroundColor = [UIColor clearColor];
        [_replyInputAccessoryView addSubview:_replyTextView];
        
        [_replyTextView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(_replyInputAccessoryView).offset(-4);
            make.centerY.equalTo(_replyInputAccessoryView);
            make.left.equalTo(_cancelButton.mas_right).offset(10);
            make.right.equalTo(_submitButton.mas_left).offset(-10);
        }];
        
    }
    return _replyInputAccessoryView;
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"NSNiceHTNewsDetailViewController viewDidAppear");
    [IQKeyboardManager sharedManager].enable = NO;
    if (self.isFirstShow) {
        self.isFirstShow = NO;
        if ([self.commentInputView.text isEqualToString:@" "]) {
            self.commentInputView.text = nil;
        }
        [self loadDetailWithCompleteBlock:^{
            [self refreshUI];
            [self initDataRequests];
        }];
        [self addHistoryRecord];
    }

//    [self.playerController play];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    NSLog(@"NSNiceHTNewsDetailViewController viewDidDisappear");
    [IQKeyboardManager sharedManager].enable = YES;
    
    [self playerAllShutdown];
}

- (void)dealloc
{
    [self playerAllShutdown];
}

- (void)tao_handleNavBack{
    
    [self playerAllShutdown];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (!self.htmlLoadDone) {
        return 0;
    }
    NSInteger num = 4;

    if (self.commentGetter.hotComments.count > 0) {
        num ++;
    }
    if (self.commentGetter.normalComments.count > 0) {
        num ++;
    }
    return num;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 1;
    }
    if (section == 1) {
        return self.newsModel.mHTNewsDetailModels.count;
    }
    
    if (section == 2) {
        return 1;
    }
    if (section == 3) {
        return self.topNewsList.count;
    }
    if (section == 4 && self.commentGetter.hotComments.count > 0) {
        return self.commentGetter.hotComments.count;
    } else {
        return self.commentGetter.normalComments.count;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"cellForRowAtIndexPath indexPath.section == %d row = %d", indexPath.section,indexPath.row);
    kWeakSelf
    if (indexPath.section == 0) {
        MMoogHTNewsHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MMoogHTNewsHeaderCell"];
        [cell taosetupWithNewsModel:self.newsModel];
        return cell;
    } else if (indexPath.section == 1) {
        
        FFlaliHTNewsDetailModel *newsDetailModel = self.newsModel.mHTNewsDetailModels[indexPath.row];
        if ([@"img" isEqualToString:newsDetailModel.type]) {
            KSasxHTNewsImageTypeCell *image_cell = [tableView dequeueReusableCellWithIdentifier:@"KSasxHTNewsImageTypeCell"];
//            [image_cell.newsImageView sd_setImageWithURL:[NSURL URLWithString:newsDetailModel.data]];
            [image_cell.newsImageView sd_setImageWithURL:[NSURL URLWithString:newsDetailModel.data] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                
                if (newsDetailModel.height > 0 && newsDetailModel.width > 0) {
                    NSLog(@"newsImageView not need resize");
                }else{
                    
                    CGFloat height = image.size.height;
                    CGFloat width = image.size.width;
                    
                    if (height > 0 && width > 0) {
                        newsDetailModel.height = height;
                        newsDetailModel.width = width;
                        [self.tableView reloadData];
                    }
                   
                }
               
            }];
            image_cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return image_cell;
        }else if ([@"text" isEqualToString:newsDetailModel.type]){
            KSasxHTNewsTextCell *text_cell = [tableView dequeueReusableCellWithIdentifier:@"KSasxHTNewsTextCell"];
            [text_cell setNewsText:newsDetailModel.data];
            text_cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return text_cell;
            
//            NSNiceHTNewsWebCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NSNiceHTNewsWebCell"];
//            [cell taosetupWithClearHtmlContent: newsDetailModel.data];
//            cell.onContentHeightUpdateBlock = ^(CGFloat height) {
//                    if (fabs(height - weakSelf.newsContentHeight) < 1) {
//                        return;
//                    }
//                    weakSelf.newsContentHeight = height;
//                    [weakSelf.tableView reloadData];
//                NSLog(@"onContentHeightUpdateBlock height = %d", height);
//            };
//            return cell;
                
        }else if ([@"video" isEqualToString:newsDetailModel.type])
        {
            KSasxHTFilmHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KSasxHTFilmHomeCell"];
            
            PLMediaInfo *info = [[PLMediaInfo alloc] init];
            info.videoURL = newsDetailModel.data;
            info.thumbURL = newsDetailModel.poster;
            info.totalTime = newsDetailModel.length_formatted;
            [cell taosetupWithPLMediaInfo:info];
            
            cell.mPlayerTableViewCellDelegate = self;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
            
        }else if ([@"video-youtube" isEqualToString:newsDetailModel.type])
        {
            WSKggHTYoutubePlayerCell *mHTYoutubePlayerCell = [tableView dequeueReusableCellWithIdentifier:@"WSKggHTYoutubePlayerCell"];
            [mHTYoutubePlayerCell setNewsModel:self.newsModel newsDetailModel:newsDetailModel];
            mHTYoutubePlayerCell.selectionStyle = UITableViewCellSelectionStyleNone;
            return mHTYoutubePlayerCell;
            
//            NSString *XXXXX = @"<iframe width=\"644\" height=\"362\" src=\"https://www.youtube.com/embed/k49NQpZNiIc\" title=\"YouTube video player\" frameborder=\"0\" allow=\"accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture\" allowfullscreen></iframe>";
//
//            XXXXX = [self adapterHtmlData:XXXXX];
//                NSNiceHTNewsWebCell *mHTNewsWebCell = [tableView dequeueReusableCellWithIdentifier:@"NSNiceHTNewsWebCell"];
//                [mHTNewsWebCell taosetupWithClearHtmlContent:XXXXX];
//                return mHTNewsWebCell;
    
        }else if ([@"video-twitter" isEqualToString:newsDetailModel.type])
        {
            
            NSString *MMM = @"<blockquote class=\"twitter-tweet\"><p lang=\"en\" dir=\"ltr\">Kyrie added to his dunk collection tonight! <a href=\"https://t.co/Or0CRi5iYf\">pic.twitter.com/Or0CRi5iYf</a></p>&mdash; NBA (@NBA) <a href=\"https://twitter.com/NBA/status/1380038950220296192?ref_src=twsrc%5Etfw\">April 8, 2021</a></blockquote> <script async src=\"https://platform.twitter.com/widgets.js\" charset=\"utf-8\"></script>";
                NSNiceHTNewsWebCell *mHTNewsWebCell = [tableView dequeueReusableCellWithIdentifier:@"NSNiceHTNewsWebCell"];
                [mHTNewsWebCell taosetupWithClearHtmlContent:MMM];
            mHTNewsWebCell.selectionStyle = UITableViewCellSelectionStyleNone;
                return mHTNewsWebCell;

        }
        KSasxHTNewsTextCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KSasxHTNewsTextCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    } else if (indexPath.section == 2) {
        BByasHTAdViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BByasHTAdViewCell"];
        [cell requestAd:self];
        return cell;
    } else if (indexPath.section == 3) {
           KSasxHTNewsHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KSasxHTNewsHomeCell"];
           [cell taosetupWithNewsModel:self.topNewsList[indexPath.row]];
           return cell;
    }
    BByasHTNewsCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([BByasHTNewsCommentCell class])];
    cell.onReplyBlock = ^(NSNiceHTCommentModel * _Nonnull commentModel) {
        weakSelf.currentCommentModel = commentModel;
        //weakSelf.commentInputView.placeholder = [NSString stringWithFormat:@"回復 %@", commentModel.comment_author];
        weakSelf.commentInputView.text = nil;
        [weakSelf.commentInputView becomeFirstResponder];
        [weakSelf.replyTextView becomeFirstResponder];
//        weakSelf.replyTextView.placeholder = [NSString stringWithFormat:@"回復 %@", commentModel.comment_author];
    };
    cell.onExpendBlock = ^{
        [weakSelf.tableView beginUpdates];
        [weakSelf.tableView endUpdates];
    };
    if (indexPath.section == 4 && self.commentGetter.hotComments.count > 0) {
        [cell taorefreshWithCommentModel:self.commentGetter.hotComments[indexPath.row]];
    } else {
        [cell taorefreshWithCommentModel:self.commentGetter.normalComments[indexPath.row]];
    }
    return cell;
}
#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
//    NSLog(@"didEndDisplayingCell");
    if ([cell isKindOfClass:[KSasxHTFilmHomeCell class]] && cell == self.playingCell) {
        [self.playingCell stop];
        self.playingCell = nil;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 3) {
        UUaksHTNewsModel *newsModel = self.topNewsList[indexPath.row];
        NSNiceHTNewsDetailViewController *detailVc = [NSNiceHTNewsDetailViewController taoviewController];
        detailVc.post_id = newsModel.news_id;
        [self.navigationController pushViewController:detailVc animated:YES];
    }else if (indexPath.section == 1)
    {
       
        FFlaliHTNewsDetailModel *newsDetailModel = self.newsModel.mHTNewsDetailModels[indexPath.row];
        if ([@"img" isEqualToString:newsDetailModel.type]) {
            NSMutableArray *mmArr = [NSMutableArray array];
            [mmArr addObject:@{@"url":newsDetailModel.data,@"title":[NSString stringWithFormat:@"图片"]}];
            TuTuosHTImageBrowserViewController *imageBrController = [[TuTuosHTImageBrowserViewController alloc] initWithImages:mmArr];
            [[self navigationController] pushViewController:imageBrController animated:NO];
        }
       
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    
    if (indexPath.section == 0) {
        return self.newsModel.detailHeaderHeight;
    } else if (indexPath.section == 1) {//新闻内容
        
        FFlaliHTNewsDetailModel *newsDetailModel = self.newsModel.mHTNewsDetailModels[indexPath.row];
        NSLog(@"indexPath.section == 1 row = %d", indexPath.row);
        if ([@"img" isEqualToString:newsDetailModel.type]) {
            if (newsDetailModel.width == 0 || newsDetailModel.height == 0) {
                
                self.newsContentHeight += 180;
                return  180;//默认值
            }
            CGFloat cellHeight = self.view.frame.size.width / newsDetailModel.width * newsDetailModel.height;
            if (cellHeight < 0) {
                self.newsContentHeight += 180;
                return  180;//默认值
            }
            cellHeight = cellHeight + 16;
            self.newsContentHeight += cellHeight;
            return cellHeight;
        }else if ([@"text" isEqualToString:newsDetailModel.type]){
           
            if (!newsDetailModel.data || [@"" isEqualToString:newsDetailModel.data]) {
                self.newsContentHeight += 20;
                return 20;
            }
            CGFloat textHeight = [UUaksBJUtility calculateRowHeight:newsDetailModel.data fontSize:18 width:self.view.frame.size.width - 30];
            textHeight = textHeight + 12;
            if (textHeight < 50) {
                textHeight = 50;
            }
            self.newsContentHeight += textHeight;
            return textHeight;
        }else if ([@"video" isEqualToString:newsDetailModel.type])
        {
            CGFloat mheadHeight = [KSasxHTFilmHomeCell headerViewHeight];
            self.newsContentHeight += mheadHeight;
            return mheadHeight;
        }else if ([@"video-youtube" isEqualToString:newsDetailModel.type])
        {
            CGFloat mheadHeight = 220;//self.view.width / 644 * 362;
            self.newsContentHeight += mheadHeight;
            return mheadHeight;
//            return 200;
        }if ([@"video-twitter" isEqualToString:newsDetailModel.type]){
            CGFloat mheadHeight = self.view.width / 644 * 362;
            self.newsContentHeight += mheadHeight;
            return mheadHeight;
        }
        self.newsContentHeight += 300;
        return 300;
        
    } else if (indexPath.section == 2) {
        self.newsContentHeight += 250;
        return 250;
    } else if (indexPath.section == 3) {
        return KSasxHTNewsHomeCell.xHTNewsHomeCellHeight;
       }
    NSNiceHTCommentModel *commentModel;
    if (indexPath.section == 4 && self.commentGetter.hotComments.count > 0) {
        commentModel = self.commentGetter.hotComments[indexPath.row];
    } else {
        commentModel = self.commentGetter.normalComments[indexPath.row];
    }
    return commentModel.cellHeight;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
        
    if (section == 0) {
        return 0.1;
    }
    if (section == 1) {
        return 16;
    }
    if (section == 2) {
        return 20;
    }
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return 6;
    }
    return 0.1;
}

- (UITableViewHeaderFooterView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (section == 0 || section == 2) {
        return nil;
    }
    if (section == 1) {
        WSKggHTNoUseHeaderTableViewCell *nouseHeaderView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"WSKggHTNoUseHeaderTableViewCell"];
        return nouseHeaderView;
    }
    BlysaHTNewsTopHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"BlysaHTNewsTopHeaderView"];
    if (section == 3) {
        [headerView taorefreshWithTitle:@"推薦閱讀"];
    } else if (section == 4 && self.commentGetter.hotComments.count > 0) {
        [headerView taorefreshWithTitle:@"熱門回覆"];
    } else {
        [headerView taorefreshWithTitle:@"全部回覆"];
    }
    return headerView;
}
#pragma mark - requests
- (void)loadDetailWithCompleteBlock:(dispatch_block_t)block {
    [YeYeeHTNewsAdditionRequest taorequestDetailWithPostId:self.post_id successBlock:^(UUaksHTNewsModel * _Nonnull newsModel) {
       
        self.newsModel = newsModel;
        self.htmlLoadDone = YES;
        if (block) {
            block();
        }
    } errorBlock:^(YeYeeBJError *error) {
        [self.view showToast:@"數據拉取失敗"];
        if (!self.newsModel) {
            [self.view showEmptyViewWithTitle:@"數據拉取失敗，點擊重試" tapBlock:^{
                [self.view hideEmptyView];
                [self.view showLoadingView];
                [self loadDetailWithCompleteBlock:block];
            }];
        }
    }];
}
- (void)initDataRequests {//推薦閱讀
    kWeakSelf
    self.topRequestDone = NO;
   
    [WSKggHTNewsTopRequest taorequestWithSuccessBlock:^(NSArray<UUaksHTNewsModel *> *newsList) {
        weakSelf.topNewsList = newsList;
        weakSelf.topRequestDone = YES;
        [weakSelf refreshUI];
    } errorBlock:^(YeYeeBJError *error) {
        [weakSelf.view showToast:@"「推薦閱讀」獲取失敗"];
        weakSelf.topRequestDone = YES;
        [weakSelf refreshUI];
    }];
//    if (!weakSelf.htmlContent) {
//        self.htmlLoadDone = NO;
//        [self.newsModel taogetClearContentWithBlock:^(BOOL success, NSString *content) {
//            weakSelf.htmlContent = content;
//            weakSelf.htmlLoadDone = YES;
//            [weakSelf refreshUI];
//        }];
//    }
    [self loadComments];
}
- (void)loadComments {
    if (self.newsModel.total_comment == 0) {
        self.tableView.tableFooterView = self.noCommentsFooterView;
        self.tableView.mj_footer.hidden = YES;
        [self.tableView reloadData];
        return;
    }
    self.tableView.tableFooterView = nil;
    self.tableView.mj_footer.hidden = NO;
    kWeakSelf
    [self.commentGetter taodoRequestWithCompleteBlock:^{
        if (weakSelf.commentGetter.hasMore) {
            [weakSelf.tableView.mj_footer endRefreshing];
        } else {
            [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        [weakSelf.tableView reloadData];
        
//        [weakSelf onShowCommentListAction:nil];
    }];
}
- (void)updateAfterComment {
    [self loadDetailWithCompleteBlock:^{
        [self refreshUI];
        [self.commentGetter taoreset];
        [self loadComments];
    }];
}
- (void)addHistoryRecord {
    [TuTuosHTUserRequest taoaddHistoryWithNewsId:self.post_id successBlock:^{
        BJLog(@"添加瀏覽歷史成功");
    } failBlock:^(YeYeeBJError *error) {
        BJLog(@"添加瀏覽歷史失敗");
    }];
}
#pragma mark - UI refresh
- (void)setupViews {
    [self.view showLoadingView];
    self.title = @"新聞詳情";
    self.newsContentHeight = 0;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.estimatedRowHeight = 20;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    [self.tableView registerNib:[UINib nibWithNibName:@"MMoogHTNewsHeaderCell" bundle:nil]
         forCellReuseIdentifier:@"MMoogHTNewsHeaderCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"NSNiceHTNewsWebCell" bundle:nil]
         forCellReuseIdentifier:@"NSNiceHTNewsWebCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"KSasxHTNewsHomeCell" bundle:nil]
         forCellReuseIdentifier:@"KSasxHTNewsHomeCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"BlysaHTNewsTopHeaderView" bundle:nil] forHeaderFooterViewReuseIdentifier:@"BlysaHTNewsTopHeaderView"];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([BByasHTNewsCommentCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([BByasHTNewsCommentCell class])];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"BByasHTAdViewCell" bundle:nil]
    forCellReuseIdentifier:@"BByasHTAdViewCell"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"KSasxHTNewsTextCell" bundle:nil]
    forCellReuseIdentifier:@"KSasxHTNewsTextCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"KSasxHTNewsImageTypeCell" bundle:nil]
    forCellReuseIdentifier:@"KSasxHTNewsImageTypeCell"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"KSasxHTFilmHomeCell" bundle:nil]
         forCellReuseIdentifier:@"KSasxHTFilmHomeCell"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"WSKggHTYoutubePlayerCell" bundle:nil]
         forCellReuseIdentifier:@"WSKggHTYoutubePlayerCell"];
        
    [self.tableView registerNib:[UINib nibWithNibName:@"WSKggHTNoUseHeaderTableViewCell" bundle:nil] forHeaderFooterViewReuseIdentifier:@"WSKggHTNoUseHeaderTableViewCell"];
    
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    kWeakSelf
    self.tableView.mj_footer = [BlysaMJRefreshGenerator bj_foorterWithRefreshingBlock:^{
        [weakSelf loadComments];
    }];
    if ([UUaksHTNewsModel taocanShare]) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"nav_icon_share"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] style:UIBarButtonItemStylePlain target:self action:@selector(onShareButtonTapped:)];
    }
    UIImage *commentIcon = [[UIImage imageNamed:@"icon_add_comment"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [self.commentButton setImage:commentIcon forState:UIControlStateNormal];
    [self.commentButton setTintColor:[UIColor hx_colorWithHexRGBAString:@"999999"]];
    UIImage *saveIcon = [[WSKggPPXXBJBaseViewController taofixImageSize:[UIImage imageNamed:@"icon_add_collection"] toSize:CGSizeMake(20, 20)] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [self.saveButton setImage:saveIcon forState:UIControlStateNormal];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onInputBegin) name:UITextViewTextDidBeginEditingNotification object:self.commentInputView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onInputEnd) name:UITextViewTextDidEndEditingNotification object:self.commentInputView];
    [self.commentInputView bk_addObserverForKeyPath:@"contentSize" task:^(id target) {
        CGFloat height = weakSelf.commentInputView.contentSize.height;
        if (height < 34) {
            height = 34;
        }
        if (height > 92) {
            height = 92;
        }
        if (height != weakSelf.comtentHeight.constant) {
            [UIView animateWithDuration:0.15 animations:^{
                weakSelf.comtentHeight.constant = height;
                [weakSelf.view layoutIfNeeded];
            }];
        }
    }];
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:@" "];
    attr.yy_lineSpacing = 5;
    attr.yy_font = [UIFont systemFontOfSize:15];
    attr.yy_color = [UIColor hx_colorWithHexRGBAString:@"333333"];
    self.commentInputView.attributedText = attr;
}
- (void)refreshUI {
//    if (!self.topRequestDone || !self.htmlLoadDone) {
//        return;
//    }
    [self.view hideLoadingView];
    [self.tableView reloadData];
    [self setupSaveButton];
    if (self.newsModel.total_comment > 0) {
        self.commentCountContent.hidden = NO;
        self.commentCountLabel.text = [NSString stringWithFormat:@"%ld", self.newsModel.total_comment];
    } else {
        self.commentCountContent.hidden = YES;
    }
}
- (void)setupSaveButton {
    if (self.newsModel.my_save) {
        [self.saveButton setTintColor:appBaseColor];
        self.saveButton.selected = YES;
    } else {
        self.saveButton.selected = NO;
        [self.saveButton setTintColor:[UIColor hx_colorWithHexRGBAString:@"999999"]];
    }
}
#pragma mark - actions
- (void)onShareButtonTapped:(id)sender {
    [self.newsModel taoshare];
}
- (IBAction)onSaveAction:(UIButton *)sender {
    if (![NSNiceHTUserManager tao_isUserLogin]) {
        [NSNiceHTUserManager tao_doUserLogin];
        [self.view showToast:@"請登錄"];
        return;
    }
    if (sender.selected) {
        [TuTuosHTUserRequest taodeleteCollectionWithNewsId:self.newsModel.news_id successBlock:^{
            [self.view showToast:@"已取消收藏"];
            self.newsModel.my_save = NO;
            [self setupSaveButton];
        } failBlock:^(YeYeeBJError *error) {
            [self.view showToast:@"取消收藏失敗"];
        }];
    } else {
        [TuTuosHTUserRequest taoaddCollectionWithNewsId:self.newsModel.news_id successBlock:^{
            [self.view showToast:@"已收藏"];
            self.newsModel.my_save = YES;
            [self setupSaveButton];
        } failBlock:^(YeYeeBJError *error) {
            [self.view showToast:@"收藏失敗"];
        }];
    }
    sender.selected = !sender.selected;
    self.newsModel.my_save = sender.selected;
}
- (IBAction)onShowCommentListAction:(id)sender {
    CGFloat contentHeight = self.newsContentHeight + self.newsModel.detailHeaderHeight +  KSasxHTNewsHomeCell.xHTNewsHomeCellHeight * self.topNewsList.count + 40;
    CGFloat commnetHeight = self.tableView.contentSize.height - contentHeight;
    if (commnetHeight > self.tableView.height) {
        [self.tableView setContentOffset:CGPointMake(0, contentHeight) animated:YES];
    } else {
        [self.tableView setContentOffset:CGPointMake(0, contentHeight-(self.tableView.height-commnetHeight)) animated:YES];
    }
}
- (IBAction)sendCommentAction:(id)sender {
    if (self.commentInputView.text.length == 0) {
        [kWindow showToast:@"請輸入評論"];
        return;
    }
    [TuTuosHTUserRequest taopostCommentWithComment_txt:self.commentInputView.text post_id:self.newsModel.news_id reply_comment_id:self.currentCommentModel.comment_id successBlock:^{
        self.commentInputView.text = nil;
        self.replyTextView.text = nil;
        [self.view endEditing:YES];
        [kWindow showToast:@"評論成功"];
        [self updateAfterComment];
    } failBlock:^(YeYeeBJError *error) {
        [kWindow showToast:@"評論失敗"];
    }];
}
- (void)onInputBegin {
    if (![NSNiceHTUserManager tao_isUserLogin]) {
        [self.view endEditing:YES];
        [NSNiceHTUserManager tao_doUserLogin];
        [self.view showToast:@"請登錄"];
        return;
    }
//    self.buttonContentView.hidden = YES;
//    self.sendButton.hidden = NO;
    [UIView animateWithDuration:0.25 animations:^{
        self.contentRight.constant = 20;
        [self.commentInputView.superview layoutIfNeeded];
    }];
}
- (void)onInputEnd {
    if (self.commentInputView.text.length == 0) {
//        self.buttonContentView.hidden = NO;
//        self.sendButton.hidden = YES;
        [UIView animateWithDuration:0.25 animations:^{
            self.contentRight.constant = 80;
            [self.commentInputView.superview layoutIfNeeded];
        }];
    }
}
#pragma mark - lazy load
- (YeYeeHTCommentGetter *)commentGetter {
    if (!_commentGetter) {
        _commentGetter = [[YeYeeHTCommentGetter alloc] initWithPostId:self.post_id];
    }
    return _commentGetter;
}
- (KSasxHTNoCommentFooterView *)noCommentsFooterView {
    if (!_noCommentsFooterView) {
        _noCommentsFooterView = [KSasxHTNoCommentFooterView taofooterViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
    }
    return _noCommentsFooterView;
}

#pragma mark - UIButton Target Aciton
- (void)cancelButtonClicked
{
    [_replyTextView resignFirstResponder];
   // [_replyInput resignFirstResponder];
    [self.view endEditing:YES];
    
}

- (void)submitButtonClicked
{

    [_replyTextView resignFirstResponder];
    self.commentInputView.text = _replyTextView.text;
    [self.view endEditing:YES];
    [self sendCommentAction:self.sendButton];
}

#pragma mark - cell代理PlayerTableViewCellDelegate
- (void)tableViewWillPlay:(KSasxHTFilmHomeCell *)cell {
    if (cell == self.playingCell) return;
    
    NSArray *array = [self.tableView visibleCells];
    for (UITableViewCell *tempCell in array) {
        
        if (cell != tempCell && [tempCell isKindOfClass:[KSasxHTFilmHomeCell class]]) {
            KSasxHTFilmHomeCell *xxTempCell = (KSasxHTFilmHomeCell *)tempCell;
            [xxTempCell shutdown];//所有其他不播放的可见cell stop
        }
    }
    self.playingCell = cell;
}

- (void)tableViewCellEnterFullScreen:(KSasxHTFilmHomeCell *)cell {
    self.isFullScreen = YES;
//    [self setNeedsStatusBarAppearanceUpdate];
}

- (void)tableViewCellExitFullScreen:(KSasxHTFilmHomeCell *)cell {
    self.isFullScreen = NO;
//    [self setNeedsStatusBarAppearanceUpdate];
}


- (void)playerAllShutdown {
    
    NSArray *array = [self.tableView visibleCells];

    for (UITableViewCell *tempCell in array) {
        
        if ([tempCell isKindOfClass:[KSasxHTFilmHomeCell class]]) {
            KSasxHTFilmHomeCell *xxTempCell = (KSasxHTFilmHomeCell *)tempCell;
            [xxTempCell shutdown];//所有其他不播放的可见cell stop
        }
    }
}

@end
