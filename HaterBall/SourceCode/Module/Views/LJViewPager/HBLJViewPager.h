#import <UIKit/UIKit.h>
#import "HBLJTabBar.h"
@class HBLJViewPager;
@protocol LJViewPagerDataSource <NSObject>
@required
- (UIViewController *)viewPagerInViewController;
- (NSInteger)numberOfPagesInViewPager;
- (UIViewController *)viewPager:(HBLJViewPager *)viewPager
               controllerAtPage:(NSInteger)page;
@end
@protocol LJViewPagerDelegate <NSObject>
@optional
- (void)viewPager:(HBLJViewPager *)viewPager didScrollToPage:(NSInteger)page;
- (void)viewPager:(HBLJViewPager *)viewPager didScrollToOffset:(CGPoint)offset;
@end
@interface HBLJViewPager : UIScrollView
@property (strong, nonatomic) HBLJTabBar *tabBar;
@property (weak, nonatomic) id<LJViewPagerDataSource> viewPagerDateSource;
@property (weak, nonatomic) id<LJViewPagerDelegate> viewPagerDelegate;
@property (copy, nonatomic, readonly) NSArray *viewControllers;
@property (assign, nonatomic, readonly) NSInteger currentPage;
- (void)reloadData;
- (void)scrollToPage:(NSInteger)page;
- (void)scrollToPage:(NSInteger)page animated:(BOOL)animated;
@end
