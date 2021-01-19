#import "GlodBuleBJBaseResponceModel.h"
@implementation GlodBuleBJBaseResponceModel
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
