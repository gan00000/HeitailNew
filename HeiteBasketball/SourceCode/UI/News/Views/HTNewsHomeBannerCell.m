//
//  HTNewsHomeBannerCell.m
//  HeiteBasketball
//
//  Created by 冯生伟 on 2018/9/9.
//  Copyright © 2018年 Dean_F. All rights reserved.
//

#import "HTNewsHomeBannerCell.h"

@interface HTNewsHomeBannerCell () <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet UIScrollView *titleScrollView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (nonatomic, strong) NSArray *bannerList;
@property (nonatomic, strong) NSTimer *scrollTimer;

@end


@implementation HTNewsHomeBannerCell

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
    
    // remove imageViews
    for (UIView *sv in self.scrollView.subviews) {
        [sv removeFromSuperview];
    }

    // add imageViews
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

            HTNewsModel *banner = self.bannerList[i];
            [imageView sd_setImageWithURL:[NSURL URLWithString:banner.img_url]
                         placeholderImage:HT_DEFAULT_IMAGE];
        }

        if (self.bannerList.count > 1) {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, [self p_height])];
            imageView.contentMode = UIViewContentModeScaleAspectFill;
            imageView.clipsToBounds = YES;
            imageView.tag = self.bannerList.count - 1;
            [self.scrollView addSubview:imageView];

            HTNewsModel *lastBanner = [self.bannerList lastObject];
            [imageView sd_setImageWithURL:[NSURL URLWithString:lastBanner.img_url]
                         placeholderImage:HT_DEFAULT_IMAGE];

            imageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * (self.bannerList.count+1), 0, SCREEN_WIDTH, [self p_height])];
            imageView.contentMode = UIViewContentModeScaleAspectFill;
            imageView.clipsToBounds = YES;
            imageView.tag = 0;
            [self.scrollView addSubview:imageView];

            HTNewsModel *firstBanner = [self.bannerList firstObject];
            [imageView sd_setImageWithURL:[NSURL URLWithString:firstBanner.img_url]
                         placeholderImage:HT_DEFAULT_IMAGE];
        }
    }

    // content & offset
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH * (self.bannerList.count+2*(self.bannerList.count > 1)), [self p_height]);
    if (self.pageControl.numberOfPages != self.bannerList.count) {
        self.scrollView.contentOffset = CGPointMake(0, 0);
        self.pageControl.numberOfPages = self.bannerList.count;
        self.pageControl.currentPage = 0;

        if (self.bannerList.count > 1) {
            self.scrollView.contentOffset = CGPointMake(SCREEN_WIDTH, 0);
        }
    }
    
    NSInteger index = (NSInteger)(self.scrollView.contentOffset.x / SCREEN_WIDTH);
    if (self.bannerList.count > 1) {
        index -= 1;
    }
    HTNewsModel *currentModel = self.bannerList[index];
    self.titleLabel.text = currentModel.title;

    [self startScrollTimer];
}

#pragma mark - Action
- (void)onBannerImageTapped:(UITapGestureRecognizer *)tap {
    UIImageView *tapImageView = (UIImageView *)tap.view;
    HTNewsModel *banner = self.bannerList[tapImageView.tag];
    if (banner.url.length == 0) {
        return;
    }
    if (self.onBannerTappedBlock) {
        self.onBannerTappedBlock(banner);
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self stopScrollTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self startScrollTimer];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self p_fixScrollOffset];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
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
    
    HTNewsModel *nextModel;
    if (currentIndex < self.bannerList.count) {
        nextModel = self.bannerList[currentIndex];
    } else {
        nextModel = self.bannerList[0];
    }
    self.titleLabel.text = nextModel.title;
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

@end












