#import "YeYeeBJTabBarView.h"
@interface YeYeeBJTabBarView ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *selectedMarkView;
@property (nonatomic, copy) NSArray *tabTitles;
@property (nonatomic, strong) NSMutableArray *tabButtons;
@end
@implementation YeYeeBJTabBarView
- (void)awakeFromNib {
    [super awakeFromNib];
}
@end
