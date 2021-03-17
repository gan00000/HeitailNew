#import "GlodBuleHTFilmHomeCell.h"
#import <WebKit/WebKit.h>
#import "GlodBuleLMVideoPlayer.h"
#import "GlodBuleLMPlayerModel.h"

@interface GlodBuleHTFilmHomeCell () <WKNavigationDelegate, LMVideoPlayerDelegate>
@property (weak, nonatomic) IBOutlet UIView *webContentView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *viewCountLabel;
@property (weak, nonatomic) IBOutlet UIView *shareButtonContentView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *webContentViewHeight;
@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, weak) GlodBuleHTNewsModel *newsModel;

@property (weak, nonatomic) IBOutlet UIView *localPlayerView;

@property (nonatomic, strong) GlodBuleLMVideoPlayer *player;
@property (nonatomic, strong) GlodBuleLMPlayerModel *playerModel;

@property (nonatomic, strong) GlodBuleLMPlayerModel *playModel;

@end
@implementation GlodBuleHTFilmHomeCell
- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    //[self.webContentView addSubview:self.webView];
//    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.left.bottom.right.mas_equalTo(0);
//    }];
    if ([GlodBuleHTNewsModel taocanShare]) {
        self.shareButtonContentView.hidden = NO;
    }
    self.viewCountLabel.hidden = YES;
    
    self.playModel = [[GlodBuleLMPlayerModel alloc] init];
    
    self.localPlayerView.backgroundColor = UIColor.blueColor;
    
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
    self.timeLabel.text = newsModel.time;
    self.viewCountLabel.text = newsModel.view_count;
    
    if (self.playModel.videoUrls && self.playModel.videoUrls.count > 0) {
        NSString *mVideo = self.playModel.videoUrls[0];
        if ([mVideo isEqualToString:newsModel.play_url]) {
            return;
        }
    }
    self.playModel.videoUrls = @[newsModel.play_url];
    GlodBuleLMVideoPlayer *player = [GlodBuleLMVideoPlayer videoPlayerWithView:self.localPlayerView delegate:self playerModel:self.playModel];
    self.player = player;
//    [self.player playNewVideo:self.playModel];
//    [player autoPlayTheVideo];
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


#pragma mark - LMVideoPlayerDelegate
/** 返回按钮被点击 */
- (void)playerBackButtonClick {

//    [self destoryPlayer];
}

/** 控制层封面点击事件的回调 */
- (void)controlViewTapAction {
    if (_player) {
        [self.player autoPlayTheVideo];
//        self.isStartPlay = YES;
    }
}

@end
