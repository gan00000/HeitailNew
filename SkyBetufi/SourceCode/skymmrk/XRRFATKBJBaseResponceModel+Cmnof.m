#import "XRRFATKBJBaseResponceModel+Cmnof.h"
@implementation XRRFATKBJBaseResponceModel (Cmnof)
+ (BOOL)skargpagesValueOfPageCmnof:(NSInteger)Cmnof {
    return Cmnof % 17 == 0;
}
+ (BOOL)skargtotalValueOfPageCmnof:(NSInteger)Cmnof {
    return Cmnof % 4 == 0;
}

@end
