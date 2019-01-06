#import <UIKit/UIKit.h>
#import "HBNewsModel.h"
#import "HBNewsHomeBannerCell.h"

@interface HBNewsHomeBannerCell (Mixcode)
- (void)awakeFromNibMixcode:(NSString *)mixcode;
- (void)setupWithNewsModels:(NSArray *)bannerList mixcode:(NSString *)mixcode;
- (void)onBannerImageTapped:(UITapGestureRecognizer *)tap mixcode:(NSString *)mixcode;
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView mixcode:(NSString *)mixcode;
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate mixcode:(NSString *)mixcode;
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView mixcode:(NSString *)mixcode;
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView mixcode:(NSString *)mixcode;
- (void)startScrollTimerMixcode:(NSString *)mixcode;
- (void)stopScrollTimerMixcode:(NSString *)mixcode;
- (void)scrollBannerMixcode:(NSString *)mixcode;
- (void)p_fixScrollOffsetMixcode:(NSString *)mixcode;
- (void)p_heightMixcode:(NSString *)mixcode;
- (void)p_setupTitleMixcode:(NSString *)mixcode;
- (void)p_fitWithTitle:(NSString *)title mixcode:(NSString *)mixcode;
- (void)addLableAtX:(CGFloat)x width:(CGFloat)width text:(NSString *)text mixcode:(NSString *)mixcode;
- (void)startTitleTimerMixcode:(NSString *)mixcode;
- (void)stopTitleTimerMixcode:(NSString *)mixcode;
- (void)scrollTitleMixcode:(NSString *)mixcode;

@end
