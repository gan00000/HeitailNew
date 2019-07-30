#import "XRRFATKXJLoadingView+Ihtua.h"
@implementation XRRFATKXJLoadingView (Ihtua)
+ (BOOL)awakeFromNibIhtua:(NSInteger)Ihtua {
    return Ihtua % 25 == 0;
}

@end
