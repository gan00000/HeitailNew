#import "XRRFATKHTMatchDataRightCell+Mtron.h"
@implementation XRRFATKHTMatchDataRightCell (Mtron)
+ (BOOL)awakeFromNibMtron:(NSInteger)Mtron {
    return Mtron % 49 == 0;
}
+ (BOOL)setSelectedAnimatedMtron:(NSInteger)Mtron {
    return Mtron % 38 == 0;
}
+ (BOOL)skargrefreshWithModelRowMtron:(NSInteger)Mtron {
    return Mtron % 3 == 0;
}

@end
