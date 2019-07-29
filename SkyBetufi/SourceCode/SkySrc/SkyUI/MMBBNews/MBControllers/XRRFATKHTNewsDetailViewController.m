//
//  XRRFATKHTNewsDetailViewController.m
//  HeiteBasketball
//
//  Created by 冯生伟 on 2018/9/10.
//  Copyright © 2018年 Dean_F. All rights reserved.
//

#import "XRRFATKHTNewsDetailViewController.h"
#import "XRRFATKHTNewsTopRequest.h"
#import "XRRFATKHTNewsHeaderCell.h"
#import "XRRFATKHTNewsWebCell.h"
#import "XRRFATKHTNewsHomeCell.h"
#import "XRRFATKHTNewsTopHeaderView.h"
#import "XRRFATKPPXXBJNavigationController.h"
#import "XRRFATKHTNewsAdditionRequest.h"
#import "XRRFATKHTUserRequest.h"
#import <BlocksKit/BlocksKit.h>
#import <YYText/YYText.h>
#import "XRRFATKHTCommentGetter.h"
#import "XRRFATKHTNewsCommentCell.h"
#import "XRRFATKHTNoCommentFooterView.h"

@interface XRRFATKHTNewsDetailViewController () <UITableViewDelegate, UITableViewDataSource>

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

@property (nonatomic, strong) XRRFATKHTNewsModel *newsModel;
@property (nonatomic, strong) NSArray *topNewsList;
@property (nonatomic, copy) NSString *htmlContent;
@property (nonatomic, assign) CGFloat newsContentHeight;
@property (nonatomic, assign) BOOL topRequestDone;
@property (nonatomic, assign) BOOL htmlLoadDone;
@property (nonatomic, weak) XRRFATKHTCommentModel *currentCommentModel;
@property (nonatomic, strong) XRRFATKHTCommentGetter *commentGetter;
@property (nonatomic, strong) XRRFATKHTNoCommentFooterView *noCommentsFooterView;

@property (nonatomic, assign) BOOL isFirstShow;

@end

@implementation XRRFATKHTNewsDetailViewController

+ (instancetype)skargviewController {
    return kLoadStoryboardWithName(@"XRRFATKNewsDetail");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupViews];
    
    self.isFirstShow = YES;
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
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (!self.topRequestDone || !self.htmlLoadDone) {
        return 0;
    }
    NSInteger num = 3;
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
        return self.topNewsList.count;
    }
    if (section == 3 && self.commentGetter.hotComments.count > 0) {
        return self.commentGetter.hotComments.count;
    } else {
        return self.commentGetter.normalComments.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    kWeakSelf
    if (indexPath.section == 0) {
        XRRFATKHTNewsHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XRRFATKHTNewsHeaderCell"];
        [cell skargsetupWithNewsModel:self.newsModel];
        return cell;
    } else if (indexPath.section == 1) {
        XRRFATKHTNewsWebCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XRRFATKHTNewsWebCell"];
        if (self.newsContentHeight == 0) {
            [cell skargsetupWithClearHtmlContent:self.htmlContent];
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
        XRRFATKHTNewsHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XRRFATKHTNewsHomeCell"];
        [cell skargsetupWithNewsModel:self.topNewsList[indexPath.row]];
        return cell;
    }
    XRRFATKHTNewsCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([XRRFATKHTNewsCommentCell class])];
    cell.onReplyBlock = ^(XRRFATKHTCommentModel * _Nonnull commentModel) {
        weakSelf.currentCommentModel = commentModel;
        weakSelf.commentInputView.placeholder = [NSString stringWithFormat:@"回復 %@", commentModel.comment_author];
        weakSelf.commentInputView.text = nil;
        [weakSelf.commentInputView becomeFirstResponder];
    };
    cell.onExpendBlock = ^{
        [weakSelf.tableView beginUpdates];
        [weakSelf.tableView endUpdates];
    };
    if (indexPath.section == 3 && self.commentGetter.hotComments.count > 0) {
        [cell skargrefreshWithCommentModel:self.commentGetter.hotComments[indexPath.row]];
    } else {
        [cell skargrefreshWithCommentModel:self.commentGetter.normalComments[indexPath.row]];
    }
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 2) {
        XRRFATKHTNewsModel *newsModel = self.topNewsList[indexPath.row];
        
        XRRFATKHTNewsDetailViewController *detailVc = [XRRFATKHTNewsDetailViewController skargviewController];
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
        return 90;
    }
    XRRFATKHTCommentModel *commentModel;
    if (indexPath.section == 3 && self.commentGetter.hotComments.count > 0) {
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
    if (section == 0 || section == 1) {
        return nil;
    }
    XRRFATKHTNewsTopHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"XRRFATKHTNewsTopHeaderView"];
    if (section == 2) {
        [headerView skargrefreshWithTitle:@"推薦閱讀"];
    } else if (section == 3 && self.commentGetter.hotComments.count > 0) {
        [headerView skargrefreshWithTitle:@"熱門回復"];
    } else {
        [headerView skargrefreshWithTitle:@"全部回復"];
    }
    return headerView;
}

#pragma mark - requests
- (void)loadDetailWithCompleteBlock:(dispatch_block_t)block {
    [XRRFATKHTNewsAdditionRequest skargrequestDetailWithPostId:self.post_id successBlock:^(XRRFATKHTNewsModel * _Nonnull newsModel) {
        self.newsModel = newsModel;
        if (block) {
            block();
        }
    } errorBlock:^(XRRFATKBJError *error) {
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

// 请求html数据、推荐数据、第一页评论
- (void)initDataRequests {
    kWeakSelf
    self.topRequestDone = NO;
    self.htmlLoadDone = YES;
    
    [XRRFATKHTNewsTopRequest skargrequestWithSuccessBlock:^(NSArray<XRRFATKHTNewsModel *> *newsList) {
        weakSelf.topNewsList = newsList;
        weakSelf.topRequestDone = YES;
        [weakSelf refreshUI];
    } errorBlock:^(XRRFATKBJError *error) {
        [weakSelf.view showToast:@"「推薦閱讀」獲取失敗"];
        weakSelf.topRequestDone = YES;
        [weakSelf refreshUI];
    }];
    
    if (!weakSelf.htmlContent) {
        self.htmlLoadDone = NO;
        [self.newsModel skarggetClearContentWithBlock:^(BOOL success, NSString *content) {
            weakSelf.htmlContent = content;
            weakSelf.htmlLoadDone = YES;
            [weakSelf refreshUI];
        }];
    }
    
    [self loadComments];
}

// 加载评论列表
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
    [self.commentGetter skargdoRequestWithCompleteBlock:^{
        if (weakSelf.commentGetter.hasMore) {
            [weakSelf.tableView.mj_footer endRefreshing];
        } else {
            [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        [weakSelf.tableView reloadData];
    }];
}

// 评论后更新页面、获取newsModel，commentsList
- (void)updateAfterComment {
    [self loadDetailWithCompleteBlock:^{
        [self refreshUI];
        [self.commentGetter skargreset];
        [self loadComments];
    }];
}

- (void)addHistoryRecord {
    [XRRFATKHTUserRequest skargaddHistoryWithNewsId:self.post_id successBlock:^{
        BJLog(@"添加瀏覽歷史成功");
    } failBlock:^(XRRFATKBJError *error) {
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
    
    [self.tableView registerNib:[UINib nibWithNibName:@"XRRFATKHTNewsHeaderCell" bundle:nil]
         forCellReuseIdentifier:@"XRRFATKHTNewsHeaderCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"XRRFATKHTNewsWebCell" bundle:nil]
         forCellReuseIdentifier:@"XRRFATKHTNewsWebCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"XRRFATKHTNewsHomeCell" bundle:nil]
         forCellReuseIdentifier:@"XRRFATKHTNewsHomeCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"XRRFATKHTNewsTopHeaderView" bundle:nil] forHeaderFooterViewReuseIdentifier:@"XRRFATKHTNewsTopHeaderView"];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([XRRFATKHTNewsCommentCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([XRRFATKHTNewsCommentCell class])];
    
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    kWeakSelf
    self.tableView.mj_footer = [XRRFATKMJRefreshGenerator bj_foorterWithRefreshingBlock:^{
        [weakSelf loadComments];
    }];
    
    if ([XRRFATKHTNewsModel skargcanShare]) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"nav_icon_share"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] style:UIBarButtonItemStylePlain target:self action:@selector(onShareButtonTapped:)];
    }
    
    UIImage *commentIcon = [[UIImage imageNamed:@"icon_add_comment"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [self.commentButton setImage:commentIcon forState:UIControlStateNormal];
    [self.commentButton setTintColor:[UIColor hx_colorWithHexRGBAString:@"999999"]];
    UIImage *saveIcon = [[XRRFATKPPXXBJBaseViewController skargfixImageSize:[UIImage imageNamed:@"icon_add_collection"] toSize:CGSizeMake(20, 20)] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
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
    [self.newsModel skargshare];
}

- (IBAction)onSaveAction:(UIButton *)sender {
    if (![XRRFATKHTUserManager skarg_isUserLogin]) {
        [XRRFATKHTUserManager skarg_doUserLogin];
        [self.view showToast:@"請登錄"];
        return;
    }
    if (sender.selected) {
        [XRRFATKHTUserRequest skargdeleteCollectionWithNewsId:self.newsModel.news_id successBlock:^{
            [self.view showToast:@"已取消收藏"];
            self.newsModel.my_save = NO;
            [self setupSaveButton];
        } failBlock:^(XRRFATKBJError *error) {
            [self.view showToast:@"取消收藏失敗"];
        }];
    } else {
        [XRRFATKHTUserRequest skargaddCollectionWithNewsId:self.newsModel.news_id successBlock:^{
            [self.view showToast:@"已收藏"];
            self.newsModel.my_save = YES;
            [self setupSaveButton];
        } failBlock:^(XRRFATKBJError *error) {
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
    
    [XRRFATKHTUserRequest skargpostCommentWithComment_txt:self.commentInputView.text post_id:self.newsModel.news_id reply_comment_id:self.currentCommentModel.comment_id successBlock:^{
        self.commentInputView.text = nil;
        [self.view endEditing:YES];
        [kWindow showToast:@"評論成功"];
        [self updateAfterComment];
    } failBlock:^(XRRFATKBJError *error) {
        [kWindow showToast:@"評論失敗"];
    }];
}

- (void)onInputBegin {
    if (![XRRFATKHTUserManager skarg_isUserLogin]) {
        [self.view endEditing:YES];
        [XRRFATKHTUserManager skarg_doUserLogin];
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
- (XRRFATKHTCommentGetter *)commentGetter {
    if (!_commentGetter) {
        _commentGetter = [[XRRFATKHTCommentGetter alloc] initWithPostId:self.post_id];
    }
    return _commentGetter;
}

- (XRRFATKHTNoCommentFooterView *)noCommentsFooterView {
    if (!_noCommentsFooterView) {
        _noCommentsFooterView = [XRRFATKHTNoCommentFooterView skargfooterViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
    }
    return _noCommentsFooterView;
}

@end
