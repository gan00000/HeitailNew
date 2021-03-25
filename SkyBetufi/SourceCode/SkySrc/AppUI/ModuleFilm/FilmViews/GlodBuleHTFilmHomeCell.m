#import "GlodBuleHTFilmHomeCell.h"
#import <WebKit/WebKit.h>
#import "GlodBuleLMVideoPlayer.h"
#import "GlodBuleLMPlayerModel.h"
#import "YSPlayerController.h"

@interface GlodBuleHTFilmHomeCell () <WKNavigationDelegate, YSPlayerControllerDelegate>
@property (weak, nonatomic) IBOutlet UIView *webContentView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *viewCountLabel;
@property (weak, nonatomic) IBOutlet UIView *shareButtonContentView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *webContentViewHeight;
@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, weak) GlodBuleHTNewsModel *newsModel;

@property (weak, nonatomic) IBOutlet UIView *localPlayerView;

//========
//@property (nonatomic, assign) BOOL isNeedReset;
//@property (nonatomic, strong) PLPlayerView *playerView;
//
//@property (nonatomic, strong) GlodBuleLMVideoPlayer *ijkPlayer;

@property (strong, nonatomic) YSPlayerController *playerController;
@property (strong, nonatomic) UIView *playerView;
@property (nonatomic, assign) BOOL fullScreen;

@end
@implementation GlodBuleHTFilmHomeCell
- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;

//    if ([GlodBuleHTNewsModel taocanShare]) {
//        self.shareButtonContentView.hidden = NO;
//    }
    self.shareButtonContentView.hidden = NO;
//    self.viewCountLabel.hidden = YES;
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
- (void)taosetupWithNewsModel:(GlodBuleHTNewsModel *)newsModel {
    if (!newsModel) {
        return;
    }
    self.newsModel = newsModel;
//    self.webContentViewHeight.constant = newsModel.iframe_height;
//    [self.webView loadHTMLString:newsModel.iframe baseURL:nil];
//    [self.webView showLoadingView];
    self.titleLabel.text = newsModel.title;
    self.timeLabel.text = [NSString stringWithFormat:@"%d", newsModel.total_comment];
    
    self.viewCountLabel.text = [NSString stringWithFormat:@"%d", newsModel.total_save];
//    [self setMedia:newsModel.plMediaInfo];
    
    
    //=======================
    
    [self.playerController shutdown];
    [self.playerView removeFromSuperview];
    self.playerController = nil;
    
    self.playerController = [[YSPlayerController alloc] initWithContentMediaInfo: newsModel.plMediaInfo];
    self.playerController.delegate = self;
    self.playerController.needPortFullScreen = YES;
    self.playerView = self.playerController.view;
    [self.webContentView addSubview:self.playerView];
    [self.playerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.webContentView);
    }];
    
//    [self.playerController setMediaInfo:newsModel.plMediaInfo];
//    [self play];
    
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


+ (CGFloat)headerViewHeight
{
    return (SCREEN_WIDTH) * 330.0 / 375.0 + 4; // 375 320
}

- (void)prepareForReuse {
//    if (self.playerController) {
//        [self.playerController shutdown];
//    }
    [super prepareForReuse];
}

- (void)play
{
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


#pragma mark -PLPlayerViewDelegate
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
    
    [self.mPlayerTableViewCellDelegate tableViewCellEnterFullScreen:self];
}

- (void)playerViewExitFullScreen {
    
//    UIView *superView = [UIApplication sharedApplication].delegate.window.rootViewController.view;
//    superView.backgroundColor = UIColor.clearColor;
    
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


-(void)startPlay:(YSPlayerController *)playerController
{
    if (self.mPlayerTableViewCellDelegate) {
        [self.mPlayerTableViewCellDelegate tableViewWillPlay:self];
    }
}

#pragma mark - YSPlayerControllerDelegate

- (void)playerControllerDidClickDone:(YSPlayerController *)playerController {
    //[self dismissViewControllerAnimated:YES completion:nil];
}

- (void)playerControllerDidClickFullScreen:(YSPlayerController *)playerController {
    self.fullScreen = self.playerController.isFullScreen;
    [self playerViewEnterFullScreen];
}

- (void)playerExitFullScreen:(YSPlayerController *)playerController
{
    [self playerViewExitFullScreen];
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
