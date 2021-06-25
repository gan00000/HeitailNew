
#import "FFlaliWBImageBrowserView.h"
#import "MMoogWBImageBrowserCell.h"
#import <UIImageView+WebCache.h>
#import <Masonry.h>
#import "MMoogHTLoginAlertView.h"
#import <UMShare/UMShare.h>
#import <FBSDKShareKit/FBSDKShareKit.h>

#define HeightForTopView 45
static  NSString *cellID = @"cellID";

@interface FFlaliWBImageBrowserView () <UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView  *collectionView;

@property (nonatomic, strong) NSArray           *browserArray;      // 数据源

@property (nonatomic, strong) UIScrollView      *currentScrollView; // 当前scrollview
@property (nonatomic, strong) UIImage           *currentImage;      // 当前图片
@property (nonatomic, assign) NSInteger         currentIndex;       // 当前选中的index

@property (nonatomic, strong) UIView    *bottomBgView;          // 顶部背景视图
@property (nonatomic, strong) UIButton  *downloadButton;     // 下载按钮
@property (nonatomic, strong) UIButton  *shareButton;        // 分享按钮
@property (nonatomic, strong) UIButton  *backButton;         // 返回
@property (nonatomic, strong) UILabel   *pageLabel;          // 页码
@property (nonatomic, strong) UILabel   *bottomTitleLabel;   // 标题

@end

@implementation FFlaliWBImageBrowserView



#pragma mark - Instant Methods

+ (instancetype)pictureBrowsweViewWithFrame:(CGRect)frame delegate:(id<WBImageBrowserViewDelegate>)delegate browserInfoArray:(NSArray *)browserInfoArray {
    FFlaliWBImageBrowserView *pictureBrowserView = [[self alloc] initWithFrame:frame];
    pictureBrowserView.delegate = delegate;
    pictureBrowserView.browserArray = browserInfoArray;
    
    return pictureBrowserView;
}

+ (void)clearImagesCache {
//    [[[SDWebImageManager sharedManager] imageCache] clearDisk];
    
//    [[[SDWebImageManager sharedManager] imageCache] clearDiskOnCompletion:^{
//        
//    }];
}

- (void)showInView:(UIView *)view {
    [view addSubview:self];
    
    self.alpha = 0.0;
    
    [UIView animateWithDuration:0.4 animations:^{
        self.alpha = 1.0;
    }];
    
    // x秒后自动隐藏
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        self.topBgView.hidden = YES;
//        self.bottomTitleLabel.hidden = YES;
//    });
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self addSubview:self.collectionView];
        [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.mas_equalTo(self);
            make.bottom.mas_equalTo(self).mas_offset(-80);
        }];
        
        [self addSubview:self.backButton];
            
        [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).mas_offset(30);
            make.top.mas_equalTo(self).mas_offset(30);
            make.width.mas_equalTo(60);
            make.height.mas_equalTo(60);
        }];
            
        
               
        [self addSubview:self.bottomBgView];
        [self.bottomBgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.left.right.mas_equalTo(self);
            make.height.mas_equalTo(80);
        }];
        
       
        [self.bottomBgView addSubview:self.pageLabel];
        
        [self.pageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                   make.top.bottom.mas_equalTo(self.bottomBgView);
                  
                    make.left.mas_equalTo(self.backButton.mas_right);
                    make.width.mas_equalTo(80);
               }];
        
        self.pageLabel.hidden = YES;
        
        [self.bottomBgView addSubview:self.downloadButton];
        
        [self.downloadButton mas_makeConstraints:^(MASConstraintMaker *make) {
              make.top.bottom.mas_equalTo(self.bottomBgView);
              
            make.right.mas_equalTo(self.bottomBgView.mas_right).mas_offset(-15);
            make.width.mas_equalTo(80);
        }];
        [self.bottomBgView addSubview:self.shareButton];
             [self.shareButton mas_makeConstraints:^(MASConstraintMaker *make) {
                     make.top.bottom.mas_equalTo(self.bottomBgView);
                    
                     make.right.mas_equalTo(self.downloadButton.mas_left);
                  make.width.mas_equalTo(80);
             }];
             
        
        
        
    }
    return self;
}

#pragma mark - 横竖屏时重设frame

- (void)setOrientation:(UIInterfaceOrientation)orientation {
    
//    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
//    self.topBgView.frame = CGRectMake(0, 0, SCREEN_WIDTH, HeightForTopView);
//    self.pageLabel.frame = CGRectMake(0, 0, SCREEN_WIDTH, HeightForTopView);
//    self.backButton.frame = CGRectMake(10, 0, HeightForTopView, HeightForTopView);
//    self.downloadButton.frame = CGRectMake(SCREEN_WIDTH - 100, 5, HeightForTopView, HeightForTopView);
//    self.shareButton.frame = CGRectMake(SCREEN_WIDTH - 50, 5, HeightForTopView, HeightForTopView);
//
//    self.collectionView.frame  = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
//    [self.collectionView reloadData];
//    [self.collectionView setContentOffset:CGPointMake(self.currentIndex * SCREEN_WIDTH, 0)];
//
//    self.topBgView.hidden = NO;
//    self.bottomTitleLabel.hidden = NO;
//
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        self.topBgView.hidden = YES;
//        self.bottomTitleLabel.hidden = YES;
//    });
}

// 横竖屏时需重新设置尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    return CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT);
}

#pragma mark - UICollectionDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.browserArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    MMoogWBImageBrowserCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    cell.bgScrollView.delegate = self;
    
//    [cell.bgImageView sd_setImageWithURL:[NSURL URLWithString:self.browserArray[indexPath.item][@"url"]]
//                     placeholderImage:[UIImage imageNamed:@"place2"]
//                            completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
//                                self.currentImage = image;
//                            }];
    
    [cell.bgImageView sd_setImageWithURL:[NSURL URLWithString:self.browserArray[indexPath.item][@"url"]]
                     placeholderImage:[UIImage imageNamed:@"place2"]
                               completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
         self.currentImage = image;
    }];
    
    
    // 底部标题
    if (self.bottomTitleLabel) {
        [self.bottomTitleLabel removeFromSuperview];
        self.bottomTitleLabel = nil;
    }
    self.bottomTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 35, SCREEN_WIDTH, 35)];
    self.bottomTitleLabel.text = self.browserArray[indexPath.row][@"title"];
    self.bottomTitleLabel.textColor = [UIColor whiteColor];
    self.bottomTitleLabel.font = [UIFont systemFontOfSize:15];
    self.bottomTitleLabel.textAlignment = NSTextAlignmentCenter;
    self.bottomTitleLabel.backgroundColor = [UIColor colorWithWhite:0.000 alpha:0.3];
    self.bottomTitleLabel.hidden = self.bottomBgView.hidden;
    [cell.contentView addSubview:self.bottomTitleLabel];
    
    // 添加手势
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapAction:)];
    [cell.bgScrollView addGestureRecognizer:singleTap];
    
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTapAction:)];
    doubleTap.numberOfTapsRequired = 2;
    [cell.bgScrollView addGestureRecognizer:doubleTap];
    
    [singleTap requireGestureRecognizerToFail:doubleTap];
    
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    MMoogWBImageBrowserCell *cell1 = (MMoogWBImageBrowserCell *)cell;
    cell1.bgScrollView.zoomScale = 1;
}

#pragma mark - UIScrollView Delegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    // 当前显示页数
    int itemIndex = (scrollView.contentOffset.x + self.collectionView.frame.size.width * 0.5) / self.collectionView.frame.size.width;
    
    self.pageLabel.text = [NSString stringWithFormat:@"%d/%lu", itemIndex + 1, self.browserArray.count];
    self.currentIndex = itemIndex;
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return scrollView.subviews[0];
}

#pragma mark - 图片缩放相关方法

// 单击手势
- (void)singleTapAction:(UITapGestureRecognizer *)tap {
    
    self.bottomBgView.hidden = !self.bottomBgView.hidden;
    self.bottomTitleLabel.hidden = !self.bottomTitleLabel.hidden;
}

// 双击手势
- (void)doubleTapAction:(UITapGestureRecognizer *)tap {
    
    self.currentScrollView = (UIScrollView *)tap.view;
    CGFloat scale = self.currentScrollView.zoomScale == 1 ? 3 : 1;
    CGRect zoomRect = [self zoomRectForScale:scale withCenter:[tap locationInView:tap.view]];
    [self.currentScrollView zoomToRect:zoomRect animated:YES];
}

// 双击时的中心点
- (CGRect)zoomRectForScale:(float)scale withCenter:(CGPoint)center {
    CGRect zoomRect;
    zoomRect.size.height = self.currentScrollView.frame.size.height / scale;
    zoomRect.size.width  = self.currentScrollView.frame.size.width  / scale;
    zoomRect.origin.x    = center.x - (zoomRect.size.width  / 2.0);
    zoomRect.origin.y    = center.y - (zoomRect.size.height / 2.0);
    return zoomRect;
}

#pragma mark - Setter

- (void)setbrowserArray:(NSArray *)browserArray {
    _browserArray = browserArray;
    self.pageLabel.text = [NSString stringWithFormat:@"1/%lu",browserArray.count];
}

- (void)setStartIndex:(NSInteger)startIndex {
    _currentIndex = startIndex - 1;
    self.pageLabel.text = [NSString stringWithFormat:@"%lu/%lu",startIndex,self.browserArray.count];
    [self.collectionView setContentOffset:CGPointMake((startIndex - 1) * SCREEN_WIDTH, 0)];
}

#pragma mark - 懒加载

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumInteritemSpacing = 0;   // item横向间距
        layout.minimumLineSpacing      = 0;   // item竖向间距
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) collectionViewLayout:layout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.pagingEnabled = YES;
        [_collectionView registerClass:[MMoogWBImageBrowserCell class] forCellWithReuseIdentifier:cellID];

    }
    return _collectionView;
}

- (UIView *)bottomBgView {
    if (!_bottomBgView) {
        _bottomBgView = [[UIView alloc] init];
        _bottomBgView.backgroundColor = [UIColor colorWithWhite:0.000 alpha:0.3];
    }
    return _bottomBgView;
}

- (UILabel *)pageLabel {
    if (!_pageLabel) {
        _pageLabel = [[UILabel alloc] init];
        _pageLabel.textColor = [UIColor whiteColor];
        _pageLabel.textAlignment = NSTextAlignmentCenter;
        _pageLabel.font = [UIFont systemFontOfSize:15];
    }
    return _pageLabel;
}

- (UIButton *)backButton {
    if (!_backButton) {
        _backButton = [[UIButton alloc] init];
        [_backButton setImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateNormal];
        [_backButton setImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateHighlighted];
        [_backButton addTarget:self action:@selector(backButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backButton;
}

- (UIButton *)downloadButton {
    if (!_downloadButton) {
        _downloadButton = [UIButton buttonWithType:UIButtonTypeCustom];
        //_downloadButton.frame = CGRectMake(SCREEN_WIDTH - 100, 0, HeightForTopView, HeightForTopView);
        [_downloadButton setImage:[UIImage imageNamed:@"photo_down_btn"] forState:UIControlStateNormal];
        [_downloadButton addTarget:self action:@selector(downloadButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _downloadButton;
}

- (UIButton *)shareButton {
    if (!_shareButton) {
        _shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
        //_shareButton.frame = CGRectMake(SCREEN_WIDTH - 50, 0, HeightForTopView, HeightForTopView);
        [_shareButton setImage:[UIImage imageNamed:@"photo_share_btn"] forState:UIControlStateNormal];
        [_shareButton addTarget:self action:@selector(shareButtonButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _shareButton;
}

#pragma mark - 按钮事件

- (void)shareButtonButtonClick {
    
    kWeakSelf
    [MMoogHTLoginAlertView taoshowShareAlertViewWithSelectBlock:^(HTLoginPlatform platform) {
        UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
        if (platform == HTLoginPlatformFB) {

            
            FBSDKShareLinkContent *content = [[FBSDKShareLinkContent alloc] init];
            content.contentURL = [NSURL URLWithString: self.browserArray[0][@"url"]];
            
            [FBSDKShareDialog showFromViewController:[CfipyPPXXBJViewControllerCenter currentViewController]
                                          withContent:content
                                             delegate:nil];
            
        } else if (platform == HTLoginPlatformLine) {
            if (![[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_Line]) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://line.me/R/"]];
                return;
            }
            messageObject.text = [NSString stringWithFormat:@"%@\n链接：%@", @"", self.browserArray[0][@"url"]];
//            if (weakSelf.img_url) {
//                [UUaksBJLoadingHud showHUDInView:[CfipyPPXXBJViewControllerCenter currentViewController].view];
//                [[SDWebImageManager sharedManager] loadImageWithURL:[NSURL URLWithString:weakSelf.img_url] options:0 progress:nil completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
//                    if (image) {
//                        UMShareImageObject *shareObject = [[UMShareImageObject alloc] init];
//                        [shareObject setShareImage:image];
//                        messageObject.shareObject = shareObject;
//                        [weakSelf doShareToPlatform:UMSocialPlatformType_Line withMessage:messageObject];
//                    } else {
//                        [weakSelf doShareToPlatform:UMSocialPlatformType_Line withMessage:messageObject];
//                    }
//                    [UUaksBJLoadingHud hideHUDInView:[CfipyPPXXBJViewControllerCenter currentViewController].view];
//                }];
//            } else {
//                [weakSelf doShareToPlatform:UMSocialPlatformType_Line withMessage:messageObject];
//            }
            [weakSelf doShareToPlatform:UMSocialPlatformType_Line withMessage:messageObject];
        }
    }];

}

- (void)doShareToPlatform:(UMSocialPlatformType)platformType withMessage:(UMSocialMessageObject *)messageObject {
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self.viewController completion:^(id result, NSError *error) {
        BJLog(@"result = %@", error);
    }];
}

- (void)downloadButtonClick {
    UIImageWriteToSavedPhotosAlbum(self.currentImage, self, @selector(imageSavedToPhotosAlbum:didFinishSavingWithError:contextInfo:), nil);
}

- (void)imageSavedToPhotosAlbum:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
//    error ? NSLog(@"%@", [error description]) : NSLog(@"成功保存到相册");
//    error ?  [kWindow showToast:@"保存失敗"] : [kWindow showToast:@"保存到相冊成功"];
    if (error) {
        NSLog(@"%@", [error description]);
        [kWindow showToast:@"保存失敗"];
    }else{
        NSLog(@"成功保存到相册");
        [kWindow showToast:@"保存到相冊成功"];
    }
}

- (void)backButtonClick {

    self.alpha = 1.0;
    
    [UIView animateWithDuration:0.1 animations:^{
        self.alpha = 0.0;
        [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
        
        // 检查屏幕横竖屏 强制竖屏
        if ([self.delegate respondsToSelector:@selector(pictureBrowserViewhide)]) {
            [self.delegate pictureBrowserViewhide];
        }
        
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        if ([self.delegate respondsToSelector:@selector(clickBackBtn)]) {
            [self.delegate clickBackBtn];
        }
    }];
}

@end
