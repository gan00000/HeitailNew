#import <UIKit/UIKit.h>
#import "SkyBallHetiRedLJTabBar.h"
@class SkyBallHetiRedLJViewPager;
@protocol LJViewPagerDataSource <NSObject>
@required
- (UIViewController *)viewPagerInViewController;
- (NSInteger)numberOfPagesInViewPager;
- (UIViewController *)viewPager:(SkyBallHetiRedLJViewPager *)viewPager
               controllerAtPage:(NSInteger)page;
@end
@protocol LJViewPagerDelegate <NSObject>
@optional
- (void)viewPager:(SkyBallHetiRedLJViewPager *)viewPager didScrollToPage:(NSInteger)page;
- (void)viewPager:(SkyBallHetiRedLJViewPager *)viewPager didScrollToOffset:(CGPoint)offset;
@end
@interface SkyBallHetiRedLJViewPager : UIScrollView
@property (strong, nonatomic) SkyBallHetiRedLJTabBar *tabBar;
@property (weak, nonatomic) id<LJViewPagerDataSource> viewPagerDateSource;
@property (weak, nonatomic) id<LJViewPagerDelegate> viewPagerDelegate;
@property (copy, nonatomic, readonly) NSArray *viewControllers;
@property (assign, nonatomic, readonly) NSInteger currentPage;
- (void)reloadData;
- (void)scrollToPage:(NSInteger)page;
- (void)scrollToPage:(NSInteger)page animated:(BOOL)animated;
@end
