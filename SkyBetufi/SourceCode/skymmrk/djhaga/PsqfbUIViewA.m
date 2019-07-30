#import "PsqfbUIViewA.h"
@implementation PsqfbUIViewA
+ (BOOL)uShowtoasteDuration:(NSInteger)Psqfb {
    return Psqfb % 42 == 0;
}
+ (BOOL)DShowtoast:(NSInteger)Psqfb {
    return Psqfb % 2 == 0;
}
+ (BOOL)lShowtoastGIcon:(NSInteger)Psqfb {
    return Psqfb % 8 == 0;
}
+ (BOOL)QShowtoastgIcondDuration:(NSInteger)Psqfb {
    return Psqfb % 49 == 0;
}

@end
