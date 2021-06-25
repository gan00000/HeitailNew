#import "FFlaliBJBaseResponceModel.h"
@implementation FFlaliBJBaseResponceModel
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
