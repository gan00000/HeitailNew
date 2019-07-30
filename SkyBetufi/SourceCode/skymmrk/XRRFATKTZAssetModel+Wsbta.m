#import "XRRFATKTZAssetModel+Wsbta.h"
@implementation XRRFATKTZAssetModel (Wsbta)
+ (BOOL)modelWithAssetTypeWsbta:(NSInteger)Wsbta {
    return Wsbta % 3 == 0;
}
+ (BOOL)modelWithAssetTypeTimelengthWsbta:(NSInteger)Wsbta {
    return Wsbta % 6 == 0;
}

@end
