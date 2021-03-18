#import "GlodBuleHTFilmHomeCell.h"
#import <WebKit/WebKit.h>
#import "GlodBuleLMVideoPlayer.h"
#import "GlodBuleLMPlayerModel.h"


@interface GlodBuleHTFilmHomeCell () <WKNavigationDelegate, PLPlayerViewDelegate>
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
@property (nonatomic, assign) BOOL isNeedReset;
@property (nonatomic, strong) PLPlayerView *playerView;

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
    
//    self.contentView.backgroundColor = UIColor.whiteColor;
    self.isNeedReset = YES;
    self.playerView = [[PLPlayerView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 200)];
    self.playerView.delegate = self;
    [_webContentView addSubview:self.playerView];
    [self.playerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.top.bottom.mas_equalTo(_webContentView);
    }];
    
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
    [self setMedia:newsModel.plMediaInfo];
    
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

#pragma mark - 播放器代理PLPlayerViewDelegate

+ (CGFloat)headerViewHeight
{
    return (SCREEN_WIDTH - 10) * 310.0 / 375.0; // 375 320
}

- (void)setMedia:(PLMediaInfo *)media {
    _media = media;
    
//    self.headerImageView.image = [UIImage imageNamed:media.headerImg];
//    self.detailDescLabel.text = media.detailDesc;
//    self.nameLabel.text = media.name;
    self.playerView.media = media;
}

- (void)prepareForReuse {
    [self stop];
    [super prepareForReuse];
}

- (void)play {
    [self.playerView play];
}

- (void)stop {
    [self.playerView stop];
}

- (void)configureVideo:(BOOL)enableRender {
    [self.playerView configureVideo:enableRender];
}

- (void)playerViewEnterFullScreen:(PLPlayerView *)playerView {
    
    UIView *superView = [UIApplication sharedApplication].delegate.window.rootViewController.view;
    [self.playerView removeFromSuperview];
    
    if (self.playerView.player.width < self.playerView.player.height) {
        
        [superView addSubview:self.playerView];
//        superView.backgroundColor = UIColor.blackColor;
        [self.playerView mas_remakeConstraints:^(MASConstraintMaker *make) {
//            make.leading.equalTo(superView).mas_offset(20);
//            make.trailing.equalTo(superView).mas_offset(-20);
//            make.top.equalTo(superView).mas_offset(44);
//            make.bottom.equalTo(superView).mas_offset(-44);
            
            
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
    
    [self.delegate tableViewCellEnterFullScreen:self];
}

- (void)playerViewExitFullScreen:(PLPlayerView *)playerView {
    
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
    
    [self.delegate tableViewCellExitFullScreen:self];
}

- (void)playerViewWillPlay:(PLPlayerView *)playerView {
    [self.delegate tableViewWillPlay:self];
}


@end
