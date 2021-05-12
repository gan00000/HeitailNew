#import "KMonkeyBJTabBarView.h"
@interface KMonkeyBJTabBarView ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *selectedMarkView;
@property (nonatomic, copy) NSArray *tabTitles;
@property (nonatomic, strong) NSMutableArray *tabButtons;
@end
@implementation KMonkeyBJTabBarView
- (void)awakeFromNib {
    [super awakeFromNib];
}
@end
