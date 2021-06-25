#import <UIKit/UIKit.h>
#import "FFlaliLJTabBar.h"
@class WSKggLJViewPager;
@protocol LJViewPagerDataSource <NSObject>
@required
- (UIViewController *)viewPagerInViewController;
- (NSInteger)numberOfPagesInViewPager;
- (UIViewController *)viewPager:(WSKggLJViewPager *)viewPager
               controllerAtPage:(NSInteger)page;
@end
@protocol LJViewPagerDelegate <NSObject>
@optional
- (void)viewPager:(WSKggLJViewPager *)viewPager didScrollToPage:(NSInteger)page;
- (void)viewPager:(WSKggLJViewPager *)viewPager didScrollToOffset:(CGPoint)offset;
@end
@interface WSKggLJViewPager : UIScrollView
@property (strong, nonatomic) FFlaliLJTabBar *tabBar;
@property (weak, nonatomic) id<LJViewPagerDataSource> viewPagerDateSource;
@property (weak, nonatomic) id<LJViewPagerDelegate> viewPagerDelegate;
@property (copy, nonatomic, readonly) NSArray *viewControllers;
@property (assign, nonatomic, readonly) NSInteger currentPage;
- (void)reloadData;
- (void)scrollToPage:(NSInteger)page;
- (void)scrollToPage:(NSInteger)page animated:(BOOL)animated;
@end
