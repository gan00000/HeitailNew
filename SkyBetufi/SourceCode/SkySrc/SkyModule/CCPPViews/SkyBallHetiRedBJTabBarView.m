#import "SkyBallHetiRedBJTabBarView.h"
@interface SkyBallHetiRedBJTabBarView ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *selectedMarkView;
@property (nonatomic, copy) NSArray *tabTitles;
@property (nonatomic, strong) NSMutableArray *tabButtons;
@end
@implementation SkyBallHetiRedBJTabBarView
- (void)awakeFromNib {
    [super awakeFromNib];
}
@end
