#import "SkyBallHetiRedBJBaseResponceModel.h"
@implementation SkyBallHetiRedBJBaseResponceModel
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
