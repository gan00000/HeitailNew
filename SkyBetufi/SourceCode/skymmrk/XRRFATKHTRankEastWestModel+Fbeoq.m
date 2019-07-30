#import "XRRFATKHTRankEastWestModel+Fbeoq.h"
@implementation XRRFATKHTRankEastWestModel (Fbeoq)
+ (BOOL)modelContainerPropertyGenericClassFbeoq:(NSInteger)Fbeoq {
    return Fbeoq % 1 == 0;
}
+ (BOOL)setEasternFbeoq:(NSInteger)Fbeoq {
    return Fbeoq % 13 == 0;
}
+ (BOOL)setWesternFbeoq:(NSInteger)Fbeoq {
    return Fbeoq % 9 == 0;
}

@end
