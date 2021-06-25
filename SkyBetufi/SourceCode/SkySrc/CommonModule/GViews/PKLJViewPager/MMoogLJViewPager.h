#import <UIKit/UIKit.h>
#import "YeYeeLJTabBar.h"
@class MMoogLJViewPager;
@protocol LJViewPagerDataSource <NSObject>
@required
- (UIViewController *)viewPagerInViewController;
- (NSInteger)numberOfPagesInViewPager;
- (UIViewController *)viewPager:(MMoogLJViewPager *)viewPager
               controllerAtPage:(NSInteger)page;
@end
@protocol LJViewPagerDelegate <NSObject>
@optional
- (void)viewPager:(MMoogLJViewPager *)viewPager didScrollToPage:(NSInteger)page;
- (void)viewPager:(MMoogLJViewPager *)viewPager didScrollToOffset:(CGPoint)offset;
@end
@interface MMoogLJViewPager : UIScrollView
@property (strong, nonatomic) YeYeeLJTabBar *tabBar;
@property (weak, nonatomic) id<LJViewPagerDataSource> viewPagerDateSource;
@property (weak, nonatomic) id<LJViewPagerDelegate> viewPagerDelegate;
@property (copy, nonatomic, readonly) NSArray *viewControllers;
@property (assign, nonatomic, readonly) NSInteger currentPage;
- (void)reloadData;
- (void)scrollToPage:(NSInteger)page;
- (void)scrollToPage:(NSInteger)page animated:(BOOL)animated;
@end
