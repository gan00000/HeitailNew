#import "KMonkeyHTMainPageHomeCell.h"
#import <WebKit/WebKit.h>
#import "GGCatLMVideoPlayer.h"
#import "MMTodayLMPlayerModel.h"
#import "UIImageView+PXFunGlodBuleHT.h"
#import "UIView+PXFunGlodBuleBlockGesture.h"
#import "HourseHTUserRequest.h"
#import "CCCasePPXXBJBaseViewController.h"
#import "NSString+YYPackageGTMHTML.h"
#import "UIView+RRDogGlodBuleViewController.h"

@interface KMonkeyHTMainPageHomeCell () <WKNavigationDelegate, YSPlayerControllerDelegate>
@property (weak, nonatomic) IBOutlet UIView *webContentView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *viewCountLabel;
@property (weak, nonatomic) IBOutlet UIView *shareButtonContentView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *webContentViewHeight;
@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, weak) PXFunHTNewsModel *newsModel;

@property (weak, nonatomic) IBOutlet UIView *localPlayerView;

@property (weak, nonatomic) IBOutlet UILabel *filmTimeLabel;
@property (weak, nonatomic) IBOutlet UIView *commentContentView;

@property (weak, nonatomic) IBOutlet UIImageView *nickHeaderImageView;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *fromTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *hotCommentLabel;
@property (weak, nonatomic) IBOutlet UILabel *hotCommentTitleLabel;


@property (weak, nonatomic) IBOutlet UIView *hotCommentView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *hotCommentViewHeight;

//@property (strong, nonatomic) NSLayoutConstraint *old_hotCommentViewHeight;

//========
//@property (nonatomic, assign) BOOL isNeedReset;
//@property (nonatomic, strong) PLPlayerView *playerView;
//
//@property (nonatomic, strong) GGCatLMVideoPlayer *ijkPlayer;

@property (weak, nonatomic) UIView *playerView;
@property (nonatomic, assign) BOOL fullScreen;
@property (nonatomic, assign) BOOL isPlayerRemove;

//@property (strong, nonatomic) UIView *thumbView;
//@property (strong, nonatomic) UIImageView *thumbImageView;
//@property (strong, nonatomic) UIButton *thumbPlayBtn;

@end
@implementation KMonkeyHTMainPageHomeCell
- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;

    self.shareButtonContentView.hidden = NO;
    
    self.addSaveImageView.hidden = YES;
    
    //self.filmTimeLabel.layer.cornerRadius = 8;
    self.hotCommentView.layer.cornerRadius = 6;
    
    self.hotCommentTitleLabel.layer.cornerRadius = 4;
    self.hotCommentTitleLabel.layer.borderWidth = 1;
    self.hotCommentTitleLabel.layer.borderColor = [UIColor hx_colorWithHexRGBAString:@"fc562e"].CGColor;
//    self.hotCommentTitleLabel.layer.w
    self.hotCommentTitleLabel.textColor = [UIColor hx_colorWithHexRGBAString:@"fc562e"];
    
//    self.old_hotCommentViewHeight = self.hotCommentViewHeight;
//    [self addPlayerView];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (IBAction)addSaveReplace:(id)sender {
    [self addSave:self.addSaveBtn];
}


- (IBAction)addSave:(UIButton *)sender {
    
    if (![MMTodayHTUserManager tao_isUserLogin]) {
        [MMTodayHTUserManager tao_doUserLogin];
        [self.contentView showToast:@"請登錄"];
        return;
    }
    if (sender.selected) {
        [HourseHTUserRequest taodeleteLikeWithNewsId:self.newsModel.news_id successBlock:^{
            [self.contentView showToast:@"已取消點讚"];
            self.newsModel.my_like = NO;
            self.newsModel.total_like = self.newsModel.total_like - 1;
            [self setupSaveButton];
        } failBlock:^(SundayBJError *error) {
            [self.contentView showToast:@"取消點讚失敗"];
        }];
    } else {
        [HourseHTUserRequest taoaddLikeWithNewsId:self.newsModel.news_id successBlock:^{
            [self.contentView showToast:@"已點讚"];
            self.newsModel.my_like = YES;
            self.newsModel.total_like = self.newsModel.total_like + 1;
            [self setupSaveButton];
        } failBlock:^(SundayBJError *error) {
            [self.contentView showToast:@"點讚失敗"];
        }];
    }
    sender.selected = !sender.selected;
    self.newsModel.my_like = sender.selected;
    
}

- (void)setupSaveButton {
    if (self.newsModel.my_like) {
        [self.addSaveBtn setImage:[UIImage imageNamed:@"icon_film_like"] forState:UIControlStateNormal];
        
        self.addSaveBtn.selected = YES;
    } else {
        [self.addSaveBtn setImage:[UIImage imageNamed:@"icon_film_unlike"] forState:UIControlStateNormal];
        
        self.addSaveBtn.selected = NO;
    }
    self.viewCountLabel.text = [NSString stringWithFormat:@"%d", self.newsModel.total_like];
}

-(void) addPlayerView
{
    [self shutdown];
    [self.webContentView removeAllSubView];
    
    self.playerController = [[CCCaseYSPlayerController alloc] initWithContentMediaInfo: self.newsModel.plMediaInfo];
    self.playerController.delegate = self;
    self.playerController.needPortFullScreen = YES;
    UIView *playerView = self.playerController.view;
    [self.webContentView addSubview:playerView];
    [playerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.webContentView);
    }];
}

-(void) addNewsImageView
{
    [self.webContentView removeAllSubView];
    if (!self.newsModel.poster) {
        return;
    }
    int imageCount = self.newsModel.poster.count;
    if (imageCount > 3) {
        imageCount = 3;
    }
    int imageWidth = (SCREEN_WIDTH - 30) / imageCount;
    for (int i = 0; i < imageCount; i++) {
        
        UIImageView *thumbShowImageView = [[UIImageView alloc] init];
        [thumbShowImageView sd_setImageWithURL:[NSURL URLWithString:self.newsModel.poster[i]]];
        [self.webContentView addSubview:thumbShowImageView];
        [thumbShowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(imageWidth);
            make.leading.mas_equalTo(self.webContentView).mas_offset(imageWidth * i);
            make.height.mas_equalTo(self.webContentView);
            make.centerY.mas_equalTo(self.webContentView);
        }];
    }
    
   
}

-(void)removeCellPlayerView
{
//    [self.playerController.view removeFromSuperview];
    self.isPlayerRemove = YES;
}

-(void)reAddCellPlayerView
{
    if (self.isPlayerRemove) {
        UIView *playerView = self.playerController.view;
        self.playerController.delegate = self;
        self.playerController.needPortFullScreen = YES;
        [self.webContentView addSubview:playerView];
        [playerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self.webContentView);
        }];
        self.isPlayerRemove = NO;
      
        [self.contentView setNeedsUpdateConstraints];
        [self.contentView updateConstraintsIfNeeded];
        
        [UIView animateWithDuration:.3 animations:^{
            [self.contentView layoutIfNeeded];
        }];
    }
    
}

//- (UIButton *)thumbPlayBtn {
//    if (!_thumbPlayBtn) {
//        _thumbPlayBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        //_downloadButton.frame = CGRectMake(SCREEN_WIDTH - 100, 0, HeightForTopView, HeightForTopView);
//        [_thumbPlayBtn setImage:[UIImage imageNamed:@"play_Image"] forState:UIControlStateNormal];
//        [_thumbPlayBtn addTarget:self action:@selector(initPlayerAndPrepareToPlay) forControlEvents:UIControlEventTouchUpInside];
//    }
//    return _thumbPlayBtn;
//}

- (void)taosetupWithNewsModel:(PXFunHTNewsModel *)newsModel {
    if (!newsModel) {
        return;
    }
    if (!newsModel.plMediaInfo) {
        [newsModel initPLMediaInfo];
    }
    self.newsModel = newsModel;
//    self.webContentViewHeight.constant = newsModel.iframe_height;
//    [self.webView loadHTMLString:newsModel.iframe baseURL:nil];
//    [self.webView showLoadingView];
    
    NSString *mtitle = newsModel.title;//[[newsModel.title stringByReplacingOccurrencesOfString:@"&#8217;" withString:@"'"] stringByReplacingOccurrencesOfString:@"&#8230;" withString:@"..."];
    self.titleLabel.text = mtitle;
    self.timeLabel.text = [NSString stringWithFormat:@"%d", newsModel.total_comment];
    
    self.viewCountLabel.text = [NSString stringWithFormat:@"%d", newsModel.total_like];
 
    [self setupSaveButton];
        
    self.news_id = self.newsModel.news_id;
    
    [self.nickHeaderImageView sd_setImageWithURL:[NSURL URLWithString:newsModel.author.avatar] placeholderImage:HT_DEFAULT_AVATAR_LOGO];
    self.nickNameLabel.text = newsModel.author.name;
    
    if (newsModel.hottest_comment && newsModel.hottest_comment.count > 0) { //热门留言
        self.hotCommentView.hidden = NO;
        self.hotCommentLabel.text = [NSString stringWithFormat:@"%@:%@",newsModel.hottest_comment[0].comment_author,newsModel.hottest_comment[0].comment_content];
        self.hotCommentViewHeight.constant = 70;
    }else{
        self.hotCommentView.hidden = YES;
        self.hotCommentViewHeight.constant = 0.1;
    }
    
    if ([newsModel.posted_on isEqualToString:@"videos"]) {
        
        self.filmTimeLabel.hidden = NO;
        self.filmTimeLabel.text = newsModel.time;
        [self.playerController setMediaInfo:newsModel.plMediaInfo];
        
        self.fromTypeLabel.text = @"發佈於 影片";
        
        [self addPlayerView];

    }else if ([newsModel.posted_on isEqualToString:@"topics"]) {
        self.filmTimeLabel.hidden = YES;
        self.fromTypeLabel.text = @"發佈於 話題";
        [self addNewsImageView];
    }else{
        
        self.filmTimeLabel.hidden = YES;
        self.fromTypeLabel.text = @"發佈於 新聞";
        
        [self addNewsImageView];
    }
    
}

- (void)taosetupWithPLMediaInfo:(PLMediaInfo *)mPLMediaInfo
{
    self.shareButtonContentView.hidden = YES;
    self.titleLabel.hidden = YES;
    self.timeLabel.hidden = YES;
    self.viewCountLabel.hidden = YES;
    self.filmTimeLabel.hidden = NO;
    self.addSaveBtn.hidden = YES;
    self.commentContentView.hidden = YES;
    self.filmTimeLabel.text = mPLMediaInfo.totalTime;
    if (!mPLMediaInfo.totalTime || [mPLMediaInfo.totalTime isEqualToString:@""]) {
        self.filmTimeLabel.hidden = YES;
    }
    [self.playerController setMediaInfo:mPLMediaInfo];
}

- (IBAction)onShareButtonTapped:(id)sender {
    [self.newsModel taoshare];
}
#pragma mark - WKNavigationDelegate
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation {
    [self.webView hideLoadingView];
}
#pragma mark - lazy load
- (WKWebView *)webView {
    if (!_webView) {
        _webView = [[WKWebView alloc] init];
        _webView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"f4f4f4"];
        _webView.scrollView.scrollEnabled = NO;
        _webView.navigationDelegate = self;
        _webView.clearsContextBeforeDrawing = YES;
        _webView.clipsToBounds = YES;
    }
    return _webView;
}


+ (CGFloat)headerViewHeight:(CGFloat) offset
{
    return (SCREEN_WIDTH) * (480.0 - offset) / 375.0 + 4; // 375 320
}

- (void)prepareForReuse {
    if (self.playerController) {
        [self.playerController shutdown];
    }
    [super prepareForReuse];
}


- (void)play
{
    self.filmTimeLabel.hidden = YES;
    if (self.playerController) {
        [self.playerController play];
    }
}

- (void)stop
{
    if (self.playerController) {
        [self.playerController stop];
    }
}

- (void)pause
{
    if (self.playerController) {
        [self.playerController pause];
    }
}

- (void)shutdown
{
    if (self.playerController) {
        [self.playerController shutdown];
    }
}


- (void)playerViewEnterFullScreen:(CCCaseYSPlayerController *)playerController{
    self.playerView = playerController.view;
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
    
    [self.mPlayerTableViewCellDelegate tableViewCellEnterFullScreen:self];
}

- (void)playerViewExitFullScreen:(CCCaseYSPlayerController *)playerController {
    
    self.playerView = playerController.view;
    [self.playerView removeFromSuperview];
    [self.webContentView addSubview:self.playerView];
    
    [self.playerView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.webContentView);
    }];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
    
    [UIView animateWithDuration:.3 animations:^{
        [self layoutIfNeeded];
    }];
    
    [self.mPlayerTableViewCellDelegate tableViewCellExitFullScreen:self];
}


-(void)willStartPlay:(CCCaseYSPlayerController *)playerController
{
    self.filmTimeLabel.hidden = YES;
    if (self.mPlayerTableViewCellDelegate) {
        [self.mPlayerTableViewCellDelegate tableViewWillPlay:self];
    }
}

#pragma mark - YSPlayerControllerDelegate

- (void)playerControllerDidClickDone:(CCCaseYSPlayerController *)playerController {
    //[self dismissViewControllerAnimated:YES completion:nil];
}

- (void)playerControllerDidClickFullScreen:(CCCaseYSPlayerController *)playerController {
    self.fullScreen = self.playerController.isFullScreen;
    [self playerViewEnterFullScreen:playerController];
}

- (void)playerExitFullScreen:(CCCaseYSPlayerController *)playerController
{
    self.fullScreen = self.playerController.isFullScreen;
    [self playerViewExitFullScreen:playerController];
}

//- (void)viewWillLayoutSubviews {
//    [super viewWillLayoutSubviews];
//    if (self.playerController.isFullScreen) {
//        self.playerController.view.frame = self.view.bounds;
//    } else {
//        self.playerController.view.frame = CGRectMake(0, [UIApplication sharedApplication].statusBarFrame.size.height, self.view.bounds.size.width, self.view.bounds.size.width * 9 / 16.0);
//    }
//}

#pragma mark - Private methods

#pragma mark - dealloc

- (void)dealloc {
    NSLog(@"%s", __func__);
    if (self.playerController) {
        [self.playerController shutdown];
    }
}
@end
