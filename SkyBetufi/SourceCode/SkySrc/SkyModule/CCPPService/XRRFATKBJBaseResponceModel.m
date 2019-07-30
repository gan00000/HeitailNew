#import "XRRFATKBJBaseResponceModel.h"
@implementation XRRFATKBJBaseResponceModel
- (NSInteger)skargpagesValueOfPage {
    if (self.page) {
        return [self.page[@"pages"] integerValue];
    }
    return 0;
}
- (NSInteger)skargtotalValueOfPage {
    return self.total;
}
@end
