#import "HBNewsHomeBannerCell.h"
@interface HBNewsHomeBannerCell () <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet UIScrollView *titleScrollView;
@property (nonatomic, strong) NSArray *bannerList;
@property (nonatomic, strong) NSTimer *scrollTimer;
@property (nonatomic, strong) NSTimer *titleTimer;
@property (nonatomic, assign) CGFloat pageWidth;
@end
@implementation HBNewsHomeBannerCell
- (void)awakeFromNib {
    [super awakeFromNib];
    self.pageControl.currentPageIndicatorTintColor = RGBA_COLOR(244, 0, 0, 1.0);
    self.pageControl.pageIndicatorTintColor = [[UIColor hx_colorWithHexRGBAString:@"dddddd"] colorWithAlphaComponent:0.5];
    self.scrollView.delegate = self;
}
- (void)setupWithNewsModels:(NSArray *)bannerList {
    self.bannerList = bannerList;
    if (!self.bannerList) {
        return;
    }
    for (UIView *sv in self.scrollView.subviews) {
        [sv removeFromSuperview];
    }
    if (self.bannerList.count > 0) {
        for (int i = 0; i < self.bannerList.count; i++) {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * (i+(self.bannerList.count > 1)), 0, SCREEN_WIDTH, [self p_height])];
            imageView.contentMode = UIViewContentModeScaleAspectFill;
            imageView.clipsToBounds = YES;
            imageView.tag = i;
            [self.scrollView addSubview:imageView];
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onBannerImageTapped:)];
            [imageView addGestureRecognizer:tap];
            imageView.userInteractionEnabled = YES;
            HBNewsModel *banner = self.bannerList[i];
            [imageView sd_setImageWithURL:[NSURL URLWithString:banner.img_url]
                         placeholderImage:HT_DEFAULT_IMAGE];
        }
        if (self.bannerList.count > 1) {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, [self p_height])];
            imageView.contentMode = UIViewContentModeScaleAspectFill;
            imageView.clipsToBounds = YES;
            imageView.tag = self.bannerList.count - 1;
            [self.scrollView addSubview:imageView];
            HBNewsModel *lastBanner = [self.bannerList lastObject];
            [imageView sd_setImageWithURL:[NSURL URLWithString:lastBanner.img_url]
                         placeholderImage:HT_DEFAULT_IMAGE];
            imageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * (self.bannerList.count+1), 0, SCREEN_WIDTH, [self p_height])];
            imageView.contentMode = UIViewContentModeScaleAspectFill;
            imageView.clipsToBounds = YES;
            imageView.tag = 0;
            [self.scrollView addSubview:imageView];
            HBNewsModel *firstBanner = [self.bannerList firstObject];
            [imageView sd_setImageWithURL:[NSURL URLWithString:firstBanner.img_url]
                         placeholderImage:HT_DEFAULT_IMAGE];
        }
    }
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH * (self.bannerList.count+2*(self.bannerList.count > 1)), [self p_height]);
    if (self.pageControl.numberOfPages != self.bannerList.count) {
        self.scrollView.contentOffset = CGPointMake(0, 0);
        self.pageControl.numberOfPages = self.bannerList.count;
        self.pageControl.currentPage = 0;
        if (self.bannerList.count > 1) {
            self.scrollView.contentOffset = CGPointMake(SCREEN_WIDTH, 0);
        }
    }
    [self p_setupTitle];
    [self startScrollTimer];
}
#pragma mark - Action
- (void)onBannerImageTapped:(UITapGestureRecognizer *)tap {
    UIImageView *tapImageView = (UIImageView *)tap.view;
    HBNewsModel *banner = self.bannerList[tapImageView.tag];
    if (banner.url.length == 0) {
        return;
    }
    if (self.onBannerTappedBlock) {
        self.onBannerTappedBlock(banner);
    }
}
#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (scrollView == self.titleScrollView) {
        return;
    }
    [self stopScrollTimer];
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (scrollView == self.titleScrollView) {
        return;
    }
    [self startScrollTimer];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView == self.titleScrollView) {
        return;
    }
    [self p_setupTitle];
    [self p_fixScrollOffset];
}
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    if (scrollView == self.titleScrollView) {
        return;
    }
    if (scrollView.contentOffset.x != (NSInteger)(self.scrollView.contentOffset.x/SCREEN_WIDTH)*SCREEN_WIDTH) {
        [scrollView setContentOffset:CGPointMake(((NSInteger)(self.scrollView.contentOffset.x/SCREEN_WIDTH)+1)*SCREEN_WIDTH, 0)
                            animated:YES];
    }
    [self p_fixScrollOffset];
}
#pragma mark - Timer
- (void)startScrollTimer {
    if (self.bannerList.count > 1) {
        if (!self.scrollTimer) {
            self.scrollTimer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(scrollBanner) userInfo:nil repeats:YES];
            [[NSRunLoop currentRunLoop] addTimer:self.scrollTimer forMode:NSRunLoopCommonModes];
        }
    } else {
        [self stopScrollTimer];
    }
}
- (void)stopScrollTimer {
    [self.scrollTimer invalidate];
    self.scrollTimer = nil;
}
- (void)scrollBanner {
    NSInteger currentIndex = (NSInteger)(self.scrollView.contentOffset.x/SCREEN_WIDTH);
    [self.scrollView setContentOffset:CGPointMake((currentIndex+1)*SCREEN_WIDTH, 0)
                             animated:YES];
    HBNewsModel *nextModel;
    if (currentIndex < self.bannerList.count) {
        nextModel = self.bannerList[currentIndex];
    } else {
        nextModel = self.bannerList[0];
    }
    [self p_fitWithTitle:nextModel.title];
}
#pragma mark - private
- (void)p_fixScrollOffset {
    if (self.scrollView.contentOffset.x <= 0) {
        [self.scrollView setContentOffset:CGPointMake(self.bannerList.count*SCREEN_WIDTH, 0)];
    } else if (self.scrollView.contentOffset.x >= (self.bannerList.count+1)*SCREEN_WIDTH) {
        [self.scrollView setContentOffset:CGPointMake(SCREEN_WIDTH, 0)];
    }
    self.pageControl.currentPage = self.scrollView.contentOffset.x / SCREEN_WIDTH - 1;
}
- (CGFloat)p_height {
    return CGRectGetHeight(self.bounds);
}
- (void)p_setupTitle {
    NSInteger index = (NSInteger)(self.scrollView.contentOffset.x / SCREEN_WIDTH);
    if (self.bannerList.count > 1) {
        index -= 1;
    }
    if (index < 0) {
        index = self.bannerList.count - 1;
    } else if (index >= self.bannerList.count) {
        index = 0;
    }
    HBNewsModel *currentModel = self.bannerList[index];
    [self p_fitWithTitle:currentModel.title];
}
- (void)p_fitWithTitle:(NSString *)title {
    for (UIView *view in self.titleScrollView.subviews) {
        [view removeFromSuperview];
    }
    [self stopTitleTimer];
    CGFloat width = [title jx_sizeWithFont:[UIFont systemFontOfSize:14] constrainedToHeight:15].width;
    [self addLableAtX:0 width:width text:title];
    if (width > self.titleScrollView.jx_width) {
        self.pageWidth = width + 30;
        [self addLableAtX:self.pageWidth width:width text:title];
        [self startTitleTimer];
    }
    [self.titleScrollView setContentOffset:CGPointMake(0, 0)];
}
- (void)addLableAtX:(CGFloat)x width:(CGFloat)width text:(NSString *)text {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(x, 0, width, self.titleScrollView.jx_height)];
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = [UIColor whiteColor];
    label.text = text;
    [self.titleScrollView addSubview:label];
    [self.titleScrollView setContentSize:CGSizeMake(x+width, self.titleScrollView.jx_height)];
}
- (void)startTitleTimer {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (!self.titleTimer) {
            self.titleTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(scrollTitle) userInfo:nil repeats:YES];
            [[NSRunLoop currentRunLoop] addTimer:self.titleTimer forMode:NSRunLoopCommonModes];
        }
    });
}
- (void)stopTitleTimer {
    [self.titleTimer invalidate];
    self.titleTimer = nil;
}
- (void)scrollTitle {
    [self.titleScrollView setContentOffset:CGPointMake(self.titleScrollView.contentOffset.x+5, 0)];
    if (self.titleScrollView.contentOffset.x >= self.pageWidth) {
        [self.titleScrollView setContentOffset:CGPointMake(self.titleScrollView.contentOffset.x-self.pageWidth, 0)];
    }
}
@end
