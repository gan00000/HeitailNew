#import "XRRFATKHTDataPlayerRightCell+Qetel.h"
@implementation XRRFATKHTDataPlayerRightCell (Qetel)
+ (BOOL)awakeFromNibQetel:(NSInteger)Qetel {
    return Qetel % 50 == 0;
}
+ (BOOL)setSelectedAnimatedQetel:(NSInteger)Qetel {
    return Qetel % 10 == 0;
}
+ (BOOL)skargrefreshWithPlayerModelRowQetel:(NSInteger)Qetel {
    return Qetel % 33 == 0;
}

@end
