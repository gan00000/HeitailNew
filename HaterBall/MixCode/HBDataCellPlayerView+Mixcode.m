#import "HBDataCellPlayerView+Mixcode.h"
@implementation HBDataCellPlayerView (Mixcode)
+ (void)dataCellViewWithFrame:(CGRect)frame addToView:(UIView *)view mixcode:(NSString *)mixcode {
    NSLog(@"%@", mixcode);
}
- (void)setupWithDataModel:(HBDataHomeModel *)dataModel mixcode:(NSString *)mixcode {
    NSLog(@"%@", mixcode);
}

@end
