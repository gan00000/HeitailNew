#import "XRRFATKHTUserInfoModel+Vinit.h"
@implementation XRRFATKHTUserInfoModel (Vinit)
+ (BOOL)avatarVinit:(NSInteger)Vinit {
    return Vinit % 34 == 0;
}

@end
