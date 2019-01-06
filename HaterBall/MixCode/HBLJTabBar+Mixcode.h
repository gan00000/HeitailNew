#import <UIKit/UIKit.h>
#import "HBLJTabBar.h"
#import "HBLJViewPager.h"

@interface HBLJTabBar (Mixcode)
- (void)initMixcode:(NSString *)mixcode;
- (void)initWithFrame:(CGRect)frame mixcode:(NSString *)mixcode;
- (void)initWithCoder:(NSCoder *)aDecoder mixcode:(NSString *)mixcode;
- (void)setupMixcode:(NSString *)mixcode;
- (void)addTabAtIndex:(NSUInteger)index mixcode:(NSString *)mixcode;
- (void)addIndicatorViewMixcode:(NSString *)mixcode;
- (void)selectedTabAtIndex:(NSInteger)index mixcode:(NSString *)mixcode;
- (void)resetTabsMixcode:(NSString *)mixcode;
- (void)tabPressed:(UIButton *)sender mixcode:(NSString *)mixcode;
- (void)setViewPager:(HBLJViewPager *)viewPager mixcode:(NSString *)mixcode;
- (void)setSelectedIndex:(NSUInteger)selectedIndex mixcode:(NSString *)mixcode;
- (void)setTitles:(NSArray *)titles mixcode:(NSString *)mixcode;
- (void)setTextFont:(UIFont *)textFont mixcode:(NSString *)mixcode;
- (void)setTextColor:(UIColor *)textColor mixcode:(NSString *)mixcode;
- (void)setSelectedTextColor:(UIColor *)selectedTextColor mixcode:(NSString *)mixcode;
- (void)setIndicatorColor:(UIColor *)indicatorColor mixcode:(NSString *)mixcode;
- (void)setSeparatorColor:(UIColor *)separatorColor mixcode:(NSString *)mixcode;
- (void)setShowShadow:(BOOL)showShadow mixcode:(NSString *)mixcode;
- (void)setShadowOffest:(CGSize)shadowOffest mixcode:(NSString *)mixcode;
- (void)setShadowColor:(UIColor *)shadowColor mixcode:(NSString *)mixcode;
- (void)setItemsPerPage:(NSInteger)itemsPerPage mixcode:(NSString *)mixcode;

@end
