#import "GlodBuleHTFilmHomeCell.h"
#import <WebKit/WebKit.h>
#import "GlodBuleLMVideoPlayer.h"
#import "GlodBuleLMPlayerModel.h"
#import "YSPlayerController.h"
#import "UIImageView+GlodBuleHT.h"

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
@property (weak, nonatomic) UIView *playerView;
@property (nonatomic, assign) BOOL fullScreen;

//@property (strong, nonatomic) UIView *thumbView;
//@property (strong, nonatomic) UIImageView *thumbImageView;
//@property (strong, nonatomic) UIButton *thumbPlayBtn;

@end
@implementation GlodBuleHTFilmHomeCell
- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;

//    if ([GlodBuleHTNewsModel taocanShare]) {
//        self.shareButtonContentView.hidden = NO;
//    }
    self.shareButtonContentView.hidden = NO;
    
//    self.thumbView = [[UIView alloc] init];
//    self.thumbView.backgroundColor = UIColor.blackColor;
//    [self.webContentView addSubview:self.thumbView];
//    [self.thumbView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.leading.trailing.top.bottom.equalTo(self.webContentView);
//    }];
//
//    self.thumbImageView = [[UIImageView alloc] init];
//    self.thumbImageView.contentMode =  UIViewContentModeScaleAspectFit;
//    [self.thumbView addSubview:self.thumbImageView];
//    [self.thumbImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.leading.trailing.top.bottom.equalTo(self.thumbView);
//    }];
//
//    [self.thumbView addSubview:self.thumbPlayBtn];
//    [self.thumbPlayBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.width.height.mas_equalTo(50);
//        make.center.mas_equalTo(self.thumbView);
//    }];
    
    [self addPlayerView];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

-(void) addPlayerView
{
    self.playerController = [[YSPlayerController alloc] initWithContentMediaInfo: self.newsModel.plMediaInfo];
    self.playerController.delegate = self;
    self.playerController.needPortFullScreen = YES;
    UIView *playerView = self.playerController.view;
    [self.webContentView addSubview:playerView];
    [playerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.webContentView);
    }];
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
    [self.playerController setMediaInfo:newsModel.plMediaInfo];
    
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
    if (self.playerController) {
        [self.playerController shutdown];
    }
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


- (void)playerViewEnterFullScreen:(YSPlayerController *)playerController{
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

- (void)playerViewExitFullScreen:(YSPlayerController *)playerController {
    
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
    [self playerViewEnterFullScreen:playerController];
}

- (void)playerExitFullScreen:(YSPlayerController *)playerController
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
