#import "PXFunHTFilmDetailViewController.h"
#import "KMonkeyHTNewsTopRequest.h"
#import "RRDogHTNewsHeaderCell.h"
#import "NDeskHTNewsWebCell.h"
#import "YYPackageHTNewsHomeCell.h"
#import "NDeskHTNewsTopHeaderView.h"
#import "HoursePPXXBJNavigationController.h"
#import "GGCatHTNewsAdditionRequest.h"
#import "HourseHTUserRequest.h"
#import <BlocksKit/BlocksKit.h>
#import <YYText/YYText.h>
#import "HourseHTCommentGetter.h"
#import "NDeskHTNewsCommentCell.h"
#import "RRDogHTNoCommentFooterView.h"
#import "MMTodayHTAdViewCell.h"
#import <IQKeyboardManager/IQKeyboardManager.h>
#import "UIColor+KMonkeyGlodBuleHex.h"
#import "UIView+PXFunGlodBuleBlockGesture.h"

#import "CCCaseYSPlayerController.h"

@import Firebase;

@interface PXFunHTFilmDetailViewController () <UITableViewDelegate, UITableViewDataSource, YSPlayerControllerDelegate>
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
@property (nonatomic, strong) PXFunHTNewsModel *newsModel;
@property (nonatomic, strong) NSArray *topNewsList;
@property (nonatomic, copy) NSString *htmlContent;
@property (nonatomic, assign) CGFloat newsContentHeight;
//@property (nonatomic, assign) BOOL topRequestDone;
//@property (nonatomic, assign) BOOL htmlLoadDone;
@property (nonatomic, weak) HourseHTCommentModel *currentCommentModel;
@property (nonatomic, strong) HourseHTCommentGetter *commentGetter;
@property (nonatomic, strong) RRDogHTNoCommentFooterView *noCommentsFooterView;
@property (nonatomic, assign) BOOL isFirstShow;

@property (weak, nonatomic) IBOutlet UIView *playerContentView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *playContentViewTralling;


//========
@property (strong, nonatomic) CCCaseYSPlayerController *playerController;
@property (strong, nonatomic) UIView *playerView;
@property (nonatomic, assign) BOOL fullScreen;

@property (nonatomic, strong)UIView * replyInputAccessoryView;
@property (nonatomic, strong)UIButton * cancelButton;
@property (nonatomic, strong)UIButton * submitButton;
@property (nonatomic, strong)UITextView *replyTextView;

@end
@implementation PXFunHTFilmDetailViewController
+ (instancetype)taoviewController {
    return kLoadStoryboardWithName(@"SkyBallHetiRedFilmDetail");
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.newsModel = self.filmModel;
    self.isFirstShow = YES;
    
    
    if (self.filmModel && self.filmModel
        .plMediaInfo && self.filmModel
        .plMediaInfo.videoURL && ![self.filmModel
                                  .plMediaInfo.videoURL isEqualToString:@""]) {
    }
    
    
    [self setupViews];
    
    if (self.cellPlayerController) {
        
        self.playerController = self.cellPlayerController;
        
    }else{
//        [self.playerController shutdown];
//        [self.playerView removeFromSuperview];
//        self.playerController = nil;
        
        self.playerController = [[CCCaseYSPlayerController alloc] initWithContentMediaInfo: self.filmModel.plMediaInfo];
    }
    
    self.playerController.delegate = self;
    self.playerController.needPortFullScreen = YES;
    self.playerView = self.playerController.view;
    [self.playerContentView addSubview:self.playerView];
    [self.playerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.playerContentView);
    }];
    
    self.commentInputView.inputAccessoryView = self.replyInputAccessoryView;
    
    [self.commentInputView addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        NSLog(@"_imTalkTextView addTapActionWithBlock:");
        [self.commentInputView becomeFirstResponder];
        [self.replyTextView becomeFirstResponder];
    }];
    
    [FIRAnalytics logEventWithName:@"IOS_FILM_Detail"
                        parameters:@{
                                     kFIRParameterItemID:[NSString stringWithFormat:@"id:%@", self.newsModel.title],
                                     kFIRParameterItemName:@"影片详情",
                                     kFIRParameterContentType:@"film-detail"
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
    NSLog(@"HourseHTNewsDetailViewController viewDidAppear");
    [IQKeyboardManager sharedManager].enable = NO;
    if (self.isFirstShow) {
        self.isFirstShow = NO;
        if ([self.commentInputView.text isEqualToString:@" "]) {
            self.commentInputView.text = nil;
        }
        
        [self loadComments];//影片只需要获取评论
        [self addHistoryRecord];
        
//        if (self.currentPlaybackTime > 0) {
//            [self.playerController playNowWithTime:self.currentPlaybackTime];
//        }
    }
//    if (!self.isPlayFilm) {
//
//        self.playContentViewTralling.constant = SCREEN_WIDTH - 0.1;
//        [self.playerContentView setNeedsUpdateConstraints];
//        [self.playerContentView updateConstraintsIfNeeded];
//        [self.playerContentView layoutIfNeeded];
//    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    NSLog(@"HourseHTNewsDetailViewController viewDidDisappear");
    [IQKeyboardManager sharedManager].enable = YES;
    
    if (!self.cellPlayerController) {
        [self.playerController pause];
    }
    
}

- (void)dealloc
{
    if (self.cellPlayerController) {
        [self.cellPlayerController.view removeFromSuperview];
    }else{
        [self.playerController shutdown];
    }
   
}

- (void)tao_handleNavBack{
    
    if (self.cellPlayerController) {
        [self.cellPlayerController.view removeFromSuperview];
    }else{
        [self.playerController shutdown];
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    NSInteger num = 1;
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
    if (section == 1 && self.commentGetter.hotComments.count > 0) {
        return self.commentGetter.hotComments.count;
    } else {
        return self.commentGetter.normalComments.count;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    kWeakSelf
    if (indexPath.section == 0) {
        RRDogHTNewsHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RRDogHTNewsHeaderCell"];
        [cell taosetupWithNewsModel:self.newsModel];
        return cell;
    }
    NDeskHTNewsCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([NDeskHTNewsCommentCell class])];
    cell.onReplyBlock = ^(HourseHTCommentModel * _Nonnull commentModel) {
        weakSelf.currentCommentModel = commentModel;
//        weakSelf.commentInputView.placeholder = [NSString stringWithFormat:@"回復 %@", commentModel.comment_author];
        weakSelf.commentInputView.text = nil;
        [weakSelf.commentInputView becomeFirstResponder];
        [weakSelf.replyTextView becomeFirstResponder];
    };
    cell.onExpendBlock = ^{
        [weakSelf.tableView beginUpdates];
        [weakSelf.tableView endUpdates];
    };
    if (indexPath.section == 1 && self.commentGetter.hotComments.count > 0) {
        [cell taorefreshWithCommentModel:self.commentGetter.hotComments[indexPath.row]];
    } else {
        [cell taorefreshWithCommentModel:self.commentGetter.normalComments[indexPath.row]];
    }
    return cell;
    
}
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        return self.newsModel.detailHeaderHeight;
    }
    HourseHTCommentModel *commentModel;
    if (indexPath.section == 1 && self.commentGetter.hotComments.count > 0) {
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
    return 40;
    
}
- (UITableViewHeaderFooterView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        return nil;
    }
    NDeskHTNewsTopHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"NDeskHTNewsTopHeaderView"];
    if (section == 1 && self.commentGetter.hotComments.count > 0) {
        [headerView taorefreshWithTitle:@"熱門回覆"];
    } else {
        [headerView taorefreshWithTitle:@"全部回覆"];
    }
    return headerView;
    
}
#pragma mark - requests


- (void)loadDetailWithCompleteBlock:(dispatch_block_t)block {
    [GGCatHTNewsAdditionRequest taorequestDetailWithPostId:self.post_id successBlock:^(PXFunHTNewsModel * _Nonnull newsModel) {
        self.newsModel = newsModel;
        if (block) {
            block();
        }
    } errorBlock:^(SundayBJError *error) {
        [self.view showToast:@"數據拉取失敗"];
        if (!self.newsModel) {
            [self.view showEmptyViewWithTitle:@"數據拉取失敗，點擊重試" tapBlock:^{
                [self.view hideEmptyView];
//                [self.view showLoadingView];
                [self loadDetailWithCompleteBlock:block];
            }];
        }
    }];
}

- (void)loadComments {
    
    [self refreshUI];

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
        [self refreshUI];
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
    [HourseHTUserRequest taoaddHistoryWithNewsId:self.post_id successBlock:^{
        BJLog(@"添加瀏覽歷史成功");
    } failBlock:^(SundayBJError *error) {
        BJLog(@"添加瀏覽歷史失敗");
    }];
}
#pragma mark - UI refresh
- (void)setupViews {
    
    self.title = @"影片詳情";
    self.newsContentHeight = 0;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    [self.tableView registerNib:[UINib nibWithNibName:@"RRDogHTNewsHeaderCell" bundle:nil]
         forCellReuseIdentifier:@"RRDogHTNewsHeaderCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"NDeskHTNewsWebCell" bundle:nil]
         forCellReuseIdentifier:@"NDeskHTNewsWebCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"YYPackageHTNewsHomeCell" bundle:nil]
         forCellReuseIdentifier:@"YYPackageHTNewsHomeCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"NDeskHTNewsTopHeaderView" bundle:nil] forHeaderFooterViewReuseIdentifier:@"NDeskHTNewsTopHeaderView"];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([NDeskHTNewsCommentCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([NDeskHTNewsCommentCell class])];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"MMTodayHTAdViewCell" bundle:nil]
    forCellReuseIdentifier:@"MMTodayHTAdViewCell"];
    
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    kWeakSelf
    self.tableView.mj_footer = [HourseMJRefreshGenerator bj_foorterWithRefreshingBlock:^{
        [weakSelf loadComments];
    }];
    if ([PXFunHTNewsModel taocanShare]) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"nav_icon_share"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] style:UIBarButtonItemStylePlain target:self action:@selector(onShareButtonTapped:)];
    }
    UIImage *commentIcon = [[UIImage imageNamed:@"icon_add_comment"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [self.commentButton setImage:commentIcon forState:UIControlStateNormal];
    [self.commentButton setTintColor:[UIColor hx_colorWithHexRGBAString:@"999999"]];
//    UIImage *saveIcon = [[CCCasePPXXBJBaseViewController taofixImageSize:[UIImage imageNamed:@"icon_add_collection"] toSize:CGSizeMake(20, 20)] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
//    [self.saveButton setImage:saveIcon forState:UIControlStateNormal];
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
//- (void)setupSaveButton {
//    if (self.newsModel.my_save) {
//        [self.saveButton setTintColor:[UIColor hx_colorWithHexRGBAString:@"fc562e"]];
//        self.saveButton.selected = YES;
//    } else {
//        self.saveButton.selected = NO;
//        [self.saveButton setTintColor:[UIColor hx_colorWithHexRGBAString:@"999999"]];
//    }
//}

- (void)setupSaveButton {
    if (self.newsModel.my_like) {
        [self.saveButton setImage:[UIImage imageNamed:@"icon_like_film2"] forState:UIControlStateNormal];
        self.saveButton.selected = YES;
    } else {
        [self.saveButton setImage:[UIImage imageNamed:@"icon_unlike_film2"] forState:UIControlStateNormal];
        self.saveButton.selected = NO;
    }
}

#pragma mark - actions
- (void)onShareButtonTapped:(id)sender {
    [self.newsModel taoshare];
}
- (IBAction)onSaveAction:(UIButton *)sender {
    /**
    if (![MMTodayHTUserManager tao_isUserLogin]) {
        [MMTodayHTUserManager tao_doUserLogin];
        [self.view showToast:@"請登錄"];
        return;
    }
    if (sender.selected) {
        [HourseHTUserRequest taodeleteCollectionWithNewsId:self.newsModel.news_id successBlock:^{
            [self.view showToast:@"已取消收藏"];
            self.newsModel.my_save = NO;
            [self setupSaveButton];
        } failBlock:^(SundayBJError *error) {
            [self.view showToast:@"取消收藏失敗"];
        }];
    } else {
        [HourseHTUserRequest taoaddCollectionWithNewsId:self.newsModel.news_id successBlock:^{
            [self.view showToast:@"已收藏"];
            self.newsModel.my_save = YES;
            [self setupSaveButton];
        } failBlock:^(SundayBJError *error) {
            [self.view showToast:@"收藏失敗"];
        }];
    }
    sender.selected = !sender.selected;
    self.newsModel.my_save = sender.selected;
     */
    
    if (![MMTodayHTUserManager tao_isUserLogin]) {
        [MMTodayHTUserManager tao_doUserLogin];
        [self.view showToast:@"請登錄"];
        return;
    }
    if (sender.selected) {
        [HourseHTUserRequest taodeleteLikeWithNewsId:self.newsModel.news_id successBlock:^{
            [self.view showToast:@"已取消點讚"];
            self.newsModel.my_like = NO;
            self.newsModel.total_like = self.newsModel.total_like - 1;
            [self setupSaveButton];
        } failBlock:^(SundayBJError *error) {
            [self.view showToast:@"取消點讚失敗"];
        }];
    } else {
        [HourseHTUserRequest taoaddLikeWithNewsId:self.newsModel.news_id successBlock:^{
            [self.view showToast:@"已點讚"];
            self.newsModel.my_like = YES;
            self.newsModel.total_like = self.newsModel.total_like + 1;
            [self setupSaveButton];
        } failBlock:^(SundayBJError *error) {
            [self.view showToast:@"點讚失敗"];
        }];
    }
    sender.selected = !sender.selected;
    self.newsModel.my_like = sender.selected;
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
    [HourseHTUserRequest taopostCommentWithComment_txt:self.commentInputView.text post_id:self.newsModel.news_id reply_comment_id:self.currentCommentModel.comment_id successBlock:^{
        self.commentInputView.text = nil;
        self.replyTextView.text = nil;
        [self.view endEditing:YES];
        [kWindow showToast:@"評論成功"];
        [self updateAfterComment];
    } failBlock:^(SundayBJError *error) {
        [kWindow showToast:@"評論失敗"];
    }];
}
- (void)onInputBegin {
    if (![MMTodayHTUserManager tao_isUserLogin]) {
        [self.view endEditing:YES];
        [MMTodayHTUserManager tao_doUserLogin];
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
- (HourseHTCommentGetter *)commentGetter {
    if (!_commentGetter) {
        _commentGetter = [[HourseHTCommentGetter alloc] initWithPostId:self.post_id];
    }
    return _commentGetter;
}
- (RRDogHTNoCommentFooterView *)noCommentsFooterView {
    if (!_noCommentsFooterView) {
        _noCommentsFooterView = [RRDogHTNoCommentFooterView taofooterViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
    }
    return _noCommentsFooterView;
}

#pragma mark - YSPlayerControllerDelegate

- (void)playerControllerDidClickFullScreen:(CCCaseYSPlayerController *)playerController {
    self.fullScreen = self.playerController.isFullScreen;
    [self playerViewEnterFullScreen];
}

- (void)playerExitFullScreen:(CCCaseYSPlayerController *)playerController
{
    [self playerViewExitFullScreen];
}

- (void)playerViewEnterFullScreen{
    
    UIView *superView = [UIApplication sharedApplication].delegate.window.rootViewController.view;
    [self.playerView removeFromSuperview];
    
    if (self.playerController.videoWidth < self.playerController.videoHeight) {
        
        [superView addSubview:self.playerView];
//        superView.backgroundColor = UIColor.blackColor;
        [self.playerView mas_remakeConstraints:^(MASConstraintMaker *make) {
//            make.leading.equalTo(superView);
//            make.trailing.equalTo(superView);
//            make.top.equalTo(superView);//.mas_offset(44);
//            make.bottom.equalTo(superView).mas_offset(-20);
            
            
            make.width.equalTo(superView.mas_width);
            make.height.equalTo(superView.mas_height);
            make.center.equalTo(superView);
        }];
        
    }else{
        [superView addSubview:self.playerView];
        [self.playerView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(superView.mas_height);
            make.height.equalTo(superView.mas_width);
            make.center.equalTo(superView);
        }];
    }
    
    [superView setNeedsUpdateConstraints];
    [superView updateConstraintsIfNeeded];
    
    [UIView animateWithDuration:.3 animations:^{
        [superView layoutIfNeeded];
    }];
    
    //[self.mPlayerTableViewCellDelegate tableViewCellEnterFullScreen:self];
}

- (void)playerViewExitFullScreen {
    
//    UIView *superView = [UIApplication sharedApplication].delegate.window.rootViewController.view;
//    superView.backgroundColor = UIColor.clearColor;
    
    [self.playerView removeFromSuperview];
    [self.playerContentView addSubview:self.playerView];
    
    [self.playerView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.playerContentView);
    }];
    
    [self.view setNeedsUpdateConstraints];
    [self.view updateConstraintsIfNeeded];
    
    [UIView animateWithDuration:.3 animations:^{
        [self.view layoutIfNeeded];
    }];
    
    //[self.mPlayerTableViewCellDelegate tableViewCellExitFullScreen:self];
}


-(void)willStartPlay:(CCCaseYSPlayerController *)playerController
{
//    if (self.mPlayerTableViewCellDelegate) {
//        [self.mPlayerTableViewCellDelegate tableViewWillPlay:self];
//    }
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

@end
