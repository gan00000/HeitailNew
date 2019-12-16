#import "SkyBallHetiRedHTNewsDetailViewController.h"
#import "SkyBallHetiRedHTNewsTopRequest.h"
#import "SkyBallHetiRedHTNewsHeaderCell.h"
#import "SkyBallHetiRedHTNewsWebCell.h"
#import "SkyBallHetiRedHTNewsHomeCell.h"
#import "SkyBallHetiRedHTNewsTopHeaderView.h"
#import "SkyBallHetiRedPPXXBJNavigationController.h"
#import "SkyBallHetiRedHTNewsAdditionRequest.h"
#import "SkyBallHetiRedHTUserRequest.h"
#import <BlocksKit/BlocksKit.h>
#import <YYText/YYText.h>
#import "SkyBallHetiRedHTCommentGetter.h"
#import "SkyBallHetiRedHTNewsCommentCell.h"
#import "SkyBallHetiRedHTNoCommentFooterView.h"
#import "HTAdViewCell.h"
@interface SkyBallHetiRedHTNewsDetailViewController () <UITableViewDelegate, UITableViewDataSource>
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
@property (nonatomic, strong) SkyBallHetiRedHTNewsModel *newsModel;
@property (nonatomic, strong) NSArray *topNewsList;
@property (nonatomic, copy) NSString *htmlContent;
@property (nonatomic, assign) CGFloat newsContentHeight;
@property (nonatomic, assign) BOOL topRequestDone;
@property (nonatomic, assign) BOOL htmlLoadDone;
@property (nonatomic, weak) SkyBallHetiRedHTCommentModel *currentCommentModel;
@property (nonatomic, strong) SkyBallHetiRedHTCommentGetter *commentGetter;
@property (nonatomic, strong) SkyBallHetiRedHTNoCommentFooterView *noCommentsFooterView;
@property (nonatomic, assign) BOOL isFirstShow;
@end
@implementation SkyBallHetiRedHTNewsDetailViewController
+ (instancetype)waterSkyviewController {
    return kLoadStoryboardWithName(@"SkyBallHetiRedNewsDetail");
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViews];
    self.isFirstShow = YES;
    
//    if ([self.commentInputView.text isEqualToString:@" "]) {
//        self.commentInputView.text = nil;
//    }
//    [self loadDetailWithCompleteBlock:^{
//        [self initDataRequests];
//    }];
//    [self addHistoryRecord];
    
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (self.isFirstShow) {
        self.isFirstShow = NO;
        if ([self.commentInputView.text isEqualToString:@" "]) {
            self.commentInputView.text = nil;
        }
        [self loadDetailWithCompleteBlock:^{
            [self initDataRequests];
        }];
        [self addHistoryRecord];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (!self.topRequestDone || !self.htmlLoadDone) {
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
    if (section == 0 || section == 1) {
        return 1;
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
    kWeakSelf
    if (indexPath.section == 0) {
        SkyBallHetiRedHTNewsHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SkyBallHetiRedHTNewsHeaderCell"];
        [cell waterSkysetupWithNewsModel:self.newsModel];
        return cell;
    } else if (indexPath.section == 1) {
        SkyBallHetiRedHTNewsWebCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SkyBallHetiRedHTNewsWebCell"];
        if (self.newsContentHeight == 0) {
            [cell waterSkysetupWithClearHtmlContent:self.htmlContent];
            cell.onContentHeightUpdateBlock = ^(CGFloat height) {
                if (fabs(height - weakSelf.newsContentHeight) < 1) {
                    return;
                }
                weakSelf.newsContentHeight = height;
                [weakSelf.tableView reloadData];
            };
        }
        return cell;
    } else if (indexPath.section == 2) {
        HTAdViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HTAdViewCell"];
        [cell requestAd:self];
        return cell;
    } else if (indexPath.section == 3) {
           SkyBallHetiRedHTNewsHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SkyBallHetiRedHTNewsHomeCell"];
           [cell waterSkysetupWithNewsModel:self.topNewsList[indexPath.row]];
           return cell;
    }
    SkyBallHetiRedHTNewsCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SkyBallHetiRedHTNewsCommentCell class])];
    cell.onReplyBlock = ^(SkyBallHetiRedHTCommentModel * _Nonnull commentModel) {
        weakSelf.currentCommentModel = commentModel;
        weakSelf.commentInputView.placeholder = [NSString stringWithFormat:@"回復 %@", commentModel.comment_author];
        weakSelf.commentInputView.text = nil;
        [weakSelf.commentInputView becomeFirstResponder];
    };
    cell.onExpendBlock = ^{
        [weakSelf.tableView beginUpdates];
        [weakSelf.tableView endUpdates];
    };
    if (indexPath.section == 4 && self.commentGetter.hotComments.count > 0) {
        [cell waterSkyrefreshWithCommentModel:self.commentGetter.hotComments[indexPath.row]];
    } else {
        [cell waterSkyrefreshWithCommentModel:self.commentGetter.normalComments[indexPath.row]];
    }
    return cell;
}
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 2) {
        SkyBallHetiRedHTNewsModel *newsModel = self.topNewsList[indexPath.row];
        SkyBallHetiRedHTNewsDetailViewController *detailVc = [SkyBallHetiRedHTNewsDetailViewController waterSkyviewController];
        detailVc.post_id = newsModel.news_id;
        [self.navigationController pushViewController:detailVc animated:YES];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return self.newsModel.detailHeaderHeight;
    } else if (indexPath.section == 1) {
        return self.newsContentHeight;
    } else if (indexPath.section == 2) {
        return 250;
    } else if (indexPath.section == 3) {
           return 90;
       }
    SkyBallHetiRedHTCommentModel *commentModel;
    if (indexPath.section == 4 && self.commentGetter.hotComments.count > 0) {
        commentModel = self.commentGetter.hotComments[indexPath.row];
    } else {
        commentModel = self.commentGetter.normalComments[indexPath.row];
    }
    return commentModel.cellHeight;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0 || section == 1) {
        return 0.1;
    }
    return 40;
}
- (UITableViewHeaderFooterView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0 || section == 1 || section == 2) {
        return nil;
    }
    SkyBallHetiRedHTNewsTopHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"SkyBallHetiRedHTNewsTopHeaderView"];
    if (section == 3) {
        [headerView waterSkyrefreshWithTitle:@"推薦閱讀"];
    } else if (section == 4 && self.commentGetter.hotComments.count > 0) {
        [headerView waterSkyrefreshWithTitle:@"熱門回覆"];
    } else {
        [headerView waterSkyrefreshWithTitle:@"全部回覆"];
    }
    return headerView;
}
#pragma mark - requests
- (void)loadDetailWithCompleteBlock:(dispatch_block_t)block {
    [SkyBallHetiRedHTNewsAdditionRequest waterSkyrequestDetailWithPostId:self.post_id successBlock:^(SkyBallHetiRedHTNewsModel * _Nonnull newsModel) {
        self.newsModel = newsModel;
        if (block) {
            block();
        }
    } errorBlock:^(SkyBallHetiRedBJError *error) {
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
- (void)initDataRequests {
    kWeakSelf
    self.topRequestDone = NO;
    self.htmlLoadDone = YES;
    [SkyBallHetiRedHTNewsTopRequest waterSkyrequestWithSuccessBlock:^(NSArray<SkyBallHetiRedHTNewsModel *> *newsList) {
        weakSelf.topNewsList = newsList;
        weakSelf.topRequestDone = YES;
        [weakSelf refreshUI];
    } errorBlock:^(SkyBallHetiRedBJError *error) {
        [weakSelf.view showToast:@"「推薦閱讀」獲取失敗"];
        weakSelf.topRequestDone = YES;
        [weakSelf refreshUI];
    }];
    if (!weakSelf.htmlContent) {
        self.htmlLoadDone = NO;
        [self.newsModel waterSkygetClearContentWithBlock:^(BOOL success, NSString *content) {
            weakSelf.htmlContent = content;
            weakSelf.htmlLoadDone = YES;
            [weakSelf refreshUI];
        }];
    }
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
    [self.commentGetter waterSkydoRequestWithCompleteBlock:^{
        if (weakSelf.commentGetter.hasMore) {
            [weakSelf.tableView.mj_footer endRefreshing];
        } else {
            [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        [weakSelf.tableView reloadData];
    }];
}
- (void)updateAfterComment {
    [self loadDetailWithCompleteBlock:^{
        [self refreshUI];
        [self.commentGetter waterSkyreset];
        [self loadComments];
    }];
}
- (void)addHistoryRecord {
    [SkyBallHetiRedHTUserRequest waterSkyaddHistoryWithNewsId:self.post_id successBlock:^{
        BJLog(@"添加瀏覽歷史成功");
    } failBlock:^(SkyBallHetiRedBJError *error) {
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
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    [self.tableView registerNib:[UINib nibWithNibName:@"SkyBallHetiRedHTNewsHeaderCell" bundle:nil]
         forCellReuseIdentifier:@"SkyBallHetiRedHTNewsHeaderCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"SkyBallHetiRedHTNewsWebCell" bundle:nil]
         forCellReuseIdentifier:@"SkyBallHetiRedHTNewsWebCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"SkyBallHetiRedHTNewsHomeCell" bundle:nil]
         forCellReuseIdentifier:@"SkyBallHetiRedHTNewsHomeCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"SkyBallHetiRedHTNewsTopHeaderView" bundle:nil] forHeaderFooterViewReuseIdentifier:@"SkyBallHetiRedHTNewsTopHeaderView"];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SkyBallHetiRedHTNewsCommentCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SkyBallHetiRedHTNewsCommentCell class])];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"HTAdViewCell" bundle:nil]
    forCellReuseIdentifier:@"HTAdViewCell"];
    
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    kWeakSelf
    self.tableView.mj_footer = [SkyBallHetiRedMJRefreshGenerator bj_foorterWithRefreshingBlock:^{
        [weakSelf loadComments];
    }];
    if ([SkyBallHetiRedHTNewsModel waterSkycanShare]) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"nav_icon_share"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] style:UIBarButtonItemStylePlain target:self action:@selector(onShareButtonTapped:)];
    }
    UIImage *commentIcon = [[UIImage imageNamed:@"icon_add_comment"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [self.commentButton setImage:commentIcon forState:UIControlStateNormal];
    [self.commentButton setTintColor:[UIColor hx_colorWithHexRGBAString:@"999999"]];
    UIImage *saveIcon = [[SkyBallHetiRedPPXXBJBaseViewController waterSkyfixImageSize:[UIImage imageNamed:@"icon_add_collection"] toSize:CGSizeMake(20, 20)] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
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
    if (!self.topRequestDone || !self.htmlLoadDone) {
        return;
    }
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
        [self.saveButton setTintColor:[UIColor hx_colorWithHexRGBAString:@"fc562e"]];
        self.saveButton.selected = YES;
    } else {
        self.saveButton.selected = NO;
        [self.saveButton setTintColor:[UIColor hx_colorWithHexRGBAString:@"999999"]];
    }
}
#pragma mark - actions
- (void)onShareButtonTapped:(id)sender {
    [self.newsModel waterSkyshare];
}
- (IBAction)onSaveAction:(UIButton *)sender {
    if (![SkyBallHetiRedHTUserManager waterSky_isUserLogin]) {
        [SkyBallHetiRedHTUserManager waterSky_doUserLogin];
        [self.view showToast:@"請登錄"];
        return;
    }
    if (sender.selected) {
        [SkyBallHetiRedHTUserRequest waterSkydeleteCollectionWithNewsId:self.newsModel.news_id successBlock:^{
            [self.view showToast:@"已取消收藏"];
            self.newsModel.my_save = NO;
            [self setupSaveButton];
        } failBlock:^(SkyBallHetiRedBJError *error) {
            [self.view showToast:@"取消收藏失敗"];
        }];
    } else {
        [SkyBallHetiRedHTUserRequest waterSkyaddCollectionWithNewsId:self.newsModel.news_id successBlock:^{
            [self.view showToast:@"已收藏"];
            self.newsModel.my_save = YES;
            [self setupSaveButton];
        } failBlock:^(SkyBallHetiRedBJError *error) {
            [self.view showToast:@"收藏失敗"];
        }];
    }
    sender.selected = !sender.selected;
    self.newsModel.my_save = sender.selected;
}
- (IBAction)onShowCommentListAction:(id)sender {
    CGFloat contentHeight = self.newsContentHeight + self.newsModel.detailHeaderHeight + 90*self.topNewsList.count + 40;
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
    [SkyBallHetiRedHTUserRequest waterSkypostCommentWithComment_txt:self.commentInputView.text post_id:self.newsModel.news_id reply_comment_id:self.currentCommentModel.comment_id successBlock:^{
        self.commentInputView.text = nil;
        [self.view endEditing:YES];
        [kWindow showToast:@"評論成功"];
        [self updateAfterComment];
    } failBlock:^(SkyBallHetiRedBJError *error) {
        [kWindow showToast:@"評論失敗"];
    }];
}
- (void)onInputBegin {
    if (![SkyBallHetiRedHTUserManager waterSky_isUserLogin]) {
        [self.view endEditing:YES];
        [SkyBallHetiRedHTUserManager waterSky_doUserLogin];
        [self.view showToast:@"請登錄"];
        return;
    }
    self.buttonContentView.hidden = YES;
    self.sendButton.hidden = NO;
    [UIView animateWithDuration:0.25 animations:^{
        self.contentRight.constant = 20;
        [self.commentInputView.superview layoutIfNeeded];
    }];
}
- (void)onInputEnd {
    if (self.commentInputView.text.length == 0) {
        self.buttonContentView.hidden = NO;
        self.sendButton.hidden = YES;
        [UIView animateWithDuration:0.25 animations:^{
            self.contentRight.constant = 80;
            [self.commentInputView.superview layoutIfNeeded];
        }];
    }
}
#pragma mark - lazy load
- (SkyBallHetiRedHTCommentGetter *)commentGetter {
    if (!_commentGetter) {
        _commentGetter = [[SkyBallHetiRedHTCommentGetter alloc] initWithPostId:self.post_id];
    }
    return _commentGetter;
}
- (SkyBallHetiRedHTNoCommentFooterView *)noCommentsFooterView {
    if (!_noCommentsFooterView) {
        _noCommentsFooterView = [SkyBallHetiRedHTNoCommentFooterView waterSkyfooterViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
    }
    return _noCommentsFooterView;
}
@end
