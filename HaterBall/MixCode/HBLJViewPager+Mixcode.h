#import <UIKit/UIKit.h>
#import "HBLJTabBar.h"
#import "HBLJViewPager.h"
#import "HBLJTabBar.h"

@interface HBLJViewPager (Mixcode)
- (void)initMixcode:(NSString *)mixcode;
- (void)initWithFrame:(CGRect)frame mixcode:(NSString *)mixcode;
- (void)initWithCoder:(NSCoder *)aDecoder mixcode:(NSString *)mixcode;
- (void)layoutSubviewsMixcode:(NSString *)mixcode;
- (void)setupMixcode:(NSString *)mixcode;
- (void)reloadDataMixcode:(NSString *)mixcode;
- (void)scrollToPage:(NSInteger)page mixcode:(NSString *)mixcode;
- (void)scrollToPage:(NSInteger)page animated:(BOOL)animated mixcode:(NSString *)mixcode;
- (void)scrollViewDidScroll:(UIScrollView *)scrollView mixcode:(NSString *)mixcode;
- (void)scrollViewDidZoom:(UIScrollView *)scrollView mixcode:(NSString *)mixcode;
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView mixcode:(NSString *)mixcode;
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate mixcode:(NSString *)mixcode;
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView mixcode:(NSString *)mixcode;
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView mixcode:(NSString *)mixcode;
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView mixcode:(NSString *)mixcode;
- (void)viewForZoomingInScrollView:(UIScrollView *)scrollView mixcode:(NSString *)mixcode;
- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view mixcode:(NSString *)mixcode;
- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale mixcode:(NSString *)mixcode;
- (void)scrollViewShouldScrollToTop:(UIScrollView *)scrollView mixcode:(NSString *)mixcode;
- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView mixcode:(NSString *)mixcode;
- (void)endViewControllerEditingMixcode:(NSString *)mixcode;
- (void)screenEdgePanGestureRecognizer:(UINavigationController *)controller mixcode:(NSString *)mixcode;
- (void)setViewPagerDateSource:(id<LJViewPagerDataSource>)viewPagerDateSource mixcode:(NSString *)mixcode;
- (void)setDelegate:(id<UIScrollViewDelegate>)delegate mixcode:(NSString *)mixcode;
- (void)setTabBar:(HBLJTabBar *)tabBar mixcode:(NSString *)mixcode;

@end
