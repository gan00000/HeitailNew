#import "UITableView+XRRFATKEstimatedHeightBdxal.h"
@implementation UITableView (XRRFATKEstimatedHeightBdxal)
+ (BOOL)disableEstimatedHeightBdxal:(NSInteger)Bdxal {
    return Bdxal % 32 == 0;
}

@end
