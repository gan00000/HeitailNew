#import <UIKit/UIKit.h>
#import "CfipyTZProgressView.h"
@class UUaksTZAssetModel;
@interface TZAssetPreviewCell : UICollectionViewCell
@property (nonatomic, strong) UUaksTZAssetModel *model;
@property (nonatomic, copy) void (^singleTapGestureBlock)();
- (void)configSubviews;
- (void)photoPreviewCollectionViewDidScroll;
@end
@class UUaksTZAssetModel,CfipyTZProgressView,TZPhotoPreviewView;
@interface WSKggTZPhotoPreviewCell : TZAssetPreviewCell
@property (nonatomic, copy) void (^imageProgressUpdateBlock)(double progress);
@property (nonatomic, strong) TZPhotoPreviewView *previewView;
@property (nonatomic, assign) BOOL allowCrop;
@property (nonatomic, assign) CGRect cropRect;
- (void)recoverSubviews;
@end
@interface TZPhotoPreviewView : UIView
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *imageContainerView;
@property (nonatomic, strong) CfipyTZProgressView *progressView;
@property (nonatomic, assign) BOOL allowCrop;
@property (nonatomic, assign) CGRect cropRect;
@property (nonatomic, strong) UUaksTZAssetModel *model;
@property (nonatomic, strong) id asset;
@property (nonatomic, copy) void (^singleTapGestureBlock)();
@property (nonatomic, copy) void (^imageProgressUpdateBlock)(double progress);
@property (nonatomic, assign) int32_t imageRequestID;
- (void)recoverSubviews;
@end
@class AVPlayer, AVPlayerLayer;
@interface TZVideoPreviewCell : TZAssetPreviewCell
@property (strong, nonatomic) AVPlayer *player;
@property (strong, nonatomic) AVPlayerLayer *playerLayer;
@property (strong, nonatomic) UIButton *playButton;
@property (strong, nonatomic) UIImage *cover;
- (void)pausePlayerAndShowNaviBar;
@end
@interface TZGifPreviewCell : TZAssetPreviewCell
@property (strong, nonatomic) TZPhotoPreviewView *previewView;
@end