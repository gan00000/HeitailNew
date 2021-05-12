#import "GGCatBJBaseResponceModel.h"
@implementation GGCatBJBaseResponceModel
- (NSInteger)taopagesValueOfPage {
    if (self.page) {
        return [self.page[@"pages"] integerValue];
    }
    return 0;
}
- (NSInteger)taototalValueOfPage {
    return self.total;
}
@end
