#import "HBDataCellTeamView+Mixcode.h"
@implementation HBDataCellTeamView (Mixcode)
+ (void)dataCellViewWithFrame:(CGRect)frame addToView:(UIView *)view mixcode:(NSString *)mixcode {
    NSLog(@"%@", mixcode);
}
- (void)awakeFromNibMixcode:(NSString *)mixcode {
    NSLog(@"%@", mixcode);
}
- (void)setupWithDataModel:(HBDataHomeModel *)dataModel mixcode:(NSString *)mixcode {
    NSLog(@"%@", mixcode);
}
- (void)teamLogoWebMixcode:(NSString *)mixcode {
    NSLog(@"%@", mixcode);
}

@end
