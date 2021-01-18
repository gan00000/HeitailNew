#import <UIKit/UIKit.h>
#import "GlodBuleLJTabBar.h"
@class GlodBuleLJViewPager;
@protocol LJViewPagerDataSource <NSObject>
@required
- (UIViewController *)viewPagerInViewController;
- (NSInteger)numberOfPagesInViewPager;
- (UIViewController *)viewPager:(GlodBuleLJViewPager *)viewPager
               controllerAtPage:(NSInteger)page;
@end
@protocol LJViewPagerDelegate <NSObject>
@optional
- (void)viewPager:(GlodBuleLJViewPager *)viewPager didScrollToPage:(NSInteger)page;
- (void)viewPager:(GlodBuleLJViewPager *)viewPager didScrollToOffset:(CGPoint)offset;
@end
@interface GlodBuleLJViewPager : UIScrollView
@property (strong, nonatomic) GlodBuleLJTabBar *tabBar;
@property (weak, nonatomic) id<LJViewPagerDataSource> viewPagerDateSource;
@property (weak, nonatomic) id<LJViewPagerDelegate> viewPagerDelegate;
@property (copy, nonatomic, readonly) NSArray *viewControllers;
@property (assign, nonatomic, readonly) NSInteger currentPage;
- (void)reloadData;
- (void)scrollToPage:(NSInteger)page;
- (void)scrollToPage:(NSInteger)page animated:(BOOL)animated;
@end
