#import <UIKit/UIKit.h>
@class SkyBallHetiRedLJViewPager;
@class SkyBallHetiRedLJTabBar;
@protocol LJTabBarDelegate <NSObject>
- (void)tabBar:(SkyBallHetiRedLJTabBar *)tabBar didSelectedItemAtIndex:(NSUInteger)index;
@end
@interface SkyBallHetiRedLJTabBar : UIView
@property (weak, nonatomic) SkyBallHetiRedLJViewPager *viewPager;
@property (weak, nonatomic) id<LJTabBarDelegate> delegate;
@property (assign, nonatomic) NSInteger itemsPerPage;
@property (assign, nonatomic) NSUInteger selectedIndex;
@property (strong, nonatomic) UIView *indicatorView;
@property (assign, nonatomic) CGFloat indicatorViewHeight;
@property (copy, nonatomic) NSArray *titles;
@property (copy, nonatomic) NSArray *iconImages;
@property (copy, nonatomic) NSArray *selectedIconImages;
@property (strong, nonatomic) UIFont *textFont;
@property (strong, nonatomic) UIColor *textColor;
@property (strong, nonatomic) UIColor *selectedTextColor;
@property (strong, nonatomic) UIColor *indicatorColor;
@property (strong, nonatomic) UIColor *separatorColor;
@property (assign, nonatomic) BOOL showShadow;
@property (assign, nonatomic) CGSize shadowOffest;
@property (strong, nonatomic) UIColor *shadowColor;
@end
