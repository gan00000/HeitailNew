#import "HBBJBaseResponceModel.h"
@implementation HBBJBaseResponceModel
- (NSInteger)pagesValueOfPage {
    if (self.page) {
        return [self.page[@"pages"] integerValue];
    }
    return 0;
}
- (NSInteger)totalValueOfPage {
    return self.total;
}
@end
