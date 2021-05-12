#import <UIKit/UIKit.h>
#import "NDeskLJTabBar.h"
@class YYPackageLJViewPager;
@protocol LJViewPagerDataSource <NSObject>
@required
- (UIViewController *)viewPagerInViewController;
- (NSInteger)numberOfPagesInViewPager;
- (UIViewController *)viewPager:(YYPackageLJViewPager *)viewPager
               controllerAtPage:(NSInteger)page;
@end
@protocol LJViewPagerDelegate <NSObject>
@optional
- (void)viewPager:(YYPackageLJViewPager *)viewPager didScrollToPage:(NSInteger)page;
- (void)viewPager:(YYPackageLJViewPager *)viewPager didScrollToOffset:(CGPoint)offset;
@end
@interface YYPackageLJViewPager : UIScrollView
@property (strong, nonatomic) NDeskLJTabBar *tabBar;
@property (weak, nonatomic) id<LJViewPagerDataSource> viewPagerDateSource;
@property (weak, nonatomic) id<LJViewPagerDelegate> viewPagerDelegate;
@property (copy, nonatomic, readonly) NSArray *viewControllers;
@property (assign, nonatomic, readonly) NSInteger currentPage;
- (void)reloadData;
- (void)scrollToPage:(NSInteger)page;
- (void)scrollToPage:(NSInteger)page animated:(BOOL)animated;
@end
