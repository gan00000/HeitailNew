#import "XRRFATKBJTabBarView.h"
@interface XRRFATKBJTabBarView ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *selectedMarkView;
@property (nonatomic, copy) NSArray *tabTitles;
@property (nonatomic, strong) NSMutableArray *tabButtons;
@end
@implementation XRRFATKBJTabBarView
- (void)awakeFromNib {
    [super awakeFromNib];
}
@end
