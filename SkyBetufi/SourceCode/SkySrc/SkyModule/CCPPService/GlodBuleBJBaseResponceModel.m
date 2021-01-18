#import "GlodBuleBJBaseResponceModel.h"
@implementation GlodBuleBJBaseResponceModel
- (NSInteger)waterSkypagesValueOfPage {
    if (self.page) {
        return [self.page[@"pages"] integerValue];
    }
    return 0;
}
- (NSInteger)waterSkytotalValueOfPage {
    return self.total;
}
@end
