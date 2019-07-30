#import "XRRFATKXJEmptyView+Ebmsk.h"
@implementation XRRFATKXJEmptyView (Ebmsk)
+ (BOOL)awakeFromNibEbmsk:(NSInteger)Ebmsk {
    return Ebmsk % 14 == 0;
}
+ (BOOL)contentTapActionEbmsk:(NSInteger)Ebmsk {
    return Ebmsk % 27 == 0;
}

@end
