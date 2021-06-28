#import "UUaksTZVideoPlayerController.h"
#import <MediaPlayer/MediaPlayer.h>
#import "UIView+YYPackageGlodBuleLayout.h"
#import "WSKggTZImageManager.h"
#import "UUaksTZAssetModel.h"
#import "BByasTZImagePickerController.h"
#import "WSKggTZPhotoPreviewController.h"
#import "YeYeeDRDeleteAlertView.h"
@interface UUaksTZVideoPlayerController () {
    AVPlayer *_player;
    AVPlayerLayer *_playerLayer;
    UIButton *_playButton;
    UIImage *_cover;
    UIView *_toolBar;
    UIButton *_doneButton;
    UIButton *_delectButton;
    UILabel *_previewTipLabel;
    UIProgressView *_progress;
    UIImageView *_coverImageView;
    UIStatusBarStyle _originStatusBarStyle;
}
@end
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
@implementation UUaksTZVideoPlayerController
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}
- (BOOL)navigationBarTranslucent {
    return YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    BByasTZImagePickerController *tzImagePickerVc = (BByasTZImagePickerController *)self.navigationController;
    if (tzImagePickerVc) {
        self.navigationItem.title = tzImagePickerVc.previewBtnTitleStr;
    }
    [self configMoviePlayer];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pausePlayerAndShowNaviBar) name:UIApplicationWillResignActiveNotification object:nil];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    _originStatusBarStyle = [UIApplication sharedApplication].statusBarStyle;
    [UIApplication sharedApplication].statusBarStyle = iOS7Later ? UIStatusBarStyleLightContent : UIStatusBarStyleBlackOpaque;
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [UIApplication sharedApplication].statusBarStyle = _originStatusBarStyle;
}
- (void)configMoviePlayer {
    if (self.coverImg) {
        _cover = self.coverImg;
    } else {
        [[WSKggTZImageManager manager] getOriginalPhotoWithAsset:_model.asset completion:^(UIImage *photo, NSDictionary *info) {
            _cover = photo;
        }];
    }
    if (self.videoPath.length > 0) {
        _player = [[AVPlayer alloc] initWithURL:[NSURL URLWithString:self.videoPath]];
        _playerLayer = [AVPlayerLayer playerLayerWithPlayer:_player];
        _playerLayer.frame = self.view.bounds;
        _coverImageView = [[UIImageView alloc] initWithImage:_cover];
        _coverImageView.frame = self.view.bounds;
        [self.view.layer addSublayer:_playerLayer];
        [self.view addSubview:_coverImageView];
        [self configPlayButton];
        [self configBottomToolBar];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pausePlayerAndShowNaviBar) name:AVPlayerItemDidPlayToEndTimeNotification object:_player.currentItem];
    } else {
        kWeakSelf
        [[WSKggTZImageManager manager] getVideoWithAsset:_model.asset completion:^(AVPlayerItem *playerItem, NSDictionary *info) {
            dispatch_async(dispatch_get_main_queue(), ^{
                _player = [AVPlayer playerWithPlayerItem:playerItem];
                _playerLayer = [AVPlayerLayer playerLayerWithPlayer:_player];
                _playerLayer.frame = weakSelf.view.bounds;
                _coverImageView = [[UIImageView alloc] initWithImage:_cover];
                _coverImageView.frame = weakSelf.view.bounds;
                _coverImageView.contentMode = UIViewContentModeScaleAspectFill;
                [weakSelf.view.layer addSublayer:_playerLayer];
                [weakSelf.view addSubview:_coverImageView];
                [weakSelf configPlayButton];
                [weakSelf configBottomToolBar];
                [[NSNotificationCenter defaultCenter] addObserver:weakSelf selector:@selector(pausePlayerAndShowNaviBar) name:AVPlayerItemDidPlayToEndTimeNotification object:_player.currentItem];
            });
        }];
    }
}
- (void)addProgressObserver{
    AVPlayerItem *playerItem = _player.currentItem;
    UIProgressView *progress = _progress;
    [_player addPeriodicTimeObserverForInterval:CMTimeMake(1.0, 1.0) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
        float current = CMTimeGetSeconds(time);
        float total = CMTimeGetSeconds([playerItem duration]);
        if (current) {
            [progress setProgress:(current/total) animated:YES];
        }
    }];
}
- (void)configPlayButton {
    _playButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_playButton setImage:[UIImage imageNamedFromMyBundle:@"MMVideoPreviewPlay"] forState:UIControlStateNormal];
    [_playButton setImage:[UIImage imageNamedFromMyBundle:@"MMVideoPreviewPlayHL"] forState:UIControlStateHighlighted];
    [_playButton addTarget:self action:@selector(playButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_playButton];
}
- (void)configBottomToolBar {
    _toolBar = [[UIView alloc] initWithFrame:CGRectZero];
    CGFloat rgb = 34 / 255.0;
    _toolBar.backgroundColor = [UIColor colorWithRed:rgb green:rgb blue:rgb alpha:0.7];
    _delectButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_delectButton setImage:kDefaultImage(@"preview_icon_delect") forState:UIControlStateNormal];
    [_delectButton addTarget:self action:@selector(delectButtonClick) forControlEvents:UIControlEventTouchUpInside];
    _previewTipLabel = [[UILabel alloc] init];
    _previewTipLabel.text = @"1/1";
    _previewTipLabel.textColor = [UIColor whiteColor];
    _previewTipLabel.font = [UIFont systemFontOfSize:16];
    _previewTipLabel.textAlignment = NSTextAlignmentCenter;
    [_previewTipLabel sizeToFit];
    _doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _doneButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [_doneButton addTarget:self action:@selector(doneButtonClick) forControlEvents:UIControlEventTouchUpInside];
    BByasTZImagePickerController *tzImagePickerVc = (BByasTZImagePickerController *)self.navigationController;
    if (tzImagePickerVc) {
        [_doneButton setTitle:tzImagePickerVc.doneBtnTitleStr forState:UIControlStateNormal];
        [_doneButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    } else {
        [_doneButton setImage:kDefaultImage(@"preview_icon_close") forState:UIControlStateNormal];
        [_toolBar addSubview:_delectButton];
        [_toolBar addSubview:_previewTipLabel];
    }
    [_toolBar addSubview:_doneButton];
    [self.view addSubview:_toolBar];
}
#pragma mark - Layout
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    _playerLayer.frame = self.view.bounds;
    _playButton.frame = CGRectMake(0,[UINavigationBar navigationBarHeight], SCREEN_WIDTH, SCREEN_HEIGHT - [UINavigationBar navigationBarHeight] - [UITabBar tabBarHeight]);
    _doneButton.frame = CGRectMake(0, 0, 70, 49);
    _delectButton.frame = CGRectMake(SCREEN_WIDTH - 70, 0, 70, 49);
    _previewTipLabel.frame = CGRectMake(0, 0, 80, 49);
    _previewTipLabel.centerX = SCREEN_WIDTH *0.5;
    _toolBar.frame = CGRectMake(0, SCREEN_HEIGHT - [UITabBar tabBarHeight], SCREEN_WIDTH, [UITabBar tabBarHeight]);
}
#pragma mark - Click Event
- (void)playButtonClick {
    _coverImageView.hidden = YES;
    CMTime currentTime = _player.currentItem.currentTime;
    CMTime durationTime = _player.currentItem.duration;
    if (_player.rate == 0.0f) {
        if (currentTime.value == durationTime.value) [_player.currentItem seekToTime:CMTimeMake(0, 1)];
        [_player play];
        [self.navigationController setNavigationBarHidden:YES];
        _toolBar.hidden = YES;
        [_playButton setImage:nil forState:UIControlStateNormal];
        if (!TZ_isGlobalHideStatusBar) {
            if (iOS7Later) [UIApplication sharedApplication].statusBarHidden = YES;
        }
    } else {
        [self pausePlayerAndShowNaviBar];
    }
}
- (void)doneButtonClick {
    BByasTZImagePickerController *imagePickerVc = (BByasTZImagePickerController *)self.navigationController;
    if (self.navigationController) {
        if (imagePickerVc.autoDismiss) {
            [self.navigationController dismissViewControllerAnimated:YES completion:^{
                [self callDelegateMethod];
            }];
        } else {
            [self callDelegateMethod];
        }
    } else {
        [self dismissViewControllerAnimated:YES completion:^{
            [self callDelegateMethod];
        }];
    }
}
- (void)delectButtonClick {
    [YeYeeDRDeleteAlertView showDeleteAlertViewWithComplete:^(BOOL isDelete) {
        if (isDelete) {
            self.deleteBlock ? self.deleteBlock() : nil;
            if ([self.delegate respondsToSelector:@selector(videoPlayerControllerDelectVideo:)]) {
                [self.delegate videoPlayerControllerDelectVideo:self];
            }
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }];
}
- (void)callDelegateMethod {
    BByasTZImagePickerController *imagePickerVc = (BByasTZImagePickerController *)self.navigationController;
    if ([imagePickerVc.pickerDelegate respondsToSelector:@selector(imagePickerController:didFinishPickingVideo:sourceAssets:)]) {
        [imagePickerVc.pickerDelegate imagePickerController:imagePickerVc didFinishPickingVideo:_cover sourceAssets:_model.asset];
    }
    if (imagePickerVc.didFinishPickingVideoHandle) {
        imagePickerVc.didFinishPickingVideoHandle(_cover,_model.asset);
    }
}
#pragma mark - Notification Method
- (void)pausePlayerAndShowNaviBar {
    [_player pause];
    _toolBar.hidden = NO;
    [self.navigationController setNavigationBarHidden:NO];
    [_playButton setImage:[UIImage imageNamedFromMyBundle:@"MMVideoPreviewPlay"] forState:UIControlStateNormal];
    if (!TZ_isGlobalHideStatusBar) {
        if (iOS7Later) [UIApplication sharedApplication].statusBarHidden = NO;
    }
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
#pragma clang diagnostic pop
@end
